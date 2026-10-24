import 'package:flutter/material.dart';

import 'widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final email = args is String ? args : 'usuario@correo.com';
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          //  Formas decorativas
          Positioned(
            top: -110,
            right: -90,
            child: Blob(size: size.width * 0.8, gradient: AppGradients.primary),
          ),
          const Positioned(
            top: 120,
            left: 36,
            child: Blob(size: 30, gradient: AppGradients.yellow),
          ),
          Positioned(
            top: size.height * 0.4,
            left: -22,
            child: const Ring(size: 44, color: Color(0xFFF472B6), thickness: 5),
          ),
          Positioned(
            bottom: size.height * 0.04,
            left: -80,
            child: const Blob(size: 210, gradient: AppGradients.blue),
          ),
          Positioned(
            bottom: size.height * 0.2,
            right: -10,
            child: const Blob(
              size: 62,
              gradient: AppGradients.amber,
              square: true,
              angle: 0.4,
            ),
          ),

          //  Contenido
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const GradientIconBox(
                              icon: Icons.person_outline_rounded,
                              size: 96,
                              circle: true,
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              '¡Bienvenido!',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.chipBg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.mail_outline_rounded,
                                    size: 18,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      email,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 56),
                            PrimaryButton(
                              text: 'Cerrar sesión',
                              onPressed: () =>
                                  Navigator.pushReplacementNamed(context, '/'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
