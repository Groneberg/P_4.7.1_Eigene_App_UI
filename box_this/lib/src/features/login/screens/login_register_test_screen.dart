import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:box_this/src/data/repositories/firebase_auth_repository.dart';
// Definieren Sie eine konstante Instanz Ihres Repositories

class AuthScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentifizierung')),
      body: Center(
        // Form for register
        child: Form(
          key: _formKey,
          //
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-Mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Bitte eine gültige E-Mail-Adresse eingeben';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Passwort',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Passwort muss mindestens 6 Zeichen lang sein';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuthRepository.instance
                          .signInWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: const Text(
                  'Einloggen',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuthRepository.instance
                          .createUserWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: const Text(
                  'Registrieren',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class AuthForm extends StatefulWidget {
//   const AuthForm({super.key});

//   @override
//   _AuthFormState createState() => _AuthFormState();
// }

// class _AuthFormState extends State<AuthForm> {
//   final _formKey = GlobalKey<FormState>();
//   String _email = '';
//   String _password = '';
//   bool _isLogin = true;

//   void _submit() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         if (_isLogin) {
//           await FirebaseAuthRepository.instance.signInWithEmailAndPassword(
//             _email,
//             _password,
//           ); // Verwendet die Anmeldefunktion
//         } else {
//           await FirebaseAuthRepository.instance.createUserWithEmailAndPassword(
//             _email,
//             _password,
//           ); // Verwendet die Registrierungsfunktion
//         }
//       } on Exception catch (e) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text(e.toString())));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         margin: EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     _isLogin ? 'Einloggen' : 'Registrieren',
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   TextFormField(
//                     key: ValueKey('email'),
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(labelText: 'E-Mail-Adresse'),
//                     validator: (value) {
//                       if (value!.isEmpty || !value.contains('@')) {
//                         return 'Bitte geben Sie eine gültige E-Mail-Adresse ein.';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       _email = value!;
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Passwort',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   TextFormField(
//                     key: ValueKey('password'),
//                     decoration: InputDecoration(labelText: 'Passwort'),
//                     obscureText: true,
//                     validator: (value) {
//                       if (value!.isEmpty || value.length < 6) {
//                         return 'Passwort muss mindestens 6 Zeichen lang sein.';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       _password = value!;
//                     },
//                   ),
//                   SizedBox(height: 12),
//                   ElevatedButton(
//                     onPressed: _submit,
//                     child: Text(_isLogin ? 'Einloggen' : 'Registrieren', style: TextStyle(
//                       color: Colors.black,
//                     ),),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         _isLogin = !_isLogin;
//                       });
//                     },
//                     child: Text(
//                       _isLogin
//                           ? 'Neues Konto erstellen'
//                           : 'Ich habe bereits ein Konto',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LoggedInScreen extends StatelessWidget {
//   final User user;

//   LoggedInScreen({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Angemeldet als: ${user.email}',
//             style: TextStyle(fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () async {
//               try {
//                 await FirebaseAuthRepository.instance
//                     .signOut(); // Verwendet die Ausloggen-Funktion
//               } on Exception catch (e) {
//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(SnackBar(content: Text(e.toString())));
//               }
//             },
//             child: Text('Ausloggen'),
//           ),
//           SizedBox(height: 10),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             onPressed: () async {
//               try {
//                 await user
//                     .delete(); // Löscht das Konto des angemeldeten Benutzers
//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(SnackBar(content: Text('Konto wurde gelöscht')));
//               } on Exception catch (e) {
//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(SnackBar(content: Text(e.toString())));
//               }
//             },
//             child: Text('Konto löschen'),
//           ),
//         ],
//       ),
//     );
//   }
// }
