@RestResource(urlMapping='/api/Accountss/*')
global with sharing class RestTestAcc
{
    @HttpGet 
    global static Account doGet() 
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE id = :accId ];
        return result;
    }
    
    
    @HttpPost
    global static String doPost(String name,String phone,String AccountNumber ) 
    {
        Account acc = new Account();
        acc.name= name;
        acc.phone=phone;
        insert acc;
        
        return acc.Id;
    }
    
}