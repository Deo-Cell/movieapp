import 'package:flutter/material.dart';

class CustomToast {
  static OverlayEntry? _currentToast;
  static bool _isVisible = false;

  // Couleurs pour les différents types de toast
  static final successColors = {
    'background': const Color(0xFFECFDF5),
    'border': const Color(0xFF10B981),
    'icon': const Color(0xFF10B981),
    'iconBg': const Color(0xFFD1FAE5),
    'text': const Color(0xFF047857),
  };

  // Couleurs pour les erreurs
  static final errorColors = {
    'background': const Color.fromARGB(255, 252, 232, 232),
    'border': const Color(0xFFEF4444),
    'icon': const Color(0xFFEF4444),
    'iconBg':  Colors.red.withOpacity(0.2),
    'text': const Color(0xFFB91C1C),
  };

static final warningColors = {
  'background': Colors.amber.shade50,
  'border': Colors.amber.shade400,
  'icon': Colors.amber.shade700,
  'iconBg': Colors.amber.shade100.withOpacity(0.8),
  'text': Colors.amber.shade700,
};

  static void _showToast(
    BuildContext context, {
    required String message,
    required Map<String, Color> colors,
    required IconData icon,
    int durationSeconds = 3,
  }) {
    if (_isVisible) {
      _currentToast?.remove();
    }

    _currentToast = OverlayEntry(
      builder: (context) => _ToastOverlay(
        message: message,
        colors: colors,
        icon: icon,
        onDismiss: () {
          _currentToast?.remove();
          _isVisible = false;
        },
      ),
    );

    _isVisible = true;
    Overlay.of(context).insert(_currentToast!);

    Future.delayed(Duration(seconds: durationSeconds), () {
      if (_currentToast != null && _isVisible) {
        _currentToast?.remove();
        _currentToast = null;
        _isVisible = false;
      }
    });
  }

  static void showSuccess(BuildContext context, {String message = "Trajet créé avec succès"}) {
    _showToast(
      context,
      message: message,
      colors: successColors,
      icon: Icons.check,
    );
  }

  static void showError(BuildContext context, {String message = "Erreur lors de la suppression du trajet"}) {
    _showToast(
      context,
      message: message,
      colors: errorColors,
      icon: Icons.close,
    );
  }

  static void showWarning(BuildContext context, {String message = "Modifications en attente de sauvegarde"}) {
    _showToast(
      context,
      message: message,
      colors: warningColors,
      icon: Icons.warning_amber_rounded,
    );
  }
}

class _ToastOverlay extends StatefulWidget {
  final String message;
  final Map<String, Color> colors;
  final IconData icon;
  final VoidCallback onDismiss;

  const _ToastOverlay({
    required this.message,
    required this.colors,
    required this.icon,
    required this.onDismiss,
  });

  @override
  _ToastOverlayState createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(
      begin: -100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          top: _slideAnimation.value + 72,
          left: 16,
          right: 16,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.colors['background'],
                  border: Border(
                    left: BorderSide(
                      color: widget.colors['border']!,
                      width: 4,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.colors['iconBg'],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          widget.icon,
                          color: widget.colors['icon'],
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: TextStyle(
                          color: widget.colors['text'],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _animationController.reverse().then((_) {
                          widget.onDismiss();
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: widget.colors['icon']!.withOpacity(0.7),
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}