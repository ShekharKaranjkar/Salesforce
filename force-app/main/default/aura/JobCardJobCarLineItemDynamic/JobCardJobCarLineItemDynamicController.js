({
     doInit : function(component, event, helper) {
         
       // console.log('rowIndex==========='+component.get("v.rowIndex"));
       //  console.log('rowIndex==========='+JSON.stringify(component.get("v.jobcardItemInstance")));
    },
   AddNewRow : function(component, event, helper){
        
        
        var temp=component.get("v.jobcardItemInstance");
        console.log('tempppppppppp==========='+JSON.stringify(temp));
        var cmpEvent = component.getEvent("AddNewRowEvt");
        cmpEvent.setParams( { "productId" :'10' } );
        
        cmpEvent.fire();
        
    },
    
    removeRow : function(component, event, helper){
        
      
        
            console.log('rowIndex==========='+component.get("v.rowIndex"));
        //  component.getEvent("DeleteRowEvt").setParams({"indexVar" : 0 }).fire();
        
        //  component.getEvent("DeleteRowEvt").fire();     
        component.getEvent("DeleteRowEvt").setParams({"indexVar" :component.get("v.rowIndex"), "productId" :"10" }).fire();
        
        
    },
})