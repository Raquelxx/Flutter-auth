import 'package:flutter/material.dart';

import 'widgets.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _accepted = false;

  // Validaciones
  bool get _nameValid => _nameCtrl.text.trim().length >= 2;
  bool get _emailValid => Validators.isEmail(_emailCtrl.text);
  bool get _passValid => _passCtrl.text.length >= 8;
  bool get _matchValid =>
      _confirmCtrl.text.isNotEmpty && _confirmCtrl.text == _passCtrl.text;
  bool get _formValid =>
      _nameValid && _emailValid && _passValid && _matchValid && _accepted;

  String? get _nameError => _nameCtrl.text.isNotEmpty && !_nameValid
      ? 'Ingresa tu nombre completo'
      : null;
  String? get _emailError => _emailCtrl.text.isNotEmpty && !_emailValid
      ? 'Ingresa un correo válido'
      : null;
  String? get _passError =>
      _passCtrl.text.isNotEmpty && !_passValid ? 'Mínimo 8 caracteres' : null;
  String? get _confirmError => _confirmCtrl.text.isNotEmpty && !_matchValid
      ? 'Las contraseñas no coinciden'
      : null;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _goLogin() =>
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

  void _register() {
    Navigator.pushNamed(context, '/home', arguments: _emailCtrl.text.trim());
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
            top: -90,
            right: -80,
            child: Blob(size: size.width * 0.65, gradient: AppGradients.orange),
          ),
          Positioned(
            top: 120,
            right: 40,
            child: const Ring(size: 38, color: Color(0xFF8B5CF6), thickness: 6),
          ),
          const Positioned(
            top: 165,
            right: -8,
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
            bottom: -50,
            right: -50,
            child: Blob(size: 170, gradient: AppGradients.blue),
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
                      const SizedBox(height: 24),
                      const Text(
                        'Crea tu cuenta',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Completa tus datos para empezar',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textGrey,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Formulario
                      CustomInput(
                        label: 'Nombre completo',
                        hint: 'Juan Pérez',
                        controller: _nameCtrl,
                        errorText: _nameError,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
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
                        hint: 'Mínimo 8 caracteres',
                        controller: _passCtrl,
                        isPassword: true,
                        errorText: _passError,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Confirmar contraseña',
                        hint: 'Repite tu contraseña',
                        controller: _confirmCtrl,
                        isPassword: true,
                        errorText: _confirmError,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 18),

                      // Términos
                      _TermsRow(
                        accepted: _accepted,
                        onToggle: () => setState(() => _accepted = !_accepted),
                      ),
                      const SizedBox(height: 22),

                      PrimaryButton(
                        text: 'Crear cuenta',
                        onPressed: _formValid ? _register : null,
                      ),
                      const SizedBox(height: 28),

                      // Pie
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '¿Ya tienes cuenta? ',
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

/// Fila del checkbox de términos y condiciones.
class _TermsRow extends StatelessWidget {
  final bool accepted;
  final VoidCallback onToggle;

  const _TermsRow({required this.accepted, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    const link = TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
      fontSize: 12.5,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              gradient: accepted ? AppGradients.primary : null,
              color: accepted ? null : Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: accepted
                  ? null
                  : Border.all(color: AppColors.border, width: 1.5),
            ),
            child: accepted
                ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
                : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: onToggle,
            child: Text.rich(
              TextSpan(
                style: const TextStyle(
                  color: AppColors.textGrey,
                  fontSize: 12.5,
                  height: 1.4,
                ),
                children: const [
                  TextSpan(text: 'Acepto los '),
                  TextSpan(text: 'Términos y condiciones', style: link),
                  TextSpan(text: ' y la '),
                  TextSpan(text: 'Política de privacidad', style: link),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
