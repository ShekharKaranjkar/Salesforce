/*
    Date            :    5/15/2020
    Description     :    This a restresource class which is used to stored current community logged in user geolocation
*/

@RestResource(urlMapping='/uploadGeoData/*')
global with sharing class GeoLocationRestResource {
 
  @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        
        //For RequestParams
        Map<String, String> paramMap = req.params;
        Set<String> duplicateUserDtTimeSet = new Set<String>();
                        
        /*
        key is a secure key so API can be accessed only by application which knows the same
        uid is userid or mobile number which you want to use to identify user
        deviceID is a string which will be sent for each request.
        */
        system.debug('paramMap '+paramMap);
        //REQUEST PARAM
        if(paramMap.containsKey('key')){
              String key = paramMap.get('key');
              if(key == Label.GeoLocationKey){
              //REQUEST BODY
              if(String.isNotBlank(req.requestBody.toString())){
                    /*
                        "lat":""
                        "long":""
                        "time":""
                    */
                    
                    Map<String, Object> bodyJSONMap = (Map<String, Object>) JSON.deserializeUntyped(req.requestBody.toString());
                    //system.debug('bodyJSONMap '+ bodyJSONMap);
                    system.debug('Step '+ bodyJSONMap);
                    //GET userid as Uid
                    if(bodyJSONMap.containskey('Uid') && String.isNotBlank(String.valueOf(bodyJSONMap.get('Uid')))){
                        
                        String uId = String.valueOf(bodyJSONMap.get('Uid'));
                        system.debug('Step 1');
                        List<User> usrLst = [SELECT Id,Contact.Service_Provider__c FROM User WHERE Id=: uId AND Profile.Name='SP']; 
                        system.debug('usrLst '+usrLst);
                        if(usrLst.size() > 0){
                            system.debug('Step 2');
                           String serviceProviderId = usrLst[0].Contact.Service_Provider__c;
                           String deviceId = '';
                           if(bodyJSONMap.containskey('DeviceID') && String.isNotBlank(String.valueOf(bodyJSONMap.get('DeviceID')))){
                               system.debug('Step 3');
                               deviceId = String.valueOf(bodyJSONMap.get('DeviceID'));
                               if(bodyJSONMap.containskey('geolocationData') && String.isNotBlank(String.valueOf(bodyJSONMap.get('geolocationData')))){
                                   system.debug('Step 4' + bodyJSONMap.get('geolocationData'));
                                   List<GeoLocation__c> gwLst = new List<GeoLocation__c>();
                                   //GeoLocation -- 
                                   
                                   for(GeoLocation__c gl :[SELECT Id,Date_Time__c,Userid__c FROM GeoLocation__c WHERE Userid__c =: uId AND DeviceID__c =:deviceId]){
                                       duplicateUserDtTimeSet.add(gl.Userid__c + '-' + gl.Date_Time__c);
                                   }
                                   //GeoLocation -- 
                                   String jsn = JSON.serialize(bodyJSONMap.get('geolocationData')).replace('lat','plat').replace('long','plong');
                                    List<GeoLocationWrapper> gwWrapperLst = (List<GeoLocationWrapper>) JSON.deserialize(jsn,List<GeoLocationWrapper>.class);
                                    system.debug('Step 5');
                                    for(GeoLocationWrapper glw : gwWrapperLst){
                                        GeoLocation__c gl = new GeoLocation__c();
                                        gl.Location__Latitude__s = glw.plat;
                                        gl.Location__Longitude__s = glw.plong;
                                        String epTimeStamp = String.valueOf(glw.epochTimestamp);                                                                
                                        gl.Date_Time__c = DateTime.newInstance(Long.valueOf(epTimeStamp)); 
                                        gl.Service_Provider__c = serviceProviderId;
                                        gl.DeviceID__c = deviceId;
                                        gl.Userid__c = uId;
                                        if(!duplicateUserDtTimeSet.contains(gl.Userid__c + '-' + gl.Date_Time__c))
                                            gwLst.add(gl);
                                    }
                                    system.debug('gwLst >> ' + gwLst);
                                    if(gwLst.size() > 0){
                                        insert gwLst; 
                                        //Response
                                          
                                        httpResponse(new ResponseWrapper('Record Inserted','RECORD_INSERTED'),200);
                                    }else{
                                        httpResponse(new ResponseWrapper('No/Duplicate Record Found','NO_DUPLICATE_RECORD'),404);
                                    }
                               }else{
                                   httpResponse(new ResponseWrapper('Geolocation JSON Does Not Exist','JSON_NOT_FOUND'),404);
                               }
                           }else{
                               //ERROR MSG -- DEVICE NOT FOUND

                               httpResponse(new ResponseWrapper('Device Not Found','DEVICE_NOT_FOUND'),404);
                               
                           }
                            /*
                                GeoLocation__c gl = new GeoLocation__c();
                            */
                        }else{
                            //ERROR MSG -- USER DOES NOT EXIST
                            httpResponse(new ResponseWrapper('User Does Not Exist','USER_NOT_EXIST'),404);
                        }
                    }else{
                        //ERROR MSG -- Uid IS BLANK
                        httpResponse(new ResponseWrapper('UID Is Blank','UID_IS_BLANK'),404);
                    }
                    
                }
              }else{
                  system.debug('paramMap '+ paramMap.keySet());
                  httpResponse(new ResponseWrapper('Invalid Key','INVALID_KEY'),404);
              } 
        }else{
            //ERROR MSG -- Paramter key is required
            httpResponse(new ResponseWrapper('Paramter key is required','KEY_REQUIRED'),404);
        }
    }
    
    private static void httpResponse(ResponseWrapper wrapper,Integer statusCode){
        Blob successBlob = Blob.valueof(JSON.serialize(new List<ResponseWrapper>{wrapper}));
        RestContext.response.responseBody = successBlob;
        RestContext.response.statusCode  = statusCode;
        RestContext.response.addHeader('Content-Type', 'application/json');
   }
    
    
    global class GeoLocationWrapper{
        Decimal plat;
        Decimal plong;
        String epochTimestamp;
    }
    
    global class ResponseWrapper{
        global String message;
        global String errorCode;
        global ResponseWrapper(String message,String errorCode){
            this.message = message;
            this.errorCode = errorCode;
        }
    }
}