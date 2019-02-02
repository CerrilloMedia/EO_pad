module ProfilesHelper

def labeled_divider(label, dashboard=true)

  ('<div class="col px-0 px-sm-1">
    <div class="d-flex py-2">
      <div class="col col-sm-2 pt-1 pl-0">
        <hr class="mt-1 border-2 hr-divider border border-warning">
      </div>
      <div class="text-center">
        <span class="">
        ' + label + '
        </span>' +
        ( dashboard ? "Dashboard" : '' ) +
      '</div>
      <div class="col pt-1 pr-0">
        <hr class="my-1 hr-divider border border-warning">
      </div>
    </div>
  </div>').html_safe

  ('<span></span>').html_safe

end

def all_requests_for(user, self_, type)
  if self_ # if on own profile, your tasks are requests with you as the recipient
    type == 'requested' ? user.requests.assigned : user.tasks.assigned
  else
    type == 'requested' ? user.requests.assigned.to_user(current_user) : user.tasks.assigned.from_user(current_user)
  end
end

end
