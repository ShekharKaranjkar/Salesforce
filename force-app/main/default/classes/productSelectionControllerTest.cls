@isTest
public class productSelectionControllerTest {
    
    
    @testSetup static void setup() {
        
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        
        Opportunity ol=new Opportunity();
        ol.name='ragh';
        ol.StageName='M1: Solution Sent for Approval';
        ol.CloseDate=system.today();
        ol.AccountId=acc.id;
        ol.Electricity_included__c=false;
        insert ol;
        
        
        Id stId = Test.getStandardPricebookId();
        
        Product2 prod = new Product2(Name = 'Laptop X200',  Family = 'Hardware');
        insert prod;
        
        Pricebook2 customPB = new Pricebook2(Name='Electricity Included' , isActive=true);
        insert customPB;
        
        PricebookEntry stPOrice = new PricebookEntry(Pricebook2Id = stId, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert stPOrice;
        
        PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPB.Id, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
        
    }
    
    static testMethod void getDependentMapList() {
        String sobjectname='OpportunityLineItem';
        String location ='Location__c';
        String subLocation ='SubLocation__c'; 
        String objectStr = 'Account';
        string s;
        string l;
        List<Schema.SObjectType> objects = new List<Schema.SObjectType>{ OpportunityLineItem.SObjectType};
            for(Schema.SObjectType objType: objects){
                for(Schema.SObjectField fld: objType.getDescribe().fields.getMap().values()){
                    
                    if(fld.getDescribe().getName()=='Location__c'){
                        l=  fld.getDescribe().getName();
                    }
                    if(fld.getDescribe().getName()=='SubLocation__c'){
                        s=  fld.getDescribe().getName();
                    }
                    System.debug('API Field Name =  '+fld.getDescribe().getName());
                }
            }
        Schema.SObjectType convertType = Schema.getGlobalDescribe().get(sobjectname);
        Sobject genericObject = convertType.newSObject();
        Test.startTest();
        productSelectionController.getDependentMap(genericObject,l,s);
        Test.stopTest();
    }
    
    static testMethod void decimalToBinary() {
        Integer val=8;
        
        Test.startTest();
        productSelectionController.decimalToBinary(val);
        Test.stopTest();
    }
    
    static testMethod void base64ToBits() {
        String val='test';
        
        Test.startTest();
        productSelectionController.base64ToBits(val);
        Test.stopTest();
    }
    
    
    static testMethod void getAllProducts() {
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        
        Opportunity o=new Opportunity();
        o.name='ragh';
        o.StageName='M1: Solution Sent for Approval';
        o.CloseDate=system.today();
        o.AccountId=acc.id;
        o.Electricity_included__c = true;
        insert o;
        
        Id stId = Test.getStandardPricebookId();
        
        Product2 prod = new Product2(Name = 'Laptop X200',  Family = 'Hardware');
        insert prod;
        
        Pricebook2 customPB = new Pricebook2(Name='Electricity Included' , isActive=true);
        insert customPB;
        
        PricebookEntry stPOrice = new PricebookEntry(Pricebook2Id = stId, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert stPOrice;
        
        PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPB.Id, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
        Test.startTest();
        productSelectionController.getAllProducts(o.Id);
        Test.stopTest();
        
    }
    static testMethod void getAllProductselectrictyNotinclude() {
        account acc=new account();
        acc.Name='rag';
        acc.Lithium_Billing_Entity__c='Pune';
        acc.Lithium_Bank_Account__c='State Bank';
        insert acc;
        
        Opportunity ol=new Opportunity();
        ol.name='ragh';
        ol.StageName='M1: Solution Sent for Approval';
        ol.CloseDate=system.today();
        ol.AccountId=acc.id;
        ol.Electricity_included__c=false;
        insert ol;
        
        
        Id stId = Test.getStandardPricebookId();
        
        Product2 prod = new Product2(Name = 'Laptop X200',  Family = 'Hardware');
        insert prod;
        
        Pricebook2 customPB = new Pricebook2(Name='Electricity Included' , isActive=true);
        insert customPB;
        
        PricebookEntry stPOrice = new PricebookEntry(Pricebook2Id = stId, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert stPOrice;
        
        PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = customPB.Id, Product2Id = prod.Id, UnitPrice = 12000, IsActive = true);
        insert customPrice;
        
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId = ol.Id,
            Quantity = 5,
            PricebookEntryId = customPrice.Id,
            TotalPrice = 4 * customPrice.UnitPrice
        );
        insert oli;
        
        Test.startTest();
        productSelectionController.getAllProducts(ol.Id);
        Test.stopTest();
        
        
    }
    
    
    static testMethod void saveProduct() {
        List<OpportunityLineItem> opLineItem = new   List<OpportunityLineItem>();
        
        List<OpportunityLineItem> onelist = new   List<OpportunityLineItem>();
        Opportunity o=[select id ,name from Opportunity ];
        integer t=9;
        
        List<pricebook2> custompricebook = [select id from pricebook2 where name='Electricity Included' Limit 1];
        List<pricebookentry> priceenrty = [select id,unitPrice from pricebookentry where pricebook2.id =: custompricebook[0].id Limit 1];
        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId = o.Id,
            Quantity = 5,
            PricebookEntryId = priceenrty[0].Id,
            TotalPrice = 2000);
        opLineItem.add(oli);
        
        
        OpportunityLineItem onelistobj = new OpportunityLineItem(
            OpportunityId = o.Id,
            Quantity = 5,
            PricebookEntryId = priceenrty[0].Id,
            TotalPrice = 2000);
        onelist.add(onelistobj);
        
        List<OpportunityLineItem> opLineItemFlatUpdatenew = new   List<OpportunityLineItem>();
        List<OpportunityLineItem> opLineItemFlatUpdate = new   List<OpportunityLineItem>();
        OpportunityLineItem ol = new OpportunityLineItem(
            OpportunityId = o.Id,
            Quantity = 59,
            PricebookEntryId = priceenrty[0].Id,
            TotalPrice = 2000);
        opLineItemFlatUpdate.add(ol);
        insert opLineItemFlatUpdate;
        opLineItemFlatUpdatenew =[select id ,name from OpportunityLineItem where Quantity =59 Limit 1  ];
        
        List<OpportunityLineItem> opLineItemdelete = new   List<OpportunityLineItem>();
        OpportunityLineItem olil = new OpportunityLineItem(
            OpportunityId = o.Id,
            Quantity = 5,
            PricebookEntryId = priceenrty[0].Id,
            TotalPrice = 2000);
        opLineItemdelete.add(olil);
        insert opLineItemdelete;
        list<string> str= new list<String>{opLineItemdelete[0].id};
            
            Test.startTest();
        productSelectionController.saveProduct(o.id,opLineItem,onelist,opLineItemFlatUpdatenew,opLineItemFlatUpdatenew,t,str,str,str);
        Test.stopTest();
        
        
    }
    
     static testMethod void getControllingMap() {
        String sobjectname='OpportunityLineItem';
        String location ='Location__c';
        String subLocation ='SubLocation__c'; 
        String objectStr = 'Account';
        string s;
        string l;

          Schema.SObjectType convertType = Schema.getGlobalDescribe().get(sobjectname);
        Sobject genericObject = convertType.newSObject();
        Test.startTest();
        productSelectionController.getControllingMap(sobjectname,location);
        Test.stopTest();
    }
    
}