import 'package:flutter/material.dart';

import 'widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();

  bool get _emailValid => Validators.isEmail(_emailCtrl.text);
  String? get _emailError => _emailCtrl.text.isNotEmpty && !_emailValid
      ? 'Ingresa un correo válido'
      : null;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _goLogin() =>
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

  void _sendCode() {
    Navigator.pushNamed(
      context,
      '/verification',
      arguments: _emailCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Formas decorativas
          Positioned(
            top: -110,
            right: -90,
            child: Blob(
              size: size.width * 0.75,
              gradient: const LinearGradient(
                colors: [Color(0xFF22B8E6), Color(0xFF4F7CF7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          const Positioned(
            top: 170,
            right: 30,
            child: Blob(size: 24, gradient: AppGradients.yellow),
          ),
          const Positioned(
            bottom: -20,
            left: -20,
            child: Blob(
              size: 60,
              gradient: AppGradients.primary,
              square: true,
              angle: 0.3,
            ),
          ),
          const Positioned(
            bottom: -40,
            right: -40,
            child: Blob(
              size: 130,
              gradient: LinearGradient(
                colors: [Color(0xFFFFE8C7), Color(0xFFFFD6B0)],
              ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      AppBackButton(onTap: _goLogin),
                      const SizedBox(height: 26),
                      const GradientIconBox(
                        icon: Icons.mail_outline_rounded,
                        gradient: LinearGradient(
                          colors: [Color(0xFF22B8E6), Color(0xFF4F7CF7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        size: 54,
                        radius: 16,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '¿Olvidaste tu\ncontraseña?',
                        style: TextStyle(
                          fontSize: 28,
                          height: 1.2,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Ingresa el correo con el que te registraste y te enviaremos un código de 4 dígitos.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: AppColors.textGrey,
                        ),
                      ),
                      const SizedBox(height: 28),
                      CustomInput(
                        label: 'Correo electrónico',
                        hint: 'tu@correo.com',
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        errorText: _emailError,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        text: 'Enviar código',
                        onPressed: _emailValid ? _sendCode : null,
                      ),
                      const SizedBox(height: 80),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '¿La recordaste? ',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 13,
                              ),
                            ),
                            GestureDetector(
                              onTap: _goLogin,
                              child: const Text(
                                'Inicia sesión',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
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
