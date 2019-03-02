import 'dart:io';

enum TransactionType {WITHDRAWAL, DEPOSIT, BALANCE}

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
  List<Account> Accounts;
  bool makeTransaction(Transaction transaction) {
    switch(transaction.type) {
      case TransactionType.WITHDRAWAL:
        break;
      case TransactionType.DEPOSIT:
        break;
      case TransactionType.BALANCE:
        break;
      default:
        throw 'Invalid Transaction Type!';
    }
  }
}

class Transaction {
  var type;

}

class Account {

}

class Person {
  var name;
}

