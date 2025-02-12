require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({ name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
    @facility_1 = Facility.new({ name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
    @facility_2 = Facility.new({ name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
    @cruz = Vehicle.new({ vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice })
    @bolt = Vehicle.new({ vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev })
    @camaro = Vehicle.new({ vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice })
    @facility = Facility.new({ name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
    @facility_1 = Facility.new({ name: 'Albany DMV Office', address: '2242 Santiam Hwy SE Albany OR 97321', phone: '541-967-2014' })
    @facility_2 = Facility.new({ name: 'Ashland DMV Office', address: '600 Tolman Creek Rd Ashland OR 97520', phone: '541-776-6092' })
    @cruz = Vehicle.new({ vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice })
    @bolt = Vehicle.new({ vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev })
    @camaro = Vehicle.new({ vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice })
  end

  # Starts 'Vehicle Registration' section of Iteration 2

  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('Albany DMV Office')
      expect(@facility.address).to eq('2242 Santiam Hwy SE Albany OR 97321')
      expect(@facility.phone).to eq('541-967-2014')
      expect(@facility.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#add additional facilities' do
    it 'returns empty array for registered_vehicles' do
      expect(@facility_1.registered_vehicles).to eq([])
      expect(@facility_2.registered_vehicles).to eq([])
    end

    it 'adds a service to facility_1' do
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to include('Vehicle Registration')
    end
  end

  describe '#registering vehicles' do
    it 'all elements return correct initial values' do
      expect(@cruz.registration_date).to eq(nil)
      expect(@facility_1.registered_vehicles).to eq([])
      expect(@facility_1.collected_fees).to eq(0)
    end
    it 'register_vehicle registers the vehicle for cruz' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)

      expect(@cruz.registration_date).to eq(Date.today)
    end

    it 'register_vehicle registers the vehicle for camaro' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@camaro)

      expect(@camaro.registration_date).to eq(Date.today)
    end

    it 'register_vehicle registers the vehicle for bolt' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@bolt)

      expect(@bolt.registration_date).to eq(Date.today)
    end

    it 'prevent vehicle registration if vehicle already registered' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      expect(@cruz.registration_date).to eq(Date.today)
      expect { @facility_1.register_vehicle(@cruz) }.to raise_error(StandardError, 'Vehicle already registered.')
    end
  end

  describe '#plate_type' do
    it 'plate_type method returns correct plate for regular' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)

      expect(@cruz.plate_type).to eq(:regular)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
    end

    it 'plate_type method returns correct plate for antique' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@camaro)

      expect(@camaro.plate_type).to eq(:antique)
      expect(@facility_1.registered_vehicles).to eq([@camaro])
    end

    it 'plate_type method returns correct plate for ev' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@bolt)

      expect(@bolt.plate_type).to eq(:ev)
      expect(@facility_1.registered_vehicles).to eq([@bolt])
    end
  end

  describe '#collected_fees' do
    it 'collected_fees returns correct value for regular' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)

      expect(@facility_1.collected_fees).to eq(100)
    end

    it 'collected_fees returns correct value for antique' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@camaro)

      expect(@facility_1.collected_fees).to eq(25)
    end

    it 'collected_fees returns correct value for ev' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@bolt)

      expect(@facility_1.collected_fees).to eq(200)
    end
  end

  describe 'registered_vehicles final' do
    it 'facility will have all three vehicles registered.' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)

      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
    end
  end

  describe 'collected_fees final' do
    it 'facility will have collected fees for all vehicles' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      @facility_1.register_vehicle(@bolt)

      expect(@facility_1.collected_fees).to eq(325)
    end
  end

  describe 'facility.services' do
    it 'facilities without "Vehicle Registration" service cannot register vehicles' do
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.services).to eq([])
      expect(@facility_2.register_vehicle(@bolt)).to eq(nil)
    end
  end

  # Start 'Getting a Driver's License' section of Iteration 2
  #  Administer a written test
  # A written test can only be administered to registrants with a permit and
  # who are at least 16 years of age

  describe 'new registrants' do
    before(:each) do
      @registrant_1 = Registrant.new('Bruce', 18, true)
      @registrant_2 = Registrant.new('Penny', 16)
      @registrant_3 = Registrant.new('Tucker', 15)
    end

    it 'registrants license data is correct' do
      expect(@registrant_1.license_data).to eq({ written: false, license: false, renewed: false })
      expect(@registrant_2.license_data).to eq({ written: false, license: false, renewed: false })
      expect(@registrant_3.license_data).to eq({ written: false, license: false, renewed: false })
    end

    it 'registrants permit data is correct (tests permit? method)' do
      expect(@registrant_1.permit?).to eq(true)
    end

    it 'return error on earn_permit if registrant already has a permit' do
      @registrant_2.earn_permit
      expect(@registrant_2.permit?).to eq(true)
      expect { @facility.earn_permit(@registrant_2) }.to raise_error(StandardError, 'Already has permit.')
    end
  end

  describe 'administer_written_test' do
    before(:each) do
      @registrant_1 = Registrant.new('Bruce', 18, true)
      @registrant_2 = Registrant.new('Penny', 16)
      @registrant_3 = Registrant.new('Tucker', 15)
    end

    it 'administer_written_test updates license_data' do
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)

      expect(@registrant_1.license_data).to eq({ written: true, license: false, renewed: false })
    end

    it 'administer_written_test on facility updates license_data' do
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)

      expect(@registrant_1.license_data).to eq({ written: true, license: false, renewed: false })
      expect(@registrant_2.age).to eq(16)
      expect(@registrant_2.permit?).to eq(false)
    end

    it 'tests administer_written_test on registrant without permit' do
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_2)

      expect(@registrant_2.license_data).to eq({ written: false, license: false, renewed: false })
    end

    it 'earn_permit and administer_written_test' do
      @facility_1.add_service('Written Test')
      @registrant_2.earn_permit

      expect(@registrant_2.permit?).to eq(true)
      expect(@registrant_2.license_data).to eq({ written: false, license: false, renewed: false })

      @facility_1.administer_written_test(@registrant_2)

      expect(@registrant_2.license_data).to eq({ written: true, license: false, renewed: false })
    end

    it 'administer_written_test checks age' do
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_3)

      expect(@registrant_3.age).to eq(15)
      expect(@registrant_3.permit?).to eq(false)
      expect(@registrant_3.license_data).to eq({ written: false, license: false, renewed: false })
    end

    it 'administer_written_test checks age and permit' do
      @facility_1.add_service('Written Test')
      @registrant_3.earn_permit
      @facility_1.administer_written_test(@registrant_3)

      expect(@registrant_3.permit?).to eq(true)
      expect(@registrant_3.license_data).to eq({ written: false, license: false, renewed: false })
    end

    it 'administer_written_test checks for service, age, and permit' do
      @registrant_3.earn_permit
      @facility_1.administer_written_test(@registrant_3)
      expect(@registrant_3.license_data).to eq({ written: false, license: false, renewed: false })

      expect(@registrant_1.permit?).to eq(true)
      expect(@registrant_1.license_data).to eq({ written: false, license: false, renewed: false })

      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)

      expect(@registrant_1.license_data).to eq({ written: true, license: false, renewed: false })
    end

    it 'return error on administer_written_test if registrant already took written test' do
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)
      expect(@registrant_1.license_data).to eq({ written: true, license: false, renewed: false })
      expect { @facility_1.administer_written_test(@registrant_1) }.to raise_error(StandardError, 'Already took written test.')
    end
  end

  describe 'administer_road_test' do
    before(:each) do
      @registrant_1 = Registrant.new('Bruce', 18, true)
      @registrant_2 = Registrant.new('Penny', 16)
      @registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)
      @facility_1.administer_written_test(@registrant_2)
    end

    it 'administer_road_test follows services and license data rules' do
      @facility_1.administer_road_test(@registrant_3)
      expect(@registrant_3.license_data).to eq({ written: false, license: false, renewed: false })

      @registrant_3.earn_permit
      expect(@registrant_3.license_data).to eq({ written: false, license: false, renewed: false })

      @facility_1.add_service('Road Test')
      expect(@facility_1.services).to eq(['Written Test', 'Road Test'])

      @facility_1.administer_road_test(@registrant_1)
      expect(@registrant_1.license_data).to eq({ written: true, license: true, renewed: false })

      @facility_1.administer_road_test(@registrant_2)
      expect(@registrant_1.license_data).to eq({ written: true, license: true, renewed: false })
    end

    it 'return error on administer_road_test if registrant already took road test and has license' do
      @facility_1.add_service('Road Test')
      @facility_1.administer_road_test(@registrant_1)
      expect(@registrant_1.license_data).to eq({ written: true, license: true, renewed: false })
      expect { @facility_1.administer_road_test(@registrant_1) }.to raise_error(StandardError, 'Already took road test and has license.')
    end
  end

  describe 'renew_drivers_license' do
    before(:each) do
      @registrant_1 = Registrant.new('Bruce', 18, true)
      @registrant_2 = Registrant.new('Penny', 16)
      @registrant_3 = Registrant.new('Tucker', 15)
      @facility_1.add_service('Written Test')
      @facility_1.earn_permit(@registrant_2)
      @facility_1.administer_written_test(@registrant_1)
      @facility_1.administer_written_test(@registrant_2)
      @facility_1.add_service('Road Test')
      @facility_1.administer_road_test(@registrant_1)
    end

    it 'renew_drivers_license follows service rule' do
      @facility_1.renew_drivers_license(@registrant_1)
      expect(@registrant_1.license_data).to eq({ written: true, license: true, renewed: false })

      @facility_1.add_service('Renew License')
      @facility_1.renew_drivers_license(@registrant_1)
      expect(@registrant_1.license_data).to eq({ written: true, license: true, renewed: true })
    end

    it 'return error on renew_drivers_license if registrant already has a license' do
      @facility_1.add_service('Renew License')
      @facility_1.renew_drivers_license(@registrant_2)
      expect(@registrant_2.license_data).to eq({ written: true, license: false, renewed: false })
    end

    it 'return error on renew_drivers_license if registrant already renewed drivers license' do
      @facility_1.add_service('Renew License')
      @facility_1.renew_drivers_license(@registrant_1)
      expect(@registrant_1.license_data).to eq({ written: true, license: true, renewed: true })
      expect { @facility_1.renew_drivers_license(@registrant_1) }.to raise_error(StandardError, 'Already renewed drivers license.')
    end
  end

  # Iteration 3
  describe 'invalid state check' do
    it 'returns error if unsupported state is called' do
      facility_data = DmvDataService.new.or_dmv_office_locations
      expect { Facility.create_facility('CA', facility_data) }.to raise_error(RuntimeError, 'Unsupported state: CA')
    end
  end

  describe 'create_facility from Oregon' do
    it 'fetches API data' do
      expect(facility_data = DmvDataService.new.or_dmv_office_locations).not_to be_nil
    end

    it 'can initialize' do
      facility_data = DmvDataService.new.or_dmv_office_locations
      oregon_facilities = Facility.create_facility('OR', facility_data)
      expected_data = facility_data[0]
      expect(oregon_facilities[0]).to be_an_instance_of(Facility)
    end

    it 'maps data to correct data types' do
      facility_data = DmvDataService.new.or_dmv_office_locations
      oregon_facilities = Facility.create_facility('OR', facility_data)
      expected_data = facility_data[0]

      expect(oregon_facilities[0].name).to be_a(String)
      expect(oregon_facilities[0].address).to be_a(String)
      expect(oregon_facilities[0].phone).to be_a(String)
      expect(oregon_facilities[0].website).to be_a(String)
    end
    it 'creates one facility from Oregon (compare mapped data to API data)' do
      facility_data = DmvDataService.new.or_dmv_office_locations
      oregon_facilities = Facility.create_facility('OR', facility_data)

      expected_data = facility_data[0]
      expect(oregon_facilities[0].name).to eq(expected_data[:title])
      expected_address = JSON.parse(expected_data[:location_1][:human_address]).values.join(', ')
      expect(oregon_facilities[0].address).to eq(expected_address)
      expect(oregon_facilities[0].phone).to eq(expected_data[:phone_number])
      expect(oregon_facilities[0].website).to eq(expected_data[:website])
    end

    it 'creates multiple facilities from Oregon (compare mapped data to API data)' do
      facility_data = DmvDataService.new.or_dmv_office_locations
      oregon_facilities = Facility.create_facility('OR', facility_data)

      expected_data = facility_data[0]
      expect(oregon_facilities[0].name).to eq(expected_data[:title])
      expected_address = JSON.parse(expected_data[:location_1][:human_address]).values.join(', ')
      expect(oregon_facilities[0].address).to eq(expected_address)
      expect(oregon_facilities[0].phone).to eq(expected_data[:phone_number])
      expect(oregon_facilities[0].website).to eq(expected_data[:website])

      expected_data = facility_data[1]
      expect(oregon_facilities[1].name).to eq(expected_data[:title])
      expected_address = JSON.parse(expected_data[:location_1][:human_address]).values.join(', ')
      expect(oregon_facilities[1].address).to eq(expected_address)
      expect(oregon_facilities[1].phone).to eq(expected_data[:phone_number])
      expect(oregon_facilities[1].website).to eq(expected_data[:website])
    end
  end

  describe 'create_facility from New York' do
    it 'fetches API data' do
      expect(facility_data = DmvDataService.new.ny_dmv_office_locations).not_to be_nil
    end

    it 'can initialize' do
      facility_data = DmvDataService.new.ny_dmv_office_locations
      new_york_facilities = Facility.create_facility('NY', facility_data)
      expected_data = facility_data[0]
      expect(new_york_facilities[0]).to be_an_instance_of(Facility)
    end

    it 'maps data to correct data types' do
      facility_data = DmvDataService.new.ny_dmv_office_locations
      new_york_facilities = Facility.create_facility('NY', facility_data)
      expected_data = facility_data[0]

      expect(new_york_facilities[0].name).to be_a(String)
      expect(new_york_facilities[0].address).to be_a(String)
      # Certain locations in New York (kiosks) do not have phone numbers and
      # the endpoint is just not there if that is the case.
      expect(new_york_facilities[0].phone).to be_a(String).or be_nil
      expect(new_york_facilities[0].website).to be_a(String)
    end
    it 'creates a single facility from New York (compare mapped data to API data)' do
      facility_data = DmvDataService.new.ny_dmv_office_locations
      new_york_facilities = Facility.create_facility('NY', facility_data)

      expected_data = facility_data[0]
      expect(new_york_facilities[0].name).to eq(Helper.title_case(expected_data[:office_name]))
      expect(new_york_facilities[0].address).to eq("#{Helper.title_case(expected_data[:street_address_line_1])}, #{Helper.title_case(expected_data[:city])}, #{Helper.title_case(expected_data[:state])}, #{expected_data[:zip_code]}")
      expect(new_york_facilities[0].phone).to eq(expected_data[:public_phone_number])
      expect(new_york_facilities[0].website).to eq('undefined')
    end
    it 'creates multiple facilities from New York (compare mapped data to API data)' do
      facility_data = DmvDataService.new.ny_dmv_office_locations
      new_york_facilities = Facility.create_facility('NY', facility_data)

      expected_data = facility_data[0]
      expect(new_york_facilities[0].name).to eq(Helper.title_case(expected_data[:office_name]))
      expect(new_york_facilities[0].address).to eq("#{Helper.title_case(expected_data[:street_address_line_1])}, #{Helper.title_case(expected_data[:city])}, #{Helper.title_case(expected_data[:state])}, #{expected_data[:zip_code]}")
      expect(new_york_facilities[0].phone).to eq(expected_data[:public_phone_number])
      expect(new_york_facilities[0].website).to eq('undefined')

      expected_data = facility_data[1]
      expect(new_york_facilities[1].name).to eq(Helper.title_case(expected_data[:office_name]))
      expect(new_york_facilities[1].address).to eq("#{Helper.title_case(expected_data[:street_address_line_1])}, #{Helper.title_case(expected_data[:city])}, #{Helper.title_case(expected_data[:state])}, #{expected_data[:zip_code]}")
      expect(new_york_facilities[1].phone).to eq(expected_data[:public_phone_number])
      expect(new_york_facilities[1].website).to eq('undefined')

      expected_data = facility_data[2]
      expect(new_york_facilities[2].name).to eq(Helper.title_case(expected_data[:office_name]))
      expect(new_york_facilities[2].address).to eq("#{Helper.title_case(expected_data[:street_address_line_1])}, #{Helper.title_case(expected_data[:city])}, #{Helper.title_case(expected_data[:state])}, #{expected_data[:zip_code]}")
      expect(new_york_facilities[2].phone).to eq(expected_data[:public_phone_number])
      expect(new_york_facilities[2].website).to eq('undefined')
    end
  end

  describe 'create_facility from Missouri' do
    it 'fetches API data' do
      expect(facility_data = DmvDataService.new.mo_dmv_office_locations).not_to be_nil
    end

    it 'can initialize' do
      facility_data = DmvDataService.new.mo_dmv_office_locations
      missouri_facilities = Facility.create_facility('MO', facility_data)
      expected_data = facility_data[0]
      expect(missouri_facilities[0]).to be_an_instance_of(Facility)
    end

    it 'maps data to correct data types' do
      facility_data = DmvDataService.new.mo_dmv_office_locations
      missouri_facilities = Facility.create_facility('MO', facility_data)
      expected_data = facility_data[0]

      expect(missouri_facilities[0].name).to be_a(String)
      expect(missouri_facilities[0].address).to be_a(String)
      expect(missouri_facilities[0].phone).to be_a(String)
      expect(missouri_facilities[0].website).to be_a(String)
    end
    it 'creates one facility from Missouri (compare mapped data to API data)' do
      facility_data = DmvDataService.new.mo_dmv_office_locations
      missouri_facilities = Facility.create_facility('MO', facility_data)

      expected_data = facility_data[0]
      expect(missouri_facilities[0].name).to eq(Helper.title_case(expected_data[:name]))
      expect(missouri_facilities[0].address).to eq("#{Helper.title_case(expected_data[:address1])}, #{Helper.title_case(expected_data[:city])}, #{expected_data[:state]}, #{expected_data[:zipcode]}")
      expect(missouri_facilities[0].phone).to eq(expected_data[:phone])
      expect(missouri_facilities[0].website).to eq(expected_data[:facebook_url])
    end

    it 'creates multiple facilities from Missouri (compare mapped data to API data)' do
      facility_data = DmvDataService.new.mo_dmv_office_locations
      missouri_facilities = Facility.create_facility('MO', facility_data)

      expected_data = facility_data[0]
      expect(missouri_facilities[0].name).to eq(Helper.title_case(expected_data[:name]))
      expect(missouri_facilities[0].address).to eq("#{Helper.title_case(expected_data[:address1])}, #{Helper.title_case(expected_data[:city])}, #{expected_data[:state]}, #{expected_data[:zipcode]}")
      expect(missouri_facilities[0].phone).to eq(expected_data[:phone])
      expect(missouri_facilities[0].website).to eq(expected_data[:facebook_url])

      expected_data = facility_data[1]
      expect(missouri_facilities[1].name).to eq(Helper.title_case(expected_data[:name]))
      expect(missouri_facilities[1].address).to eq("#{Helper.title_case(expected_data[:address1])}, #{Helper.title_case(expected_data[:city])}, #{expected_data[:state]}, #{expected_data[:zipcode]}")
      expect(missouri_facilities[1].phone).to eq(expected_data[:phone])
      expect(missouri_facilities[1].website).to eq(expected_data[:facebook_url])

      expected_data = facility_data[2]
      expect(missouri_facilities[2].name).to eq(Helper.title_case(expected_data[:name]))
      expect(missouri_facilities[2].address).to eq("#{Helper.title_case(expected_data[:address1])}, #{Helper.title_case(expected_data[:city])}, #{expected_data[:state]}, #{expected_data[:zipcode]}")
      expect(missouri_facilities[2].phone).to eq(expected_data[:phone])
      expect(missouri_facilities[2].website).to eq(expected_data[:facebook_url])
    end
  end
end
