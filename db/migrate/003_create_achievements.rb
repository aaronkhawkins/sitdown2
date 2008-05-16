class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.string :description
      t.references :profile
      t.timestamps
    end
  end

  def self.down
    drop_table :achievements
  end
end
