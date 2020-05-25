class BackfillUserNames < ActiveRecord::Migration[6.0]
  def change
    User.where(first_name: nil, last_name: nil).find_each do |user|
      user.first_name = "Dear"
      user.last_name = "Guest"

      user.save
    end
  end
end
