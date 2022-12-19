import 'package:flutter_test/flutter_test.dart';
import 'package:login/domain/email_validator.dart';

void main() {
  late EmailValidator sut;

  setUp(() {
    sut = EmailValidator();
  });

  group("email validator tests", () {
    test("invalid email of empty space, returns false", () {
      bool isValid = sut.isValid("    ");
      expect(isValid, false);
    });

    test("invalid email length, returns false", () {
      bool isValid = sut.isValid("123");
      expect(isValid, false);
    });

    test("valid email length, returns true", () {
      bool isValid = sut.isValid("1234");
      expect(isValid, true);
    });
  });
}
