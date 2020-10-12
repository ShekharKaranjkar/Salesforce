({
    doInit : function(component, event, helper) {
       // alert('dcavpc');
    },
    /* AccHandlerCMPController.js */
    handleComponentEvent : function(component, event) {
        var certificateApexString=component.get("v.certificateApexString");
       
        
        var accRec = event.getParam("id");
        var field = event.getParam("field");
        var fileName = event.getParam("fileName");
        var base64Data = event.getParam("base64Data");
        console.log('accRec'+fileName);
        console.log('field'+base64Data);  
        console.log('accRec'+fileName);
        console.log('field'+base64Data); 
        if(field=='certificate'){
            var temp=field+'----'+fileName+'----'+base64Data;
            console.log('temppppppppppppppppppppppppp@@@@@@@@@@################'+temp);
            component.set("v.certificateApexString",temp);
        }
       

        
    },
    
    itemsChange:function(component,event,helper){
        
    //    alert( component.get("v.vehicleid"));
           var callbackmethod = component.get("v.redirecttovf");
        if(callbackmethod != null && callbackmethod != undefined)
            callbackmethod( component.get("v.vehicleid"),function(){});
    },
    handleSave: function(component,event,helper) {
        
        
        helper.handlesave(component,event,helper);
    }
})