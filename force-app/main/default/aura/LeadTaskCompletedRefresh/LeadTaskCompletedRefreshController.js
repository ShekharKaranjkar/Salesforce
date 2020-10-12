({
	handleMessage : function(component, event, helper) {
		const param = event.getParam('message');
		console.log('Step handleMessage ', `${param.sobject.WhatId}`);
        console.log('Step 3 ',component.get("v.recordId") + ' ' + `${param.sobject.WhatId}`);
        if(component.get("v.recordId") === `${param.sobject.WhatId}` || component.get("v.recordId") === `${param.sobject.WhoId}`){
            /*var workspaceAPI = component.find("QuestionaireTab");
        	workspaceAPI.getFocusedTabInfo().then(function(response) {
            var focusedTabId = response.tabId;
                workspaceAPI.refreshTab({
                          tabId: focusedTabId,
                          includeAllSubtabs: true
                 });
            })
            .catch(function(error) {
                console.log(error);
            });*/
            console.log('Step 1');
            
            $A.get('e.force:refreshView').fire();
            /*window.setTimeout(
                $A.getCallback(function() {
                	    $A.get('e.force:refreshView').fire();
                }), 200
            );*/
        }
        
        console.log(`Account with Id ${param.sobject.Id} ${param.sobject.WhoId} ${param.sobject.WhatId} is ${param.sobject.Status}!!`);
	}
})