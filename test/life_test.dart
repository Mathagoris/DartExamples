import 'package:DartExamples/life.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockBank extends Mock implements Bank {}
class MockAccount extends Mock implements Account {}

void main() {
  group('Test Bank Class', () {
    test('processTransaction Exception', () async {
      var bank = Bank();
      var account = MockAccount();
      bank.accounts["Any User"] = account;
      var transaction = Transaction()
        ..credentials = (Credentials()
          ..password = "anyPassword"
          ..user = "Any User")
        ..amount = 1
        ..type = INVALID_TRANSACTION_TYPE;

      when(account.auth(any)).thenReturn(true);

      expect(() => bank.processTransaction(transaction), throwsException);
    });
    test('getAccount Exception', () async {
      var creds = Credentials()
          ..user = "Some User"
          ..password = "Wrong Password";
      var account = MockAccount();
      when(account.auth(any)).thenReturn(false);
      var bank = Bank();
      bank.accounts["Some User"] = account;

      expect(() => bank.getAccount(creds), throwsException);
    });
  });
}