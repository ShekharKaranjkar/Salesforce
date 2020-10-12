public class AssignCar {
    
    
    public List<Service_Provider__c> dr{get;set;}
    public Service_Provider__c inventryProduct{get; set;}
    
    //  public string valuefromJS{get;set;}
    public List<Vehicle__c>carList {get;set;}
    
    public string searchServiceProvider {get; set;}
    
    public string searchVehicles {get; set;}
    public Map<String,Service_Provider__c>driverdetailsMap{get;set;}
    public string jsondriverdetailsMap{get;set;}
    public   Map<String,List<Vehicle_Assignment__c>> VehicleVsServiceprovider {get;set;}
    public Map<String,Vehicle__c>cardetailsMap{get;set;}
    public string jsoncardetailsMap{get;set;}
    public string driverNameget {get; set;}
    public string searchVehicle {get; set;}
    public String  hiddendriver {set;get;}
    public String hiddendcar {get;set;}
    public boolean display{get; set;}
    public boolean display1{get; set;}
    
    
    
    public AssignCar() {
        try{
            display = false;
            //isVechileAvilable = false;
            carList = new List<Vehicle__c>();
            driverNameget='';
            List<Service_Provider__c>spr=[SELECT id, name,Phone_Number__c from Service_Provider__c  where  Status__c ='Active' limit 20];
            List<Vehicle_Assignment__c>vaList=[SELECT id,Service_Provider__c   FROM Vehicle_Assignment__c where Service_Provider__c in:spr  limit 20 ];
            VehicleVsServiceprovider =new        Map<String,List<Vehicle_Assignment__c>> ();
            
            For(Vehicle_Assignment__c va : vaList)
            {
                if(VehicleVsServiceprovider.containsKey(va.Service_Provider__c))
                {
                    List<Vehicle_Assignment__c> vList = VehicleVsServiceprovider.get(va.Service_Provider__c);
                    vList.add(va);
                }
                else
                {
                    List<Vehicle_Assignment__c> vList = new List<Vehicle_Assignment__c>();
                    vList.add(va);
                    VehicleVsServiceprovider.put(va.Service_Provider__c,vList);
                }
            }
            dr=[SELECT id,name,Phone_Number__c FROM Service_Provider__c where  Phone_Number__c!=Null and Is_Available__c=true and Vehicle_Assigned_To__c=null limit 20];
            system.debug('vaLists'+dr);
            driverdetailsMap = New Map<String,Service_Provider__c>();
            inventryProduct = New Service_Provider__c();
            for (Service_Provider__c dr : [select id,Phone_Number__c, name from Service_Provider__c where Phone_Number__c!=Null and Is_Available__c=true and Vehicle_Assigned_To__c=null AND Status__c ='Active' limit 10000]){
                driverdetailsMap.put(dr.Phone_Number__c,dr);
                
                //   system.debug('driverdetailsMap'+driverdetailsMap);
            }  
            jsondriverdetailsMap = JSON.serialize(driverdetailsMap);
            
            cardetailsMap = New Map<String,Vehicle__c>();
            
            for (Vehicle__c cr : [select id,Vehicle_Registration_Number__c,VIN_Number__c, Name from Vehicle__c where VIN_Number__c!=Null and Is_Available__c=true  limit 10000]){
                cardetailsMap.put(cr.VIN_Number__c,cr);
                
            }  
            system.debug('cardetailsMap'+cardetailsMap.size());
            jsoncardetailsMap = JSON.serialize(cardetailsMap);   
            system.debug('jsoncardetailsMap'+jsoncardetailsMap);
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
        
        
    }
    
    
    Public PageReference GetRecordPage(){
        
        display = true;
        
        GetRecordFetching();
        
        return null;   
    }
    Public List<Service_Provider__c> GetRecordFetching(){
        
        return dr;
    }
    Public PageReference GetRecordPageforServicProvider(){
        serchServiceProviderRecords();
        return null;   
    }
    
    Public List<Service_Provider__c> serchServiceProviderRecords(){
        system.debug('searchServiceProvider'+searchServiceProvider);
        
        if(String.isNotBlank(searchServiceProvider)){
            string serchvarible='%'+searchServiceProvider+'%';
            system.debug('serchvarible'+serchvarible); 
            dr=[SELECT Id, Name,Phone_Number__c from Service_Provider__c where (Name   LIKE :serchvarible  or Phone_Number__c LIKE :serchvarible) and( Phone_Number__c!=Null) and Is_Available__c=true and Vehicle_Assigned_To__c=null AND Status__c ='Active' limit 20];
            
            system.debug('spr'+dr); 
            
            
            return dr;
        }
        else{
            //  string serchvarible='%'+searchServiceProvider+'%';
            dr=[SELECT id,name,Phone_Number__c FROM Service_Provider__c where  Phone_Number__c!=Null and Is_Available__c=true and Vehicle_Assigned_To__c=null AND Status__c='Active' limit 20];
            system.debug('spr'+dr);
            return dr;
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
        List<Vehicle__c> listitem22;
        string serchvarible='%'+searchVehicles+'%';
        string drivername = driverNameget;
        System.debug('drivername'+drivername);
        //Service_Provider__c serviceObj = [ Select Id,City__c,City__r.Name ,Phone_Number__c, Name From Service_Provider__c where Phone_Number__c=:driverNameget limit 1];
        List<Service_Provider__c> serviceObjList= [ Select Id,City__c,City__r.Name ,Phone_Number__c, Name From Service_Provider__c where Phone_Number__c=:driverNameget limit 1];
        if(serviceObjList != null && !serviceObjList.isempty()){
            Service_Provider__c  serviceObj = serviceObjList.get(0);
            carList =  new List<Vehicle__c>();
            if(searchVehicles!=null && searchVehicles!=''){
                listitem22  = [Select Id,City__c,VIN_Number__c, City__r.Name,Vehicle_Registration_Number__c,  Name From Vehicle__c where  City__r.Name=:serviceObj.City__r.Name and Is_Available__c=true and Status1__c='Onroad' and name LIKE :serchvarible limit 20 ];
                System.debug('listitem22'+listitem22.size());
            }else{
                listitem22= [Select Id,City__c,VIN_Number__c, City__r.Name,Vehicle_Registration_Number__c,  Name From Vehicle__c where  City__r.Name=:serviceObj.City__r.Name and Status1__c='Onroad'and Is_Available__c=true limit 20];
            }
            if(listitem22.size() > 0)
            {
                carList.addall(listitem22);
                system.debug('caarListSizetest   '+carList);
            }
        }
        return null;
    }
    
    
    Public PageReference GetRecordPage1(){
        
        display1= true;
        
        GetRecordFetching1();
        if(carList.size() > 0){
            
        }else{
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,label.vehicle_is_not_present_for_this_Location));
            
        }
        return null;   
    }
    Public  PageReference  GetRecordFetching1(){
        string phonenumber = Apexpages.currentPage().getParameters().get('drivernametoController');
        System.debug('drivername'+phonenumber);
        driverNameget=phonenumber;
        
        //  Service_Provider__c serviceObj = [ Select Id,City__c,Phone_Number__c,City__r.Name,  Name From Service_Provider__c where Phone_Number__c=:phonenumber limit 1];
        List<Service_Provider__c> serviceObjList= [ Select Id,City__c,City__r.Name ,Phone_Number__c, Name From Service_Provider__c where Phone_Number__c=:phonenumber  and Is_Available__c=true AND status__c='Active'  limit 1];
        if(serviceObjList != null && !serviceObjList.isempty()){
            Service_Provider__c  serviceObj = serviceObjList.get(0);
            System.debug('serviceObj'+serviceObj);       
            carList =  new List<Vehicle__c>();
            List<Vehicle__c> listitem1 = [Select Id,City__c, City__r.Name,VIN_Number__c,Vehicle_Registration_Number__c,  Name 
                                          From Vehicle__c
                                          where  City__c=:serviceObj.City__c and Status1__c='Onroad' and Is_Available__c=true limit 20];
            System.debug('listitem1=='+listitem1.size());        
            if(listitem1.size() > 0)
            {
                carList.addall(listitem1); 
                
            }else{
                
                
            }
            
            
        }
        system.debug('caarListSize'+carList.size());
        return null;
    }
    
    public pagereference save(){
        dr = [select id,name from Service_Provider__c];
        
        return null;
    }
    public  PageReference  savemethod(){
        try{
            string vinNumber = system.CurrentPageReference().getParameters().get('hiddendcar');
            string phoneNumber = system.CurrentPageReference().getParameters().get('hiddendriver');
            system.debug('phoneNumber:  '+phoneNumber);
            system.debug('vinNumber:  '+vinNumber);
            Boolean flag=false;
            Service_Provider__c serviceObj = [ Select Id,City__c, Vehicle_Assigned_To__c,Phone_Number__c,Is_Available__c, Name From Service_Provider__c where Phone_Number__c=:phoneNumber AND Status__c='Active' limit 1];
            system.debug('serviceObj:  '+serviceObj);
            Vehicle__c vehicleObj = [Select Id,City__c,Vehicle_Registration_Number__c, VIN_Number__c ,City__r.Name,Is_Available__c,Status1__c,  Name From Vehicle__c where VIN_Number__c=:vinNumber limit 1];
            
            list<Vehicle_Assignment__c> vaListforServiceProvider=[SELECT id,Service_Provider__c   FROM Vehicle_Assignment__c where Service_Provider__c=:serviceObj.Id limit 1];   
            //       list<Vehicle_Assignment__c> vaListForVehicle=[SELECT id,Name   FROM Vehicle_Assignment__c where Vehicle__c=:vehicleObj.Id limit 1];  
            system.debug('vaListforServiceProvider:  '+vaListforServiceProvider);
            
            if(serviceObj.Vehicle_Assigned_To__c==null && vehicleObj.Status1__c=='Onroad'  ){
                flag=true;
            }
            if(flag){
                if(serviceObj.City__c==vehicleObj.City__c){
                    vehicleObj.Is_Available__c=false;
                    serviceObj.Is_Available__c=false;
                    serviceObj.Vehicle_Assigned_To__c=vehicleObj.Id;
                    Vehicle_Assignment__c va=new Vehicle_Assignment__c();
                    va.Service_Provider__c=serviceObj.Id;
                    va.Vehicle__c=vehicleObj.Id;
                    // va.Is_Available__c=false;
                    system.debug('va'+va);
                    insert va;
                    update serviceObj;
                    update vehicleObj;
                    PageReference p = new PageReference('/'+va.Id);
                    p.setRedirect(true);
                    return p;
                }
                else{
                    system.debug('vehicleObj:  '+vehicleObj);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,Label.City_not_matched));
                } 
            } else if(vehicleObj.Status1__c!='Onroad'){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,label.Vehicle_Is_not_Onroad));
            }
            else {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,label.Already_Assinged_to_the_Another_vehicle));
            }
            
            
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
        //system.debug('car:  '+passedParam2);
        
        return null;
        
        
    } 
    
    
    
}