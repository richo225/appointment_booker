require_relative "lib/appointment.rb"
require "json"

json = File.read("lib/availability_slots.json")
slot_data = JSON.parse(json)["availability_slots"]

appointment = Appointment.new(slot_data)
requested_time = ARGV[0]
appointment.check_availability(requested_time)
appointment.print_menu
