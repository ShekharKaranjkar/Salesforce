/*
 * This InActivePermanentSPHelper is to update Users and contact when SP status is Inactive(Permanent) and SP status is Active state..*
 * InactivePermanentsp method is for updating the user and the contact Name like '.deactivated' when the sp status is changed to Inactive(permanent).
 * activesp method is for updateing the user and the contact Name removing the appened value, when the sp status is changed to Active. And checking the Duplicate Usernames.
 */
public class InActivePermanentSPHelper {
    public static void InactivePermanentsp(Map<id,Service_Provider__c> spNewMap,Map<id,Service_Provider__c> sptMap){
        system.debug('snew'+spNewMap);
        set<id> setuserid     = new set<id>();
        list<user> usList     = new list<user>();
        list<contact> conList = [select id, lastname,Service_Provider__c  from Contact where Service_Provider__c in:spNewMap.values() ];
        string setusername ;
        system.debug('conList -->'  +conList);
        for(user users :[select id,ContactId,isactive,username from user where profile.name='SP' AND ContactId in:conList And isactive = true]){
            system.debug('userlist---->'+ users);
            setuserid.add(users.id);
            system.debug('setuserid--->'+ setuserid);
            setusername = users.username+'.deactivated';
            system.debug('setusername->'+ setusername);
        }
        for(Service_Provider__c sp :spNewMap.values() ){
            If(sptMap.get(sp.id).Status__c!=sp.Status__c){ 
                if(sp.status__c   == 'InActive Permanent'){
                    user us        =  new user();
                    us.username    =  setusername;
                    usList.add(us);
                }
            }
        }
        if(usList.size() >0 ){
            updateInactive(setuserid);
            updateconInactivate(setuserid);
            system.debug('usList updatw'+ setuserid);
            
        }
    }
    public static void activesp(Map<id,Service_Provider__c> spNewMap,Map<id,Service_Provider__c> sptMap){
        system.debug('snew'+spNewMap);
        String userPhoneSet ;
        String userMobileSet ;
        string setusername;
         set<Id> spIds= new set<Id>();
        Set<String> userPhSet=new set<String>();
        set<string> settusernames           = new set<string>();
        set<id> setuserid         			= new set<id>();
        list<user> usList     			    = new list<user>();
        list<String> userPhoneSet1          = new list<String>();
            set<String> setusernames          = new set<String>();
        Map<String,String> existUserNameMap = new Map<String,String>();
        list<contact> conList               = [select id, lastname,Service_Provider__c from Contact where Service_Provider__c in:spNewMap.values() ];
        system.debug('conList --> '+ conList);
        for(user users :[select id,ContactId,isactive,username,MobilePhone,Contact.Username__c from user where profile.name='SP' AND ContactId in:conList ]){
            system.debug('users---------->' + users);
            setuserid.add(users.id);
            system.debug('setuserid ----->' + setuserid);
            setusername  = users.username;
            system.debug('setusername---->' + setusername);
            userPhoneSet = users.MobilePhone;
            system.debug('userPhoneSet --> '+ userPhoneSet);
            String s1          = users.Username;
            String target      = '.deactivated';
            String replacement = '';
            String s2          = s1.replace(target, replacement);
            system.debug('s2--'+s2);
            settusernames.add(s2);
            system.debug('settusernames -->'+ settusernames);
        } 
        
        for(user u:[Select id , Username ,ContactId,MobilePhone from user where isactive= true AND profile.Name='SP'   ]){
                //spUserMap.put(u.contact.Service_Provider__c,u.Username);
                setusernames.add(u.Username);  
            }
        
        for(user usr :[select id,ContactId,isactive,username,Contact.MobilePhone from user where isactive= true AND  profile.name='SP' AND (username in:settusernames OR  username in:setusernames) ]){
            userPhoneSet1.add(usr.Contact.MobilePhone);
            system.debug('userPhoneSet1-->'+userPhoneSet1);
        }
        
       
        for(Service_Provider__c sp:spNewMap.values()){
                if(sptMap.get(sp.Id).Phone_Number__c!= sp.Phone_Number__c ){
                    spIds.add(sp.Id);
                    userPhSet.add(sp.Phone_Number__c);
                    
                }
            }
         
         for(user u: [Select id,name,UserName,Contact.Service_Provider__c,ContactId,MobilePhone from User  where Contact.Service_Provider__c In :spIds ]){
                system.debug('existUserNameMap'+existUserNameMap);
                if(spNewMap.containsKey(u.Contact.Service_Provider__c)){
                    Service_Provider__c spro=spNewMap.get(u.Contact.Service_Provider__c);
                    string replacePhone= u.UserName.replace(u.MobilePhone,spro.Phone_Number__c);
                    system.debug('replacePhone'+replacePhone);
                    if(existUserNameMap.containsKey(replacePhone)){
                        spro.addError(System.Label.SP_user_is_already_exist_with_provided_phone_number);
                    }
                }
         }
        
        
        for(Service_Provider__c sp :spNewMap.values()){
            system.debug('sp.Phone_Number__c'+sp.Phone_Number__c);
            If(sptMap.get(sp.id).Status__c!=sp.Status__c){ 
                if(sp.status__c == 'Active'){
                    system.debug('sp.status__c'+sp.status__c);
                     system.debug('userPhoneSet1'+userPhoneSet1);
                    If(userPhoneSet1.contains(sp.Phone_Number__c) && sp.status__c == 'Active' ){ 
                      //  ChangeUserContactUserName.changeUserContactPhone(spNewMap,sptMap);
                     sp.addError('This SP can not be Activated..');
                    }
                  else  if(userPhoneSet1.contains(sp.Phone_Number__c) ){
                        system.debug('if');
                        sp.addError('Active SP user Is Already Exist with same User Name,So This SP can not be Activated..');
                    }
                    else {
                        system.debug('else');
                        user us                 = new user();
                        string names            = setusername;
                        list<string> splitname  = names.split('\\.');
                        us.username             = splitname[0];
                        uslist.add(us);                
                    }    
                }
            }
        }
        if(usList.size() >0 ){
            updateactive(setuserid);
            system.debug('usList update-->'+setuserid);
            updateconactivate(setuserid);
        }
     }
      @future
    public static void updateInactive(set<id> userId){
        list<User> uListUpdate = new list<User>();
        for(User u: [Select id ,name,username,ContactId, Contact.Username__c from User where id in: userId ]){
            system.debug('u-->'+ u);       
            u.username              = u.username+'.deactivated';
            u.IsActive              = false;
            uListUpdate.add(u);
            system.debug('uListUpdate'+uListUpdate);
        }
        if(uListUpdate.size() >0){
            update uListUpdate; 
            system.debug('uListUpdate'+uListUpdate);
        }
    }
    
