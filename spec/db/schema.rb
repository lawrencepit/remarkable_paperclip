ActiveRecord::Schema.define :version => 0 do
  create_table :people, :force => true do |t|
    t.string :avatar_file_name
    t.string :photo_file_name
  end
end
