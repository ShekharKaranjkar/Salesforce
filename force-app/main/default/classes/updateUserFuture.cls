public class updateUserFuture {
    @future
    public static void updatee(set<id> userId){
        
        list<User> uListUpdate = new list<User>();
        for(User u: [Select id ,name,username from User where id in: userId ]){
            system.debug('u-->'+ u);       
            u.username         = u.username+'.deactivated';
            u.IsActive         = false;
            uListUpdate.add(u);
            system.debug('uListUpdate'+uListUpdate);
        }
        if(uListUpdate.size() >0){
            update uListUpdate; 
        }
        //  Update new User(Id = userId,isActive = false,username = username);
            system.debug('uListUpdate'+uListUpdate);
        
    }
    @future
    public static void updateeactive(set<id> userId){
        
        list<User> uListUpdate      = new list<User>();
        for(User u: [Select id ,name,username from User where id in: userId ]){
            system.debug('u-->'+u);  
            string startda          =  u.username;
            list<string> startDate  =  startda.split('\\.');
            string usernames        =  startDate[0];
            system.debug('usernames'+  usernames);
            u.Username              =  usernames+'.com';
            u.IsActive              =  true;
            uListUpdate.add(u);
            system.debug('uListUpdate'+uListUpdate);
        }
        if(uListUpdate.size() >0){
            update uListUpdate; 
        }
        //  Update new User(Id = userId,isActive = true,username = username+'.com');
            system.debug('uListUpdate'+uListUpdate);
        
    }
}