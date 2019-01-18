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

end
