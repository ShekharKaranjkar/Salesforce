@isTest
public class LookupTest {
	@isTest
    public static void unitTest(){
        Account acc = new Account(Name='test');
        insert acc;
        
        Lookup.searchDB('Account','Name','Id',10,'Name','test');
    }
}