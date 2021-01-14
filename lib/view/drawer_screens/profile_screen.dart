import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/constants_colors.dart';
import 'package:project/locale_language/localization_delegate.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  OutlineInputBorder borderE = OutlineInputBorder(
    borderSide: BorderSide(
      color: primary200Color,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(50),
  );

  OutlineInputBorder borderF = OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: primaryColor,
    ),
    borderRadius: BorderRadius.circular(50),
  );

  TextStyle _labelStyle = TextStyle(color: blackColor, inherit: true);

  CollectionReference travelerCollection = FirebaseFirestore.instance.collection('Travelers');
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String genderValue;

  var _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  File _image;
  String _url;

  Map<String, dynamic> data;

  void radioButtonChanges(String value) {
    setState(() {
      genderValue = value;
    });
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      travelerCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    });

    return null;
  }

  @override
  void initState() {
    setState(() {
      genderValue = "Male";
    });
    refreshList();
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.indigo[800],
        ),
        CustomPaint(
          painter: Background(),
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: transparent,
              elevation: 0,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: whiteColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                AppLocalization.of(context).getTranslated("profile_title"),
                style: TextStyle(color: whiteColor),
              ),
              centerTitle: true,
            ),
            backgroundColor: transparent,
            body: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshList,
              child: FutureBuilder<DocumentSnapshot>(
                future: travelerCollection.doc(FirebaseAuth.instance.currentUser.uid).get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.active:
                      return Center(child: CircularProgressIndicator());
                      break;

                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                      break;

                    case ConnectionState.none:
                      return Text("No Connection");
                      break;

                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return Text(snapshot.error);
                      } else if (snapshot.hasData) {

                         data = snapshot.data.data();
                        return Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.75,
                                decoration: BoxDecoration(
                                  color: grey50Color,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35),
                                  ),
                                ),
                              ),
                            ),
                            _profileImage(data),
                            profileUser(data),
                            profileInfo(data),
                          ],
                        );
                      }
                      break;
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _profileImage(data) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      left: MediaQuery.of(context).size.width / 2.9,
      child: CircleAvatar(
        backgroundColor: whiteColor,
        radius: MediaQuery.of(context).size.width * 0.18,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.170,
              backgroundImage: NetworkImage(data['image']==null?"https://www.flaticon.com/svg/vstatic/svg/929/929422.svg?token=exp=1610581352~hmac=3289dc6e4527b339241852ba4be792f9":data["image"]),
            ),
            CircleAvatar(
              radius: 22,
              backgroundColor: whiteColor,
              child: CircleAvatar(
                child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: whiteColor,
                    ),
                    onPressed: () {
                      //_showPicker(context);
                    }),
                backgroundColor: grey400Color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileUser(data) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.245,
      left: 0,
      right: 0,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            data["fullName"] == null ? "FullName" : data["fullName"],
            style: TextStyle(
                color: blackColor, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            data["username"] == null ? "DisplayName" : data["username"],
            style: TextStyle(
                color:grey500Color,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget profileInfo(data) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.350,
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).getTranslated("text_full_name"),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data["fullName"] != null
                                    ? data["fullName"]
                                    : "fullName",
                                style: TextStyle(
                                  color: grey500Color,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  _updateName(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: grey50Color,
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).getTranslated("text_address_profile"),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:whiteColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data["address"] == null
                                    ? "address"
                                    : data["address"],
                                style: TextStyle(
                                  color: grey500Color,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  _updateAddress(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: grey50Color,
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).getTranslated("text_password_profile"),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data["password"] == null
                                    ? "password"
                                    : data["password"],
                                style: TextStyle(
                                  color: grey500Color,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  _updatePassword(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: grey50Color,
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).getTranslated("text_phone_profile"),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:whiteColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data["phone"] == null ? "phone" : data["phone"],
                                style: TextStyle(
                                  color:grey500Color,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  _updatePhone(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: grey50Color,
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).getTranslated("text_Gender_profile"),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                data["gender"] == null
                                    ? "Gender"
                                    : data["gender"],
                                style: TextStyle(
                                  color: grey500Color,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  _updateGender(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: grey50Color,
                                  ),
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future getImageFromGallery() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.photo_library,
                        color: deepPurpleColor,
                      ),
                      title: Text(
                        'Gallery',
                        style: TextStyle(color: deepPurpleColor),
                      ),
                      onTap: () async{
                        getImageFromGallery();
                        // var user = FirebaseAuth.instance.currentUser.uid;
                        // await travelerCollection.doc(user).update({
                        //   "image": _image.path.toString(),
                        // }).then((value) {
                        //   Navigator.pop(context);
                        //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("You Updated Image Successful")));
                        // }).catchError((error) {
                        //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Failed to Image user: $error")));
                        // });

                      }),
                  ListTile(
                    leading: Icon(
                      Icons.photo_camera,
                      color: deepPurpleColor,
                    ),
                    title: Text(
                      'Camera',
                      style: TextStyle(color: deepPurpleColor),
                    ),
                    onTap: () async{
                      getImageFromCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _updateName(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 10,
                right: 10,
                top: 10),
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        AppLocalization.of(context).getTranslated("update_name"),
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: _fullNameController,
                      style: TextStyle(
                        color: blackColor,
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalization.of(context).getTranslated("text_full_name1"),
                        labelStyle: _labelStyle,
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        fillColor: Colors.white,
                        focusedBorder: borderF,
                        enabledBorder: borderE,
                        border: borderE,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context).getTranslated("required_field_full_name");
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_cancel_profile"),style: TextStyle(color: redColor),)),
                        FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var user = FirebaseAuth.instance.currentUser.uid;
                                await travelerCollection.doc(user).update({
                                  "fullName": _fullNameController.text.trim(),
                                }).then((value) {
                                  _fullNameController.clear();
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          "You Updated Full Name Successful")));
                                  print("User Updated");
                                }).catchError((error) {
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Failed to update user: $error")));

                                  print("Failed to update user: $error");
                                });
                              }
                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_update_profile"),style: TextStyle(color: primaryColor),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _updateAddress(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 10,
                right: 10,
                top: 10),
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        AppLocalization.of(context).getTranslated("update_address"),
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: _addressController,
                      style: TextStyle(
                        color: blackColor,
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalization.of(context).getTranslated("text_address"),
                        labelStyle: _labelStyle,
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        fillColor: whiteColor,
                        focusedBorder: borderF,
                        enabledBorder: borderE,
                        border: borderE,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context).getTranslated("required_field_address");
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_cancel_profile"),style: TextStyle(color: redColor),)),
                        FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var user =
                                    FirebaseAuth.instance.currentUser.uid;
                                await travelerCollection.doc(user).update({
                                  "address": _addressController.text.trim(),
                                }).then((value) {
                                  _addressController.clear();
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          "You Updated Address Successful")));
                                  print("Address Updated");
                                }).catchError((error) {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          "Failed to update Address: $error")));

                                  print("Failed to update Address: $error");
                                });
                              }
                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_update_profile"),style: TextStyle(color: primaryColor),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _updatePassword(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 10,
                right: 10,
                top: 10),
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        AppLocalization.of(context).getTranslated("update_password"),
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 1,
                      controller: _passwordController,
                      style: TextStyle(
                        color: blackColor,
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalization.of(context).getTranslated("text_password_register"),
                        labelStyle: _labelStyle,
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        fillColor: whiteColor,
                        focusedBorder: borderF,
                        enabledBorder: borderE,
                        border: borderE,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context).getTranslated("required_field_password_register");
                        } else if (value.length < 6) {
                          return AppLocalization.of(context).getTranslated("strength_field_password_register");
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_cancel_profile"),style: TextStyle(color: redColor),)),
                        FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var user =
                                    FirebaseAuth.instance.currentUser.uid;
                                await travelerCollection.doc(user).update({
                                  "password": _passwordController.text.trim(),
                                }).then((value) {
                                  _passwordController.clear();
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          "You Updated Password Successful")));
                                  print("Password Updated");
                                }).catchError((error) {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          "Failed to update Password: $error")));

                                  print("Failed to update Password: $error");
                                });
                              }
                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_update_profile"),style: TextStyle(color: primaryColor),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _updatePhone(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 10,
                right: 10,
                top: 10),
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        AppLocalization.of(context).getTranslated("update_phone"),
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLines: 1,
                      maxLength: 11,
                      controller: _phoneController,
                      style: TextStyle(
                        color: blackColor,
                      ),
                      decoration: InputDecoration(
                        labelText: AppLocalization.of(context).getTranslated("text_phone"),
                        labelStyle: _labelStyle,
                        prefixIcon: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        fillColor: whiteColor,
                        focusedBorder: borderF,
                        enabledBorder: borderE,
                        border: borderE,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalization.of(context).getTranslated("required_field_phone");
                        } else if (value.length < 11) {
                          return AppLocalization.of(context).getTranslated("check_digits_field_phone");
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_cancel_profile"),style: TextStyle(color: redColor),)),
                        FlatButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var user =
                                    FirebaseAuth.instance.currentUser.uid;
                                await travelerCollection.doc(user).update({
                                  "phone": _phoneController.text.trim(),
                                }).then((value) {
                                  _phoneController.clear();
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "You Updated Phone Successful")));
                                  print("Phone Updated");
                                }).catchError((error) {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                      content: Text(
                                          "Failed to update Phone: $error")));

                                  print("Failed to update Phone: $error");
                                });
                              }
                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_update_profile"),style: TextStyle(color: primaryColor),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _updateGender(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder:(BuildContext context, StateSetter setState)=> Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 10,
                  right: 10,
                  top: 10),
              child: SizedBox(
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        AppLocalization.of(context).getTranslated("update_gender"),
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Radio(
                              value: AppLocalization.of(context).getTranslated("text_male"),
                              groupValue: genderValue,
                              onChanged: (value){
                                setState(() {
                                  genderValue = value;
                                });
                                radioButtonChanges(value);
                              },
                              activeColor: primaryColor,
                            ),
                            Text(
                              AppLocalization.of(context).getTranslated("text_male"),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Radio(
                              value: AppLocalization.of(context).getTranslated("text_female"),
                              groupValue: genderValue,
                              onChanged: (value){
                                setState(() {
                                  genderValue = value;
                                });
                                radioButtonChanges(value);
                              },
                              activeColor: primaryColor,
                            ),
                            Text(
                              AppLocalization.of(context).getTranslated("text_female"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_cancel_profile"),style: TextStyle(color: redColor),)),
                        FlatButton(
                            onPressed: () async {
                                var user =
                                    FirebaseAuth.instance.currentUser.uid;
                                await travelerCollection.doc(user).update({
                                  "gender": genderValue,
                                }).then((value) {
                                  Navigator.pop(context);
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("You Updated Gender Successful")));
                                  print("Gender Updated");
                                }).catchError((error) {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Failed to update Gender: $error")));
                                  print("Failed to update Gender: $error");
                                });

                            },
                            child: Text(AppLocalization.of(context).getTranslated("button_update_profile"),style: TextStyle(color: primaryColor),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class Background extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _circle5(canvas, size);
    _circle3(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void _circle3(Canvas canvas, Size size) {
    Gradient gradient1 = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        primaryColor,
        primaryColor,
      ],
      stops: [0.0, 0.3],
    );
    Paint paint1 = Paint();
    Rect rect1 = Rect.fromLTWH(0, 0, size.width, size.height);
    paint1.shader = gradient1.createShader(rect1);
    Offset offset1 =
        Offset(size.width - (size.width * 0.05), size.height * 0.1);
    Offset offset2 =
        Offset(size.width - (size.width * 0.05) - 3, size.height * 0.1 - 3);
    Path path = Path();
    Rect rect = Rect.fromCircle(center: offset2, radius: 175);
    path.addOval(rect);
    canvas.drawShadow(path, blackColor.withOpacity(0.4), 6, true);
    canvas.drawCircle(offset1, 170, paint1);
  }

  void _circle5(Canvas canvas, Size size) {
    Gradient gradient5 = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryColor,
        primaryColor,
      ],
      stops: [0.2, 0.4],
    );
    Paint paint5 = Paint();
    Rect rect7 = Rect.fromLTWH(0, 0, size.width, size.height);
    paint5.shader = gradient5.createShader(rect7);
    Offset offset7 = Offset(size.width * 0.1 - (size.width * 0.25),
        size.height - (size.height * 0.65));
    Offset offset8 = Offset(size.width * 0.1 - (size.width * 0.25) - 3,
        size.height - (size.height * 0.65) - 3);
    Path path4 = Path();
    Rect rect8 = Rect.fromCircle(center: offset8, radius: 163);
    path4.addOval(rect8);
    canvas.drawShadow(path4, blackColor.withOpacity(0.4), 8, true);
    canvas.drawCircle(offset7, 155, paint5);
  }
}

class CirclePainter extends CustomPainter {
  final _paint = Paint()
    ..color = whiteColor
    ..strokeWidth = 4
    // Use [PaintingStyle.fill] if you want the circle to be filled.
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
