trigger UpdateCount on Contract_Terms__c (after update) {
     set<id> ids=new set<id>();
    list<Penalties__c> myList = new list<Penalties__c>();
    Map<Id, Integer> mapInterviewerIds = new Map<Id,Integer>();
    for(Contract_Terms__c ct: trigger.new){
        if(ct.Root_of_penalty__c!=trigger.oldMap.get(ct.id).Root_of_penalty__c)
        ids.add(ct.id);
    }    
        for(Penalties__c pen:[SELECT Id,Root__c,Contract_Terms__c,number__c from Penalties__c WHERE Contract_Terms__c IN:ids]){
            if(pen.Root__c !=trigger.newMap.get(pen.Contract_Terms__c).Root_of_penalty__c ){
                pen.number__c=0;
            }else{
                pen.number__c=1;
            }
            
          myList.add(pen);
           
        }
    if(myList.size()>0)
           update myList;
    }