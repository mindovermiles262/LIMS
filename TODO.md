# TO DO

* ~~Fix login form display~~
* ~~Add analyst/admin checkbox to user profile~~
  * ~~for administrators only~~
  * ~~`Unpermitted parameters: :company, :analyst, :admin` when updating user~~
* ~~Add descriptions for tests~~
* ~~Add test batch functionality~~
* Add equpment model
* Add Media Model
* ~~Style edit user form~~
* Remove tests from batches
* ~~Limit user delete project if project has been started(batched)~~
* ~~Fix User Show path button in navbar~~
* Fix update batch (enter results) redirect back to batch#show

Users index - extend table headers by 1 column
Analyst & Admin Projects link Broken:
```Ruby 
2017-09-19T16:58:09.641268+00:00 app[web.1]: F, [2017-09-19T16:58:09.641198 #4] FATAL -- : [b626690a-a99c-4799-83ab-becff4ddaa03]   
2017-09-19T16:58:09.641397+00:00 app[web.1]: F, [2017-09-19T16:58:09.641334 #4] FATAL -- : [b626690a-a99c-4799-83ab-becff4ddaa03] ActionView::Template::Error (undefined method `first_name' for nil:NilClass):
2017-09-19T16:58:09.641693+00:00 app[web.1]: F, [2017-09-19T16:58:09.641621 #4] FATAL -- : [b626690a-a99c-4799-83ab-becff4ddaa03]     19:             <tr>
2017-09-19T16:58:09.641695+00:00 app[web.1]: [b626690a-a99c-4799-83ab-becff4ddaa03]     20:               <th><%= project.id %></th>
2017-09-19T16:58:09.641695+00:00 app[web.1]: [b626690a-a99c-4799-83ab-becff4ddaa03]     21:               <th><%= project.description %></th>
2017-09-19T16:58:09.641696+00:00 app[web.1]: [b626690a-a99c-4799-83ab-becff4ddaa03]     22:               <th><%= project.user.first_name %> <%= project.user.last_name %></th>
2017-09-19T16:58:09.641697+00:00 app[web.1]: [b626690a-a99c-4799-83ab-becff4ddaa03]     23:               <th><%= project.lot %></th>
2017-09-19T16:58:09.641698+00:00 app[web.1]: [b626690a-a99c-4799-83ab-becff4ddaa03]     24:               <th><%= project.samples.count %></th>
2017-09-19T16:58:09.641698+00:00 app[web.1]: [b626690a-a99c-4799-83ab-becff4ddaa03]     25:               <th><%= project.status %></th>
2017-09-19T16:58:09.641776+00:00 app[web.1]: F, [2017-09-19T16:58:09.641719 #4] FATAL -- : [b626690a-a99c-4799-83ab-becff4ddaa03]   
2017-09-19T16:58:09.641864+00:00 app[web.1]: F, [2017-09-19T16:58:09.641807 #4] FATAL -- : [b626690a-a99c-4799-83ab-becff4ddaa03] app/views/projects/index.html.erb:22:in `block in _app_views_projects_index_html_erb__931528343959714464_22080560'
2017-09-19T16:58:09.641866+00:00 app[web.1]: [b626690a-a99c-4799-83ab-becff4ddaa03] app/views/projects/index.html.erb:18:in `_app_views_projects_index_html_erb__931528343959714464_22080560'
2017-09-19T16:58:09.643221+00:00 heroku[router]: at=info method=GET path="/projects" host=appert.herokuapp.com request_id=b626690a-a99c-4799-83ab-becff4ddaa03 fwd="67.164.25.127" dyno=web.1 connect=3ms service=21ms status=500 bytes=1827 protocol=https
2017-09-19T16:58:09.974169+00:00 heroku[router]: at=info method=GET path="/favicon.ico" host=appert.herokuapp.com request_id=96734b96-5376-4c00-bd40-bcd377e6c14c fwd="67.164.25.127" dyno=web.1 connect=1ms service=10ms status=304 bytes=48 protocol=https
```