import 'package:login/domain/validator_type.dart';

class PasswordValidator extends ValidatorType {
  @override
  bool isValid(String value) {
    return value.trim().length > 3;
  }
}
