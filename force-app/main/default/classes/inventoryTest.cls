public class inventoryTest {
  
    public List<Inventory_Product__c> dr{get;set;}
    public Inventory_Product__c inventryProduct{get; set;}
    

    public List<Vehicle__c>carList {get;set;}

    public Map<String,Inventory_Product__c>driverdetailsMap{get;set;}
    public string jsondriverdetailsMap{get;set;}

    public Map<String,Vehicle__c>cardetailsMap{get;set;}
    public string jsoncardetailsMap{get;set;}

    public String  hiddendriver {set;get;}
    public String hiddendcar {get;set;}
    public boolean display{get; set;}
    public boolean display1{get; set;}
    
    public inventoryTest() {
        display = false;
        dr =  [Select Id, Name From Inventory_Product__c];
        
        driverdetailsMap = New Map<String,Inventory_Product__c>();
        inventryProduct = New Inventory_Product__c();
        for (Inventory_Product__c dr : [select id, name from Inventory_Product__c ]){
            driverdetailsMap.put(dr.id,dr);
            system.debug('driverdetailsMap'+driverdetailsMap);
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
    Public List<Inventory_Product__c> GetRecordFetching(){
        
        List<Inventory_Product__c> listitem = [Select Id, Name From Inventory_Product__c ];
        return listitem;
    }
    Public PageReference GetRecordPage1(){
        
        display1= true;
        
        GetRecordFetching1();
        
        return null;   
    }
    Public  PageReference  GetRecordFetching1(){
        string drivername = Apexpages.currentPage().getParameters().get('drivernametoController');
        System.debug('drivername'+drivername);
        Inventory_Product__c inveProduct=[   select id,City__c,Name  FROM Inventory_Product__c WHERE ID=:drivername limit 1];
        
        List<Vehicle__c> listitem1 = [Select Id, Name,Vehicle_Registration_Number__c From Vehicle__c where City__r.Id =:inveProduct.City__c];
        carList=new list<Vehicle__c>();
        if(listitem1.size() > 0)
        {
            carList.addall(listitem1);        
        }  
        
        return null;
    }
    
    
    
    public pagereference save(){
        dr = [select id,name from Inventory_Product__c];
        
        return null;
    }
    public  PageReference  savemethod(){
        try{
            
            
            
            system.debug('hiiiiii:');
            string passedParam2 = system.CurrentPageReference().getParameters().get('hiddendcar');
            string passedParam1 = system.CurrentPageReference().getParameters().get('hiddendriver');
            system.debug('passedParam2:  '+passedParam2);
            system.debug('passedParam1:  '+passedParam1);
            Inventory_Product__c inProduct=[select id,name,Stock__c  from Inventory_Product__c where id=:passedParam1];
            Decimal i=  inProduct.Stock__c;
            
            if(i<1){
                system.debug('hiiiiiiiiiiii');
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Stock Is Not Available'));
                
            }
            else{
                
                inProduct.Stock__c=i-1;
                update inProduct;
                
                Inventory_Assignment__c inven  = new Inventory_Assignment__c();
                inven.Vehicle__c=passedParam2;
                inven.Inventory_Product__c=passedParam1;
                insert inven;
                
                
                
                PageReference p = new PageReference('https://lithium--dev.lightning.force.com/lightning/r/Inventory_Assignment__c/'+inven.Id+'/view');
                p.setRedirect(true);
                return p;
            }
            
            
        }catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
        //system.debug('car:  '+passedParam2);
        
        return null;
        
        
    } 
    public void saveInventryRecord(){
        system.debug('inventryProduct'+inventryProduct);
        upsert inventryProduct;
    }
}