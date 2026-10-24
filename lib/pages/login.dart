import 'package:flutter/material.dart';

import 'widgets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  static final _emailRegex = RegExp(r'^[\w\.\-+]+@([\w\-]+\.)+[a-zA-Z]{2,}$');

  bool get _emailValid => _emailRegex.hasMatch(_emailCtrl.text.trim());
  bool get _formValid => _emailValid && _passCtrl.text.isNotEmpty;

  String? get _emailError {
    final t = _emailCtrl.text.trim();
    if (t.isEmpty) return null;
    return _emailValid ? null : 'Ingresa un correo válido';
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    Navigator.pushNamed(context, '/home', arguments: _emailCtrl.text.trim());
  }

  void _unavailable() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidad no disponible')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          //  Formas decorativas
          Positioned(
            top: -90,
            right: -80,
            child: Blob(
              size: size.width * 0.75,
              gradient: AppGradients.primary,
            ),
          ),
          const Positioned(
            top: 80,
            left: 36,
            child: Blob(size: 26, gradient: AppGradients.yellow),
          ),
          const Positioned(
            top: 150,
            left: -60,
            child: Blob(size: 130, gradient: AppGradients.blue),
          ),
          Positioned(
            top: size.height * 0.68,
            left: -18,
            child: const Ring(size: 34, color: Color(0xFF06B6D4)),
          ),
          const Positioned(
            bottom: -50,
            left: -30,
            child: Blob(size: 150, gradient: AppGradients.pink),
          ),
          const Positioned(
            bottom: 20,
            right: -8,
            child: Blob(
              size: 62,
              gradient: AppGradients.amber,
              square: true,
              angle: 0.35,
            ),
          ),

          // Contenido
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 56),
                      const GradientIconBox(
                        icon: Icons.lock_outline_rounded,
                        size: 68,
                        radius: 20,
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'Bienvenido de nuevo',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Inicia sesión para continuar',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textGrey,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Formulario
                      CustomInput(
                        label: 'Correo electrónico',
                        hint: 'tu@correo.com',
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        errorText: _emailError,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Contraseña',
                        hint: '••••••••',
                        controller: _passCtrl,
                        isPassword: true,
                        onChanged: (_) => setState(() {}),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/forgot-password'),
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      PrimaryButton(
                        text: 'Iniciar sesión',
                        onPressed: _formValid ? _login : null,
                      ),
                      const SizedBox(height: 24),

                      // Divisor
                      Row(
                        children: const [
                          Expanded(child: Divider(color: AppColors.border)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'o continúa con',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: AppColors.border)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              text: 'Google',
                              onPressed: _unavailable,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SecondaryButton(
                              text: 'Apple',
                              onPressed: _unavailable,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // Pie
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿No tienes cuenta? ',
                            style: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/register'),
                            child: const Text(
                              'Regístrate',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
