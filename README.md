### Heroku Application

The heroku application is available here: <http://ruben-timely.herokuapp.com/>

### How to test the app

The application have the following sections:

* Create a task
  * You can create a task here: <http://ruben-timely.herokuapp.com/tasks/new>
  * You can pick an existent Project or create a new one in the same UI for create a Task.
  * The application has validations for the uniqueness of the Project name and the presence of the Task name.
* List tasks
  * The listing of tasks is available in the Home page, you can also view tasks from the past 7 days (only tasks that have Sessions that were started and finished in that day will be listed). Finally you have the ability to Start working on a Task or Stop working on it.
* List All Task Sessions
  * The listing is available here: <http://ruben-timely.herokuapp.com/task_sessions>
  * I've added this section in order to make more easy the testing of the listing for the past days. In this sections you can modify when a Session was started or finished. Only finished sessions will be listed here.

### Some pending tasks

* Add test coverage
* Improve the UI (maybe with Twitter Bootstrap)

I'm happy to implement these missing points if I have a bit more of time to do this.
