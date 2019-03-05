import 'dart:io';
import 'package:random_string/random_string.dart' as random;

enum TransactionType {WITHDRAWAL, DEPOSIT, BALANCE}
final INVALID_TRANSACTION_TYPE = 4;

abstract class Planet {
  Future<int> floatThroughSpace();
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

  Future<int> floatThroughSpace() async {
    for(var person in people) {
      person.password = bank.createAccount(person.name);
    }
    print("Press Enter to destroy...");
    while(await stdin.isEmpty) {
      live();
    }
    return 67000;
  }
  void live()  {
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
  Map<String, Account> accounts;
  Receipt processTransaction(Transaction transaction){
    Account accountToProcess = getAccount(transaction.credentials);
    switch (transaction.type){
      case (TransactionType.DEPOSIT):
        return Receipt(deposit(accountToProcess, transaction.amount), accountToProcess.balance);
        break;
      case (TransactionType.WITHDRAWAL):
        return Receipt(withdrawal(accountToProcess, transaction.amount), accountToProcess.balance);
        break;
      case (TransactionType.BALANCE):
        return Receipt(true, accountToProcess.balance);
        break;
      default:
        throw "Invalid Transaction Type";
    }
  }

  String createAccount(Person person) {
    var newPassword = random.randomString(10);
    person.password = newPassword;
    accounts[person.name] = Account.create(person.name, newPassword);
  }

  bool withdrawal(Account acc, double amount) => deposit(acc, -amount);
  bool deposit(Account acc, double amount){
    acc.balance += amount;
    return true;
  }

  Account getAccount(credentials) {
    Account acc = accounts[credentials.user];
    if (acc != null && acc.auth(credentials.pwd))
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
  bool success;
  double balance;

  Receipt(this.success, this.balance);
}

class Account {
  var _username;
  var _password;
  var balance;
  Account.create(this._username, this._password);
  bool auth(String pwd) => _password == pwd;
}

class Person {
  var name;
  var _password;

  Person(this.name);
  set password(String pwd) => _password = pwd;
}

