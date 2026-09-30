import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/widgets/app_button.dart';
import 'package:ecommerce_app/core/widgets/app_text_field.dart';
import 'package:ecommerce_app/feature/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 42),

                const Text(
                  'Welcome back ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Shop smarter. Discover products\nyou’ll love.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 26),

                const Text(
                  'Email or phone',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 10),

                const AppTextField(
                  hintText: 'Enter your email or phone',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 17),

                const Text(
                  'Password',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 10),

                AppTextField(
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                AppButton(
                  text: 'LOGIN',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                ),

                const SizedBox(height: 28),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        'or continue',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                const SizedBox(height: 24),

                AppButton(
                  text: ' Continue With Google',
                  outlined: true,
                  onPressed: () {},
                ),

                const SizedBox(height: 28),

                Center(
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Create account',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
