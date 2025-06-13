public with sharing class Utils {
    public static void Ciao() {
        List<Duplicate_Thingy__c> duplicatesThingies = new List<Duplicate_Thingy__c>();
        for (int i = 0; i < 10; i++) {
            duplicatesThingies.Add(new Duplicate_Thingy__c(Name='Duplicate thingy ' + i));
        }

        insert duplicatesThingies;

        List<Duplicate_Configuration_Thingy__c> duplicateConfigurationThingies = new List<Duplicate_Configuration_Thingy__c>();
        for (int i = 0; i < 10; i++ ) {
            duplicateConfigurationThingies.Add(new Duplicate_Configuration_Thingy__c(Name='Duplicate configuration thingy ' + i));
        }

        insert duplicateConfigurationThingies;
    }

    public static void GenerateData() {
        Contact contact = new Contact(LastName='Contact for #3');
		insert contact;
        
        List<Duplicate_Thingy__c> duplicatesThingies = new List<Duplicate_Thingy__c>();
        for (integer i = 0; i < 10; i++) {
            duplicatesThingies.Add(new Duplicate_Thingy__c(Name__c='Name for Duplicate thingy ' + i, Type__c='Duplicate', Contact__c=contact.Id));
        }

        insert duplicatesThingies;

        List<Duplicate_Configuration_Thingy__c> duplicateConfigurationThingies = new List<Duplicate_Configuration_Thingy__c>();
        for (integer i = 0; i < 10; i++ ) {
            duplicateConfigurationThingies.Add(new Duplicate_Configuration_Thingy__c(Name__c='Name for Duplicate configuration thingy ' + i, Description__c='Description ' + i));
        }

        insert duplicateConfigurationThingies;
    }
}