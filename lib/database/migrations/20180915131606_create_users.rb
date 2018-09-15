Sequel.migration do
  up do
    create_table(:users) do
      unique :email
      primary_key :id
      String :first_name, null: false, size: 255
      String :last_name, null: false, size: 255
      String :email, null: false, size: 255
      String :password, null: false, size: 255
      DateTime :created_at, null: false, default: Time.now
      DateTime :updated_at, null: false, default: Time.now
    end
  end

  down do
    drop_table(:users)
  end
end
