Public class AccountTriggerHandler{
	public static void createContact(List<Account> accList){
		List<Contact> ct = new List <Contact>();
		for(Account acc : accList){
            Contact c = new Contact();
			c.LastName = acc.Name;
            c.AccountId= acc.Id;                                                 
            c.Fax=acc.Fax;                                               
            c.Phone=acc.Phone;                                               
			ct.add(c);
		}
		insert ct;
	}
}