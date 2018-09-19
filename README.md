# Exploring Options
####  A collaborative web-app for salon professionals looking to maximize their opportunities

#### Current Setup:
  - [Devise](https://github.com/plataformatec/devise)-gem for user management
  - Rails 5.2 as the MVC (using sqlite for dev environment)
  - Bootstrap for quick prototyping of layout and minor animation
  - jQuery for handling AJAX requests and supporting Bootstrap
  - Utilizing [Cocoon](https://github.com/nathanvda/cocoon)-gem to manage nested forms for Requests and their Availabilities.


#### Current Capabilities
- Anyone can sign up and generate a request to any other user from their respective dashboard.
  - Mobile formatted screens allow for faster access with fixed-bottom menu.
  - A request can also be utilized as a To-Do as they can also be self-assigned and managed separately from the other team oriented requests.
- Each request is currently set up to allow for (4) guest availabilities.
  - An Availability has a start-time, end/exit-time, start-date and/or end-date.
  - Requests have a recipient and author as well as message-title and client fields if need be.
  - The number of Availabilities within a request can be adjusted within the Request model.

#### Future:
Project __direction__ and _opportunities_
- [ ] __Adding Active-Admin to help manage team/company participants__.

- [ ] *Current Availability validation/form errors are global and not specific to each availability failing within the parent Request. Would like to leverage jQuery/Bootstrap to highlight which availabilities require adjustments as opposed to just the general Request.errors.full_messages I'm currently dealing with.*

- [ ] **Adding a __Conversation__ thread to each __Request__ so recipient and subsequent team members can have a chat about each request and guest opportunity. Might go the route of having a has_many_through join-table for Request -> Conversation -> Comment... but we shall see.**

- [ ] **A Notification system to alert recipients or collaborative teams of new messages and updates. This would be my shot at dealing with ActionCable! Wish me luck. ;)**

- [ ] **Querying request opportunities allowing for anyone to utilize this app to manage a waitlist for open appointments.**
