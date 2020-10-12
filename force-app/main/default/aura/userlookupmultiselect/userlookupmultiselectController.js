({
    onblur : function(component,event,helper){
        // on mouse leave clear the listOfSeachRecords & hide the search result component 
        component.set("v.listOfSearchRecords", null );
        component.set("v.SearchKeyWord", '');
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
    onfocus : function(component,event,helper){
        
        //alert(component.get("v.userobj"));
        console.log('user'+component.get("v.userobj"));
        // show the spinner,show child search result component and call helper function
     //   $A.util.addClass(component.find("mySpinner"), "slds-show");
        component.set("v.listOfSearchRecords", null ); 
        var forOpen = component.find("searchRes");
        $A.util.addClass(forOpen, 'slds-is-open');
        $A.util.removeClass(forOpen, 'slds-is-close');
        // Get Default 5 Records order by createdDate DESC 
        var getInputkeyWord = '';
        helper.searchHelper(component,event,getInputkeyWord);
    },
    
    keyPressController : function(component, event, helper) {
       // $A.util.addClass(component.find("mySpinner"), "slds-show");
        // get the search Input keyword   
        var getInputkeyWord = component.get("v.SearchKeyWord");
        // check if getInputKeyWord size id more then 0 then open the lookup result List and 
        // call the helper 
        // else close the lookup result List part.   
        if(getInputkeyWord.length > 0){
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord);
        }
        else{  
            component.set("v.listOfSearchRecords", null ); 
            var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
        }
    },
    
    // function for clear the Record Selaction 
    clear :function(component,event,heplper){
        var selectedPillId = event.getSource().get("v.name");
        var AllPillsList = component.get("v.lstSelectedRecords"); 
        var getSelectRecord= component.set("v.userobj");
        for(var i = 0; i < AllPillsList.length; i++){
            if(AllPillsList[i].Id == selectedPillId){
                AllPillsList.splice(i, 1);
                component.set("v.lstSelectedRecords", AllPillsList);
            }  
        }
        component.set("v.SearchKeyWord",null);
        component.set("v.listOfSearchRecords", null ); 
        component.set("v.showpill", false );
         component.set("v.userid", null );component.set("v.userobj", null );
        var compEvent = component.getEvent("oSelecteduserlookupIdEvent");
        // set the Selected sObject Record to the event attribute.  
        compEvent.setParams({"recordByEvent" : getSelectRecord,"passingid":false,"indexnum": component.get("v.index"),"whichtaskList":component.get("v.whichtaskList")});  
        // fire the event  
        compEvent.fire();
    },
    
    // This function call when the end User Select any record from the result list.   
    handleComponentEvent : function(component, event, helper) {
        component.set("v.SearchKeyWord",null);
        // get the selected object record from the COMPONENT event 	 
        ///var listSelectedItems =  component.get("v.lstSelectedRecords");
        var selecteduserGetFromEvent = event.getParam("recordByEvent");
        //listSelectedItems.push(selectedAccountGetFromEvent);
        //alert('userId: '+selecteduserGetFromEvent.Id);
        var forclose = component.find("lookup-pill");
        $A.util.addClass(forclose, 'slds-show');
        $A.util.removeClass(forclose, 'slds-hide');
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open'); 
        component.set("v.userobj" , selecteduserGetFromEvent);
        if(component.get("v.iscontact") == false){
            component.set("v.showpill" , true);
        component.set("v.userid" , selecteduserGetFromEvent.Id);
        var compEvent = component.getEvent("oSelecteduserlookupIdEvent");
        // set the Selected sObject Record to the event attribute.  
        compEvent.setParams({"recordByEvent" : selecteduserGetFromEvent,"passingid":true,"indexnum": component.get("v.index"),"whichtaskList":component.get("v.whichtaskList")});  
        // fire the event  
        compEvent.fire();
        }else if(component.get("v.iscontact") == true){
            //alert('Contact Lookup');
            debugger;
            component.set("v.showcontactpill" , true);
             component.set("v.contactobj" , selecteduserGetFromEvent);
            //var listSelectedItems =  component.get("v.lstSelectedRecords");
            //listSelectedItems.push(selecteduserGetFromEvent);
            //component.set("v.lstSelectedRecords" , listSelectedItems);
        var compEvent1 = component.getEvent("oSelectedcontactlookupIdEvent");
        // set the Selected sObject Record to the event attribute.  
        compEvent1.setParams({"recordByEvent" : selecteduserGetFromEvent});  
        // fire the event  
        compEvent1.fire();
        }
    },
    doInit : function(component, event) {
        //alert(component.get("v.lstSelectedRecords").length)
        if(component.get("v.lstSelectedRecords").length>0)
            component.set("v.showcontactpill" , true);
    }
})