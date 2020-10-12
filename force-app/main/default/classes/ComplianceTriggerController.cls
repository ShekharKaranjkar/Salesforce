public class ComplianceTriggerController {
    public static void attachFiles(list<Compliance__c>compList){
        try{
            List<Compliance__c> complianceList = compList;
            Map<Id,Compliance__c> comMap = new Map<Id,Compliance__c>();
                Map<Id,Compliance__c> spId = new Map<Id,Compliance__c>();
            for(Compliance__c cmp:compList){
                comMap.put(cmp.Id,cmp);
            }
            
            list<Compliance__c> cRecord=[select id,name,Service_Provider_Id__c,Lithium_ID__r.Id from Compliance__c where id in :comMap.keyset() Limit 10000 ];

            system.debug('cRecord'+cRecord);
            for(Compliance__c com : cRecord){
                spId.put(com.Lithium_ID__r.Id,com);
            }
            list<Candidate__c> canRec = [SELECT Id,PAN_Card_Picture__c,Aadhar_Card_Picture__c,Address_Proof_Picture__c,Driving_Licence_Front_Page_Picture__c,Driving_Licence_Back_Page_Picture__c,Bank_PassBook_Picture__c,VoterId_Card_Picture__c,MSA_Picture__c,CRA_Picture__c FROM Candidate__c WHERE Service_Provider__c in :spId.Keyset()];
			system.debug('canRec'+canRec);
            Map<Id,Candidate__c> canMap = new Map<Id,Candidate__c>();
            for(Candidate__c cn:canRec){
                
                canMap.put(cn.PAN_Card_Picture__c, cn);
                canMap.put(cn.Aadhar_Card_Picture__c, cn);
                canMap.put(cn.Address_Proof_Picture__c, cn);
                canMap.put(cn.Driving_Licence_Front_Page_Picture__c, cn);
                 canMap.put(cn.Driving_Licence_Back_Page_Picture__c, cn);
                 canMap.put(cn.Bank_PassBook_Picture__c, cn);
                 canMap.put(cn.VoterId_Card_Picture__c, cn);
                 canMap.put(cn.MSA_Picture__c, cn);
                 canMap.put(cn.CRA_Picture__c, cn);
            }
            system.debug('canMap'+canMap);
            list<ContentDocumentLink> conLink = [SELECT id,ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where ContentDocumentId in:canMap.Keyset() and  LinkedEntityId in (select id from Candidate__c  where Service_Provider__c in :spId.Keyset())];
           system.debug('conLink'+conLink);
            List<ContentDocumentLink> ContentDocumentList = new List<ContentDocumentLink>();
            
            for(ContentDocumentLink conList :conLink ){
               
                    
                ContentDocumentLink cdl = New ContentDocumentLink();
                cdl.LinkedEntityId = complianceList[0].id;
                cdl.ContentDocumentId = conList.ContentDocumentId;
                cdl.shareType = 'V';
                insert cdl;
               // ContentDocumentList.add(cdl);
            } 
                            //system.debug('cdl'+cdl);

            //insert ContentDocumentList;
        }catch(exception ex){
            system.debug(ex.getMessage());
        }
    }
}