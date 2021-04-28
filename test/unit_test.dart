


import 'package:flutter_test/flutter_test.dart';
import 'package:zwappr/features/authentication/ui/login_page.dart';

void main(){
  test("Empty email returns error string", (){
    var result = EmailValidator.validate('');
    expect(result, "Vennligst skriv inn e-post");
  });
  test("non-Empty email returns null", (){
    var result = EmailValidator.validate("email@mail.com");
    expect(result, null);
  });

  test("Empty password returns error string", (){
    var result = PasswordValidator.validate('');
    expect(result, "Vennligst skriv inn passord");
  });
  test("non-Empty password returns null", (){
    var result = PasswordValidator.validate("passord123");
    expect(result, null);
  });

}
