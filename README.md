# neodocs_assignment

## Table Data

- Table data is stored in json format.
- Each entry of table is a json object whose key = entry no.
- The Range is stored as another object which has properties lowerLimit and upperLimit.
- Refer [here](/lib/models/data.dart) to modify the table data, the lower limit of current entry/object should be equal to the upper limit of preceeding one
