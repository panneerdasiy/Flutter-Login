import 'package:login/domain/login_fields_validator_type.dart';
import 'package:login/domain/validator_type.dart';

class LoginFieldsValidator extends LoginFieldsValidatorType {
  final ValidatorType emailValidator;
  final ValidatorType passwordValidator;

  LoginFieldsValidator({
    required this.emailValidator,
    required this.passwordValidator,
  });

  @override
  String validate(String email, String password) {
    if (!emailValidator.isValid(email)) {
      return "Please enter a valid Email ID";
    }
    if (!passwordValidator.isValid(password)) {
      return "Please enter a valid password";
    }
    return "";
  }
}
