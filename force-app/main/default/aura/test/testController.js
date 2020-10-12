({
 handleOnSubmit : function(component, event, helper) {
        event.preventDefault();
        var fields = event.getParam("fields");
        console.log("response======================="+ JSON.stringify(fields));
     var inputEmail = component.find("userEmail").get("v.value");
        console.log("response======================="+ JSON.stringify(inputEmail));
        component.find('form').submit(fields);
     
       
    },
    
    handleOnError: function(cmp, event, helper) {
        var errors = event.getParams();
     console.log("response======================="+ JSON.stringify(errors));
        
    },
    
    handleOnSuccess: function(component, event, helper) {
  
        
        
        
    },
    handleOnload: function(cmp, event, helper) {
        
    },

})