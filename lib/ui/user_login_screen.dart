import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../admin/admin_ui/admin_login_screen.dart';
import '../services/user_login_service.dart';
import '../services/forgot_password_service.dart';
import 'bottomActivities/home_screen.dart';
import 'user_register_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService _loginService = LoginService();
  final ForgotPasswordService _forgotPasswordService = ForgotPasswordService();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isLoading = false;

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
                SizedBox(height: 30),
                Image(
                  image: AssetImage('assets/images/signin.png'),
                  height: height * 0.15,
                ),
                SizedBox(height: 16),
                Text(
                  'Welcome Back',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Swift Answers, Better Plants Health: Welcome to BioVitality',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined, color: Colors.green),
                          labelText: 'Email',
                          hintText: 'xyz@gmail.com',
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
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint, color: Colors.green),
                          labelText: 'Password',
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,
                              color: Colors.green,
                            ),
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
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              _forgotPassword();
                            },
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.poppins(
                                color: Colors.green[800],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AdminLoginScreen()),
                              );
                            },
                            child: Text(
                              'Login as Admin',
                              style: GoogleFonts.poppins(
                                color: Colors.green[800],
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green[900],
                            padding: EdgeInsets.symmetric(vertical: 18.0),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            'Login'.toUpperCase(),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('OR'),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _loginWithGoogle();
                          },
                          icon: Image.asset(
                            'assets/images/google.png',
                            width: 20.0,
                          ),
                          label: Text(
                            'Login with Google',
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
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an Account? ',
                                style: GoogleFonts.poppins(
                                  color: Colors.green[800],
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: 'Register',
                                style: GoogleFonts.poppins(
                                  color: Colors.green[800],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential? userCredential = await _loginService.login(
        emailController.text,
        passwordController.text,
      );
      if (userCredential != null && userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          bool userExists = await _loginService.checkIfUserExists(emailController.text);
          if (userExists) {
            String uid = userCredential.user!.uid;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home(uid: uid)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Account not found, please register to login'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please verify your email address'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      print("Login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid credentials'),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential? userCredential = await _loginService.loginWithGoogle();
      if (userCredential != null && userCredential.user != null) {
        bool userExists = await _loginService.checkIfUserExists(userCredential.user!.email!);
        if (userExists) {
          String uid = userCredential.user!.uid;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home(uid: uid)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account not found, please register to login'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      print("Google login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in with Google'),
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _forgotPassword() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email address'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      await _forgotPasswordService.sendPasswordResetEmail(emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print("Forgot password error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send password reset email'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}