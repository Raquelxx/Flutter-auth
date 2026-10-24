import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets.dart';

class VerificationCodeScreen extends StatefulWidget {
  VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  static const _totalSeconds = 45;

  final _controllers = List.generate(4, (_) => TextEditingController());
  final _focusNodes = List.generate(4, (_) => FocusNode());

  Timer? _timer;
  int _seconds = _totalSeconds;

  bool get _complete => _controllers.every((c) => c.text.isNotEmpty);
  bool get _canResend => _seconds == 0;

  String get _timeText {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = _totalSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds <= 1) {
        t.cancel();
        setState(() => _seconds = 0);
      } else {
        setState(() => _seconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  void _onBackspaceWhenEmpty(int index) {
    if (index > 0) {
      _controllers[index - 1].clear();
      _focusNodes[index - 1].requestFocus();
      setState(() {});
    }
  }

  void _resend() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
    _startTimer();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Código reenviado')));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final email = args is String ? args : 'usuario@correo.com';
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Formas decorativas
          Positioned(
            top: -110,
            right: -90,
            child: Blob(size: size.width * 0.75, gradient: AppGradients.orange),
          ),
          Positioned(
            top: size.height * 0.2,
            right: 28,
            child: const Ring(size: 36, color: Color(0xFF8B5CF6), thickness: 6),
          ),
          const Positioned(
            bottom: -60,
            right: -40,
            child: Blob(size: 190, gradient: AppGradients.blue),
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
                      // Botón atrás
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/forgot-password'),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(
                            Icons.chevron_left_rounded,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      const GradientIconBox(
                        icon: Icons.verified_user_outlined,
                        gradient: AppGradients.orange,
                        size: 54,
                        radius: 16,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Verifica tu correo',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Escribe el código de 4 dígitos que enviamos a',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textGrey,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Casillas del código
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (i) => CodeDigitInput(
                            controller: _controllers[i],
                            focusNode: _focusNodes[i],
                            onChanged: (v) => _onDigitChanged(i, v),
                            onBackspaceWhenEmpty: () =>
                                _onBackspaceWhenEmpty(i),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Temporizador / reenviar
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '¿No te llegó? ',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 13,
                              ),
                            ),
                            if (_canResend)
                              GestureDetector(
                                onTap: _resend,
                                child: const Text(
                                  'Reenviar código',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            else
                              Text(
                                'Reenviar código en $_timeText',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      PrimaryButton(
                        text: 'Siguiente',
                        onPressed: _complete
                            ? () =>
                                  Navigator.pushNamed(context, '/new-password')
                            : null,
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
