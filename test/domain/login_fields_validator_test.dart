import 'package:flutter_test/flutter_test.dart';
import 'package:login/domain/login_fields_validator.dart';
import 'package:login/domain/validator_type.dart';

class MockValidator extends ValidatorType {
  bool result = true;
  int callCount = 0;

  @override
  bool isValid(String value) {
    callCount++;
    return result;
  }
}

void main() {
  late LoginFieldsValidator sut;
  late MockValidator emailValidator;
  late MockValidator passwordValidator;

  setUp(() {
    emailValidator = MockValidator();
    passwordValidator = MockValidator();

    sut = LoginFieldsValidator(
      emailValidator: emailValidator,
      passwordValidator: passwordValidator,
    );
  });

  group("login fields validator tests", () {
    test(
      "LoginFieldsValidator delegates the call to emailValidator's & passwordValidator's isValid method",
      () {
        emailValidator.result = true;
        passwordValidator.result = true;

        sut.validate("", "");

        expect(emailValidator.callCount, 1);
        expect(passwordValidator.callCount, 1);
      },
    );

    test(
      "invalid email, return error",
      () {
        emailValidator.result = false;

        String error = sut.validate("", "");

        expect(error.trim(), isNotEmpty);
      },
    );

    test(
      "invalid password, return error",
      () {
        passwordValidator.result = false;

        String error = sut.validate("", "");

        expect(error.trim(), isNotEmpty);
      },
    );

    test(
      "valid email & password, return empty string",
      () {
        emailValidator.result = true;
        passwordValidator.result = true;

        String error = sut.validate("", "");

        expect(error, isEmpty);
      },
    );
  });
}
