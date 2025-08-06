import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

  const SocialLoginButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.cardBlack,
          foregroundColor: textColor ?? AppTheme.textWhite,
          disabledForegroundColor: AppTheme.textGray,
          side: BorderSide(
            color: AppTheme.textGray.withOpacity(0.3),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: isLoading
            ? _buildLoadingIndicator()
            : _buildButtonContent(),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          textColor ?? AppTheme.textWhite,
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24,
          color: iconColor ?? _getIconColor(),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor ?? AppTheme.textWhite,
          ),
        ),
      ],
    );
  }

  Color _getIconColor() {
    // Return specific colors for different social platforms
    if (icon == Icons.g_mobiledata) {
      return Colors.red; // Google red
    } else if (icon == Icons.facebook) {
      return const Color(0xFF1877F2); // Facebook blue
    }
    return iconColor ?? AppTheme.primaryGold;
  }
}
