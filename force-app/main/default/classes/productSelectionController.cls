public class productSelectionController {
    @AuraEnabled
    public static list<productSelectionController.ProductWrapperClass> getAllProducts(String recordId ){
        list<ProductWrapperClass> productWrapperList=new list<ProductWrapperClass>();
        list<ModelTrip__mdt> ModelTripList=[ SELECT Name__c, DeveloperName, Price__c ,Location__c, SubLocation__c,  ElectricityInclude__c  FROM     ModelTrip__mdt];
        list<Model1D2D__mdt> Model1D2DList=[SELECT Name__c, DeveloperName, Price__c ,Duration__c  FROM Model1D2D__mdt];
        list<PricebookEntry>pbe =new list<PricebookEntry>();
        list<PriceBook2> pb=[select Id, Name, IsActive from PriceBook2 where IsActive =True];
        Opportunity opp= [Select id,Pricebook2.Id,Price_Car_Month__c ,Electricity_included__c from Opportunity where Id =:recordId limit 1];
        list<OpportunityLineItem> opList =
            [  select Id,Name,Location__c, Product2.Name,SubLocation__c,Product2.Id,SuggestedPriceCarMonth__c,
             Current_Pursuit__c,Trips_per_Day__c, Price_Trip__c, Flat_slab__c,
             Cars_to_be_ordered_for_Current_Pursuit__c, Driver_Model__c, Duration__c, MRROFTrip__c, Price_Car_Month__c, PricebookEntryId, Product2Id,
             Productivity__c, ProductCode, Quantity, Slab__c, TotalPrice, Trips_per_Month__c, UnitPrice,Other_Location_Present__c,Other_Location__c
             from OpportunityLineItem
             where OpportunityId =: opp.id
            ];
        if(opp.Electricity_included__c){
            pbe = [ select id, name, ProductCode,    Product2.Max_MinPrice__c, Product2.Family, Product2.ProductCode, Product2.SubLocation__c,
                   Product2.Location__c, isActive, Product2.Name, UnitPrice,Pricebook2Id
                   from PricebookEntry
                   where Pricebook2.Name ='Electricity Included' ];
        }
        else{
            pbe = [ select id, name, ProductCode,    Product2.Max_MinPrice__c, Product2.Family, Product2.ProductCode, Product2.SubLocation__c,
                   Product2.Location__c, isActive, Product2.Name, UnitPrice,Pricebook2Id
                   from PricebookEntry
                   where Pricebook2.Name ='Electricity Excluded'];
        }
        if(opList.size()>0){
            for(PricebookEntry p : pbe ){
                ProductWrapperClass pwc=new ProductWrapperClass();
                pwc.pbe = p;
                pwc.oli = opList;
                pwc.PriceCarMonth  =opp.Price_Car_Month__c;
                pwc.ModelTrip = ModelTripList;
                pwc.Model1D = Model1D2DList;
                pwc.electricityInclude = opp.Electricity_included__c;
                productWrapperList.add(pwc);
                system.debug('pwc='+pwc);
            }
        }else{
            for(PricebookEntry p : pbe ){
                ProductWrapperClass pwc=new ProductWrapperClass();
                pwc.pbe =p;
                pwc.PriceCarMonth=opp.Price_Car_Month__c;
                pwc.ModelTrip=ModelTripList;
                pwc.Model1D=Model1D2DList;
                pwc.electricityInclude = opp.Electricity_included__c;
                productWrapperList.add(pwc);
            }
        }
        return productWrapperList;
    }
    @AuraEnabled
    public static Map<String, List<String>> getDependentMap(sObject objDetail, string contrfieldApiName,string depfieldApiName) {
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        Schema.sObjectType objType = objDetail.getSObjectType();
        if (objType==null){
            return objResults;
        }
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            return objResults;
        }
        Schema.SObjectField theField = objFieldMap.get(dependentField);
        Schema.SObjectField ctrlField = objFieldMap.get(controllingField);
        List<Schema.PicklistEntry> contrEntries = ctrlField.getDescribe().getPicklistValues();
        List<PicklistEntryWrapper> depEntries = wrapPicklistEntries(theField.getDescribe().getPicklistValues());
        List<String> controllingValues = new List<String>();
        for (Schema.PicklistEntry ple : contrEntries) {
            String label = ple.getLabel();
            objResults.put(label, new List<String>());
            controllingValues.add(label);
        }
        for (PicklistEntryWrapper plew : depEntries) {
            String label = plew.label;
            String validForBits = base64ToBits(plew.validFor);
            for (Integer i = 0; i < validForBits.length(); i++) {
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    objResults.get(controllingValues.get(i)).add(label);
                }
            }
        }
        return objResults;
    }
    
    @AuraEnabled
    public static List<String> getdurationPicklist(){
        List<String> optionlist = new List<String>();
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Map<String, Schema.SObjectField> field_map = gd.get('OpportunityLineItem').getDescribe().fields.getMap(); 
        List<Schema.PicklistEntry> picklistValues = field_map.get('Duration__c').getDescribe().getPickListValues();
        optionlist.add('--None--');
        for (Schema.PicklistEntry pv : picklistValues) {
            optionlist.add(pv.getValue());
        }
        system.debug('optionlist'+optionlist);
        return optionlist;
    }
    
    @AuraEnabled
    public static List<String> getControllingMap(String objDetail, String contrfieldApiName){
        List<String> pickval= new List<String>();
        Schema.SObjectType s = Schema.getGlobalDescribe().get(objDetail) ;
        Schema.DescribeSObjectResult r = s.getDescribe() ;
        Map<String,Schema.SObjectField> fields = r.fields.getMap() ;
        Schema.DescribeFieldResult fieldResult = fields.get(contrfieldApiName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickval.add(pickListVal.getLabel());
        }
        return pickval;
    }
     @AuraEnabled
    public static boolean saveProduct(String recordId,List<sObject> listofTripProduct, List<sObject> onelist, List<sObject> oliListFlatUpdate, List<sObject> ondupdate,
                                      integer total, List<string>  DeleteoneDList,
                                      List<string>  DeleteflatList,
                                      List<string>  DeleteslabList
                                     ) 
    {
        try {
            
            Opportunity opp= [Select id,Pricebook2.Id,Price_Car_Month__c,Amounts__c  from Opportunity where Id =:recordId limit 1];
            opp.Amounts__c=total;
            update opp;
            if(listofTripProduct.size()>0){
                insert listofTripProduct;
            }
            if(onelist.size()>0){
                insert onelist;
            }
            if(oliListFlatUpdate!=null){
                update oliListFlatUpdate;
            }
            if(ondupdate!=null){
                update ondupdate;
            }
            if(DeleteoneDList.size()>0){
                delete [select Id from OpportunityLineItem  where id in:DeleteoneDList];
            }
            if(DeleteflatList.size()>0){
                delete [select Id from OpportunityLineItem  where id in:DeleteflatList];
            }
            if(DeleteslabList.size()>0){
                delete [select Id from OpportunityLineItem  where id in:DeleteslabList];
            }
            return true;
        }
        catch (Exception e) {
            // "Convert" the exception into an AuraHandledException
            throw new AuraHandledException(e.getMessage());    
        }
        
    }
        
        
    public class ProductWrapperClass{
        @AuraEnabled public list<ModelTrip__mdt> ModelTrip{get;set;}
        @AuraEnabled public list<Model1D2D__mdt> Model1D{get;set;}
        @AuraEnabled public PricebookEntry pbe{get;set;}
        @AuraEnabled public list<OpportunityLineItem> oli{get;set;}
        @AuraEnabled public Boolean checkboxSelected1d {get;set;}
        @AuraEnabled public Boolean checkboxSelectedTrip {get;set;}
        @AuraEnabled public Boolean electricityInclude {get;set;}
        @AuraEnabled public Boolean occured {get;set;}
        @AuraEnabled public String currentPursuit {get;set;}
        @AuraEnabled public String prName {get;set;}
        @AuraEnabled public String   location {get;set;}
        @AuraEnabled public String  subLocation{get;set;}
        @AuraEnabled public Boolean tableToShow {get;set;}
        @AuraEnabled public Decimal PriceCarMonth {get;set;}
        public  ProductWrapperClass(){
            oli = new list<OpportunityLineItem> ();
            ModelTrip= new list<ModelTrip__mdt>();
            Model1D= new list<Model1D2D__mdt>();
            pbe = new PricebookEntry();
            checkboxSelected1d = false;
            checkboxSelectedTrip = false;
            electricityInclude =false;
            tableToShow = false;
            PriceCarMonth = 0;
            currentPursuit= '' ;
            prName= '' ;
            occured =false;
            location='--- None ---';
            subLocation='--- None ---';
        }
    }
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';
        String validForBits = '';
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }
        return validForBits;
    }
    private static final String base64Chars = '' +
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
        'abcdefghijklmnopqrstuvwxyz' +
        '0123456789+/';
    private static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<PicklistEntryWrapper>.class);
    }
    public class PicklistEntryWrapper{
        public String active {get;set;}
        public String defaultValue {get;set;}
        public String label {get;set;}
        public String value {get;set;}
        public String validFor {get;set;}
        public PicklistEntryWrapper(){
        }
    }
}