({
    
    doInit : function(component, event, helper) {      
           component.set("v.selected", true);
        
           console.log('1tabelListdoInit'+JSON.stringify(component.get("v.jobcardItemInstance")));
       // helper.opporunityProduct(component, event, helper);
    },
    
    handleswapp : function(component,event,helper) {

        var tabelList=component.get("v.jobcardItemInstance"); 
        console.log('1tabelListdoInit'+JSON.stringify(component.get("v.jobcardItemInstance")));
        component.set("v.selected", false);
        console.log('1tabelList'+JSON.stringify(tabelList));
        tabelList.showAction=true;
        tabelList.showInventory=false;
        component.set("v.jobcardItemInstance", tabelList);
        console.log('2tabelList'+JSON.stringify(tabelList));
    },
    
    handleInventory: function(component,event,helper) {
        
          console.log('1tabelListSlab');  
    component.set("v.selected", true);
        var tabelListSlab=component.get("v.jobcardItemInstance"); 

        console.log('1tabelListSlab'+JSON.stringify(tabelListSlab));
        tabelListSlab.showAction=false;
        tabelListSlab.showInventory=true;
        component.set("v.jobcardItemInstance", tabelListSlab);
        console.log('2tabelListSlab'+JSON.stringify(tabelListSlab));
    },   
})