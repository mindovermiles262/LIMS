## Buttons
```
Action      Name      Color
################################
#index      New       Info

#show       Back      Primary
            Edit      Info

#edit       Submit    Success
            Cancel    Danger
```
Buttons are attached to tables in the following way:
```
<table>
  ...
</table>
<div class="field is-grouped">
  <div class="control">
    <%= BUTTON %>
  </div>
  <div class="control">
    <%= BUTTON %>
  </div>
</div>
```