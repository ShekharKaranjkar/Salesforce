@isTest(Seealldata=true)
public class GeoLocationRestResourceTest {
     
    
    @isTest
    public static void unitTest1(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/uploadGeoData?key='+Label.GeoLocationKey; //Request URL
        req.httpMethod = 'POST';
        req.params.put('key',Label.GeoLocationKey);
        
        
        //system.debug();
        String Uid = [SELECT Id FROM User WHERE Contact.Service_Provider__c != NULL limit 1].Id;
        String postData = '{"Uid": "'+Uid+'","DeviceID": "dfjdfhhfkahfkxzx2323","geolocationData": [ {"lat": 12.3566756,"long": 76.618956,"epochTimestamp": 1516769368396},{"lat": 12.3566726,"long": 76.618056,"epochTimestamp": 1516769368396}]}';
        String JsonMsg=JSON.serialize(postData);
        req.requestBody = Blob.valueof(postData);
        RestContext.request = req;
        RestContext.response= res;
        
        Test.startTest();
        GeoLocationRestResource.doPost();
        Test.stopTest();
    }
}