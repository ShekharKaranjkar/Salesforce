/*
Created By : Dazeworks
Description : This is used to display GroupFeeds in a List view.
*/

public without sharing class HelpMain_CollaborationGroupController {
    
    // IMVU Community
    private static final Id COMMUNITY_ID = [SELECT Id FROM Network WHERE Name = 'Service Provider'].Id;
    
    //This method is used to display Groups as a tile view
    @AuraEnabled
    public static List<collaborationGroupWrapper> getCollaborationGroupRecords() {
        List<collaborationGroupWrapper> wrapList = new List<collaborationGroupWrapper>();
        Set<Id> collGroupIds = new Set<id>();
        for(CollaborationGroupMember cbm : [SELECT Id,CollaborationGroupId FROM CollaborationGroupMember WHERE MemberId= :UserInfo.getUserId()]){
            collGroupIds.add(cbm.CollaborationGroupId);
        }
        List<CollaborationGroup> CollaborationGroupList = [Select Id,FullPhotoUrl,Name,NetworkId,MemberCount,CollaborationType,Description,
                                                            (Select Id from Feeds where Type !='TrackedChange')
                                                            FROM CollaborationGroup
                                                            WHERE NetworkId = :COMMUNITY_ID 
                                                           AND CollaborationType !='Unlisted'
                                                           AND Id IN : collGroupIds ];
        if(!CollaborationGroupList.isEmpty()) {
            for(CollaborationGroup grp : CollaborationGroupList) {                
                wrapList.add(new collaborationGroupWrapper(grp,grp.Feeds.size()));
            }
        }
        return wrapList;
    } 
    
    public class collaborationGroupWrapper {        
        @AuraEnabled
        public integer feedCount {get;set;}
        @AuraEnabled
        public CollaborationGroup CollaborationGroupObject {get;set;} 
        
        
        public collaborationGroupWrapper(CollaborationGroup colGroupObject, integer count) {
            this.CollaborationGroupObject = colGroupObject;
            this.feedCount = count;
        }     
    }
    
    //This method display GroupFeeds in a List
    @AuraEnabled
    public static List<groupWrapper> getCollaborationGroupFeedList(Id collaborationGroupId,string selectedValue) {
        
        List<CollaborationGroup> CollaborationGroupList = new List<CollaborationGroup>(); 
        List<groupWrapper> groupWrapList = new List<groupWrapper>();
        List<collaborationGroupFeedWrapper> feedWrapList = new List<collaborationGroupFeedWrapper>();
        
        if(selectedValue == 'Latest Posts') {
            CollaborationGroupList = [Select Id,Name,Description,InformationBody,Owner.Name,MemberCount,
                                                            (Select Id,Title,Type, Body,CommentCount,LikeCount,CreatedById,
                                                            CreatedBy.Name, CreatedDate FROM Feeds where Type !='TrackedChange'
                                                            Order By CreatedDate DESC LIMIT 15)
                                                            from CollaborationGroup where Id=:collaborationGroupId];
        
        } else {
            // Instead of LastModified date we use systemModStamp  to search most recent feed : 25-05-2020
            CollaborationGroupList = [Select Id,Name,Description,InformationBody,Owner.Name,MemberCount,
                                                            (Select Id,Title,Type, Body,CommentCount,LikeCount,CreatedById,
                                                            CreatedBy.Name, CreatedDate FROM Feeds where Type !='TrackedChange'
                                                            Order By systemModStamp DESC LIMIT 15)
                                                            from CollaborationGroup where Id=:collaborationGroupId ];
            
        }
        if(!CollaborationGroupList.isEmpty()) {
            for(CollaborationGroup cgroup : CollaborationGroupList) {
                
                groupWrapper groupWrap = new groupWrapper();
                groupWrap.CollaborationGroupObject = cgroup;            
                List<collaborationGroupFeedWrapper> lstcolGroupFeedWrap = new List<collaborationGroupFeedWrapper>();
                
                for(CollaborationGroupFeed grpFeed : cgroup.Feeds) {
                    collaborationGroupFeedWrapper feedWrap = new collaborationGroupFeedWrapper();
                    feedWrap.colGroupFeedObject = grpFeed ;
                        
                    //wrap.colGroupFeedObjectList.add(grpFeed);
                    //system.debug('wrap.colGroupFeedObjectList-----'+feedWrap.colGroupFeedObjectList);
                    if(grpFeed.Body != ''  && grpFeed.Body != null) {
                        if(grpFeed.Body.length()>150) {
                            system.debug('grpFeed.Body-----'+grpFeed.Body);
                             feedWrap.colGroupBody = grpFeed.Body.substring(0,150) +'...';
                        } else {
                            system.debug('grpFeed.Body-----'+grpFeed.Body);
                             feedWrap.colGroupBody = grpFeed.Body;  
                        }
                    }                 
                    feedWrapList.add(feedWrap);
                    
                }
                groupWrap.colGroupFeedWrapList = feedWrapList;

                groupWrapList.add(groupWrap);
            }
            // pre populate notification frequency
            CollaborationGroupMember cgm = [select id, NotificationFrequency from CollaborationGroupMember where 
                                        MemberId =: UserInfo.getUserId() AND CollaborationGroupId =:collaborationGroupId];
                groupWrapList[0].notifiFreq = cgm.NotificationFrequency;
            //return CollaborationGroupList; 
        }
        system.debug('groupWrapList '+ groupWrapList);
        if(!groupWrapList.isEmpty()) 
        {
            return groupWrapList;
        }
        else {
            return null;
        }
    }  
    public class groupWrapper {        
        @AuraEnabled
        public CollaborationGroup CollaborationGroupObject {get;set;}  
       // @AuraEnabled
       // public boolean isGroupMember {get;set;}
        @AuraEnabled
        public List<collaborationGroupFeedWrapper> colGroupFeedWrapList {get;set;}
        @AuraEnabled
        public String notifiFreq {get;set;}
    }
    
    public class collaborationGroupFeedWrapper {
        @AuraEnabled
        public CollaborationGroupFeed colGroupFeedObject {get;set;}   
        @AuraEnabled
        public string colGroupBody {get;set;}
    }
    
    //This method is used to display Annoucement on list view page
    @AuraEnabled
    public static string getFeedAnnouncement(Id collaborationGroupId) {
                        
        List<CollaborationGroupFeed> CollaborationGroupFeedList = [Select ParentId, Title, Type, Body, CreatedDate 
                                                            FROM CollaborationGroupFeed 
                                                            WHERE Type = 'AdvancedTextPost' AND ParentId=:collaborationGroupId
                                                            ORDER By CreatedDate DESC LIMIT 1];
        String feedBody = '';
        if(!CollaborationGroupFeedList.isEmpty()) {
            for(CollaborationGroupFeed cgf : CollaborationGroupFeedList) {
                if(cgf.Body != null) {
                    feedBody = cgf.Body;
                }
            }
        }        
        return feedBody ;
    } 
    
    //This method is used to search the Group feeds in List view page
    @AuraEnabled
    public static List<collaborationGroupFeedWrapper> getSearchedFeedRecords(String searchTerm, Id collaborationGroupId){
    
        //List<CollaborationGroupFeed> searchGroupFeedList = new List<CollaborationGroupFeed>();
        List<collaborationGroupFeedWrapper> feedWrapList = new List<collaborationGroupFeedWrapper>();
        
        system.debug('searchTerm ---'+searchTerm);
        if(searchTerm != null && searchTerm != '') {
            List<CollaborationGroupFeed> groupFeedList = [Select ParentId,Parent.Name, Title,CreatedBy.Name, Type, Body,CreatedDate,CommentCount,LikeCount
                                                             FROM CollaborationGroupFeed 
                                                             WHERE Type != 'TrackedChange' AND ParentId='0F90w00000007Q0CAI'
                                                             ORDER By CreatedDate DESC];
            if(!groupFeedList.isEmpty()) {                  
                for(CollaborationGroupFeed fd : groupFeedList) {
                    string feedBody = fd.Body.toUpperCase();
                    collaborationGroupFeedWrapper wrap = new collaborationGroupFeedWrapper();
                    
                    if(feedBody.contains(searchTerm.toUpperCase())) {
                        //searchGroupFeedList.add(fd);
                        wrap.colGroupFeedObject = fd;
                        if(fd.Body.length()>150) {                    
                             wrap.colGroupBody = fd.Body.substring(0,150) +'...';
                        } else {                          
                             wrap.colGroupBody = fd.Body;  
                        }
                        feedWrapList.add(wrap);
                    }
                }
            }
        }
        
            system.debug('feedWrapList' + feedWrapList.size());
        if(!feedWrapList.isEmpty()) {
            return feedWrapList;
        }
        else {
            return null;
        }
    }
    
    //This method is used to create a feeditem record
    @AuraEnabled
    public static void createFeedItem(String feedBody, Id collaborationGroupId) { //, String blobImgId
        system.debug('------------'+feedBody);
        
        //system.debug('------------'+blobImgId);
        String imageURL = '';
        FeedItem FI = new FeedItem();
        
        //Added By: Anjali(08 May 2020)
        //Rich Text Parser
        RichTextAPI rtApi = new RichTextAPI( feedBody ).getImageURLs();
        system.debug(' rtApi ' + rtApi);
        //Modified By: Anjali(08 May 2020)
        If(feedBody <>'' && !rtApi.hasInlineImages() )
        {
            /**
             * TODO: Please use Chatter ConnectApi (via ConnectApiHelper)
             * Ref: https://github.com/forcedotcom/ConnectApiHelper
             */
            FI.ParentId = collaborationGroupId;
            FI.NetworkScope = COMMUNITY_ID;
            FI.visibility = 'AllUsers';
            FI.IsRichText = true;
            FI.Type = 'TextPost';
            
            //Modified By: Anjali(15 May 2020)
            //Added trimUnsupportedTags()
            FI.Body = rtApi.trimUnsupportedTags().richText;
            string addval = FI.Body ;
            addval = addval.replaceAll( '<p>','')
                           .replaceAll( '</p>','')
                           .replaceAll('<br>','')
                           .replaceAll('&nbsp;','')
                           .replaceAll('<img src="//:0">','');
            FI.Body = FI.Body.replaceAll('<img src="//:0">','');
            addval = addval.replaceAll(' ','');
            addval = addval.trim();
            if(addval != ''){
                INSERT FI;
            }
            
        }
        else {
            //Modified By: Anjali(15 May 2020)
            //Added trimUnsupportedTags()
            rtApi.getImageContentDocuments().trimImageTags().trimUnsupportedTags().createImageMarkup();
            //Modified By: Anjali(15 May 2020)
            
            string addval = rtApi.richTextWithoutImgTags ;
            addval = addval.replaceAll( '<p>','')
                           .replaceAll( '</p>','');
            addval = addval.replaceAll(' ','');
            addval = addval.trim();
            if(addval.length()<1)
            {
                rtApi.richTextWithoutImgTags = 'Image';
            }
                                         
                        
            //Refer: https://github.com/forcedotcom/ConnectApiHelper/blob/master/force-app/main/default/classes/ConnectApiHelper.cls#L94
            ConnectApiHelper.postFeedItemWithRichText(
                Network.getNetworkId(),
                collaborationGroupId, 
                rtApi.richTextWithoutImgTags + 
                rtApi.imageMarkup
            );
        }
    }
    
    @AuraEnabled
    public static Boolean IsGroupMember(Id collaborationGroupId) 
    {
        system.debug('collaborationGroupId'+collaborationGroupId);
        Boolean isMember = False;
        list<CollaborationGroupMember> collGroupMember = [SELECT Id, CollaborationRole,CollaborationGroupId FROM CollaborationGroupMember WHERE CollaborationGroupId=:collaborationGroupId AND MemberId= :UserInfo.getUserId() ];
        system.debug('Group Member List Size'+collGroupMember.size());
        If(collGroupMember.size()>0 && collGroupMember[0].CollaborationRole == 'Admin') 
         {
            isMember = True;  
        } 
        
        Return isMember;
    }
    
    @AuraEnabled
    public static Boolean IsGroupMember2(Id collaborationGroupId) 
    {
        system.debug('collaborationGroupId'+collaborationGroupId);
        Boolean isMember = False;
        list<CollaborationGroupMember> collGroupMember = [SELECT Id, CollaborationRole,CollaborationGroupId FROM CollaborationGroupMember WHERE CollaborationGroupId=:collaborationGroupId AND MemberId= :UserInfo.getUserId() ];
        system.debug('Group Member List Size'+collGroupMember.size());
        If(collGroupMember.size()>0)
        {
            isMember = True;  
        } 
        
        Return isMember;
    }
    
    @AuraEnabled
    public static void IncrementLikeCount(String feedItempostId , Boolean likeIncDec) {
        system.debug('------------'+feedItempostId+likeIncDec);
      FeedItem feedItemRec = [SELECT Id, Type, LikeCount, Title, InsertedById,
                              (SELECT Id FROM FeedLikes) 
                              FROM FeedItem WHERE Id =:feedItempostId];
        system.debug('feedItemRec >>'+feedItemRec);
        if(likeIncDec){
            Feedlike flRec = new FeedLike(FeedItemId = feedItempostId );
            try{insert flRec;}
            catch(exception e){system.debug('-------liked ' + e);}
        }/*else{
            Feedlike  fdlkRec= feedItemRec.FeedLikes[0];
           DELETE fdlkRec;
        }*/
        
    }
    @AuraEnabled
    public static void ManageNotificationFrequency(Id collaborationGroupId, String Frequency) 
    {
        List<CollaborationGroupMember> ListCGM = New List<CollaborationGroupMember>();
       //Map<string, String> FrequencyMap = new Map<string, String>{'Daily' => 'D', 'Weekly' => 'W', 'Never' => 'N', 'On each post' => 'P'};
        system.debug('##'+collaborationGroupId);
        //system.debug('###'+CollaborationMemberId);
        system.debug('####'+Frequency);
        For(CollaborationGroupMember cgm : [select id, NotificationFrequency from CollaborationGroupMember where 
        MemberId =: UserInfo.getUserId() AND CollaborationGroupId =:collaborationGroupId])
        {
            If(cgm.id<>null && Frequency<>null)
            {
                cgm.NotificationFrequency = Frequency;
                ListCGM.add(cgm);
            }
            If(ListCGM.size()>0)
            {
                Update ListCGM;
            }
        }        
        
    }
    
    // Adds on more records to the list when view more is clicked
    @AuraEnabled
    public static List<groupWrapper> getCollaborationGroupFeedListViewMore (Id collaborationGroupId,string selectedValue, Integer OffsetValue) {
        
        List<CollaborationGroup> CollaborationGroupList = new List<CollaborationGroup>(); 
        List<groupWrapper> groupWrapList = new List<groupWrapper>();
        List<collaborationGroupFeedWrapper> feedWrapList = new List<collaborationGroupFeedWrapper>();
        List<CollaborationGroupFeed> collGrpFeeds = new List<CollaborationGroupFeed>();
        if(selectedValue == 'Latest Posts') {
            CollaborationGroupList = [Select Id,Name,Description,InformationBody,Owner.Name,MemberCount
                                                            
                                                            from CollaborationGroup where Id=:collaborationGroupId ];
             collGrpFeeds = [Select Id,Title,Type, Body,CommentCount,LikeCount,CreatedById,
                                                            CreatedBy.Name, CreatedDate FROM CollaborationGroupFeed 
                                                            where ParentId =: collaborationGroupId AND Type !='TrackedChange'
                                                            Order By systemModStamp DESC LIMIT 15 OFFSET : OffsetValue];
        } else {
            // Instead of LastModified date we use systemModStamp  to search most recent feed : 25-05-2020
            CollaborationGroupList = [Select Id,Name,Description,InformationBody,Owner.Name,MemberCount
                                                            /*,(Select Id,Title,Type, Body,CommentCount,LikeCount,CreatedById,
                                                            CreatedBy.Name, CreatedDate FROM Feeds where Type !='TrackedChange'
                                                            Order By systemModStamp DESC LIMIT 2 OFFSET : OffsetValue)*/
                                                            from CollaborationGroup where Id=:collaborationGroupId ];
            collGrpFeeds = [Select Id,Title,Type, Body,CommentCount,LikeCount,CreatedById,
                                                            CreatedBy.Name, CreatedDate FROM CollaborationGroupFeed 
                                                            where ParentId =: collaborationGroupId AND Type !='TrackedChange'
                                                            Order By systemModStamp DESC LIMIT 15 OFFSET : OffsetValue];
        }
        if(!CollaborationGroupList.isEmpty()) {
            for(CollaborationGroup cgroup : CollaborationGroupList) {
                groupWrapper groupWrap = new groupWrapper();
                groupWrap.CollaborationGroupObject = cgroup;            
                List<collaborationGroupFeedWrapper> lstcolGroupFeedWrap = new List<collaborationGroupFeedWrapper>();
                
                for(CollaborationGroupFeed grpFeed : collGrpFeeds) {
                    collaborationGroupFeedWrapper feedWrap = new collaborationGroupFeedWrapper();
                    feedWrap.colGroupFeedObject = grpFeed ;
                        
                    //wrap.colGroupFeedObjectList.add(grpFeed);
                    //system.debug('wrap.colGroupFeedObjectList-----'+feedWrap.colGroupFeedObjectList);
                    if(grpFeed.Body != ''  && grpFeed.Body != null) {
                        if(grpFeed.Body.length()>150) {
                            system.debug('grpFeed.Body-----'+grpFeed.Body);
                             feedWrap.colGroupBody = grpFeed.Body.substring(0,150) +'...';
                        } else {
                            system.debug('grpFeed.Body-----'+grpFeed.Body);
                             feedWrap.colGroupBody = grpFeed.Body;  
                        }
                    }                 
                    feedWrapList.add(feedWrap);
                    
                }
                groupWrap.colGroupFeedWrapList = feedWrapList;

                groupWrapList.add(groupWrap);
            }
            // pre populate notification frequency
            CollaborationGroupMember cgm = [select id, NotificationFrequency from CollaborationGroupMember where 
                                        MemberId =: UserInfo.getUserId() AND CollaborationGroupId =:collaborationGroupId];
                groupWrapList[0].notifiFreq = cgm.NotificationFrequency;
            //return CollaborationGroupList; 
        }
        if(!groupWrapList.isEmpty()) 
        {
            return groupWrapList;
        }
        else {
            return null;
        }
    }  
}