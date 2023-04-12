<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://testflight.apple.com/join/3HiuqZk7">
    <img src="https://user-images.githubusercontent.com/114204612/231291150-ac8d1869-bcd8-44f0-a93c-18d4b92f2027.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Little Lemon - Food Ordering App</h3>

  <p align="center">
    Capstone Project based on a user friendly food ordering app.
    <br />
    <a href="https://github.com/rhencyd/ll/tree/main/FoodOrderingApp/FoodOrderingApp"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://testflight.apple.com/join/3HiuqZk7">View Demo</a>
  
  </p>
</div>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
         <li><a href="#development-process">Development Process</a></li>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

<div align="center">
 <img src="https://user-images.githubusercontent.com/114204612/231298203-f9696492-4f6a-4aa7-b5bb-c492a3afd0f7.png" alt="welcomeView" height="430">
 <img src="https://user-images.githubusercontent.com/114204612/231300095-f814a86b-e360-46ac-a79e-16d41ab87eb4.png" alt="homeView" height="430">
 <img src="https://user-images.githubusercontent.com/114204612/231300470-c74916d1-144f-419a-b801-c93b6f7f728d.png" alt="dishView" height="430">
 <img src="https://user-images.githubusercontent.com/114204612/231300800-fc803f73-89f8-412d-9ab4-2b789f2f41b5.png" alt="cartView" height="430">
 <img src="https://user-images.githubusercontent.com/114204612/231301064-4692ef5d-07a9-43dc-bb96-7562459ce7b5.png" alt="deliveryView" height="430">
</div>

<br />
<br />


Little Lemon is the name of a fictional Mediterranean restaurant located in Chicago, and serves as the main case study created by Meta to solve business-oriented problems.

This idea was used throughout the <a href="https://www.coursera.org/professional-certificates/meta-ios-developer"> Meta iOS Developer</a> training content, and among the issues to be resolved was the need to create a tool that would allow users to order food through their mobile devices, specifically targeting iPhone users. This is how Little Lemon Food Ordering App was born, which was the culminating project necessary to obtain certification as an iOS Developer.


<br />

### Development Process


This project was based on creating an app from scratch, which can provide customers with a nice and easy to use experience for ordering food. The development process consisted of the following steps:



1. Set up and configure the development environment for the project, which includes setting up the repository and creating an appropriate folder and file structure to work in Swift, in order to handle the version control.

2. Apply UX and UI principles, as well as the engagement structure, thus determining the individual pieces of the application and getting a better idea of how they fit together and how users are likely to interact with them. With this, the design of a <a href="https://www.figma.com/proto/kLdlPrHculQFxEpkHNnb5m/LittleLemonCapstone?node-id=58-162&starting-point-node-id=58%3A162&scaling=scale-down">high-fidelity prototype</a> was achieved that would align the goals of the company with those of potential users.

3. Design a user onboarding and registration process. Likewise, give the user the ability to store simple data and modifying their profile. In addition, create a navigation flow that makes it easy for users to move from one screen to another no matter where they are.

4. Setting up a food ordering process that allows users to sort and filter the menu page so they can narrow their search to the dishes that are most relevant to them. Getting this data from the network, store it in a database, and represent the data in Swift.

5. Transport the information provided by the user's selection to fill the shopping cart, also giving them the possibility of adding, deleting and editing each of the dishes that are in it.



<br />
<br />
<br />
<br />


Likewise, the user has the possibility of filtering, editing, deleting, and updating the dishes on the menu, as well as the option of home delivery or food collection, tips and adding special requests and getting an approximate cost of shipping based on distance and time data using MapKit in real-time. . time. After making the purchase, the user can access the history of the orders created and place new orders.


- Set up a SwiftUI app with Xcode
- Commit the project to a Git repository (https://github.com/rhencyd/ll)
- Plan and design the UI/UX:
  - User persona (https://www.figma.com/file/koasaX6mALzx8qHeo63Nr3/Persona-RD?node-id=0%3A1&t=eYLuzgMs6T8V5MM3-1)
  - Journey map: https://www.figma.com/file/61scramjcLgnjOiMAqwEUK/Journey-Map-RD?node-id=2%3A38&t=eYLuzgMs6T8V5MM3-1
  - High fidelity prototype: https://www.figma.com/proto/kLdlPrHculQFxEpkHNnb5m/LittleLemonCapstone?node-id=58-162&starting-point-node-id=58%3A162
- Configure the user onboarding UI flow
- Food Menu UI Setting, for this, I have used core data, URL request, and third-party API to get directions to show the map roue


I hope you enjoyed it, and let me know how I can improve it! 

<br />
<br />

## Privacy Policy

No personal data shared with us will be given to any third party, under any circumstances. Your data will also never be used by us for any purpose without specific permission.

The app engages in no ad targeting, data mining, or other activities that may compromise your privacy, and we do not affiliate ourselves with any third parties that do so.
