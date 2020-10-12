public class CRMAutoPopulateEVlisthelper {
 public static void crmlists(list<Final_EV_Input__c> crmlist) {
      
     
        list<Final_EV_Input__c> finallistupdate = new list<Final_EV_Input__c>();
        for (Final_EV_Input__c finals :crmlist){
            if(finals.Opportunity__c != null){
                system.debug('AccountId'+finals.Opportunity__c);
                system.debug('contract------>>>>>>'+finals.Costs_Risk_Matrix__c);
                Costs_Risk_Matrix__c ct = [select id,Name from Costs_Risk_Matrix__c where Opportunity__c =: finals.Opportunity__c limit 1];
                finals.Costs_Risk_Matrix__c = ct.id;
                finallistupdate.add(finals);
                system.debug('conta-----------'+finals);
            }
        }
        if (finallistupdate.size()>0 ){
          //  insert conlistupdate;
            system.debug('conlistupdate----------->>>>>>>>>>>>'+finallistupdate);
        }
    }

}