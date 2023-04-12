<a name="readme-top"></a>


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
    <li><a href="#contact">Contact</a></li>
    <li><a href="#privacy-policy">Privacy Policy</a></li>
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

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Development Process


This project was based on creating an app from scratch, which can provide customers with a nice and easy to use experience for ordering food. The development process consisted of the following steps:



1. Set up and configure the development environment for the project, which includes setting up the repository and creating an appropriate folder and file structure to work in Swift, in order to handle the version control.

2. Apply UX and UI principles, as well as the engagement structure, thus determining the individual pieces of the application and getting a better idea of how they fit together and how users are likely to interact with them. With this, the design of a <a href="https://www.figma.com/proto/kLdlPrHculQFxEpkHNnb5m/LittleLemonCapstone?node-id=58-162&starting-point-node-id=58%3A162&scaling=scale-down">high-fidelity prototype</a> was achieved that would align the goals of the company with those of potential users.

3. Design a user onboarding and registration process. Likewise, give the user the ability to store simple data and modifying their profile. In addition, create a navigation flow that makes it easy for users to move from one screen to another no matter where they are.

4. Setting up a food ordering process that allows users to sort and filter the menu page so they can narrow their search to the dishes that are most relevant to them. Getting this data from the network, store it in a database, and represent the data in Swift.

5. Utilize the information provided by the user's selection to fill the shopping cart, also giving them the possibility of adding, deleting and editing each of the dishes that are in it.

6. Assemble a checkout view, giving the user food delivery and pickup options to choose from, as well as other additional customizations like special requests, courier tips, and a food pickup schedule. In addition to providing a view that shows the map route and calculates the rate and the estimated delivery time based on the user address provided.

7. Create a view that displays the order summary, displaying of all the options selected by the user. As well as a view of an order history that preserves the last orders made. 


<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Built With

