global class LocationDataMockTest implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"response":[{"attributes":{"type":"locationdata__c"},"Lidbid__c":100001,"DataSource__c":"Lithium-AWS","CarSpeed__c":0,"TimeStamp__c":1436115936000,"Mode__c":null,"GPS_Date_TimeUT__c":"2015-07-06T04:05:00Z","Is_Successful__c":"1","Vin_Number__c":"MB7D8RXBAFJE11115","Car_Status__c":"IDLE","Is_Valid__c":null,"Distance_To_Empty__c":96,"HVAC_status__c":"0","Odometer_Reading__c":"336","Kwh__c":0,"Server_Time__c":"2015-07-06T04:05:18Z","Latitude__c":"12.983055","Longitude__c":"77.708582","Direction_Longitude__c":"E","Direction_Latitude__c":"N","SOC__c":96.6},{"attributes":{"type":"locationdata__c"},"Lidbid__c":100002,"DataSource__c":"Lithium-AWS","CarSpeed__c":0,"TimeStamp__c":1436115936000,"Mode__c":null,"GPS_Date_TimeUT__c":"2015-07-05T22:34:00Z","Is_Successful__c":"1","Vin_Number__c":"MB7D8RXBAFJD11114","Car_Status__c":"IDLE","Is_Valid__c":null,"Distance_To_Empty__c":91,"HVAC_status__c":"0","Odometer_Reading__c":"296","Kwh__c":-0.52,"Server_Time__c":"2015-07-06T04:04:03Z","Latitude__c":"12.961582","Longitude__c":"77.601387","Direction_Longitude__c":"E","Direction_Latitude__c":"N","SOC__c":93}]}');
        res.setStatusCode(200);
        return res;
    }
}