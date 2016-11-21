Appointment booker
==================

A command line program that allows patients to book appointments with a doctor, using the dataset provided. It meets all the specifications asked for but I also included a menu loop after inputting the first parameter. I felt like this was better than re-running availability.rb each time - it meant simpler testing and no need to write the deleted appointments to availability_slots.json.

Installing
------------


Running the app
----------------

The command line app accepts a single argument, which is the time that the patient would like to book to see a doctor. The app checks which is the next available slot and books it before prompting the user for further input. Time must be in the format below and pressing enter twice exits the app. Eg:

```
$ ruby availability.rb 08:00:00
Appointment confirmed at 08:00:00 with Doctor 1
Please enter another time:
08:00:00
Appointment confirmed at 08:00:00 with Doctor 2
Please enter another time:
12:45:00
Appointment confirmed at 12:50:00 with Doctor 1
Please enter another time:
/// Hit enter ///
$
```

Walkthrough
-----------

The JSON file is parsed and the resulting object injected into the appointment class. The requested time parameter is validated(08<x<15) and checked against the parsed slot_data array to see if the appointment is available. If it's both valid and available, the appointment is booked, a confirmation message appears and the hash is deleted from the array. The print_menu method is then called which asks for another time to book. This makes sure that the updated array persists and a new instance of appointment isn't created. This keeps looping until the user hits enter twice to exit the app. Running the app again parses the JSON and creates a brand new refreshed slot_data array.

Specifications
-----------------------

- Patients cannot book appointments before 8am and after 3pm. An error is raised.
- An error is raised if the app is run without a time parameter.
- An error is raised if the time isn't a string or in the format "hh:mm:ss".
- Once an availability has been used up for an appointment it cannot be booked again.
- In the dataset there are multiple doctors (id: 1 & 2) and each doctor can only have 1 appointment per slot. For example, you could potentially book 12:20 once for doctor 1 and again for doctor 2.
