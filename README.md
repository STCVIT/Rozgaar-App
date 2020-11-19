<h1>Rozgar - Post Covid Employment App :construction_worker: </h1>

Rozgar is a humble app that aims to bring employment to the poorest of the poor of our country who don't have Whatsapp or Linkedin to search for jobs.

# The Problems This Solves

## For Workers

<br>
<p align="center">
  <img height="600px" src="https://images.unsplash.com/photo-1531668361947-d00e652ac030?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"/>
</p>
<br>
We all know the plight of migrant labourers post-COVID-19.
A lot of the daily-wage-workers rushed to their homes in villages when the lockdown was instated. Now that these restrictions are being lifted, it's a real challenge for them to find employment. A lot of old businesses have been shut down and many others are running at a reduced capacity. Workers can use their simple 2G Feature Phones to register themselves on a nationwide database of workers actively seeking for employment by just sending a message.

The message will be sent to a toll free number in the following format:
<br>

```
<pin-code> <skill-code>
```

<br>
Here pin-code is the pin code of the location the worker wants to find employment in and skill-code represents the following skills:
<br>
<p align="center">
<table>
  <tr>
    <th>Skill Code</th>
    <th>Skill</th>
  </tr>

  <tr>
    <td>
      1
    </td>
    <td>
      driver
    </td>
  </tr> 
    <tr>
      <td>
        2
      </td>
      <td>
        labourer
      </td>
    </tr>
    <tr>
      <td>
        3
      </td>
      <td>
        maid
      </td>
    </tr>
    <tr>
      <td>
        4
      </td>
      <td>
        guard
      </td>
    </tr>
    <tr>
      <td>
        5
      </td>
      <td>
        carpenter
      </td>
    </tr>
    <tr>
      <td>
        6
      </td>
      <td>
         plumber
      </td>
    </tr>
    <tr>
      <td>
        7
      </td>
      <td>
        electrician
      </td>
    </tr>
</table>
</p>
This adds the worker to the worker database and automatically finds the district of the worker like this:
<br>
<p align="center">
<img src="https://i.ibb.co/Fm9f2TD/mobile.png" alt="mobile" border="0">
</p>
<br />
Now the worker will be listed in the Aamdani app for being hired by a potential employer.

## For Employers

<br>
<p align="center">
<img src="https://analyticsindiamag.com/wp-content/uploads/2019/12/How-SMBs-In-India-Can-Unlock-Their-Potential-With-Analytics.jpg" />
</p>
<br>
Employers have been hit really hard by a shortage of both skilled and unskilled workers. These employers can use our app to provide the pin code of their home or workplace and their requirement(maid, labourer) etc. to search for relevant workers near them. The employers can then contact these workers and hire them. So there's a win-win situation for both the hiring and the hired.

## For NGOs

<br>
<br>
<p align="center">
<img src="https://i.ibb.co/jZmcyWW/tilted.jpg" alt="tilted" border="0">
  </p>
<br>
<br>
We have integrated Firebase ML Kit to recognise text from images which can help all NGOs like https://nirmana.org and https://www.savengo.org which help poor people gain employment. If an NGO is maintaining a list of people seeking employment, they can directly scan it and bulk upload it on our database to accelerate the job search process instead of having to manually upload details of each worker one by one.

The list of workers just has to be given in the format:

```
  <mobile_number> <skill> <pin-code>
  <mobile_number> <skill> <pin-code>
  <mobile_number> <skill> <pin-code>
  .
  .
  .
```

# Challenges We Faced

While building this app, the biggest challenge we faced was to establish communication with poor workers who don't have internet access or expensive smartphones. We brainstormed it and came up with this messaging solution. Using text messages, we can easily and cheaply obtain data of millions of workers across india and add them to our database. We used Integromat to read messages and then sent the information to a NodeJS API endpoint which parses all the relevant information and enters it into our database.

Another challenge we faced was to integrate the ML Kit into the app. Both of us in the team had no previous experience in using Firebase ML Kit. But we read the documentation and learnt it on the spot and were successfully able to implement it in our app within the time limit.

# Getting Started

**Note:** Make sure your Flutter environment is setup.

#### Installation

In the command terminal, run the following commands:

    $ git clone https://github.com/vasumanhas000/hourglass-app.git
    $ cd hourglass-app
    $ flutter run

# Simulate for iOS

#### Method One

    Open the project in Xcode from ios/Runner.xcodeproj.
    Hit the play button.

#### Method Two

    Run the following command in your terminal.
    $ open -a Simulator
    $ flutter run

# Simulate for Android

    Make sure you have an Android emulator installed and running.
    Run the following command in your terminal.
    $ flutter run

##### Check out Flutter’s online [documentation](http://flutter.io/) for help getting start with your Flutter project.

##### Figma link-

      https://www.figma.com/file/fopwsT0SbBtkhcdqHH6XaM/Hello-World-4.0
