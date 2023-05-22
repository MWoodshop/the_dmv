class Facility
  attr_reader :name,
              :address,
              :phone,
              :services,
              :registered_vehicles,
              :collected_fees

  def initialize(data)
    @name = data[:name]
    @address = data[:address]
    @phone = data[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    return nil unless @services.include?('Vehicle Registration')

    vehicle.registration_date = Date.today
    vehicle.determine_plate_type
    @registered_vehicles << vehicle
    calculate_collected_fees(vehicle)
    @registered_vehicles
  end

  def calculate_collected_fees(vehicle)
    plate_type_fees = {
      ev: 200,
      antique: 25
    }

    @collected_fees += plate_type_fees[vehicle.plate_type] || 100
  end

  def earn_permit(registrant)
    raise 'Already has permit.' if registrant.permit?

    return nil unless registrant.age > 15

    registrant.earn_permit
  end

  def administer_written_test(registrant)
    raise 'Already took written test.' if registrant.written_test?

    return nil unless registrant.permit? && registrant.age > 15 && @services.include?('Written Test')

    registrant.administer_written_test
  end

  def administer_road_test(registrant)
    raise 'Already took road test and has license.' if registrant.road_test?

    return nil unless registrant.written_test? && @services.include?('Road Test')

    registrant.administer_road_test
  end

  def renew_drivers_license(registrant)
    raise 'Already renewed drivers license.' if registrant.renewed_drivers_license?

    return nil unless registrant.written_test? && registrant.road_test? && services.include?('Renew License')

    registrant.renew_drivers_license
  end
end
