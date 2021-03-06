class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.date :date
      t.time :startTime
      t.time :endTime
      t.date :endDate
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
