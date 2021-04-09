def define_first_post
  @first_post = Post.create!(title: 'a title')
end

RSpec.configure do |config|
  config.before(:suite) do
    ActiveRecord::Migration.class_eval do
      # Users are created and updated by other Users
      create_table :users, :force => true do |t|
        t.column :name,           :string
        t.column :creator_id,     :integer
        t.column :created_on,     :datetime
        t.column :updater_id,     :integer
        t.column :updated_at,     :datetime
      end

      # People are created and updated by Users
      create_table :people, :force => true do |t|
        t.column :name,           :string
        t.column :creator_id,     :integer
        t.column :created_on,     :datetime
        t.column :updater_id,     :integer
        t.column :updated_at,     :datetime
      end

      # Posts are created and updated by People
      create_table :posts, :force => true do |t|
        t.column :title,          :string
        t.column :creator_id,     :integer
        t.column :created_on,     :datetime
        t.column :updater_id,     :integer
        t.column :updated_at,     :datetime
        t.column :deleter_id,     :integer
        t.column :deleted_at,     :datetime
      end

      # Comments are created and updated by People
      # and also use non-standard foreign keys.
      create_table :comments, :force => true do |t|
        t.column :post_id,        :integer
        t.column :comment,        :string
        t.column :created_by,     :integer
        t.column :created_at,     :datetime
        t.column :updated_by,     :integer
        t.column :updated_at,     :datetime
        t.column :deleted_by,     :integer
        t.column :deleted_at,     :datetime
      end

      create_table :tags, force: true do |t|
        t.column :title,          :string
      end

      create_table :post_tags, force: true do |t|
        t.column :post_id,        :integer
        t.column :tag_id,         :integer
      end
    end
  end

  config.before(:each) do
    User.delete_all
    Person.delete_all
    Post.delete_all
    Comment.delete_all
    User.reset_stamper
    Person.reset_stamper

    @zeus = User.create!(name: 'Zeus')
    @hera = User.create!(name: 'Hera')
    User.stamper = @zeus.id

    @delynn = Person.create!(name: 'Delynn')
    @nicole = Person.create!(name: 'Nicole')
    Person.stamper = @delynn.id
  end
end
