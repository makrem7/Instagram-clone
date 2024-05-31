import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  const LoginScreen(this.show , {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  FocusNode emailF = FocusNode();
  final password = TextEditingController();
  FocusNode passwordF = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 96.w, height: 100.h),
              Center(
                child: SizedBox(
                  width: 175.w,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(height: 120.h),
              CustomTextField(
                  controller: email,
                  focusNode: emailF,
                  icon: Icons.email,
                  type: "Email"),
              SizedBox(height: 15.h),
              CustomTextField(
                  controller: password,
                  focusNode: passwordF,
                  icon: Icons.lock,
                  type: "Password"),
              SizedBox(height: 10.h),
              const Forgot(),
              SizedBox(height: 10.h),
              const Login(),
              SizedBox(height: 10.h),
              Have(show: widget.show),
            ],
          ),
        ),
      ),
    );
  }
}

class Have extends StatelessWidget {
  const Have({
    super.key,
    required this.show
  });
  final VoidCallback show;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Don't have account? ",
              style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
          GestureDetector(
            onTap: show,
            child: Text("Signup",
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          "Log in",
          style: TextStyle(
              fontSize: 23.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class Forgot extends StatelessWidget {
  const Forgot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        "Forgot your password?",
        style: TextStyle(
            fontSize: 13.sp, color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.icon,
    required this.type,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final IconData icon;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
              hintText: type,
              prefixIcon: Icon(
                icon,
                color: focusNode.hasFocus ? Colors.black : Colors.grey,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Colors.grey, width: 2.w)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(color: Colors.black, width: 2.w))),
        ),
      ),
    );
  }
}
