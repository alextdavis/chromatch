Sequel.migration do
  up do
    create_table :users do
      primary_key :id

      String :uid, :null => false, :unique => true
      String :email, :null => false, :unique => true
      String :name, :null => false
      String :avatar
      String :phone
      String :position
      String :token

    end
    # User.set_dataset :users

    User.each do |user|
      user.update({:token => SecureRandom.hex})
    end
  end

  down do
    drop_table :users
  end
end
