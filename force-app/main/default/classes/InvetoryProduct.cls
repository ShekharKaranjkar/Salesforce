public class InvetoryProduct {
    
    public List<Vehicle__c> vehiclelist{get;set;}
    public Service_Provider__c inventryProduct{get; set;}
    public List<Inventory_Product__c>inventoryProductList {get;set;}
    public string searchServiceProvider {get; set;}
    public string searchVehicles {get; set;}
    public Map<String,Vehicle__c>driverdetailsMap{get;set;}
    public string jsondriverdetailsMap{get;set;}
    public Map<String,Inventory_Product__c>cardetailsMap{get;set;}
    public string jsoncardetailsMap{get;set;}
    public string driverNameget {get; set;}
    public string searchVehicle {get; set;}
    public String  hiddendriver {set;get;}
    public String hiddendcar {get;set;}
    public boolean display{get; set;}
    public boolean display1{get; set;}
    
    public InvetoryProduct() {
        
        display = false;
        inventoryProductList = new List<Inventory_Product__c>();
        driverNameget='';
        vehiclelist=[SELECT  id,Vehicle_Registration_Number__c,VIN_Number__c, Name  from Vehicle__c  limit 20];
        driverdetailsMap = New Map<String,Vehicle__c>();
        inventryProduct = New Service_Provider__c();
        for (  Vehicle__c cr : [select id,Vehicle_Registration_Number__c,VIN_Number__c, Name from Vehicle__c where VIN_Number__c!=NULL limit 10000]){
            driverdetailsMap.put(cr.VIN_Number__c,cr);
        }  
        jsondriverdetailsMap = JSON.serialize(driverdetailsMap);
        cardetailsMap = New Map<String,Inventory_Product__c>();
        for (Inventory_Product__c dr : [select id,Name,QR_Code__c  from Inventory_Product__c where QR_Code__c!=NULL limit 10000] ){
            cardetailsMap.put(dr.QR_Code__c,dr);
        }  
        system.debug('driverdetailsMap'+driverdetailsMap.size());
        system.debug('cardetailsMap'+cardetailsMap.size());
        jsoncardetailsMap = JSON.serialize(cardetailsMap);   
        system.debug('jsoncardetailsMap'+jsoncardetailsMap);
    }

    Public PageReference GetRecordPage(){
        display = true;
        GetRecordFetching();
        return null;   
    }
    
    Public List<Vehicle__c> GetRecordFetching(){
        return vehiclelist;
    }
    
    Public PageReference GetRecordPageforServicProvider(){
        serchServiceProviderRecords();
        return null;   
    }
    
    Public List<Vehicle__c> serchServiceProviderRecords(){
        system.debug('searchServiceProvider'+searchServiceProvider);
        if(searchServiceProvider!=null && searchServiceProvider!=''){
            string serchvarible='%'+searchServiceProvider+'%';
            vehiclelist=[Select Id,City__c,VIN_Number__c, City__r.Name,Vehicle_Registration_Number__c,  Name From Vehicle__c where  name LIKE :serchvarible limit 20];
            return vehiclelist;
        }
        else{
            string serchvarible='%'+searchServiceProvider+'%';
            vehiclelist=[Select Id,City__c,VIN_Number__c, City__r.Name,Vehicle_Registration_Number__c,  Name From Vehicle__c limit 20];
            return vehiclelist;
        } 
    }
    
    Public PageReference GetRecordPageforVehicle(){
        display1= true;
        GetRecordPageforVehicles();
        return null;   
    }
    
    Public  PageReference  GetRecordPageforVehicles(){
        system.debug('searchServiceProvider'+searchVehicles);
        system.debug('searchServiceProvider'+driverNameget);
        List<Inventory_Product__c> listitem22;
        string serchvarible='%'+searchVehicles+'%';
        string drivername = driverNameget;
        System.debug('drivername'+drivername);
        //Service_Provider__c serviceObj = [ Select Id,City__c,City__r.Name ,Phone_Number__c, Name From Service_Provider__c where Phone_Number__c=:driverNameget limit 1];
        List<Vehicle__c> VehicleObjList= [ Select Id,City__c,Vehicle_Registration_Number__c, VIN_Number__c ,City__r.Name,Is_Available__c,  Name From Vehicle__c where VIN_Number__c=:drivername limit 1];
        if(VehicleObjList != null && !VehicleObjList.isempty()){
            Vehicle__c  VehicleObj = VehicleObjList.get(0);
            inventoryProductList =  new List<Inventory_Product__c>();
            if(searchVehicles!=null && searchVehicles!=''){
                listitem22  = [Select Id, Name,QR_Code__c From Inventory_Product__c where  City__r.Name=:VehicleObj.City__r.Name  and name LIKE :serchvarible limit 20];
                System.debug('listitem22'+listitem22.size());
            }else{
                listitem22= [Select Id, Name,QR_Code__c From Inventory_Product__c where  City__r.Name=:VehicleObj.City__r.Name  limit 20];
            }
            if(listitem22.size() > 0)
            {
                inventoryProductList.addall(listitem22);
                system.debug('caarListSizetest   '+inventoryProductList);
            }
        }
        return null;
    }
    
    Public PageReference GetRecordPage1(){
        display1= true;
        GetRecordFetching1();
        if(inventoryProductList.size() > 0){
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,Label.Product_Is_not_Available));
        }
        return null;   
    }
    
    Public  PageReference  GetRecordFetching1(){
        string vinNumber = Apexpages.currentPage().getParameters().get('drivernametoController');
        system.debug('vinNumber'+vinNumber);
        driverNameget=vinNumber;
        Vehicle__c vehicleObj = [Select Id,City__c,Vehicle_Registration_Number__c, VIN_Number__c ,City__r.Name,Is_Available__c,  Name From Vehicle__c where VIN_Number__c=:vinNumber limit 1];
      system.debug('vehicleObj'+vehicleObj);
        List<Inventory_Product__c> listitem1 = [Select Id, Name,QR_Code__c From Inventory_Product__c where City__r.Name =:vehicleObj.City__r.Name];
         system.debug('listitem1'+listitem1);
        inventoryProductList=new list<Inventory_Product__c>();
        if(listitem1.size() > 0)
        {
            inventoryProductList.addall(listitem1);        
        }
        system.debug('caarListSize'+inventoryProductList.size());
        return null;
    }
 /*   
    public pagereference save(){
        dr = [select id,name from Service_Provider__c];
        
        return null;
    }
*/
    public  PageReference  savemethod(){
     try{
            system.debug('hiiiiii:');
            string qrcodevalue = system.CurrentPageReference().getParameters().get('hiddendcar');
            string vinNumber = system.CurrentPageReference().getParameters().get('hiddendriver');
            system.debug('qrcodevalue:  '+qrcodevalue);
            system.debug('passedParam1:  '+vinNumber);
            Inventory_Product__c inProduct=[select id,name,Stock__c,QR_Code__c,Expiration_Date__c, City__r.Name from Inventory_Product__c where QR_Code__c=:qrcodevalue];
            Decimal i=  inProduct.Stock__c;
            Vehicle__c vehicleObj = [Select Id,City__c,Vehicle_Registration_Number__c, VIN_Number__c ,City__r.Name,Is_Available__c,  Name From Vehicle__c where VIN_Number__c=:vinNumber limit 1];
            if(i<1){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,Label.Stock_Is_Not_Available));
            }
         else if(inProduct.Expiration_Date__c < system.today().addDays(6) ){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,Label.The_Expiration_Date_is_near));
         }
         else if(inProduct.City__r.Name!=vehicleObj.City__r.Name){
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,label.City_not_matched));
         }
            else{
                inProduct.Stock__c=i-1;
                update inProduct;
                Inventory_Assignment__c inven  = new Inventory_Assignment__c();
                inven.Vehicle__c=vehicleObj.Id;
                inven.Inventory_Product__c=inProduct.Id;
                insert inven;
                PageReference p = new PageReference('/'+inven.Id);
                p.setRedirect(true);
                return p;
            }
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
        return null;
    } 
}