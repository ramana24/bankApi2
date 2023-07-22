using { sap.capire.bank_details as my } from '../db/schema';


service  Executiveservice   {

    entity Banks 
    as projection on my.Banks {
        key bankID,
        bankname,
        state.name as StateName,
        city.name as CityName,
        state,
        city,
        customers
    };



    entity Customers 
    as projection on my.Customers  {
        key custID,
        firstname,
        lastname,
        bank.bankID as BankId,
        bank.bankname as BankName,
        status as Accountstatus,
        address,    
        city.name as CityName,
        state.name as StateName,
        accounts,
        state,
        city,
        bank
    };
 entity Accounts 
    as projection on my.Accounts {
        key accountid,
        account_type,
        account_status,
        Balance,    
        customers.custID,
        customers.firstname ,
        customers.lastname,
        customers.bank.bankID,
        customers.bank.bankname,
        message,
        createdAt,
        transections,
        customers
    } ;

     entity Transections 
    as projection on my.Transections;
   
    @readonly entity State as projection on my.State;

}