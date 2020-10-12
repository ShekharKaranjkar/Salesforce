public class HttpLocationChargeController{
    
    public static String chargeEndPointUrl = Label.Lthium_URL+'/getChargeData';
    public static String locationEndPointUrl = Label.Lthium_URL+'/getLocationData';
    public static String apiKey = Label.Lithium_API;
    
    public static void getLocationData(){
        try{
            Integer indexId = Integer.valueOf(Label.Default_Locationdata);
            List<locationdata__c> indexLst = [SELECT Id,Lidbid__c FROM locationdata__c Order by Lidbid__c desc LIMIT 1];
            if(indexLst.size() > 0){
                indexId = Integer.valueOf(indexLst[0].Lidbid__c) + 1;
            }
            HttpRequest req = new HttpRequest();
            req.setEndpoint(locationEndPointUrl +'?startId='+ indexId + '&apiKey=' + apiKey);
            req.setMethod('GET');
            Http http = new Http();
            HTTPResponse res;
            
            //if(!Test.isRunningTest())
            res = http.send(req);
            if(res.getStatusCode() == 200){
                Map<String,Object> responseMap = (Map<String,Object>) JSON.deserializeUnTyped(res.getBody());
                List<locationdata__c> locLst = (List<locationdata__c>) JSON.deserialize(JSON.serialize(responseMap.get('response')), List<locationdata__c>.class);
                
                if(locLst.size() > 0){
                    for(locationdata__c ld : locLst){
                        if(ld.Is_Valid__c == NULL)
                           ld.Is_Valid__c = FALSE; 
                    }
                    Database.insert(locLst);
                }
                
                //system.debug(responseMap.keySet());
                //system.debug(responseMap.get('response'));
                //Database.insert(responseMap.get('response'));
            }else{
                system.debug('STATUS '+res.getStatusCode());
                system.debug('BODY '+res.getBody());
            }
            
        }catch(Exception e){
            system.debug('ERROR '+e.getMessage());
        }finally{
            
        }
        
    }
    
    public static void getChargeData(){
        try{
            
            Integer indexId = Integer.valueOf(Label.Default_Chargedata);
            List<chargedata__c> indexLst = [SELECT Id,Lidbid__c FROM chargedata__c Order by Lidbid__c desc LIMIT 1];
            if(indexLst.size() > 0){
                indexId = Integer.valueOf(indexLst[0].Lidbid__c) + 1;
            }
            HttpRequest req = new HttpRequest();
            req.setEndpoint(chargeEndPointUrl +'?startId='+ indexId + '&apiKey=' + apiKey );
            req.setMethod('GET');
            Http http = new Http();
            HTTPResponse res;
            if(!Test.isRunningTest())
                res = http.send(req);
            if(res.getStatusCode() == 200){
                Map<String,Object> responseMap = (Map<String,Object>) JSON.deserializeUnTyped(res.getBody());
                List<chargedata__c> chargeLst = (List<chargedata__c>) JSON.deserialize(JSON.serialize(responseMap.get('response')), List<chargedata__c>.class);
                if(chargeLst.size() > 0){
                    Database.insert(chargeLst);
                }
                
                //system.debug(responseMap.keySet());
                //system.debug(responseMap.get('response'));
                //Database.insert(responseMap.get('response'));
            }else{
                system.debug(res.getStatusCode());
                system.debug(res.getBody());
                
            }
        }catch(Exception e){
           system.debug('ERROR '+e.getMessage());
        }
        
    }
}