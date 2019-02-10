# Exploring Options - a waitlist dashboard
####  A collaborative web-app for salon professionals looking to maximize their opportunities

#### Current Setup:
  - Rails 5.2 on PostgreSQL because I heart Heroku
  - [Devise](https://github.com/plataformatec/devise)-gem for user management
  - Bootstrap & FontAwesome for quick prototyping of layout & UX
  - jQuery for handling AJAX requests and supporting Bootstrap UX
  - [ActiveAdmin](https://github.com/activeadmin/activeadmin) for backend management of Users and database records
  - Utilizing [Cocoon](https://github.com/nathanvda/cocoon)-gem to manage nested forms for Requests and Availabilities.
  - [Chartkick](https://github.com/ankane/chartkick) gem added for visualizing progress of task completion.


#### Current Capabilities
- [x] Users can assign and manage tasks and requests to/from other team members through their primary dashboard.
- [x] Mobile friendly because duh it's 2019
- [x] Requests can also be utilized as a personally assigned task (To-Do) and managed separately from outbound and incoming requests.
- [x] Each Request is set up to allow for (4) guest availabilities but can be extended from within the model. Will most likely move it to a global config variable.
- [x] ActiveAdmin to manage Model Data
- [x] Each Request has a comments thread to maximize realtime collaboration. Will dabble with ActionCable for notifications and if all goes well extend it to the Comments model.

#### Future:
Project __direction__ and _opportunities_
- [ ] Adding an extra layer of organization for building out collaborative teams.
- [ ] A Notification system to alert recipients or collaborative teams of new messages and updates. This would be my shot at dealing with ActionCable! Wish me luck. ;)
- [ ] Adding search capabilities to user Dashboard to quickly find a specific request.
- [ ] Focus on cleaning up and personalizing Active Admin dashboard for visual consistency.
