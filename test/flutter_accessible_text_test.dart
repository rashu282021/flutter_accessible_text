import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_accessible_text/flutter_accessible_text.dart';

void main() {
  group('SizeConfig', () {
    test('sp returns same value (content scaling)', () {
      expect(SizeConfig.sp(16), 16);
    });
  });

  group('TextRole enum', () {
    test('has chrome and content values', () {
      expect(TextRole.chrome, isNotNull);
      expect(TextRole.content, isNotNull);
    });
  });
}