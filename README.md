# Exploring Options
####  A collaborative app for salon professionals looking to utilize a waitlist for guest opportunities.

### Current Capabilities
  - Anybody can generate a Request
  - Utilized [Cocoon](https://github.com/nathanvda/cocoon) gem to add more than one Availability (start/end dates & time ranges) to each Request model. Can limit the number of requested date/time combinations within Request model and subsequent jQuery event handlers.

### ToDo
  - Current Availability validation errors are global and not specific to each availability failing. Would like to add some jQuery to the view to highlight which availabilities require adjustments as opposed to just the general Request.errors.full_messages

### Future updates
  - Will utilize [Devise](https://github.com/plataformatec/devise) gem to add Users and User Dashboards allowing for improved organization.
  - Ability to assign a request to a User as recipient.
  - Messages/Comments to each request in case there needs to be more clarity beyond basic requests
  - Notifications for messages/comments
