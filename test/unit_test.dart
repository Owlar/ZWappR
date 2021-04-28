import 'package:flutter_test/flutter_test.dart';
import 'package:zwappr/features/authentication/ui/login_page.dart';

void main() {
  test("Empty email returns error string", () {
    var result = EmailValidatorClass.validate('');
    expect(result, "Vennligst skriv inn e-post");
  });

  test("non-Empty email returns null", () {
    var result = EmailValidatorClass.validate("email@mail.com");
    expect(result, null);
  });

  test("non-Valid email returns error string", () {
    var result = EmailValidatorClass.validate("emalmail.com");
    expect(result, "Vennligst oppgi en gyldig e-postadresse");
  });

  test("Empty password returns error string", () {
    var result = PasswordValidatorClass.validate('');
    expect(result, "Vennligst skriv inn passord");
  });

  test("non-Empty password returns null", () {
    var result = PasswordValidatorClass.validate("passord123");
    expect(result, null);
  });
}
