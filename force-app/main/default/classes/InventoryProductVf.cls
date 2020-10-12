public class InventoryProductVf {
 public List<Service_Provider__c> dr{get;set;}
    public List<Vehicle__c>cr1 {get;set;}
    public string driverid {get; set;}
    public string carid{get;set;}
    public Service_Provider__c  SelectedDr{get;set;}
    public Vehicle__c SelectedCr{get;set;}
    public Map<String,Service_Provider__c>driverdetailsMap{get;set;}
    public string jsondriverdetailsMap{get;set;}
    public string jsondriverdetailsList{get;set;}
    public Map<String,Vehicle__c>cardetailsMap{get;set;}
    public string jsoncardetailsMap{get;set;}
    public list<selectoption>carnames{Set;Get; } 
    public list<Service_Provider__c>drivernames{Set;Get; } 
    public String currentRecordId {get;set;}
    
    public String  drid {set;get;}
    public String crid {get;set;}
    public String  hiddendriver {set;get;}
    public String hiddendcar {get;set;}
    public boolean display{get; set;}
    public boolean display1{get; set;}
    
    public InventoryProductVf() {
        display = false;
        dr =  [Select Id, Name From Service_Provider__c];
        
        driverdetailsMap = New Map<String,Service_Provider__c>();
        
        for (Service_Provider__c dr : [select id, name from Service_Provider__c ]){
            driverdetailsMap.put(dr.id,dr);
        }  
        jsondriverdetailsMap = JSON.serialize(driverdetailsMap);
        
        cardetailsMap = New Map<String,Vehicle__c>();
        
        for (Vehicle__c cr : [select id, name from Vehicle__c]){
            cardetailsMap.put(cr.id,cr);
        }  
        jsoncardetailsMap = JSON.serialize(cardetailsMap);   
    }
    
    Public PageReference GetRecordPage(){
        
        display = true;
        
        GetRecordFetching();
        
        return null;   
    }
    Public List<Service_Provider__c> GetRecordFetching(){
        
        List<Service_Provider__c> listitem = [Select Id, Name From Service_Provider__c];
        return listitem;
    }
    Public PageReference GetRecordPage1(){
        
        display1= true;
        
        GetRecordFetching1();
        
        return null;   
    }
    Public List<Vehicle__c> GetRecordFetching1(){
        cr1 =  new List<Vehicle__c>();
        List<Vehicle__c> listitem1 = [Select Id, Name From Vehicle__c];
        
        if(listitem1.size() > 0)
        {
            cr1.addall(listitem1);        
        }    
        return cr1;
    }
    public pagereference save(){
        dr = [select id,name from Service_Provider__c];
        
        return null;
    }
    
    public  PageReference  savemethod(){
        string passedParam2 = system.CurrentPageReference().getParameters().get('hiddendcar');
        string passedParam1 = system.CurrentPageReference().getParameters().get('hiddendriver');
        Service_Provider__c d  = new Service_Provider__c();
        d.id = passedParam1;
            d.vehicle_Assigned_To__c = passedParam2 ;
            update d;
            system.debug('car:  '+passedParam2);
         Vehicle_Assignment__c v  = new Vehicle_Assignment__c();
            v.Vehicle__c = passedParam2 ;
            v.Service_Provider__c = passedParam1;
            insert v;
            //system.debug('car:  '+passedParam2);
            
        
        PageReference p = new PageReference('/apex/CarAssign?urlparm=' + v.id);
        p.setRedirect(true);
        
        return p;
        
    } 
    
}