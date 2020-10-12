({
    AddNewRow : function(component, event, helper){
        // fire the AddNewRowEvt Lightning Event 
        component.getEvent("AddRowEvt").fire();     
    },
    
    removeRow : function(component, event, helper){
        // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
        component.getEvent("DeleteRowEvt").setParams({"indexVar" : component.get("v.rowIndex") }).fire();
    }, 
    getSlabTabel : function(component, event) {
        var params = event.getParam('arguments');
        if (params) {
            var param1 = params.slabToShow;
            console.log('param1'+param1);
            if(param1=='flat'){
                component.set("v.flatTabel",true);
            }
            else if(param1=='slab'){
               component.set("v.slabTabel",true);
            }
        }
        
    }
    
})