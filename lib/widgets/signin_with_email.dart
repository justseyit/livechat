import 'package:flutter/material.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({Key? key, required this.emailController, required this.passwordController, required this.formKey, required this.emailValidator, required this.passwordValidator, this.onEmailSaved, this.onPasswordSaved}) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;
  final void Function(String?)? onEmailSaved;
  final void Function(String?)? onPasswordSaved;

  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
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
            ],
          ),
        ),
      ),
    );
  }
}
