import 'package:flutter/material.dart';

import 'widgets.dart';

class NewPasswordScreen extends StatefulWidget {
  NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  //  Requisitos en tiempo real
  bool get _hasLength => _passCtrl.text.length >= 8;
  bool get _hasUpper => RegExp(r'[A-Z]').hasMatch(_passCtrl.text);
  bool get _hasNumber => RegExp(r'\d').hasMatch(_passCtrl.text);
  bool get _match =>
      _confirmCtrl.text.isNotEmpty && _confirmCtrl.text == _passCtrl.text;
  bool get _formValid => _hasLength && _hasUpper && _hasNumber && _match;

  String? get _confirmError => _confirmCtrl.text.isNotEmpty && !_match
      ? 'Las contraseñas no coinciden'
      : null;

  @override
  void dispose() {
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _reset() {
    // El messenger vive en MaterialApp, así que el SnackBar sobrevive al cambio de ruta.
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    messenger.showSnackBar(
      const SnackBar(
        content: Text('Contraseña actualizada correctamente'),
        backgroundColor: Color(0xFF16A34A),
      ),
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
              gradient: AppGradients.primary,
            ),
          ),
          const Positioned(
            top: 185,
            right: 20,
            child: Blob(size: 26, gradient: AppGradients.yellow),
          ),
          const Positioned(
            bottom: -50,
            left: -40,
            child: Blob(size: 150, gradient: AppGradients.blue),
          ),
          const Positioned(
            bottom: 10,
            right: -10,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      AppBackButton(onTap: () => Navigator.pop(context)),
                      const SizedBox(height: 18),

                      // Chip "Código verificado"
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.check_rounded,
                              size: 14,
                              color: Color(0xFF16A34A),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Código verificado',
                              style: TextStyle(
                                color: Color(0xFF16A34A),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const GradientIconBox(
                        icon: Icons.lock_outline_rounded,
                        size: 54,
                        radius: 16,
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'Crea una nueva\ncontraseña',
                        style: TextStyle(
                          fontSize: 28,
                          height: 1.2,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Tu nueva contraseña debe ser diferente a las que usaste antes.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: AppColors.textGrey,
                        ),
                      ),
                      const SizedBox(height: 24),

                      CustomInput(
                        label: 'Nueva contraseña',
                        hint: '••••••••',
                        controller: _passCtrl,
                        isPassword: true,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
                        label: 'Confirmar contraseña',
                        hint: '••••••••',
                        controller: _confirmCtrl,
                        isPassword: true,
                        errorText: _confirmError,
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 18),

                      // Requisitos dinámicos
                      _Requirement(text: 'Mínimo 8 caracteres', ok: _hasLength),
                      const SizedBox(height: 8),
                      _Requirement(
                        text: 'Al menos una mayúscula',
                        ok: _hasUpper,
                      ),
                      const SizedBox(height: 8),
                      _Requirement(text: 'Al menos un número', ok: _hasNumber),
                      const SizedBox(height: 24),

                      PrimaryButton(
                        text: 'Restablecer contraseña',
                        onPressed: _formValid ? _reset : null,
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

/// Fila de un requisito: check verde si se cumple, gris si no.
class _Requirement extends StatelessWidget {
  final String text;
  final bool ok;

  const _Requirement({required this.text, required this.ok});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ok ? const Color(0xFFDCFCE7) : const Color(0xFFE5E7EB),
          ),
          child: Icon(
            Icons.check_rounded,
            size: 12,
            color: ok ? const Color(0xFF22C55E) : const Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.5,
            color: ok ? AppColors.textDark : AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}
