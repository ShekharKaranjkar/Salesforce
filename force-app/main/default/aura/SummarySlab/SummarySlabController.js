({
	check : function(component, event, helper) {
        var value = event.getSource().get("v.value"); 
             console.log('value'+value);
        if( Number(value) )
        {
            
        }		  else{
                      var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error Message',
                            message:'Please enter integer values',
                            messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                            duration:'2000',
                            key: 'info_alt',
                            type: 'error',
                            mode: 'pester'
                        });
                        toastEvent.fire();
            }  
	}
})