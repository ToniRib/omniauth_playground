class User < ActiveRecord::Base
  has_many :workouts

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_by(map_my_fitness_id: auth_hash.info.id)

    unless user
      user = User.create({
        map_my_fitness_id: auth_hash.info.id,
        birthdate: auth_hash.info.birthdate,
        email: auth_hash.info.email,
        first_name: auth_hash.info.first_name,
        last_name: auth_hash.info.last_name,
        city: auth_hash.info.location.locality,
        state: auth_hash.info.location.region,
        username: auth_hash.info.username,
        time_zone: auth_hash.info.time_zone
      })
    end

    user
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
