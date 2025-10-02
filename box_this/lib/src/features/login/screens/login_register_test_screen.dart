import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:box_this/src/data/repositories/firebase_auth_repository.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentifizierung')),
     body: StreamBuilder<User?>(
        stream: FirebaseAuthRepository.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            return WelcomeScreen();
          } else {
            return AuthForm();
          }
        },
      ),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuthRepository.instance.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erfolgreich eingeloggt')));
      } on Exception catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  void _submitForRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuthRepository.instance.createUserWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Konto erfolgreich erstellt')),
        );
      } on Exception catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                    _submitForLogin();
                  }
                },
                child: const Text(
                  'Einloggen',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _submitForRegister();
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

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuthRepository.instance
          .signOut(); // Verwendet die Ausloggen-Funktion

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erfolgreich ausgeloggt')),
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _deleteAccount(BuildContext context) async {
    try {
      await FirebaseAuthRepository.instance
          .deleteAccount(); // Löscht das Konto des angemeldeten Benutzers

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konto wurde gelöscht')),
      );
    } on Exception catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Willkommen!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              selectionColor: Colors.black,
            ),
            const SizedBox(height: 16),
            const Text(
              'Sie sind eingeloggt.',
              style: TextStyle(color: Color.fromARGB(255, 0, 92, 3)),
            ),
            const SizedBox(height: 16),
            IconButton(onPressed: () {
              _logout(context);
            }, icon: const Icon(Icons.logout)),
            const SizedBox(height: 16),
            IconButton(onPressed: () {
              _deleteAccount(context);
            }, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
