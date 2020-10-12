/*
 * This class call all records from the 'Operations_And_Engagement__c' custom setting.
 * And Display it in Driver Menu Help Desk
 */

public with sharing class OperationsEngagementController {
    @AuraEnabled
    public static list<Operations_And_Engagement__c> getSetting(){
      //  System.debug('Company_Setting__c.getInstance() => '+Operations_And_Engagement__c.getValues());
     //   Operations_And_Engagement__c mc = Operations_And_Engagement__c.getValues();
    //map<string,Operations_And_Engagement__c> vv =  Operations_And_Engagement__c.getValues();
      //  return Operations_And_Engagement__c.getInstance();
    //  List<Operations_And_Engagement__c> mcs = Operations_And_Engagement__c.getall().values();
    List<Operations_And_Engagement__c> mcs  ;
        system.debug('mcs'+mcs);
         return [Select id,Name, Contact_NameE__c,Contact_NameO__c,City__c,Shift__c,Contact_Number__c, Contact_NumberO__c  from Operations_And_Engagement__c ORDER BY City__c ,Shift__c Asc];
    
    }
}