* [![SwiftUI][SwiftUI]][SwiftUI-url]
* [![CoreData][CoreData]][CoreData-url]
* [![Mapkit][Mapkit]][Mapkit-url]
* [![PositionStack][Positionstack]][Positionstack-url]
* [![Figma][Figma]][Figma-url]
* [![Coursera][Coursera]][Coursera-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p>
<br />


<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

* Xcode
  * Install the latest <a href="https://developer.apple.com/xcode/">Xcode</a> from Apple website.
  * iOS 16 and above

### Installation

1. Clone this repository:
   ```
   git clone https://github.com/rhencyd/ll.git
   ```
2. Open `FoodOrderingApp.xcodeproj` in Xcode.
3. Select the destination device you want to build on.
4. Run the app with `Cmd + R` or by pressing the `build and run` button.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
<br />


<!-- USAGE EXAMPLES -->
## Usage

To get the full potential of the app, login is required, you have three options:

1. Create an account

&nbsp;
   <img src="https://user-images.githubusercontent.com/114204612/231549667-b2f51054-26d3-42ee-aeaa-f193c068cfc6.jpeg" alt="signUp" height="400">

3. Use the demo account:
   * email = ***demo@email.com***
   * password = ***Password123*** (this field is case sensitive)
&nbsp;
   <img src="https://user-images.githubusercontent.com/114204612/231538307-3935d79d-9bf8-465c-bf62-0ee9d27ae9e9.png" alt="demoAccount" height="200">

3. Press _Order Now_ button, and start a guest mode.

&nbsp;
   <img src="https://user-images.githubusercontent.com/114204612/231541285-694748f0-eacc-495d-be7f-373a9a314b29.png" alt="guestMode" height="400">



<p align="right">(<a href="#readme-top">back to top</a>)</p>
<br />


<!-- CONTACT -->

## Contact

Rhency Delgado 

[![Linkedin][Linkedin]][Linkedin-url]
[![Gmail][Gmail]][Gmail-url]
[![Portfolio][Portfolio]][Portfolio-url]
[![GitHub][GitHub]][GitHub-url]



Project Link: [https://github.com/rhencyd/ll](https://github.com/rhencyd/ll)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- PRIVACY POLICY -->

## Privacy Policy

No personal data shared in the app will be given to any third party, under any circumstances. Your data will also never be used by us for any purpose without specific permission.

The app engages in no ad targeting, data mining, or other activities that may compromise your privacy, and we do not affiliate ourselves with any third parties that do so.



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[SwiftUI]: https://img.shields.io/badge/-SwiftUI-020C89?logo=swift&logoColor=white&style=for-the-badge
[SwiftUI-url]: https://developer.apple.com/xcode/swiftui/

[Figma]: https://img.shields.io/badge/-Figma-F24E1E?logo=figma&logoColor=white&style=for-the-badge
[Figma-url]: https://www.figma.com

[Coursera]: https://img.shields.io/badge/-Coursera-0056D2?logo=coursera&logoColor=white&style=for-the-badge
[Coursera-url]: "https://www.coursera.org/professional-certificates/meta-ios-developer

[Positionstack]: https://img.shields.io/badge/-positionstack-1E4B71?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACsAAAAtCAMAAAAA2mLvAAAAXVBMVEVHcEz///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+EHRzTAAAAHnRSTlMAFs22H8L99wkE4ulQ2WIvkA+krVhxQ/CBmSZpOXjvWtc7AAABq0lEQVQ4y5VV2bKrIBAEUVAUcd/j/3/mMTfDjiZ3qnwZurB7lgYhN/LtGPZ9ONIcPUchX0TM7IpZ9PtWPECPrjwh6PXxRt4h8aKRKvjYRqFbT33oSVmXRqAyO2NBSQhO49AreuxXajU38YyQzFCni1eOgcEJy+qtzXMsx0zRnye3BAnkSyMcLzMkiVOMHe7gld2YGogwO9sSSNYusxcw6yzGB1zQeTOg7hCbRSEq4oqKBSSaDzYLGpqC5pcR0X8yTTh3cLKaDPRsDDu/+uL+Cwt/WgJoTgJ2oI0Ea5MKXxuqP20rgzWAA7tmksOviptepCGtuYpPn91jNTtUOJ3DUB82xDScYrD0LTB9ibsZi9oC1lfKRSaYKOrVfRN6Z9jlIrm9gYm/nYu9ju+f6g2k+91EaeyoNjDDQTtr5mArtch+Hf/VuLOxh+a/xvxSGnnJpJ0l2aKGZlhwTX4e4j5peY/2nObOgkNPI/jWqyfuQoV8MPad2dCyenov8sbyazY+Py5tb+n69hIZfV2LvoWE2pIUfY/p3T+aSPRLvMdGHOi3GEo+/QhFxX4zBX8jgE9ZvoAolwAAAABJRU5ErkJggg==&logoColor=white&style=for-the-badge
[Positionstack-url]: https://positionstack.com

[CoreData]: https://img.shields.io/badge/-coredata-black?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACIAAAAtCAMAAAD8z0klAAAAaVBMVEVHcEz////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////dvhWBAAAAInRSTlMAhWci+wM59Md2ouOpmn4JVm5OQ5IQuY2w1F/BzCzoF9vEKwTI1QAAAZ9JREFUOMullNuSoyAURQ8XQRFQUUFQ1Pj/H9loMpfK9Eiqej/qKkDXPgB8mGaLzLQBd9WVDofW9JGMxes1w4OUUg1IVxW+0lUaOSXSw6ofAaKS2sStKd5XLpqN9J2QBkTV3B2hMCU8VLxjRlNDeawWtYyMb1ud+7DgHvxISArl9WKlcueJUxAaxDT7mp/vXkiCjv/mF3LcIlwMawaxDQwZpCSjyCDHMtNb5JE7LQVNM8gM0fM7gK8YBsQ6sdScvq9G+eon3YcZZr0lWYSZgFNL0q8fHEoeumBYPCvF9vRFXgVG/u0LFGPqi1xfAvheTgqlQrZXUkO1E3Z5evzM0QcItRPPIPNWqJzpMYvQSfCfaTzu23TGQ9zvCY4BqdbNyeK3lhcRtIW5K6AhrMXaDULIKUUKoZzu2j6mmSceSm6rnvye2SLlz7QS4zy9BPD6IYcKpzuFPdOb0Gk1LSt9c0Qpf4X+XbAPTfuFZpCFjDI/sC439gNaf9o6kSNqiPae2FuALcj9W4vnDWgr8vRCeozU9Fj8Xl/ZvS+tcJ257tsvP7OQGUy8BLAAAAAASUVORK5CYII=&logoColor=white&style=for-the-badge
[CoreData-url]: https://developer.apple.com/documentation/coredata

[Mapkit]: https://img.shields.io/badge/-MapKit-7EBC6F?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC0AAAAtCAMAAAANxBKoAAAAWlBMVEVHcEwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACNqrUmAAAAHXRSTlMA4hDzAnQZB7qo/M1BMNeOJPkE7MNfan+aTFWzo47dPg0AAAH3SURBVEjH7dXbumggFAbQIhWVkGP0/q+5m8lpLR/W/e6KDKlfE4SujVXSWkkJ+tCSbsZpXZtylO++mgsXWzokb7h1p6bZI2bLGbu6e8JEpoCKcuY4cEGf+Bjmm9GGqTzcZx8wLYEMazYcjscHrYwHuFpPOginfVjnVJ+AgjWUDxO3MJyIKYcVY/oydirXE+1exg4Pd22YuDXhOHnLxJXZNOmA7zKRNj6PbK+yjpuluHmZuCiH6kjt1LY0jx3KUOjXqtmnsrcRVVpukZPKjiL3GvvlmcX3Dxfs4+ldmoNvqm7B8GSvB7kY2CCowmedM9T7jnSZ+hwu1GnQGWqUxpDueXDjkyfQ78J7EHrSUUMlDGZAVJyKYS015dOshZY+uOzQqOFYIZtuuNwCIblr14zPmnGnUaO3Je5722vO7nROEI2lqZsvGqkQ+nzskEdNpE+BVyghX7TfOHykPgr2TSPWICX4Vx3K/w/6EP/1nqAXzVeddKXDXXKvh6umXQvVUrSr/6nNCJUaNe2FL1ehxeaveoQKnm1CvEY0AyV6CndFv+pEwSXE1AiV2vat40MJR3HGm58dp3Jow9d9rWCvisL5KdTcHoUQfF07I6BcDc9UWEicbZjR9Uvax6+AmTO1/ykISuyM8+n3r8P7FOe9+nklqe5/M3Q66D8r6EmDMmajEAAAAABJRU5ErkJggg==&logoColor=white&style=for-the-badge
[Mapkit-url]: https://developer.apple.com/documentation/mapkit/map

[Linkedin]: https://img.shields.io/badge/-Linkedin-0A66C2?logo=linkedin&logoColor=white&style=for-the-badge
[Linkedin-url]:https://www.linkedin.com/in/rhencyd/

[Gmail]: https://img.shields.io/badge/-gmail-EA4335?logo=gmail&logoColor=white&style=for-the-badge
[Gmail-url]: mailto:rhencyd@gmail.com

[Portfolio]: https://img.shields.io/badge/-Portfolio-00C4CC?logo=canva&logoColor=white&style=for-the-badge
[Portfolio-url]: https://rhencydelagdo.my.canva.site/

[GitHub]: https://img.shields.io/badge/-github-181717?logo=github&logoColor=white&style=for-the-badge
[GitHub-url]:https://github.com/rhencyd
