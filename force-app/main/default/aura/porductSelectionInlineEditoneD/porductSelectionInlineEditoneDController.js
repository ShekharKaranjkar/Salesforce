({    
    calculateTotal:function(component, event, helper){
        window.setTimeout(
            $A.getCallback(function() {
                helper.getTotalList(component, event, helper);  
            }), 3000
        );
        
    },
   
})