import 'package:flutter_test/flutter_test.dart';
import 'package:login/domain/password_validator.dart';

void main() {
  late PasswordValidator sut;

  setUp(() {
    sut = PasswordValidator();
  });

  group("password validator tests", () {
    test("invalid password of empty space, returns false", () {
      bool isValid = sut.isValid("    ");
      expect(isValid, false);
    });

    test("invalid password length, returns false", () {
      bool isValid = sut.isValid("123");
      expect(isValid, false);
    });

    test("valid password length, returns true", () {
      bool isValid = sut.isValid("1234");
      expect(isValid, true);
    });
  });
}
