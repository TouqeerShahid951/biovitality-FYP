import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/user_register_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  RegisterService _registerService = RegisterService();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Image(
                  image: AssetImage('assets/images/signup.png'),
                  height: height * 0.2,
                ),
                SizedBox(height: 12),
                Text(
                  'Register First',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Plants Health Guardian: Detect, Prevent, Thrive',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined, color: Colors.green),
                          labelText: 'Enter Username',
                          hintText: 'John Doe',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Username';
                          }
                          return null;
                        },
                        style: GoogleFonts.poppins(
                          color: Colors.green[900],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.green),
                          labelText: 'Enter Email Address',
                          hintText: 'johndoe@gmail.com',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter an Email Address';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        style: GoogleFonts.poppins(
                          color: Colors.green[900],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_open_outlined, color: Colors.green),
                          labelText: 'Enter Password',
                          hintText: 'Password must be 6 characters',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        style: GoogleFonts.poppins(
                          color: Colors.green[900],
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await _registerService.registerToFb(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                nameController.text.trim(),
                                context,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: isLoading
                              ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            'Sign Up'.toUpperCase(),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 18.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text('OR'),
                      SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            await _registerService.registerWithGoogle(context);
                          },
                          icon: Image.asset(
                            'assets/images/google.png',
                            width: 20.0,
                          ),
                          label: Text(
                            'Sign-In with Google',
                            style: GoogleFonts.poppins(
                              color: Colors.green[900],
                              fontSize: 15,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 18.0),
                            side: BorderSide(color: Colors.green[900]!),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Already have an Account? Login',
                          style: GoogleFonts.poppins(
                            color: Colors.green[800],
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}