require "appointment"

describe Appointment do

  let(:appointment){Appointment.new("8:00")}

  it "correctly parses JSON to an array" do
    expect{appointment.get_slots}.to_not raise_error
    expect(appointment.get_slots).to be_an Array
  end

end
