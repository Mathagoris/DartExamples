import 'dart:io';
import 'dart:math';
import 'package:random_string/random_string.dart' as random;

enum TransactionType {WITHDRAWAL, DEPOSIT, BALANCE}
final List<TransactionType> TTypes = TransactionType.values;
final INVALID_TRANSACTION_TYPE = 4;

abstract class Planet {
  Future floatThroughSpace();
}

class Earth implements Planet {
  Bank bank;
  List<Person> people;

  // Constructor
  Earth(Bank bank, List<dynamic> people) {
    print("You have created Earth");
    this.bank = bank;
    this.people = people;
  }

  // Named Constructor
  Earth.create(this.bank, this.people);

  Future floatThroughSpace() async {
    for(var person in people) {
      person.password = bank.createAccount(person.name);
    }
    print("Press Enter to destroy...");
    //while(await stdin.isEmpty) {
    while(true) {
      live();
    }
    return;
  }
  bool live()  {
    bool allSuccess = true;
    for(var person in people) {
      try {
        var rng = new Random();
        var randType = rng.nextInt(4);
        var type;
        if (randType < 3)
          type = TTypes[randType];
        else
          type = INVALID_TRANSACTION_TYPE;
        var amount = rng.nextInt(25) + 1;
        print('Attempting transaction for ${person.name}...');
        var transaction = person.createTransaction(type, amount);
        Receipt receipt = bank.processTransaction(transaction);
        if (receipt.success) {
          print('Transaction was a success!');
          print('Balance is now: \$${receipt.balance}\n');
        }
      } catch (e, s) {
        print('$e\n');
        //stderr.write('Exception details:\n $e');
        //stderr.write('Stack trace:\n $s');
        allSuccess = false;
        continue;
      }
      sleep(const Duration(seconds: 2));
    }
    return allSuccess;
  }

}

// implicit interface
class Star {
  void beReallyHot() => "Watch me turn Hydrogen to Helium, yo";
}

class Sun implements Star {
  int _temp = 5778;
  void beReallyHot() => "Watch me turn Hydrogen to Helium at &_temp K";
}

class Bank {
  Map<String, Account> accounts = Map();
  Receipt processTransaction(Transaction transaction){
    Account accountToProcess = getAccount(transaction.credentials);
    switch (transaction.type){
      case (TransactionType.DEPOSIT):
        print("Attempting to deposit \$${transaction.amount}...");
        return Receipt(deposit(accountToProcess, transaction.amount), transaction.type, accountToProcess.balance);
        break;
      case (TransactionType.WITHDRAWAL):
        print("Attempting to withdraw \$${transaction.amount}...");
        return Receipt(withdrawal(accountToProcess, transaction.amount), transaction.type, accountToProcess.balance);
        break;
      case (TransactionType.BALANCE):
        print("Checking balance...");
        return Receipt(true, transaction.type, accountToProcess.balance);
        break;
      default:
        throw "Invalid Transaction Type";
    }
  }

  String createAccount(String name) {
    var newPassword = random.randomString(10);
    // this bank is running a special promotion
    accounts[name] = Account.create(name, newPassword, 100);
    return newPassword;
  }

  bool withdrawal(Account acc, int amount) => deposit(acc, -amount);
  bool deposit(Account acc, int amount){
    acc.balance += amount;
    return true;
  }

  Account getAccount(Credentials creds) {
    Account acc = accounts[creds.user];
    if (acc != null && acc.auth(creds.password))
      return acc;
    else
      throw "Could not access Account with give credentials";
  }
}

class Transaction {
  var type;
  var credentials;
  var amount;
}

class Receipt {
  var type;
  bool success;
  int balance;

  Receipt(this.success, this.type, this.balance);
}

class Account {
  var _username;
  var _password;
  var balance;
  Account.create(this._username, this._password, this.balance);
  bool auth(String pwd) => _password == pwd;
}

class Credentials {
  var user;
  var _pwd;

  set password(String password) => _pwd = password;
  String get password => _pwd;
}

class Person {
  var name;
  var _password;

  Person(this.name);
  set password(String pwd) => _password = pwd;
  Transaction createTransaction(var type, int amount) {
    var transaction = Transaction()
        ..type = type
        ..amount = amount
        ..credentials = (Credentials()
          ..user = name
          ..password = _password);
    return transaction;
  }
}

