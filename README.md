<img align="center" src="https://rocketelevators-yt.com/assets/RocketElevators_images/clear_logo.png"  alt="Logo" width="850" height="200">


# Rocket Elevators Information System #

<details>
<summary><i>CLICK TO EXPAND</i></summary>

This week converted our static website into a Ruby on Rails application.

The first step was to use the Assett Pipeline to provide the JS, CSS and HTML files needed to run the website. 

We implemented Embeded Ruby Syntax to the HTML code.

We created a database which contained multiple tables :

The employee table is used to assign permissions to access the Backoffice. It is also used to store e-mails and passwords of said employees.

If you want to access the Backoffice use these credentials:

- username: nicolas.genest@codeboxx.biz
- password: newdog1

</br>

![](2021-02-19-19-06-57.png)

</br>

The users table is used to store login information for employees. It also assigns an ID to each one in order to link the tables together.


![](2021-02-19-19-09-22.png)

</br>

In order to create a Backoffice, we first had to implement an authentication process. To achieve this, we used Gem Devise which took care of all the controllers necessary for user creation and user sessions. We then used RailsAdmin that provided us with a Backoffice interface for managing our data, such as the Employee table, the Users table and a Quote table which is used to store all the quote requests made on the website.


![](2021-02-19-19-31-26.png)

</br>

Here is a screenshot of what the list of quotes looks like :

![](2021-02-19-19-30-54.png)

</br>

We then deployed the website to AWS Ubuntu Server using Cloudflare to secure it.

</br>
</br>

The Backoffice was updated to include more data from Mysql as well as adding a Data Warehouse.

![](2021-02-26-17-48-58.png)

</br>

It is now possible to Query the database and show the results in a graph :

![](2021-02-26-17-52-10.png)

</br>

We can also group multiple Graphs at the same time using a Dashboard :

![](2021-02-26-17-53-32.png)

</br>

In order to link the two databases together and to keep them up to date, we had to create tasks :

![](2021-02-26-17-55-30.png)

</details>
----------------------------------------------------------------------------------------------------------------
</br>

# Rocket Elevators APIs #

<details>
<summary><i>CLICK TO EXPAND</i></summary>

**Use these credentials to access the back office:**

- Username: nicolas.genest@codeboxx.biz
- Password: newdog1
---------------------------------------------------------------------------------------------------------------
</br>

<u><b>This week we had to implement APIs to our Rocket Elevators Rails Applications:</u></b>

</br>

First we added the **Twilio** and **Slack** APIs which were pretty similar. We added this code to the *Elevator Model*:

![](2021-03-11-12-17-18.png)

</br>

Next we linked the *Quotes* and *Leads* controller to **Zendesk**:

![](2021-03-11-12-56-02.png)

![](2021-03-11-12-56-45.png)

</br>

Here is what the **Sendgrid** code looks like in the *Leads Controller*:

![](2021-03-11-12-59-13.png)

This is the email that the customer receives when he/she completes the *Contact Form*:

![](2021-03-11-13-06-02.png)

</br>

In order to have *Contact Form Attachment Files* sent to **Dropbox**,(Le login est cmoutlook17@gmail.com password: rocketelevators2021) here is what we added:

![](2021-03-11-13-15-36.png)

</br>

Next comes **IBM Watson Text-to-Speech**. We started by adding an audio player to *Rails Admin* in a new tab called Watson:

![](2021-03-11-13-26-19.png)

Then, we created a method that updates the audio file with Watson reading the text provided, here is the code:

![](2021-03-11-13-51-19.png)

See what the audio player looks like:

![](2021-03-11-13-54-10.png)

</br>

Finally, we implemented **Google Maps** in the *Back Office*. This is the code:

![](2021-03-12-11-08-22.png)

![](2021-03-12-11-09-12.png)

Here is what it looks like on the website:

![](2021-03-12-11-11-36.png)

## BONUS ##

</br>

We added a **Spotify Player** to the *Admin Page*:

![](2021-03-12-17-25-18.png)
![](2021-03-12-17-25-45.png)
![](2021-03-12-17-26-46.png)

</br>

Next, we added a new **Watson** to provide interesting facts about *Star Wars*:

![](2021-03-12-17-28-30.png)
![](2021-03-12-17-29-23.png)
![](2021-03-12-17-30-09.png)

</br>

Finally we tried to add **Weather** to *Google Maps* but this is as far as we got:

![](2021-03-12-22-28-09.png)
</details>


# Extented Data Warehouse #

<u><b>This week we had to extend our data warehouse with a table named Fact Intervention:</u></b>

![](fact_int.jpg)

</br>

Then we developed a rake task to generate random data into that table.

![](fact_int2.jpg)











