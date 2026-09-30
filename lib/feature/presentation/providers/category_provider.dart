import 'package:flutter_riverpod/legacy.dart';

final selectedCategoryProvider = StateProvider<String>((ref) {
  return 'all';
});
