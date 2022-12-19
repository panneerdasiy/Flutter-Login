import 'package:login/domain/validator_type.dart';

class EmailValidator extends ValidatorType{
  @override
  bool isValid(String value) {
    return value.trim().length > 3;
  }
}