public without sharing class ExternalUserLogin {
    
    public static Cookie counter; 
    
    public ExternalUserLogin(){
        system.debug('Step1'); 
    }
    
    @AuraEnabled
    public static void doLoad(){
        //counter = ApexPages.currentPage().getCookies().get('counter');
        //system.debug('counter >>' + counter);
    }
    @AuraEnabled
    public static boolean checkStatus(string mobileNumber) {
        List<Contact> contDetails = [SELECT Id,LastName,IsFirstLogin__c,UserId__c,Username__c, MobilePhone
                                     FROM Contact WHERE MobilePhone =: mobileNumber AND UserId__c!= NULL 
                                     					 AND (NOT Username__c Like '%deactivated%') LIMIT 1];
        
        system.debug('User ' + [SELECT Id FROM User where MobilePhone=: mobileNumber] );
        if(!contDetails.isEmpty()){
            return contDetails[0].IsFirstLogin__c;
        }else{
            makeConversation(System.Label.ExternalUserNotFoundOrInvalid);
        }
        return null;
    }
    
    @AuraEnabled
    public static String loginPassword(string mobileNumber,String password){
        List<Contact> contDetails = [SELECT Id,LastName,IsFirstLogin__c,UserId__c,Username__c
                                     FROM Contact WHERE MobilePhone =: mobileNumber 
                                     AND UserId__c!= NULL AND Username__c != NULL
                                     AND (NOT Username__c Like '%deactivated%') LIMIT 1];
        if(!contDetails.isEmpty()){
            try{
                //LoginResponse lr = loginSOAP(contDetails[0].Username__c, password);
                
                //if(lr.isSuccess){
                  //  system.debug(lr);
                   // system.debug(counter);
                    /*HttpRequest req = new HttpRequest();
                    req.setEndpoint('https://uat-lithium.cs75.force.com/serviceprovider/services/apexrest/uploadGeoData?key=BNyFeCGHf77zPuobOl23');
                    req.setHeader('Authorization','Bearer '+lr.sessionId);
                    req.setHeader('Content-Type', 'application/json');
                    
                    req.setBody('{"Uid":"0050w000001eQlhAAE","DeviceID":"dfjdfhhfkahfkxzx2323","geolocationData":[{"lat":12.3566756,"long":76.618956,"epochTimestamp":1516769368396},{"lat":12.3566726,"long":76.618056,"epochTimestamp":1516769368396}]}');
                    
                    req.setMethod('POST');
                    Http http = new Http();
                    
                    HTTPResponse res = new HTTPResponse();
                    if(!Test.isRunningTest()){
                        res = http.send(req);
                        system.debug('res' + res);
                    }*/
                    
                   // Cookie counter = ApexPages.currentPage().getCookies().get('counter');
                   // counter = new Cookie('SOAP_SUID',lr.sessionId,null,0,true,'Lax');
                    //ApexPages.currentPage().setCookies(new Cookie[]{counter});
                    
                //}
                PageReference pg = Site.login(contDetails[0].Username__c, password, '/s/');
                //pg.getParameters().put('question','123');
                if(!Test.isRunningTest()){
                    aura.redirect(pg);
                }
            }catch(Exception e){
                makeConversation(e.getMessage());
            }
        }else{
            makeConversation(System.Label.ExternalUserNotFoundOrInvalid);
        }
        return null;
    }
    
    @AuraEnabled
    public static string getOtp(string mobileNumber) {
        List<Contact> contDetails = [SELECT Id,LastName,IsFirstLogin__c,UserId__c,Username__c, MobilePhone
                                     FROM Contact WHERE MobilePhone =: mobileNumber AND UserId__c!= NULL
                                     					 AND (NOT Username__c Like '%deactivated%') LIMIT 1];
        if(!contDetails.isEmpty()){ 
            Integer STRING_LENGTH = 5;
            String  otp = String.valueOf(Math.Round(Math.Random() * ((Math.pow(10,STRING_LENGTH) - 1)-Math.pow(10,STRING_LENGTH -1)) + Math.pow(10,STRING_LENGTH -1)));
            String extraMsg = System.Label.ExternalLoginSmsApiMessage + ' ';
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://api-alerts.kaleyra.com/v4/?api_key='+System.Label.ExternalLoginSmsApiKey+'&method=sms&message='+extraMsg+otp+'&to='+mobileNumber+'&sender='+System.Label.ExternalLoginSmsApiSender);
            req.setMethod('GET');
            Http http = new Http();
            HTTPResponse res = new HTTPResponse();
            if(!Test.isRunningTest()){
                res = http.send(req);
            }else{
                res.setStatusCode(200);
            }
            System.debug(res.getBody());
            if(res.getStatusCode() == 200){
                return otp;
            }else{
                makeConversation(System.Label.ExternalLoginOTPException);
            }
            return null;
        }else{
            makeConversation(System.Label.ExternalUserNotFoundOrInvalid);
        }
        return null;
    }
    
    @AuraEnabled
    public static string setUserPassword(string mobileNumber, string password) {
        List<Contact> contDetails = [SELECT Id,LastName,IsFirstLogin__c,UserId__c,Username__c
                                     FROM Contact WHERE MobilePhone =: mobileNumber AND UserId__c!= NULL
                                     					 AND (NOT Username__c Like '%deactivated%') LIMIT 1];
        system.debug('msdddg=='+contDetails);
        if(!contDetails.isEmpty()){
            try{
                System.setPassword(contDetails[0].UserId__c, password);
                update new Contact(Id = contDetails[0].Id, IsFirstLogin__c = true);
                system.debug('msg=='+contDetails[0].Username__c);
                PageReference pg = Site.login(contDetails[0].Username__c, password, '/s/');
                if(!Test.isRunningTest()){
                    aura.redirect(pg);
                }
            }catch(Exception e){
                makeConversation(e.getMessage());
            }
        }else{
            makeConversation(System.Label.ExternalUserNotFoundOrInvalid);
        }
        return null;
    }
    
    @AuraEnabled
    public static void makeConversation(String message)
    {
        if (String.isNotBlank(message)){
            AuraHandledException e = new AuraHandledException(message);
            system.debug(e);
            if(!Test.isRunningTest()){
                throw e;
            }
        }
    }
    
    @AuraEnabled
    public static String loginSOAP(String mobileNumber,String password) {
        try{
        List<Contact> contDetails = [SELECT Id,LastName,IsFirstLogin__c,UserId__c,Username__c
                                     FROM Contact WHERE MobilePhone =: mobileNumber 
                                     AND UserId__c!= NULL AND Username__c != NULL
                                      AND (NOT Username__c Like '%deactivated%') LIMIT 1];
        if(!contDetails.isEmpty()){
            
            LoginResponse objResponse = new LoginResponse();
             
            //String username = RestContext.request.params.get('username');
            //String password = RestContext.request.params.get('password');
            String domain = Label.Driver_Menu_Domain;
             
            try{
                
                string loginXML = '<?xml version="1.0" encoding="UTF-8"?>';  
                loginXML += '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="urn:partner.soap.sforce.com">';  
                loginXML += '<SOAP-ENV:Header>';  
                loginXML += '<ns1:LoginScopeHeader>';  
                loginXML += '<ns1:organizationId>'+UserInfo.getOrganizationId()+'</ns1:organizationId>';  
                loginXML += '</ns1:LoginScopeHeader>';  
                loginXML += '</SOAP-ENV:Header>';  
                loginXML += '<SOAP-ENV:Body>'; 
                loginXML += '<ns1:login>';
                loginXML += '<ns1:username>'+ contDetails[0].Username__c+'</ns1:username>';
                loginXML += '<ns1:password>'+ password +'</ns1:password>';
                loginXML += '</ns1:login>'; 
                loginXML += '</SOAP-ENV:Body>';  
                loginXML += '</SOAP-ENV:Envelope>';
                 
                HttpRequest request = new HttpRequest();
                //request.setEndpoint('<a class="vglnk" href="https://'+" rel="nofollow"><span>https</span><span>://'+</span></a> domain +'.<a class="vglnk" href="http://salesforce.com/services/Soap/c/44.0" rel="nofollow"><span>salesforce</span><span>.</span><span>com</span><span>/</span><span>services</span><span>/</span><span>Soap</span><span>/</span><span>c</span><span>/</span><span>44</span><span>.</span><span>0</span></a>');
                request.setEndpoint(Label.Driver_Menu_Domain+'/services/Soap/u/29.0/'+UserInfo.getOrganizationId());
                request.setTimeout(60000); 
                request.setMethod('POST');
                request.setHeader('SOAPAction', 'login');
                request.setHeader('Accept','text/xml');
                request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
                request.setBody(loginXML);   
                
                //HttpResponse response = new Http().send(request);
                Http http = new Http();
                HTTPResponse response = new HTTPResponse();
                if(!Test.isRunningTest()){
                    response = http.send(request);
                }
                 
                String responseBody = response.getBody();
                String sessionId = getValueFromXMLString(responseBody, 'sessionId');
                 
                objResponse.statusMessage = response.getStatus();
                objResponse.statusCode = response.getStatusCode();
                 
                if(string.isNotBlank(sessionId)){
                    objResponse.isSuccess = true;
                    objResponse.sessionId = sessionId;
                    system.debug('sessionId ' + sessionId);
                     
                }else{
                    objResponse.isSuccess = false;
                }
            }
            catch(System.Exception ex){
                objResponse.isSuccess = false;
                objResponse.statusMessage = ex.getMessage();
            }
            system.debug('objResponse-' + objResponse);
            return objResponse.sessionId;
        }
        }catch(Exception e){}
        return null;
    }
     
    /*
    * Get XML tag value from XML string
    * @param xmlString : String XML
    * @param keyField : XML key tag
    * @return String : return XML tag key value
    */
    public static string getValueFromXMLString(string xmlString, string keyField){
        String xmlKeyValue = '';
        if(xmlString.contains('<' + keyField + '>')){
            try{
                xmlKeyValue = xmlString.substring(xmlString.indexOf('<' + keyField + '>')+keyField.length() + 2, xmlString.indexOf('</' + keyField + '>'));   
            }catch (exception e){
                 
            }            
        }
        return xmlKeyValue;
    }
     
    public class LoginResponse {
        public String sessionId {get; set;}
        public Boolean isSuccess {get; set;}
        public String statusMessage {get; set;}
        public Integer statusCode {get; set;}
    }
    
}