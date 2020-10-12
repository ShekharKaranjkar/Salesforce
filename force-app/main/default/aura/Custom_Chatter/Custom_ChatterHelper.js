({
    loadData : function(component,selectedValue) {
        console.log('load data method--');
        //component.set("v.searchGroupFeedList", null);              
        //component.set("v.searchTerm", null);
        
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),                
            sURLVariables = sPageURL.split('='),
            //sURLGroupId = sURLVariables[1];
            sURLGroupId = '0F90w00000007Q5CAI';
        console.log('sPageURL ',window.location);
        component.set("v.uploadFileRecordId",sURLGroupId);
        component.set("v.CGId",sURLGroupId);
        console.log("CGId#"+component.get("v.CGId"));
        let getCollaborationGroupFeed = component.get('c.getCollaborationGroupFeedList');
        getCollaborationGroupFeed.setParams({
            "collaborationGroupId": sURLGroupId,
            "selectedValue" : selectedValue
        }); //sURLGroupId "0F9550000008oElCAI"
        getCollaborationGroupFeed.setCallback(this, function(response) {
            if (response.getState() == 'SUCCESS' && response.getReturnValue() != null) {                
                let collaborationGroupFeedList = response.getReturnValue(); 
                console.log(collaborationGroupFeedList);
                component.set("v.isgroupmember",collaborationGroupFeedList.isGroupMember);
                collaborationGroupFeedList = this.setGroupTitle(collaborationGroupFeedList);
                document.title=collaborationGroupFeedList[0].CollaborationGroupObject.Name;
                console.log('title'+collaborationGroupFeedList[0].CollaborationGroupObject.Name);
                component.set('v.collaborationGroupFeedList', collaborationGroupFeedList); 
                component.set("v.selectedValueByPostDate" , collaborationGroupFeedList[0].notifiFreq);
                // var currNotiFifreq = this.setCurrentNotifiFreq(component,event,helper,collaborationGroupFeedList[0].notifiFreq);
                this.DisplayAnnouncement(component,sURLGroupId);  
                component.set("v.hasViewMoreRecords",true);
            } else {
                console.log('getTopics_New failed');
            }
        });
        $A.enqueueAction(getCollaborationGroupFeed);
    },
    
    DisplayAnnouncement : function(component,sURLGroupId) {
        
        let getFeedAnnouncement = component.get('c.getFeedAnnouncement');
        getFeedAnnouncement.setParams({
            "collaborationGroupId": sURLGroupId  
        }); 
        getFeedAnnouncement.setCallback(this, function(response) {
            
            if (response.getState() == 'SUCCESS' && response.getReturnValue() != null) {                
                let feedAnnouncement = response.getReturnValue();
                feedAnnouncement = feedAnnouncement.replace(/[\n\r]/g, "" );
                feedAnnouncement = feedAnnouncement.replace(/<[^>]*>/g, '');
                feedAnnouncement = feedAnnouncement.replace('&#39;','\'');
                component.set('v.feedAnnouncement', feedAnnouncement);             
            } else {
                console.log('getTopics_New failed');
            }
        });
        $A.enqueueAction(getFeedAnnouncement);    
    },    
    
    search : function(component, event, helper){
        
        component.set("v.searchGroupFeedList", null);
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),                
            sURLVariables = sPageURL.split('='),
            sURLGroupId = sURLVariables[1];
        console.log('*****************'+sURLGroupId+'@@@'+component.get("v.searchTerm")+'####'+component.get("v.searchGroupFeedList"));
        var action=component.get("c.getSearchedFeedRecords");
        action.setParams(
            {searchTerm : component.get("v.searchTerm"),             
             collaborationGroupId : sURLGroupId             
            });
        action.setCallback(this,function(response){
            var state=response.getState();
            
            if(state=="SUCCESS"){
                //console.log('state-------------'+state);             
                var records=response.getReturnValue();           
                if(records != null && records !== undefined) {
                    
                    console.log(records);
                    
                    for(var i=0;i<records.length;i++){
                        var gbody = records[i].colGroupBody;
                        console.log(gbody);
                        gbody = gbody.replace(/[\n\r]/g, "" );
                        gbody = gbody.replace(/<[^>]*>/g, '');
                        var strVar = gbody.trim();
                        if(strVar.substring(0, strVar.indexOf('&lt;')) != ""){
                            strVar = strVar.substring(0, strVar.indexOf('&lt;'));
                        }
                        if(strVar.includes('&lt;')){
                            strVar = "Image";
                        }
                        
                        gbody= strVar;
                        if(strVar.startsWith("<...") ){ // || strVar.startsWith("...")
                            gbody = strVar.replace("<...", "Image");
                            
                        }else if(strVar.includes("<...")){
                            strVar = strVar.trim();
                            gbody = strVar.replace("<...", "");
                            
                        }else if(strVar == ""){
                            gbody = "Image";
                        }
                        //console.log(gbody);
                        records[i].colGroupBody = gbody.replace(/(<p[^>]+?>|<p>|<\/p>)/img, " ");
                        //console.log(gbody.replace(/[\n\r]/g, "" ));
                        if(gbody.length > 60){
                            records[i].colGroupBody = gbody.slice(0,60)+'...';
                        }
                        var newVarStr = records[i].colGroupBody ;
                        records[i].colGroupBody  = newVarStr.trim();
                    }
                    
                    
                    // records = this.setGroupTitle(records);
                    component.set("v.searchGroupFeedList", records);   
                    component.set("v.noSearchedDataFound", false); 
                } 
                else
                {
                    //component.set("v.searchTerm",'');
                    this.loadData(component, 'Most Recent Activity');//ANJ
                    
                }
                this.isGroupMemeberCheck(component,event,helper);
            }
        });
        $A.enqueueAction(action);
    },
    generateToast : function(component, event, toastType, toastMsg){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            mode: 'pester',
            message: toastMsg,
            type : toastType,            
        });
        toastEvent.fire();
    },
    
    createFeedItem : function(component, event, helper){        
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),                
            sURLVariables = sPageURL.split('='),
            sURLGroupId = sURLVariables[1];
        /* var uploadedFiles = event.getParam("files");
        console.log(uploadedFiles.length);*/
        var feedItemVar = component.get("v.feedItemName");
        
        console.log(component.get("v.feedItemName"));
        
        console.log(sURLGroupId);
        var action=component.get("c.createFeedItem");
        action.setParams(
            {feedBody : component.get("v.feedItemName"),             
             collaborationGroupId : sURLGroupId /*,
             blobImgId : component.get("v.imageRecId")*/
            });
        action.setCallback(this,function(response){
            var state=response.getState(); 
            if(state=="SUCCESS"){
                component.set("v.feedItemName",'');
                this.loadData(component, 'Most Recent Activity');
                this.isGroupMemeberCheck(component,event,helper);
            }
        });
        $A.enqueueAction(action);
        
    },
    setGroupTitle : function(groupDataList){
        console.log(groupDataList);
        if(groupDataList[0].colGroupFeedWrapList){
            for(var i=0;i<groupDataList[0].colGroupFeedWrapList.length;i++){
                if(groupDataList[0].colGroupFeedWrapList[i].colGroupBody){
                    var gbody = groupDataList[0].colGroupFeedWrapList[i].colGroupBody;
                    //gbody = gbody.slice(gbody.indexOf('<p>'),parseInt(gbody.indexOf('</p>'))+parseInt(4));
                    gbody = gbody.replace(/[\n\r]/g, "" );
                    gbody = gbody.replace(/<[^>]*>/g, '');
                    var strVar = gbody.trim();
                    //console.log(strVar.substring(0, strVar.indexOf('&lt;a')));
                    if(strVar.substring(0, strVar.indexOf('&lt;')) != ""){
                        strVar = strVar.substring(0, strVar.indexOf('&lt;'));
                    }
                    if(strVar.includes('&lt;')){
                        strVar = "Image";
                    }
                    
                    gbody= strVar;
                    if(strVar.startsWith("<...") ){ // || strVar.startsWith("...")
                        gbody = strVar.replace("<...", "Image");
                        
                    }else if(strVar.includes("<...")){
                        strVar = strVar.trim();
                        gbody = strVar.replace("<...", "");
                        
                    }else if(strVar == ""){
                        gbody = "Image";
                    }
                    //console.log(gbody);
                    groupDataList[0].colGroupFeedWrapList[i].colGroupBody = gbody.replace(/(<p[^>]+?>|<p>|<\/p>)/img, " ");
                    //console.log(gbody.replace(/[\n\r]/g, "" ));
                    if(gbody.length > 60){
                        groupDataList[0].colGroupFeedWrapList[i].colGroupBody = gbody.slice(0,60)+'...';
                    }
                    var newVarStr = groupDataList[0].colGroupFeedWrapList[i].colGroupBody ;
                    groupDataList[0].colGroupFeedWrapList[i].colGroupBody  = newVarStr.trim();
                }
            }
        }
        return groupDataList;
    },
    
    incrementDecrementLikeCountHelper : function(component, event, helper,feedId){
        var actionLikeCount = component.get("c.IncrementLikeCount");
        //var feedItemId = event.getSource().get("v.value");
        component.set("v.LikeIncrementDecrement",true);
        console.log(feedId);
        actionLikeCount.setParams(
            {
                feedItempostId : feedId ,             
                likeIncDec     : component.get("v.LikeIncrementDecrement")             
            });
        actionLikeCount.setCallback(this,function(response){
            var state=response.getState(); 
            if(state=="SUCCESS"){
                this.loadData(component, 'Most Recent Activity');
                this.isGroupMemeberCheck(component,event,helper);
            }
        });
        $A.enqueueAction(actionLikeCount);
    },
    
    isGroupMemeberCheck : function(component, event, helper){
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),                
            sURLVariables = sPageURL.split('='),
            sURLGroupId = sURLVariables[1];
        var actionCheck = component.get("c.IsGroupMember");
        
        actionCheck.setParams(
            {
                collaborationGroupId : sURLGroupId              
            });
        actionCheck.setCallback(this,function(response){
            var state=response.getState(); 
            if(state=="SUCCESS"){
                var checkResult = response.getReturnValue();
                component.set("v.isgroupmember",checkResult);
            }
        });
        $A.enqueueAction(actionCheck);
    },
    
    OnChangeNotificationFreq : function(component, event, helper,NotiFeq){
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),                
            sURLVariables = sPageURL.split('='),
            sURLGroupId = sURLVariables[1];
        var actionCheck = component.get("c.ManageNotificationFrequency");
        
        actionCheck.setParams(
            {
                collaborationGroupId : sURLGroupId,
                Frequency : NotiFeq
            });
        actionCheck.setCallback(this,function(response){
            var state=response.getState(); 
            if(state=="SUCCESS"){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Your group notification frequency is updated.",
                    "type":"success"
                });
                toastEvent.fire();
                $A.get('e.force:refreshView').fire();
            }
        });
        $A.enqueueAction(actionCheck);
    },
    
    viewMoreHandler : function(component,event,helper,selectedValue,offsetCount) {
        console.log('viewMoreHandler method--');
        //component.set("v.searchGroupFeedList", null);              
        //component.set("v.searchTerm", null);
        
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),                
            sURLVariables = sPageURL.split('='),
            //sURLGroupId = sURLVariables[1];
        	sURLGroupId = '0F90w00000007Q5CAI';
        
        component.set("v.uploadFileRecordId",sURLGroupId);
        component.set("v.CGId",sURLGroupId);
        // console.log("CGId#"+component.get("v.CGId"));
        let getCollaborationGroupFeed = component.get('c.getCollaborationGroupFeedListViewMore');
        getCollaborationGroupFeed.setParams({
            "collaborationGroupId": sURLGroupId,
            "selectedValue" : selectedValue,
            "OffsetValue" : offsetCount
        }); //sURLGroupId "0F9550000008oElCAI"
        getCollaborationGroupFeed.setCallback(this, function(response) {
            if (response.getState() == 'SUCCESS' && response.getReturnValue() != null) {                
                let collaborationGroupFeedList = response.getReturnValue(); 
                // console.log(collaborationGroupFeedList);
                component.set("v.isgroupmember",collaborationGroupFeedList.isGroupMember);
                collaborationGroupFeedList = this.setGroupTitle(collaborationGroupFeedList);
                document.title=collaborationGroupFeedList[0].CollaborationGroupObject.Name;
                //console.log('title'+collaborationGroupFeedList[0].CollaborationGroupObject.Name);
                var oldList = component.get("v.collaborationGroupFeedList"); // get the attribute into a local variable
                // console.log(oldList);console.log('oldList before');
                if(collaborationGroupFeedList[0].colGroupFeedWrapList.length > 0){
                    for(let cbt of collaborationGroupFeedList[0].colGroupFeedWrapList){
                        oldList[0].colGroupFeedWrapList.push( cbt ); 
                    }
                }else{
                    component.set("v.hasViewMoreRecords",false);
                }
                
                
                component.set('v.collaborationGroupFeedList', oldList); // adding into list 
                //component.set("v.selectedValueByPostDate" , collaborationGroupFeedList[0].notifiFreq);
                // var currNotiFifreq = this.setCurrentNotifiFreq(component,event,helper,collaborationGroupFeedList[0].notifiFreq);
                //this.DisplayAnnouncement(component,sURLGroupId);                
            } else {
                console.log('getTopics_New failed');
            }
        });
        $A.enqueueAction(getCollaborationGroupFeed);
    },
    
    
})