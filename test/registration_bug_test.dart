import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/helper/registration_controller.dart';

void main() {
  group('Email Validation', () {
    test('Valid emails', () {
      expect(RegistrationController.isValidEmail('test@example.com'), true);
      expect(RegistrationController.isValidEmail('user.name@domain.co'), true);
    });

    test('Invalid emails', () {
      expect(RegistrationController.isValidEmail('a@'), false);
      expect(RegistrationController.isValidEmail('@b'), false);
      expect(RegistrationController.isValidEmail('abc'), false);
    });
  });

  group('Password Validation', () {
    test('Strong passwords', () {
      expect(RegistrationController.isValidPassword('Abcd123!'), true);
      expect(RegistrationController.isValidPassword('Test@2024'), true);
    });

    test('Weak passwords', () {
      expect(RegistrationController.isValidPassword('password'), false);
      expect(RegistrationController.isValidPassword('12345678'), false);
      expect(RegistrationController.isValidPassword('Abcd1234'), false);
    });
  });

  group('Form Validation', () {
    test('Valid form should pass', () {
      expect(
        RegistrationController.validateForm(
          email: 'test@example.com',
          password: 'Abcd123!',
        ),
        true,
      );
    });

    test('Invalid form should fail', () {
      expect(
        RegistrationController.validateForm(email: 'invalid', password: '123'),
        false,
      );
    });
  });
}
