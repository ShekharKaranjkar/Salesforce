public class ContractAutoPopulateCRMhelper {
     public static void crmlists(list<Costs_Risk_Matrix__c> crmlist) {
      
        list<Contract> contracts= new List<Contract>([SELECT Id, Opportunity__c FROM Contract limit 1]);
        list<Costs_Risk_Matrix__c> crmlistupdate = new list<Costs_Risk_Matrix__c>();
        for (Costs_Risk_Matrix__c conta :crmlist){
            if(conta.Opportunity__c != null){
                system.debug('AccountId'+conta.Opportunity__c);
                system.debug('contract------>>>>>>'+conta.Contract__c);
                Contract ct = [select id,Name from Contract where Opportunity__c =: conta.Opportunity__c limit 1];
                conta.Contract__c = ct.id;
                crmlistupdate.add(conta);
                system.debug('conta-----------'+conta);
            }
        }
        if (crmlistupdate.size()>0 ){
         //  insert crmlistupdate;
            system.debug('conlistupdate----------->>>>>>>>>>>>'+crmlistupdate);
        }
    }

}