    @future
    public static void updateactive(set<id> userId){
        list<User> uListUpdate      = new list<User>();
        
        for(User u: [Select id ,name,username from User where id in: userId ]){
            system.debug('u-->'+u);  
          //  string usname           =  u.username;
          //  list<string> name       =  usname.split('\\.');
          //  string usernames        =  name[0];
          //  system.debug('usernames'+  usernames);
           // u.Username              =  usernames+'.com';
         //  if(u.Username)
            String s1          = u.Username;
            String target      = '.deactivated';
            String replacement = '';
            String s2          = s1.replace(target, replacement);
            system.debug('s2--'+s2);
            u.Username     =  s2;
            u.IsActive              =  true;
            uListUpdate.add(u);
            
        }
         system.debug('uListUpdate'+uListUpdate); 
        if(uListUpdate.size() >0){
            update uListUpdate; 
            system.debug('uListUpdate'+uListUpdate); 
        }
        
    }
     @future
    public static void updateconInactivate(set<id> userId){
        // list<User> uListUpdate = new list<User>();
        list<Contact> conListUpdate      = new list<Contact>();
        string username;
        for(User u: [Select id ,name,username,ContactId, Contact.Username__c from User where id in: userId ]){
            system.debug('u'+u);
            //username = u.username;
            username = u.username+'.deactivated';
            system.debug('username'+username);
        }
        for(Contact cc: [select id,name,Username__c from contact where UserId__c in :userId]){
            system.debug('cc'+cc);
            cc.Username__c = cc.Username__c+'.deactivated';
            conListUpdate.add(cc);
        }
        if(conListUpdate.size() >0){
            update conListUpdate; 
            system.debug('conListUpdate'+conListUpdate);
            
        }
    }
     @future
    public static void updateconactivate(set<id> userId){
        // list<User> uListUpdate = new list<User>();
        list<Contact> conListUpdate      = new list<Contact>();
        string username;
        for(User u: [Select id ,name,username,ContactId, Contact.Username__c from User where id in: userId ]){
            system.debug('u'+u);
            //  username =u.username;
            string usname           =  u.username;
            list<string> name       =  usname.split('\\.');
            string usernames        =  name[0];
            system.debug('usernames'+  usernames);
            username                =  usernames+'.com';
            system.debug('username' +  username);
        }
        for(Contact cc: [select id,name,Username__c from contact where UserId__c in :userId]){
            system.debug('cc'+cc);
      //       string usname          =  cc.Username__c;
       //     list<string> name       =  usname.split('\\.');
         //   string usernames        =  name[0];
         //   system.debug('usernames'+  usernames);
            String s1          = cc.Username__c;
            String target      = '.deactivated';
            String replacement = '';
            String s2          = s1.replace(target, replacement);
            system.debug('s2--'+s2);
            cc.Username__c     =  s2;
            conListUpdate.add(cc);
        }
        if(conListUpdate.size() >0){
            update conListUpdate; 
            system.debug('conListUpdate'+conListUpdate);
            }
        }
        
    }