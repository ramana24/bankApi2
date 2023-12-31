namespace sap.capire.bank_details;
using { Currency, managed, cuid, temporal } from '@sap/cds/common';

type Acc_type : String enum {
  Savings;
  Current;
}

type Status : String enum {
    Active;
    DeActivated;
}

type Transaction_type : String enum {
    deposit;
    withdraw;
}

entity State  {
    key ID : Integer;
    name : localized String(100) not null @assert.unique;
    customers : Composition of many Customers on customers.state = $self;
    banks : Composition of many Banks on banks.state = $self;
}
entity City  {
    key ID : Integer;
    name : localized String(100) not null @assert.unique;
    customers : Composition of many Customers on customers.city = $self;
    banks : Composition of many Banks on banks.city = $self;
}

entity Banks :  managed {
    key bankID : Integer  @assert.unique;
    bankname : String(100) @assert.unique;
    state : Composition of State ;
    city : Composition of City;
    status : Status default 'Active';
    customers : Composition of many Customers on customers.bank = $self;
}
entity Customers :   managed {
    key custID : Integer  @assert.unique;
    firstname : localized String(50) ;
    lastname : localized String(50) ;
    age : Integer ;
    dateOfBirth  : Date;
    bank : Composition of Banks;
    address : localized String(500) ;
    state : Composition of State ;
    city : Composition of City;
    status : Status default 'Active';
    message : String(50) default 'Customer Created Successfully';
    accounts : Composition of many Accounts on accounts.customers = $self;
}
entity Accounts : managed {
    key accountid : Integer64 @assert.unique;
    customers : Association to  Customers;
    account_type : Acc_type default 'Savings';
    Balance : Integer;
    account_status : Status default 'Active';
    message : String(50) default 'Account Created Successfully';
    transections : Composition of  many Transections on transections.accounts = $self;
}
entity Transections : cuid {
    key accounts : Association to  Accounts;
    type : Transaction_type;
    description : String(100);
    date : DateTime @cds.on.update: $now;
    amount : Integer;
}

