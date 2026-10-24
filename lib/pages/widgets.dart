import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// PALETA Y GRADIENTES

class AppColors {
  static const background = Color(0xFFF8F6FF);
  static const textDark = Color(0xFF14142B);
  static const textGrey = Color(0xFF7A7A8C);
  static const border = Color(0xFFE6E4F0);
  static const primary = Color(0xFF7F3DFF);
  static const error = Color(0xFFE53935);
  static const chipBg = Color(0xFFEDE7FF);
}

class AppGradients {
  static const primary = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const button = LinearGradient(
    colors: [Color(0xFF7F3DFF), Color(0xFFE053B2)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const orange = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const blue = LinearGradient(
    colors: [Color(0xFFBFE3FF), Color(0xFFC9D6FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const pink = LinearGradient(
    colors: [Color(0xFFFBD3EA), Color(0xFFF9C6E0)],
  );
  static const yellow = LinearGradient(
    colors: [Color(0xFFFFD60A), Color(0xFFFFC107)],
  );
  static const amber = LinearGradient(
    colors: [Color(0xFFFFB020), Color(0xFFFF8E53)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// FORMAS DECORATIVAS

/// Burbuja / cuadrado redondeado con degradado.
class Blob extends StatelessWidget {
  final double size;
  final Gradient gradient;
  final bool square;
  final double angle; // radianes (solo cuadrados)

  const Blob({
    super.key,
    required this.size,
    required this.gradient,
    this.square = false,
    this.angle = 0,
  });

  @override
  Widget build(BuildContext context) {
    final box = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        shape: square ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: square ? BorderRadius.circular(size * 0.3) : null,
      ),
    );
    return square ? Transform.rotate(angle: angle, child: box) : box;
  }
}

/// Anillo (solo borde).
class Ring extends StatelessWidget {
  final double size;
  final Color color;
  final double thickness;

  const Ring({
    super.key,
    required this.size,
    required this.color,
    this.thickness = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: thickness),
      ),
    );
  }
}

/// Contenedor con ícono sobre degradado y sombra.
class GradientIconBox extends StatelessWidget {
  final IconData icon;
  final Gradient gradient;
  final double size;
  final double radius;
  final bool circle;

  const GradientIconBox({
    super.key,
    required this.icon,
    this.gradient = AppGradients.primary,
    this.size = 64,
    this.radius = 20,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {
    final shadowColor = (gradient as LinearGradient).colors.last;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circle ? null : BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: size * 0.45),
    );
  }
}

// BOTÓN ATRÁS REUTILIZABLE + VALIDADORES
class AppBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const AppBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }
}

class Validators {
  static final _email = RegExp(r'^[\w\.\-+]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
  static bool isEmail(String value) => _email.hasMatch(value.trim());
}

// 1. CustomInput
class CustomInput extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const CustomInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;
    OutlineInputBorder border(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: c, width: 1.2),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscure,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          style: const TextStyle(fontSize: 14, color: AppColors.textDark),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Color(0xFFA0A0B2)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            enabledBorder: border(
              hasError ? AppColors.error : AppColors.border,
            ),
            focusedBorder: border(
              hasError ? AppColors.error : AppColors.primary,
            ),
            errorBorder: border(AppColors.error),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textGrey,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: AppColors.error, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

// 2. PrimaryButton
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // null => deshabilitado

  const PrimaryButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: AppGradients.button,
          borderRadius: BorderRadius.circular(16),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onPressed,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 3. SecondaryButton
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

// 4. CodeDigitInput
class CodeDigitInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  /// Se llama al presionar borrar con la casilla vacía (volver a la anterior).
  final VoidCallback? onBackspaceWhenEmpty;

  const CodeDigitInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.onBackspaceWhenEmpty,
  });

  @override
  State<CodeDigitInput> createState() => _CodeDigitInputState();
}

class _CodeDigitInputState extends State<CodeDigitInput> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final focused = widget.focusNode.hasFocus;
    return Focus(
      onKeyEvent: (_, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            widget.controller.text.isEmpty) {
          widget.onBackspaceWhenEmpty?.call();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: focused ? AppColors.primary : AppColors.border,
            width: focused ? 2 : 1.2,
          ),
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          showCursor: false,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
