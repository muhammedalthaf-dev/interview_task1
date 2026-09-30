import 'package:ecommerce_app/core/widgets/app_button.dart';
import 'package:ecommerce_app/core/widgets/app_text_field.dart';
import 'package:ecommerce_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginPage renders correctly with Riverpod and custom widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify Header and Subtitle
    expect(find.textContaining('Welcome back'), findsOneWidget);
    expect(
      find.text('Shop smarter. Discover products\nyou’ll love.'),
      findsOneWidget,
    );

    // Verify input fields
    expect(find.byType(AppTextField), findsNWidgets(2));
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);

    // Verify Login and Google Buttons
    expect(find.byType(AppButton), findsNWidgets(2));
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.textContaining('Continue With Google'), findsOneWidget);
  });
}
