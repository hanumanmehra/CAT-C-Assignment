public class CAT_C_Digital {
	public static List<SObject> filterRecords(List<SObject> records, Map<Id, SObject> oldMap, List<SObjectField> fieldTokens, Map<SObjectField, String> valueMatchDef) {
		List<SObject> toReturn = new List<SObject>();
		for (SObject record : records) {
           if (fieldsChanged(record, oldMap.get(record.Id), fieldTokens) && valuesMatch(record, valueMatchDef)) {
				toReturn.add(record);
			}

		}
		return toReturn;
	}

	private static Boolean fieldsChanged(SObject rec, SObject old, List<SObjectField> fieldTokens) {
		Boolean isChanged = false;
		for (SObjectField field : fieldTokens) {
           if (rec.get(field) != old.get(field)) {
				isChanged = true;
				break;
			}
		}
		return isChanged;
	}

	private static Boolean valuesMatch(SObject record, Map<SObjectField, String> valueMatchDef) {
		for (SObjectField fieldToken : valueMatchDef.keySet()) {
            if(record != null && record.get(fieldToken) != null && valueMatchDef !=null){
                if (String.valueOf(record.get(fieldToken)) != valueMatchDef.get(fieldToken)) return false;
            }
		}
		return true;
	}
    
    /*Private static String stringValidation (String validateString){
        if(validateString.containsIgnoreCase('|')){
            
        }
       return false; 
    }*/
}