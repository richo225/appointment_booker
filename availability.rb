require_relative "lib/appointment.rb"
require "json"

json = File.read("lib/availability_slots.json")
slot_data = JSON.parse(json)["availability_slots"]

requested_time = ARGV[0]
appointment = Appointment.new(slot_data)
appointment.check_availability(requested_time)
