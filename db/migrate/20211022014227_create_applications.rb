class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.integer :zip_code
      t.string :state
      t.string :reason
      t.string :application_status
    end
  end
end
