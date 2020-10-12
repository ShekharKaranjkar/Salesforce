public class Oppchange {
    public static void OppchangeMethod(list<opportunity> opList){
        set<Id> accId=new set<Id>();
        for(opportunity o:opList){
            accId.add(o.AccountId);
        }
        // list<opportunity>opp = [Select id ,CreatedDate , Solution_Model__c, Car_Model__c,LastModifiedDate,   Name from Opportunity  where AccountId in:accId ORDER BY LastModifiedDate ];
        list<Campus__c >site = [Select id ,CreatedDate , Solution_Model__c, Car_Model__c,    Name,Account__c from Campus__c  where Account__c  in:accId];
        map<id,opportunity> accVSopp=new map<id,opportunity>();
        for(opportunity o:opList){
            system.debug('first----loop');
            
            accVSopp.put(o.AccountId,o);
            
            
        }
        system.debug('accVSopp============'+accVSopp);
        map<id,list<Campus__c>> siteVSOpp=new map<id,list<Campus__c>>();
        List<Campus__c> siteListnew = new List<Campus__c>();
        for(Campus__c o:site){
            system.debug('first----loop');
            if(siteVSOpp.containskey(o.Account__c)){
                List<Campus__c> siteList=siteVSOpp.get(o.Account__c);
                siteList.add(o);
                siteVSOpp.put(o.Account__c,siteList);
            }
            else{
                List<Campus__c> siteList=new List<Campus__c>();
                siteList.add(o);
                siteVSOpp.put(o.Account__c,siteList);
            }
        }
        system.debug('siteVSOpp============'+siteVSOpp);
        for(id i : accVSopp.keySet()){
            IF(siteVSOpp.containsKey(i))
            {
                for( Campus__c s :siteVSOpp.get(i))
                {   
                    s.Solution_Model__c=accVSopp.get(i).Solution_Model__c;
                    s.Car_Model__c=accVSopp.get(i).Car_Model__c;
                    siteListnew.add(s);
                }
                
            }
        }
                system.debug('siteListnew============'+siteListnew);
        
        update siteListnew;
        
        
    } 
}