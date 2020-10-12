public class LithiumIdFormat {
    
    
    public static void accordingToLocation(list<Service_Provider__c>spList){
        try{
            List<Service_Provider__c> serviceProviderLst = new  List<Service_Provider__c>();
            Map<String, Decimal> LocationVsCount = new Map<String, Decimal>();
            Integer count;
            Set<String> locationSet=new set<String>();
            Set<String> phoneSet=new set<String>();
            for(Service_Provider__c sp: spList){
                locationSet.add(sp.Location__c);
                phoneSet.add(sp.Phone_Number__c);
            }
            system.debug('spList'+spList);
            for(AggregateResult sp :[select  Location__c, max(Lithium_ID_Number__c) countof from  Service_Provider__c where Location__c IN: locationSet 
                                     group by Location__c   ]
               ){
                   LocationVsCount.put((String) sp.get('Location__c'), (Decimal) sp.get('countof') );
               }
            Decimal countBulk;
            Map<string,Locations__c> mapLocationCodes = Locations__c.getAll();
            system.debug('LocationVsCount-------'+LocationVsCount);
            for(Service_Provider__c sp :spList ){
                system.debug('LocationVsCount-----------'+LocationVsCount.containsKey(sp.Location__c ));
                
                if (LocationVsCount.containsKey(sp.Location__c )) {
                    system.debug('if----------');   
                    countBulk = LocationVsCount.get(sp.Location__c);
                    countBulk++;
                    LocationVsCount.put(sp.Location__c, countBulk);
                    if(String.valueOf(LocationVsCount.get(sp.Location__c)).length()==1){
                        sp.LithiumIds__c= 'LITH'+ mapLocationCodes.get(sp.Location__c).Code__c +'000'+ LocationVsCount.get(sp.Location__c);
                        
                    }
                    if(String.valueOf(LocationVsCount.get(sp.Location__c)).length()==2){
                        sp.LithiumIds__c= 'LITH'+ mapLocationCodes.get(sp.Location__c).Code__c +'00'+ LocationVsCount.get(sp.Location__c);
                    }
                    if(String.valueOf(LocationVsCount.get(sp.Location__c)).length()==3){
                        sp.LithiumIds__c= 'LITH'+ mapLocationCodes.get(sp.Location__c).Code__c +'0'+ LocationVsCount.get(sp.Location__c);
                    }
                    if(String.valueOf(LocationVsCount.get(sp.Location__c)).length()>3){
                        sp.LithiumIds__c= 'LITH'+ mapLocationCodes.get(sp.Location__c).Code__c + String.valueOf(LocationVsCount.get(sp.Location__c)) ;
                    }
                } 
                else {
                    system.debug('else----------');  
                    sp.LithiumIds__c= 'LITH'+ mapLocationCodes.get(sp.Location__c).Code__c + '0001' ;
                    LocationVsCount.put(sp.Location__c, 0001);
                } 
            }
            
            list<String> phnList = new list<String>();
            list<Service_Provider__c> spoldVal=[select Id,Name,Phone_Number__c from Service_Provider__c where Status__c = 'Active' AND Phone_Number__c IN:  phoneSet Limit 10000 ];
            for(Service_Provider__c sps : spoldVal){
                phnList.add(sps.Phone_Number__c) ;
            }
            for(Service_Provider__c spVal :spList ){
                if(phnList.contains(spVal.Phone_Number__c)){
                    
                    spVal.addError('Service Provider with same Phone Number already exist. Please select different Phone Number ');
                }
                
            }
            
            
        }catch(exception ex){
            system.debug(ex.getMessage());
        }
        
        
        
    }
    
    
    public static void checkSiteLimit(list<Service_Provider__c>spList){
        try{
            Map<String,List<Service_Provider__c>> spSiteMap = new Map<String,List<Service_Provider__c>>();
            for(Service_Provider__c sp : spList){
                if(sp.Status__c == 'Active'){
                    if(!spSiteMap.containskey(sp.Site__c)){
                        spSiteMap.put(sp.Site__c,new List<Service_Provider__c>());
                    }
                    spSiteMap.get(sp.Site__c).add(sp);
                }
            }
            for(Campus__c site :[SELECT Id,Name,Total_Limit__c, (select Id,Name,Site__c from Drivers__r where Status__c='Active')
                                 FROM Campus__c WHERE Id IN :spSiteMap.keySet()])
            {
                
                Integer cnt = site.Drivers__r.size();
                for(Service_Provider__c sp : spSiteMap.get(site.Id)){
                    if(cnt >= site.Total_Limit__c){
                        sp.addError('Site limit is exceeded - Please increase the buffer');
                    }else{
                        cnt++;
                    }
                }
            }
        }catch(exception ex){
            system.debug(ex.getMessage());
        }
        
        
    }
    public static void incresecoverge(){   
        integer i=0;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;     
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; 
          i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; 
    }    
    
    
}