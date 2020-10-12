({
    /*doInit  : function(component, event, helper) {
        let action = component.get("c.doLoad");
        action.setCallback(this, function(response) {
            let state = response.getState();
            console.log('state doInit',state);
        });
        $A.enqueueAction(action);
    },*/
    checkStatusDetails : function(component, event, helper) {
        let action = component.get("c.checkStatus");
        action.setParams({  
            mobileNumber : component.get("v.mobileNumber")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS"){
                let returnValue = response.getReturnValue();
                if(returnValue !== undefined && returnValue != null){
                    component.set("v.checkStatus",false);
                    component.set("v.isFirstTime",returnValue);
                }
            }else if(state === "ERROR"){
                let errors = response.getError();
                let message = 'Unknown error';
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                helper.ModelToastMsg(component, event, helper, message);
            }else{
                helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginUnhandledError"));
            }
        });
        $A.enqueueAction(action);
    },
    
    passwordLogin : function(component, event, helper) {
        console.log('Step2');
        if(component.get("v.usrpassword").trim() != ''){
            let action = component.get("c.loginPassword");
            action.setParams({  
                mobileNumber : component.get("v.mobileNumber"),
                password	:	component.get("v.usrpassword"),
            });
            action.setCallback(this, function(response) {
                let state = response.getState();
                if(state === "SUCCESS"){
                    let returnValue = response.getReturnValue();
                    if(returnValue !== undefined && returnValue != null){
                        var uri_dec = decodeURIComponent(returnValue);
                        /*var urlEvent = $A.get("e.force:navigateToURL");
                        urlEvent.setParams({
                            "url": '/serviceprovider/s/',
                            "isredirect":true,
                        });
                        urlEvent.fire();
                        $A.get('e.force:refreshView').fire();*/
                    }
                }else if(state === "ERROR"){
                    let errors = response.getError();
                    let message = 'Unknown error';
                    if (errors && Array.isArray(errors) && errors.length > 0) {
                        message = errors[0].message;
                    }
                    helper.ModelToastMsg(component, event, helper, message);
                }else{
                    helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginUnhandledError"));
                }
            });
            $A.enqueueAction(action);
        }else{
            helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginBlankPassword"));
        }
    },
    SOAPlogin: function(component, event, helper){
        console.log('Step1');
        let action = component.get("c.loginSOAP");
            /*action.setParams({  
                username : "ajay1994@dazeworks.com",
                password :	"admin@123"
            });*/
        	action.setParams({  
                mobileNumber : component.get("v.mobileNumber"),
                password	:	component.get("v.usrpassword")
            });
            action.setCallback(this, function(response) {
                let state = response.getState();
                console.log('state ',state);
                if(state === "SUCCESS"){
                    let returnValue = response.getReturnValue();
                    console.log(returnValue);
                    helper.createCookie('SOAPSUID', returnValue);
                    helper.passwordLoginHelper(component, event, helper);
                }
            });
        $A.enqueueAction(action);
    },
    getOtpCode : function(component, event, helper) {
        let action = component.get("c.getOtp");
        action.setParams({  
            mobileNumber : component.get("v.mobileNumber")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS"){
                let returnValue = response.getReturnValue();
                if(returnValue !== undefined && returnValue != null){
                    component.set("v.storedOtp", returnValue);
                    component.set("v.gotOtp",true);
                    component.set("v.disableMobileNumber",true);
                }
            }else if(state === "ERROR"){
                let errors = response.getError();
                let message = 'Unknown error';
                if (errors && Array.isArray(errors) && errors.length > 0) {
                    message = errors[0].message;
                }
                helper.ModelToastMsg(component, event, helper, message);
            }else{
                helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginUnhandledError"));
            }
        });
        $A.enqueueAction(action);
    },
    
    setPassword : function(component, event, helper) {
        if(component.get("v.storedOtp") == component.get("v.readOtp")){
            if(component.get("v.forgotPassword") && (component.get("v.usrpassword").trim()=='' || component.get("v.usrpassword") != component.get("v.cnfpassword"))){
                if(component.get("v.usrpassword").trim() != ''){
                    helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginPasswordMismatch")); 
                }else{
                    helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginBlankPassword"));
                }
            }else{
                let action = component.get("c.setUserPassword");
                action.setParams({  
                    mobileNumber : component.get("v.mobileNumber"),
                    password: component.get("v.usrpassword"),
                });
                action.setCallback(this, function(response) {
                    let state = response.getState();
                    if(state === "SUCCESS"){
                        let returnValue = response.getReturnValue();
                        if(returnValue !== undefined && returnValue != null){
                            var uri_dec = decodeURIComponent(returnValue);
                            var urlEvent = $A.get("e.force:navigateToURL");
                            urlEvent.setParams({
                                "url": '/serviceprovider/s/',
                                "isredirect":true,  
                            });
                            urlEvent.fire();
                            $A.get('e.force:refreshView').fire();
                        }
                    }else if(state === "ERROR"){
                        let errors = response.getError();
                        let message = 'Unknown error';
                        if (errors && Array.isArray(errors) && errors.length > 0) {
                            message = errors[0].message;
                        }
                        helper.ModelToastMsg(component, event, helper, message);
                    }else{
                        helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginUnhandledError"));
                    }
                });
                $A.enqueueAction(action);
            }
        }else{
            helper.ModelToastMsg(component, event, helper, $A.get("$Label.c.ExternalLoginOTPMismatch"));
        }
    },
    
    forgotPassword : function(component, event, helper) {
        var mobileNumber = component.get("v.mobileNumber");
        helper.backToMain(component, event, helper);
        component.set("v.mobileNumber",mobileNumber);
        component.set("v.forgotPassword",true);
    },
    
    backToMain : function(component, event, helper) {
        helper.backToMain(component, event, helper);
    },
})