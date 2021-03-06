import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kidzone_app/Center/Screen/Centers_Bottom_Taps_screen.dart';
import 'package:kidzone_app/Center/Screen/Center_Signup.dart';
import '../../resetpassword.dart';

class LoginCenter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoginCenter> {

   String _email;
   String _password;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
   String _error;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    return initWidget();
  }

  initWidget() {


    Future<String> canLogin(String email) async {
      String state;

      await FirebaseFirestore.instance
          .collection('Centers')
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) => state = doc['state']);
        print('$state inside canlog function');
      });
      return state;
    }


    bool validateAndSave() {
      final form = _formKey.currentState;
      if (form.validate()) {
        // التحقق من الفورم
        form.save();
        return true;
      }
      return false;
    }

    void validateAndSubmit() async {
      if (validateAndSave()) {
        setState(() => loading = true);
        dynamic state = await canLogin(_email);
        print('$state inside onpress function');
        if (state == 'Active') { //should be active to log in (from the kids
          // app Admin)
          try {
            await auth.signInWithEmailAndPassword(
                email: _email, password: _password);

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CentersBottomTapsScreens()));

          } catch (e) {
            print('Error: $e');
            setState(() {
              _error = e.toString();
            });
            Fluttertoast.showToast(
              msg: "كلمة المرور غير صحيحة",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 20.0,
            );
            setState(() => loading = false);
          }
        } else {
          setState(() => loading = false);
          print('This user is not a Center');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginCenter(),
            ),
          );

          Fluttertoast.showToast(
            msg: "البريد الإلكتروني غير تابع لمركز، او انتظر للموافقه على طلبك",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 20.0,
          );
        }
      }
    }


    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                      color: new Color(0xFFFFFFFF),
                      gradient: LinearGradient(
                        colors: [(new Color(0xFFBBA68C8)), new Color(0xFFBBA68C8)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,),
                    ),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 20, top: 20),
                              alignment: Alignment.center,
                              child: Text("تسجيل دخول",
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),],
                        ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)),
                      ],),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'البريد الإلكتروني مطلوب';
                        }
                        return null;
                        },
                      onSaved: (String value) {
                        _email = value;
                        },
                      cursorColor: Color(0xFFBBA68C8),
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Color(0xFFBBA68C8),
                        ),
                        hintText: "البريد الالكتروني ",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xffEEEEEE),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)),
                      ],),
                    child: TextFormField(
                      obscureText: true,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return ' كلمة المرور مطلوبة';
                        }
                        return null;
                        },
                      onSaved: (String value) {
                        _password = value;
                        },
                      cursorColor: Color(0xFFBBA68C8),
                      decoration: InputDecoration(
                        focusColor: Color(0xFFBBA68C8),
                        icon: Icon(
                          Icons.lock_outline,
                          color: Color(0xFFBBA68C8),
                        ),
                        hintText: "كلمة المرور ",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ResetPasswordScreen()));
                      },
                      child: Text("هل نسيت كلمة المرور؟"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      validateAndSubmit();
                      },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [(new Color(0xFFBBA68C8)), new Color(0xFFBBA68C8)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE)),
                        ],
                      ),
                      child: Text("دخول",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ليس لديك حساب؟ "),
                        GestureDetector(
                          child: Text("سجل الان",
                            style: TextStyle(color: Color(0xFFBBA68C8)),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpCenter(),)

                            );},
                        )],
                    ),
                  )],
              ),
            )
        )
    );
  }
}
