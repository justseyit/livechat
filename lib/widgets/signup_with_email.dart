import 'package:flutter/material.dart';

class SignUpWithEmail extends StatefulWidget {
  const SignUpWithEmail({Key? key, required this.emailController, required this.passwordController, required this.verifyPasswordController, required this.formKey, this.emailValidator, this.passwordValidator, this.verifyPasswordValidator, this.onEmailSaved, this.onPasswordSaved, this.onVerifyPasswordSaved}) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController verifyPasswordController;
  final GlobalKey<FormState> formKey;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? verifyPasswordValidator;
  final void Function(String?)? onEmailSaved;
  final void Function(String?)? onPasswordSaved;
  final void Function(String?)? onVerifyPasswordSaved;

  @override
  _SignUpWithEmailState createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpWithEmail> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        primarySwatch: Colors.deepPurple,
      ),
      child: Container(
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: widget.emailController,
                validator: widget.emailValidator,
                onSaved: widget.onEmailSaved,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  hintText: 'Email',
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 4,),
              TextFormField(
                obscureText: true,
                controller: widget.passwordController,
                validator: widget.passwordValidator,
                onSaved: widget.onPasswordSaved,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  hintText: 'Password',
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 4,),
              TextFormField(
                obscureText: true,
                controller: widget.verifyPasswordController,
                validator: widget.verifyPasswordValidator,
                onSaved: widget.onVerifyPasswordSaved,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                  hintText: 'Verify Password',
                  labelText: 'Verify Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
