trigger getConMaildingAddress on Account (after insert, after update) 
{
		list<Contact> conList = new list<Contact>();
		Map<id,Account> AccountMap = new Map<id,Account>();
for(Account acct : Trigger.new){
    if(acct.Shippingstreet!= Trigger.oldmap.get(acct.id).Shippingstreet){
 		AccountMap.put(acct.id,acct);
	}
}
for (Contact con : [SELECT id,Accountid, Mailingstreet FROM Contact where Accountid in:AccountMap.Keyset()]){
	con.Mailingstreet = AccountMap.get(con.Accountid).Shippingstreet;
}
Update conList;
}