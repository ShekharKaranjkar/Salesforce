@isTest
public class ContactUserTriggerTest {

    @isTest
    public static void unitTest1(){
        Account acc = new Account(Name ='Lithium Service Providers');
        insert acc;
        Contact con = new Contact(FirstName ='Testco',LastName = 'Testco',MobilePhone = '1234567897' ,AccountId = acc.Id);
        insert con;
    }
}