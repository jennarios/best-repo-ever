// Trigger for listening to Tu_Mascata__e events.
trigger TuMascataNewsTrigger on Tu_Mascata__e (after insert) {
    // List to hold all cases to be created.
    List<Case> cases = new List<Case>();
 
    // Iterate through each notification.
    for (Tu_Mascata__e event : Trigger.New) {
        if (event.Urgent__c == true) {
            // Create Case to dispatch to our team.
            Case cs = new Case();
            cs.Priority = 'High';
            cs.Subject = 'News team dispatch to ' + event.Location__c;
            cs.OwnerId = 'Name';
            cases.add(cs);
        }
    }
    // Insert all cases corresponding to events received.
    insert cases;
}