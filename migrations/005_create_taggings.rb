Sequel.migrations do
  up do
    create_table :taggings do
      primary_key :id

      foreign_key :tag, :tags, :null => false
      foreign_key :user, :users, :null => false
      Float :weight, :null => false
    end
  end
  down do
    drop_table :taggings
  end
end
