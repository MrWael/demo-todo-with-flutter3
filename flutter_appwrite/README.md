# 🔖 Todo With Flutter 

A simple todo app built with Flutter and Appwrite

## 🎬 Getting Started

Appwrite is an end-to-end backend server for Web, Mobile, Native, or Backend apps packaged as a set of Docker microservices. Appwrite abstracts the complexity and repetitiveness required to build a modern backend API from scratch and allows you to build secure apps faster.

### 🤘 Install Appwrite

Follow our simple [Installation Guide](https://appwrite.io/docs/installation) to get Appwrite up and running in no time. You can either deploy Appwrite on your local machine or, on any cloud provider of your choice.

    Note: If you setup Appwrite on your local machine, you will need to create a public IP so that your hosted frontend 
    can access it.

We need to make a few configuration changes to your Appwrite server.

1. Add a new Flutter App (Android or iOS or any supported platform) in Appwrite and enter application id of your application (io.appwrite.todo, etc) 
![image](https://user-images.githubusercontent.com/45597179/191029132-5252cfdd-4da1-4ef0-9c03-d1fcc627909b.png)

2. Create a new database then inside it create a new collection with the following properties
![image](https://user-images.githubusercontent.com/45597179/191029199-f3788100-a505-40aa-a4cb-1ee48f1f0f1d.png)


  - Rules

Add the following rules to the collection.

    Make sure that your key exactly matches the key in the images

- Permissions

Add the following permissions to your collections. These permissions ensure that only registered users can access the collection.

![image](https://user-images.githubusercontent.com/45597179/191029248-255b2ef9-6444-4db7-92ab-44bb5d227f45.png)


 
Add the following attributes
![image](https://user-images.githubusercontent.com/45597179/191029301-61348770-4476-437a-8eba-b2308a801d40.png)

Create new storage bucket for profile image, with the correct permissions.
![image](https://user-images.githubusercontent.com/45597179/191029401-1bde9b32-6315-434e-b6a5-1b7c019acd5b.png)


Create new placeholder user, with the following info:
User ID: 133
Email: guest@temp.com
Password: 12345678
![image](https://user-images.githubusercontent.com/45597179/191029332-55a34596-9600-4019-b247-c9a43c442bbd.png)



## 🚀 Deploy the Front End

You have two options to deploy the front-end and we will cover both of them here. In either case, you will need to fill in these environment variables that help your frontend connect to Appwrite.

    FLUTTER_APP_ENDPOINT - Your Appwrite endpoint
    FLUTTER_APP_PROJECT - Your Appwrite project ID
    FLUTTER_APP_COLLECTION_ID - Your Appwrite collection ID
  
## Run locally

Follow these instructions to run the demo app locally

$ git clone https://github.com/MrWael/demo-todo-with-flutter3.git
$ cd demo-todo-with-flutter3

Make a one file in the Clone Repo called constant.dart

    class AppConstant {
    static const String projectid = '[PROJECTID]';
    static const String endPoint = 'https://[SERVERIPADDRESS]/v1';
    static const String database = '[DATABASEID]';
    static const String collection = '[COLLECTIONID]';
    static const String profileImgBucketId = '[BUCKETID]';
    }


Now run the following commands and you should be good to go 💪🏼

$ flutter pub get
$ flutter run


## Features

1. User can Login and Signup the app.
2. User can add, update the profile picture.
3. User can read, create, update, and delete the task. 

## Screenshots
<p>
<img src="https://user-images.githubusercontent.com/73419211/122684082-274d5580-d223-11eb-9fda-dc49ba9277e5.jpg" height="500" width="260">
<img src="https://user-images.githubusercontent.com/73419211/122684077-25839200-d223-11eb-8d41-6402c85d3c73.jpg" height="500" width="260">  
<img src="https://user-images.githubusercontent.com/73419211/122684072-23213800-d223-11eb-882a-b7d78cddbbeb.jpg" height="500" width="260">
<img src="https://user-images.githubusercontent.com/73419211/122684078-261c2880-d223-11eb-841b-778f460e63bd.jpg" height="500" width="260">
<img src="https://user-images.githubusercontent.com/73419211/122684079-26b4bf00-d223-11eb-8c39-5c143b4d8acb.jpg" height="500" width="260">
<img src="https://user-images.githubusercontent.com/73419211/122684081-274d5580-d223-11eb-807e-33c8e3e2e84a.jpg" height="500" width="260">
</p>

## 🤕 Support

If you get stuck anywhere, hop onto one of our [support channels in discord](https://discord.com/invite/GSeTUeA) and we'd be delighted to help you out 🤝


