Appointment booker
==================

A command line program that allows patients to book appointments with a doctor, using the dataset provided.

Requirements
------------

The command line app accepts a single argument, which is the time that the patient would like to book to see a doctor. Eg:

```
$ ./availability.rb 12:40
```
The app should check which is the next available slot and book it. It should print the time of the appointment that was booked.

Additional Requirements
-----------------------

Patients cannot book appointments before 8am and after 3pm. Once an availability has been used up for an appointment it cannot be booked again.

In the dataset there are multiple doctors (id: 1 & 2) and each doctor can only have 1 appointment per slot. For example, you could potentially book 12:20 once for doctor 1 and again for doctor 2.

Constraints
-----------

- Use the JSON file provided to load availability into the app.
- App should be an executable ruby script (command line).
- App should accept a time (eg: 12:40)
- App should print the time that was booked (eg: 1:10)
