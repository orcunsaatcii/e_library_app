import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  bool _accountExist = true;
  bool _hidePassword = true;
  String _enteredUsername = "";
  String _enteredEmail = "";
  String _enteredPassword = "";
  String _enteredConfirmPassword = "";

  void submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();

    try {
      if (_accountExist) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        if (_enteredPassword != _enteredConfirmPassword) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Passwords doesn\'t match'),
            ),
          );
        } else {
          final userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _enteredEmail, password: _enteredPassword);

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set(
            {
              'username': _enteredUsername,
              'email': _enteredEmail,
            },
          );
          _form.currentState!.reset();
        }
      }
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message ?? 'Authentication failed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/book.png',
                width: 175,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Welcome to E-Library',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _form,
                child: Column(
                  children: [
                    if (!_accountExist)
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          label: const Text('Username'),
                        ),
                        autocorrect: false,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 4) {
                            return 'Username must be at least 4 characters';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredUsername = newValue!;
                        },
                      ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: Icon(
                          Icons.mail,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: const Text('Email Address'),
                      ),
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.trim().contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredEmail = newValue!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          icon: const Icon(Icons.remove_red_eye),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: const Text('Password'),
                      ),
                      obscureText: _hidePassword ? true : false,
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredPassword = newValue!;
                      },
                    ),
                    if (!_accountExist) const SizedBox(height: 20),
                    if (!_accountExist)
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            icon: const Icon(Icons.remove_red_eye),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          label: const Text('Confirm Password'),
                        ),
                        obscureText: _hidePassword ? true : false,
                        validator: (value) {
                          if (value == null || value.trim().length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredConfirmPassword = newValue!;
                        },
                      ),
                    GestureDetector(
                      onTap: submit,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.6),
                              Theme.of(context).colorScheme.primary,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _accountExist ? 'SIGN IN' : 'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _accountExist
                        ? 'Don\'t have any account ?'
                        : 'I have already an account',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _accountExist = !_accountExist;
                        });
                        _form.currentState!.reset();
                      },
                      child: Text(
                        _accountExist ? 'Register' : 'Sign in',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
