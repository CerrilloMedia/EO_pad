module ProfilesHelper

def labeled_divider(label)

  ('<div class="col px-0 px-sm-1">
    <div class="d-flex my-2">
      <div class="col col-sm-2 pt-2 pl-0">
        <hr class="mt-1 border-2 hr-divider border border-warning">
      </div>
      <div class="text-center">
        <span class="">
        ' + label + '
        </span>Dashboard
      </div>
      <div class="col pt-2 pr-0">
        <hr class="my-1 hr-divider border border-warning">
      </div>
    </div>
  </div>').html_safe

end

end
