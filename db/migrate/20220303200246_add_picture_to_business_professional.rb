class AddPictureToBusinessProfessional < ActiveRecord::Migration[6.1]
  def change
    add_column :business_professionals, :picture, :string
  end
end
