class CreatePinouts < ActiveRecord::Migration[5.2]
  def change
    create_table :pinouts do |t|
      t.integer :project_id
          t.integer :pin_dut
          t.string :pin_dut_name
          t.text :pin_dut_description
          t.integer :pin_setup
          t.string :pin_setup_name
          t.text :pin_setup_description

      t.timestamps
    end
  end
end
