({
	groupFeedListMethod : function(component, event, helper) {
        //document.title=collaborationGroupFeedList[0].CollaborationGroupObject.Name;
        //document.title = component.get("v.Name");
        //("IMVU Localization Program");
        //component.get("v.Name");
        helper.loadData(component,'Most Recent Activity');  
        // check if current user is already a member
        helper.isGroupMemeberCheck(component, event, helper); 
        var opts = [
            { value: "Most Recent Activity", label: "Most Recent Activity" },
            { value: "Latest Posts", label: "Latest Posts" }
         ];
        var opts2 = [
            { value: "P", label: "Every Post" },
            { value: "D", label: "Daily Digest" },
            { value: "W", label: "Weekly Digest" },
            { value: "N", label: "Limited" }
         ];
            
         component.set("v.options", opts);
        component.set("v.optionsByPostDate", opts2);
         component.set("v.isDisplaySection",false);
    },    
    
    redirectToGroupDetail : function(component, event, helper) {
        var groupId = event.target.id;  
        window.open('https://uat-lithium.cs75.force.com/serviceprovider/s/group/' + groupId,'_self');        
     },

	onChange: function (cmp, event, helper) {
        var selectedValue = event.getSource().get("v.value"); //cmp.find('select').get('v.value');  
        helper.loadData(cmp,selectedValue); 
    },
    onChangeByPostDate: function (component, event, helper) {
        var selectedValue = event.getSource().get("v.value"); //cmp.find('select').get('v.value');  
        helper.OnChangeNotificationFreq(component,event,helper,selectedValue);
        //helper.loadData(cmp,selectedValue); 
    },
    searchGroupFeeds : function(component, event, helper) { 
        helper.search(component, event, helper);          	
    },  
    displayInputText : function(component, event, helper) { 
    	component.set("v.isDisplaySection",true);
    },   
    createFeedItemRecord : function(component, event, helper) { 
        helper.createFeedItem(component, event, helper);  
        component.set("v.isDisplaySection",false);
    },
    updateFeedLikeCount : function(component, event, helper) {
        /*var vvv = event.target.Id;
        console.log('navLink-----------'+vvv);
        var whichOne = event.getSource().getLocalId();
        console.log('whichOne----'+whichOne);
        var a = event.getSource();
		var id = a.getLocalId();*/
        var selectedItem = event.currentTarget;
        var fid = selectedItem.dataset.fid;
        console.log(fid);
        helper.incrementDecrementLikeCountHelper(component, event, helper,fid);
        //helper.createFeedItem(component, event, helper);  
        //component.set("v.isDisplaySection",false);
        
        
    },
    incrementDecrementLikeCount : function(component, event, helper){
        console.log('Call Increment');
        // ..Increment or Decrement like count value
        helper.incrementDecrementLikeCountHelper(component, event, helper);
        
    },
    
    handlePaste: function(component, event, helper) {
      
        /* should not throw error when text is copy pasted : 22-05-2020 */
        if(event.clipboardData.getData('Text') == ""){
            // Updated error messsage : 27-05-2020
            alert(component.get("v.ImageErr"));  
            event.preventDefault(); 
        }
       
    },

	/*handleContext: function(component, event, helper) {
    alert('test');
    event.preventDefault(); 
	},*/
    
    handleUploadFinished: function (component, event) {
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");
        alert("Files uploaded : " + uploadedFiles.length);
        component.set("v.disabled",true);
        component.set("v.uploadedFileRec",uploadedFiles);
        console.log(component.get("v.uploadedFileRec"));
        var imgId = uploadedFiles[0].documentId;
        console.log(imgId);
        component.set("v.imageRecId",imgId);
    },
    
    handleViewMoreRecord : function(component,event,helper){
        helper.viewMoreHandler(component,event,helper,'Most Recent Activity',component.get("v.countForViewMorerecords"));
        component.set("v.countForViewMorerecords",component.get("v.countForViewMorerecords")+15);
    },    
})