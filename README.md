# Notable App 
## Introduction
This is my personal iOS app with the purpose to get my hands dirty with iOS development, XCode IDE, Swift programming language and the features around it  
The app provides a Note-taking tool for users who have the need to take note, memorandum and share it to the world or friends  
App features:  
* Allow users to create notes, which have a title and content
* Users can take a look and inspect the notes
* Users are able to share their notes to other users in the system. Users shared must be in their contact list
* Users can add/remove users to/from their contact list
* Users are required to register with the system and login to use the functionalities of the app
## Tech Stack
* Swift 5
* iOS 13
* UIKit and Storyboard
* Parse Server and SDK for back-end
* CocoaPods as dependency manager
## Project Structure
* **Model**: App's main entities such as Note and User as well as managers, which perform asynchronous networking tasks and notfy to their respective delegates  
  * NoteManager and ContactManager: managers in charge of interacting with the server
  * Note and User: data model of the app
  * NotesDataSource and ContactsDatasource: datasource classes which will be the datasources of the tableViews defined in this project. The purpose of defining them in separate classes is reusability
* **View**: This directory contains all storyboard files as well as custom cells' XIB files. As the app's UI is quite complex, it is a good idea to split to multiple storyboard files to redure load up and improve readability. In this project, screens belonging to a tab is bundled in a storyboard
* **Controllers**: UIViewController classes. This folder is divided further to sub-directories to group VCs in the same tab
* **Enums**: enums used throughout this project
* **Utilities**: extension methods to perform tasks used widely throughout the project
  * ToastMessage: display a toast message given the message text and font
  * Spinner: methods to display and dismiss a spinner when the app is having a background task
  * StoryboardRedirect: redirect user to either Main storyboard or Login story depending on the logged in status
* **Abstraction**: generic classes and protocols to group common functionalities, including generic datasource and generic table delegate methods
