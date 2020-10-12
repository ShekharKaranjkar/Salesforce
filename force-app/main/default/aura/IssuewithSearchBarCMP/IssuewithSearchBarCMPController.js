({
	doInit : function(component, event, helper) {
        //$Label.c.Issue_With
        //$A.get("$Locale.langLocale")
       // helper.plotMap(component);
       // helper.getType(component);
         var action  = component.get ("c.getissuewithrecords");
        action.setCallback(this, function(a) {
             debugger;
             var state = a.getState();
          if (state === "SUCCESS") {
            //  alert('iwsbcc12');
              var returndata = a.getReturnValue();
              var categoryList = [];
              var categoryset = new Set();
              var issuemap = new Map();
              var language = component.get("v.userlanguage");
              if(returndata != undefined && returndata.length>0){
                  for(var i=0;i<returndata.length;i++){
                      if(language == 'en_IN' || language.includes('en_')){
                      if(!categoryset.has(returndata[i].Issue_Category__c)){
                          categoryset.add(returndata[i].Issue_Category__c);
                          var picklist = {'label': returndata[i].Issue_Category__c, 'value': returndata[i].Issue_Category__c};
                          categoryList.push(picklist);
                          var issueList = [{'issuewith':returndata[i].Issue_With__c,'Priority':returndata[i].Priority__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id}];
                          //console.log('!!!'+issueList);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                          else if(categoryset.has(returndata[i].Issue_Category__c)){
                          var issueList = issuemap.get(returndata[i].Issue_Category__c);
                          var obj = {'issuewith':returndata[i].Issue_With__c,'Priority':returndata[i].Priority__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id};
                          issueList.push(obj);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                      }
                      else if(language == 'hi'){
                      if(!categoryset.has(returndata[i].Issue_Category__c)){
                          categoryset.add(returndata[i].Issue_Category__c);
                          var picklist = {'label': returndata[i].Issue_Category_Hindi__c, 'value': returndata[i].Issue_Category__c};
                          categoryList.push(picklist);
                          var issueList = [{'issuewith':returndata[i].Issue_With_Hindi__c,'Priority':returndata[i].Priority_Hindi__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id}];
                          //console.log('!!!'+issueList);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                          else if(categoryset.has(returndata[i].Issue_Category__c)){
                          var issueList = issuemap.get(returndata[i].Issue_Category__c);
                              var obj = {'issuewith':returndata[i].Issue_With_Hindi__c,'Priority':returndata[i].Priority_Hindi__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id};
                          issueList.push(obj);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                      }
                      else if(language == 'ta'){
                      if(!categoryset.has(returndata[i].Issue_Category__c)){
                          categoryset.add(returndata[i].Issue_Category__c);
                          var picklist = {'label': returndata[i].Issue_Category_Tamil__c, 'value': returndata[i].Issue_Category__c};
                          categoryList.push(picklist);
                          var issueList = [{'issuewith':returndata[i].Issue_With_Tamil__c,'Priority':returndata[i].Priority_Tamil__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id}];
                          //console.log('!!!'+issueList);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                          else if(categoryset.has(returndata[i].Issue_Category__c)){
                          var issueList = issuemap.get(returndata[i].Issue_Category__c);
                          var obj = {'issuewith':returndata[i].Issue_With_Tamil__c,'Priority':returndata[i].Priority_Tamil__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id};
                          issueList.push(obj);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                      }
                      else if(language == 'te'){
                      if(!categoryset.has(returndata[i].Issue_Category__c)){
                          categoryset.add(returndata[i].Issue_Category__c);
                          var picklist = {'label': returndata[i].Issue_Category_Telugu__c, 'value': returndata[i].Issue_Category__c};
                          categoryList.push(picklist);
                          var issueList = [{'issuewith':returndata[i].Issue_With_Teliugu__c,'Priority':returndata[i].Priority_Telugu__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id}];
                          //console.log('!!!'+issueList);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                          else if(categoryset.has(returndata[i].Issue_Category__c)){
                          var issueList = issuemap.get(returndata[i].Issue_Category__c);
                          var obj = {'issuewith':returndata[i].Issue_With_Teliugu__c,'Priority':returndata[i].Priority_Telugu__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id};
                          issueList.push(obj);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                      }
                      else if(language == 'kn'){
                      if(!categoryset.has(returndata[i].Issue_Category__c)){
                          categoryset.add(returndata[i].Issue_Category__c);
                          var picklist = {'label': returndata[i].Issue_Category_Kannada__c, 'value': returndata[i].Issue_Category__c};
                          categoryList.push(picklist);
                          var issueList = [{'issuewith':returndata[i].Issue_With_Kannada__c,'Priority':returndata[i].Priority_Kannada__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id}];
                          //console.log('!!!'+issueList);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                          else if(categoryset.has(returndata[i].Issue_Category__c)){
                          var issueList = issuemap.get(returndata[i].Issue_Category__c);
                          var obj = {'issuewith':returndata[i].Issue_With_Kannada__c,'Priority':returndata[i].Priority_Kannada__c,'IssueWithEng':returndata[i].Issue_With__c,'recid':returndata[i].Id};
                          issueList.push(obj);
                          issuemap.set(returndata[i].Issue_Category__c,issueList);
                      }
                      }
                  }
                  debugger;
                  //console.log(issuemap);
                  //console.log(categoryList);
                 component.set("v.MainrecordsMap",issuemap);
               component.set("v.IssueCategoryList",categoryList);
              }
          }
         });
         $A.enqueueAction(action);
	},
    searchforresults : function(component, event, helper) {
        //debugger;
        component.set('v.isSearchingstarted', true);
        var seach = component.get('v.searchkeyword');
        var mainmap = component.get('v.MainrecordsMap');
        var category = component.get('v.IssueCategoryval');
        var issuewithlist = mainmap.get(category) ;
         var searchedissuewithList = [];
	var searchkeyList = [];
    var filterset = new Set();
    searchkeyList = seach.split(',');     
    for (var i = 0; i < issuewithlist.length; i++) {
        for(var j=0; j<searchkeyList.length; j++){
              if (issuewithlist[i].issuewith.toLowerCase().indexOf(searchkeyList[j].toLowerCase()) != -1) {
                  if(searchkeyList[j-1] != '' && searchkeyList.length==1 && !filterset.has(issuewithlist[i])){
                      searchedissuewithList.push(issuewithlist[i]);
                     filterset.add(issuewithlist[i]);
                  }else if (searchkeyList.length > 1 && searchkeyList[j] !='' && !filterset.has(issuewithlist[i])){
                      searchedissuewithList.push(issuewithlist[i]);
                      filterset.add(issuewithlist[i]);
                  }               
              }
       }
    }
        component.set("v.filteredresultList",searchedissuewithList);
        component.set('v.isSearchingstarted', false);
        component.set("v.showdropdown",true);
	},
    setissuewithlistoncategory : function(component, event, helper) {
       // debugger;
    var category = component.get('v.IssueCategoryval');
        if(category != undefined){
            var mainmap = component.get('v.MainrecordsMap');
            console.log('2345'+mainmap.get(category));
            component.set('v.filteredresultList',mainmap.get(category));
            component.set("v.showdropdown",true);
        }
},
    handleComponentEvent : function(component, event, helper) {
        var selectedissuewith = event.getParam("issuewith");
        component.set("v.searchissuewith",selectedissuewith);
       component.set("v.searchkeyword",selectedissuewith.issuewith);
        component.set("v.showdropdown",false);
    },
    backmethod : function(component, event, helper){
        var callbackmethod = component.get("v.redirecttovf");
        if(callbackmethod != null && callbackmethod != undefined)
            callbackmethod(null,'Back',null,null,function(){});
    },
    nextmethod : function(component, event, helper){
        if(component.get("v.searchissuewith") != null && component.get("v.searchissuewith") != undefined){
		component.set("v.issuewithresolved",true);
        component.set("v.issuewithcmp",false);
        }
        else{
            component.set("v.showtoasterror",true);
            setTimeout(function(){ component.set("v.showtoasterror",false); }, 1000);
             /*var cmpTarget = component.find('Error_Toast');
        $A.util.addClass(cmpTarget, 'slds-show');
		$A.util.removeClass(cmpTarget, 'slds-hide');*/
          // sforce.one.showToast({"title": "Error!","message": "PLease select issue with","type": "error"});
           //component.set("v.selectissuewithman",true);
        }
           
        
    },
      yesmethod : function(component, event, helper){
        var callbackmethod = component.get("v.redirecttovf");
        if(callbackmethod != null && callbackmethod != undefined)
            callbackmethod(null,'Back',null,null,function(){});
    },
    nomethod : function(component, event, helper){
       var issue = component.get("v.searchissuewith");
        var priority = issue.Priority;
        if(priority == 'Low' || priority == 'High')
            priority = priority;
        else if(priority == 'குறைந்த' || priority == 'დაბალი' || priority =='తక్కువ' || priority == 'कम' || priority == 'ಲೋ')
            priority = 'Low';
        else if(priority == 'உயர்' || priority == 'სხვა' || priority =='అధిక' || priority == 'उच्च' || priority == 'ಹೈ')
            priority = 'High';
   /* var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
      "url": '/apex/'+pagename+'?issuewith='+issue.issuewith+'&priority='+issue.Priority+'&category='+component.get("v.IssueCategoryval")//issue.IssueWithEng
    });
    urlEvent.fire();*/
       // alert(component.get("v.IssueCategoryval"));
        var domain = $A.get("$Label.c.Driver_Menu_Domain");
         if(!window.location.href.includes(domain))
                    domain = '/apex';
        if(component.get("v.iconvalue") == 'repairicon'){
            var userAgent = navigator.userAgent; 
            var theme = component.get("v.uitheme");
            //alert(theme);
            if (theme === 'Theme4d' || theme === 'Theme4u'){
                sforce.one.navigateToURL(domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid);
            }
             else if(theme ==='Theme4t'){
            if(userAgent.includes("SalesforceMoblieSDK") || userAgent.includes("Salesforce1"))
                sforce.one.navigateToURL(domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid);
               // else
               window.location=domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid;
                     } 
                 else
      window.location=domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid;
        
        }
            else{
            var callbackmethod = component.get("v.redirecttovf");
            if(callbackmethod != null && callbackmethod != undefined)
            callbackmethod(issue.issuewith,'breaknext',component.get("v.knowledgeval"),component.get("v.IssueCategoryval"),priority,function(){});
        }
               
    },
    showissueform : function(component, event, helper){
       component.set("v.issuewithresolved",false);
        component.set("v.issuewithcmp",true);
    },
    closetoast : function(component, event, helper){
       component.set("v.showtoasterror",false);
    },
})