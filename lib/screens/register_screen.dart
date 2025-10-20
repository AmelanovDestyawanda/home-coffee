import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Color?>? _color1;
  Animation<Color?>? _color2;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))
        ..repeat(reverse: true);

      _color1 = ColorTween(
        begin: Theme.of(context).colorScheme.primary,
        end: const Color(0xFFD2B48C),
      ).animate(_controller!);

      _color2 = ColorTween(
        begin: const Color(0xFFD2B48C),
        end: Theme.of(context).colorScheme.primary,
      ).animate(_controller!);
      
      _controller!.addListener(() {
        if(mounted) {
          setState(() {});
        }
      });
    });
  }
  
  @override
  void dispose() {
    _controller?.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
  if (nameController.text.isEmpty ||
      emailController.text.isEmpty ||
      passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Semua kolom wajib diisi!")),
    );
    return;
  }
  if (passwordController.text != confirmPasswordController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password dan konfirmasi tidak cocok!")),
    );
    return;
  }

  Provider.of<UserProvider>(context, listen: false)
      .updateUser(nameController.text, emailController.text);
  Navigator.pushReplacementNamed(context, '/main');
}

  @override
  Widget build(BuildContext context) {
    if (_controller == null || _color1 == null || _color2 == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, 
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_color1!.value ?? Colors.brown, _color2!.value ?? Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo.png", width: 100),
                const SizedBox(height: 20),
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Start your coffee journey with us!",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 40),
                _buildTextField(
                  controller: nameController,
                  labelText: "Full Name",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: emailController,
                  labelText: "Email",
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: passwordController,
                  labelText: "Password",
                  icon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  isPassword: true,
                  onSuffixIconPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: confirmPasswordController,
                  labelText: "Confirm Password",
                  icon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  isPassword: true,
                  onSuffixIconPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: _register,
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    bool isPassword = false,
    VoidCallback? onSuffixIconPressed,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: onSuffixIconPressed,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white54),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}