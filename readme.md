## Creating a Basic Rails CRUD Application

1. To make gemset management easier, create a “.rvmrc” file
- This command will force your computer to create the gemset 
```
rvm 2.1@williamsl25_basic_rails --create
```
2. cd out of the directory then back in again

3. Create the Rails project. First, install Rails gem
```
gem install rails
```

```
rails new . 
```

4. To start server:
```
rails s
```

5. Get rid of the “Welcome Aboard” screen and start developing your own application, so go into “config/routes.rb” and set up a root route:
 
```
Rails.application.routes.draw do
  root 'home#index'
end
```

6. initialize a Home Controller
```
rails g controller home
```

7. create “index” action 
```
class HomeController < ApplicationController
  def index
  end
end
```

8. create an index template
```
touch app/views/home/index.html.erb
```

9. config/routes.rb
```
Rails.application.routes.draw do
  root 'home#index'

  resources :contacts
end
```

* rake routes => displays routes created

10. add a link to create a new contact
```
<%= link_to "New Contact", new_contact_path %>
```

11. initialize/ create a Contacts Controller
```
rails g conroller contacts
```
* make sure controller is plural

12. create the new action in the contacts controller
```
class ContactsController < ApplicationController
  def new
  end
end
```

13. create a new template - form for creating a contact
```
<h1>New Contact</h1>

<%= form_for @contact do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <br>
  <%= f.submit %>
<% end %>
```

14. create data to give to the form
```
def new
    @contact = Contact.new
  end
```

15. create a model
```
rails g model contact name:string
```
16. run the migration
```
rake db:migrate
```

17. create a “new” action inside of our Contacts Controller.
```
class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.create params[:contact]
  end
end
```

18. add a method that whitelists parameters in contacts controller
```
private
  def que_params
    params.require(:contact).permit(:name)
  end
```

19. tell my action to render something, or I need to redirect. Let’s redirect to our root page. 
```
def create
    @contact = Contact.create que_params
    redirect_to root_path
  end
```

20. render data to the user
```
<h1>Root file</h1>

<%= link_to "New Contact", new_contact_path %>
<br>
<% @contacts.each do |contact| %>
  <%= contact.name %>
  <br>
<% end %>
```

21. define the @contacts variable
```
class HomeController < ApplicationController
  def index
    @contacts = Contact.all
  end
end
```

22. make an “Edit” link on root page
```
 <%= link_to "Edit", edit_contact_path(contact) %>
 ```

 23. create the edit action
 ```
 def edit
  end
  ```
  24. create edit template
  ```
  <h1>Edit Contact</h1>

<%= form_for @contact do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <br>
  <%= f.submit %>
<% end %>
```

25. make the edit variable in the controller
```
  def edit
    @contact = Contact.find params[:id]
  end
  ```
26. update action in controller
```
def update
    @contact = Contact.find params[:id]
    @contact.update_attributes que_params
    redirect_to root_path
  end
  ```

27. add a link to the show page
```
<%= link_to contact.name, contact_path(contact) %>
```

28. create the show action
```
def show
    @contact = Contact.find params[:id]
  end
  ```
29. add the show template
```
<h1>Show data</h1>

<%= @contact.name %>

<%= link_to "Home", root_path %>
```
30. make a delete link
```
 <%= link_to "Delete", contact_path(contact), method: :delete %>
 ```
 31. make the delete action in the controller
 ```
 def destroy
    @contact = Contact.find params[:id]
    @contact.delete
    redirect_to root_path
  end
  ```
32. 
