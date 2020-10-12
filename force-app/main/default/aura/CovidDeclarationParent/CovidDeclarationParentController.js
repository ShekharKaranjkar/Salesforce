({
    /* AccHandlerCMPController.js */
    handleComponentEvent : function(component, event) {
        var certificateApexString=component.get("v.certificateApexString");
        var signedApexString=component.get("v.signedApexString");
        
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
        if(field=='signed'){
            var temp2 =field+'----'+fileName+'----'+base64Data;
             console.log('temppppppppppppppppppppppppp222222222222222222222223############'+temp2);
            component.set("v.signedApexString",temp2);
        }

        
    },
    handleSave: function(component,event,helper) {
        
        
        helper.handlesave(component,event,helper);
    }
})