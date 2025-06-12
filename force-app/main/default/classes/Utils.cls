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
}