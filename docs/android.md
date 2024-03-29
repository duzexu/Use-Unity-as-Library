## Integrating Unity as a library into standard Android app
This document explains how to include Unity as a Library into standard Android application through Activity. You can read more about Unity as a Library.

**Requirements:**
- Android Studio 3.4.2+
- Unity version 2019.3.0b4+

**1. Get source**
- Clone or Download GitHub repo [uaal-example](https://github.com/Unity-Technologies/uaal-example). It includes:
  <br><img src="images/android/rootFolderStructure.png">
  - Unityproject - this is a simple demo project made with Unity which will be integrated to the standard Android application
  - NativeAndroidApp - this is the Basic Activity application from Android Studio templates where Unity project will be integrated. It has a simple UI, MainUnityActivity, which extends OverrideUnityActivity, and is prepared to start MainUnityActivity with an Intent 

**2. Generate Gradle project for Android platform**
- Open UnityProject in Unity Editor
- Go to Build Settings window (Menu / File / Build Settings)
  - Select and switch to Android Platform
  - Select option “Export Project” 
    <br><img src="images/android/exportProject.png" width='400px'>
  - Export UnityProject to androidBuild folder, the folder structure should look like this:
    <br><img src="images/android/exportedProjectFolder.png">
    
**3. Add Unity Library module to NativeAndroidApp**
<br>Do the following to add the exported androidBuild/unityLibrary module to the NativeAndroidApp Gradle project in Android Studio:
- Open NativeAndroidApp in Android Studio
- Open settings.gradle file
  - Add a new project pointing to unityLibrary module at the end of the file: 
  ```
  include ':unityLibrary'
  project(':unityLibrary').projectDir=new File('..\\UnityProject\\androidBuild\\unityLibrary')
  ```
  <img src="images/android/settingsGradle.png">
- Open build.gradle(Module: app) file
  - Add the following in dependencies{ block
  ```
  implementation project(':unityLibrary')
  implementation fileTree(dir: project(':unityLibrary').getProjectDir().toString() + ('\\libs'), include: ['*.jar'])
  ```
  <img src="images/android/buildGradleApp.png">
- Open build.gradle(Project: NativeAndroidApp) file
  - Add the following in allprojects{repositories{ block
  ```
  flatDir {
    dirs "${project(':unityLibrary').projectDir}/libs"
  }
  ```
  <img src="images/android/buildGradleNativeApp.png">
  
>  For project exported by Unity 2020+ , you must add `unityStreamingAssets` key to file gradle.properties
> ```
> unityStreamingAssets=.unity3d
> ```

- Click Sync Now to do a project sync since Gradle files have been modified
  <img src="images/android/syncGradle.png">
- If everything succeeds, you should see unityLibrary module added in Android view
  <img src="images/android/unityLibraryModule.png">
  
> If have 'NDK is not installed' error, you must specify NDK version
> - Open build.gradle(Project: NativeAndroidApp:unityLibrary) file
> - Add the following in android{ block }
> ```
> ndkVersion "xx.x.xxxx"
> ```

## Project is ready
Everything is ready to build, run and debug:
<br><img src="images/android/buildOnDevice.png" width='500px'>
<br>If everything succeeded, at this point you should be able to run NativeAndroidApp:

Main Activity | Unity Activity
------------ | -------------
<img src="images/android/appNativeSS.png" > | <img src="images/android/appUnitySS.png" height='800px'>
Main Activity | Unity is loaded and is running in a separate Activity. Light grey buttons in the middle are added from the MainUnityActivity implemented in NativeAndroidApp

## Notes
- Unity is running in another process android:process=":Unity" (AndroidManifest.xml at app module)
- After installation there will be two icons added on the device. To leave only the icon of the main activity, remove <intent-filter>...</intent-filter> from the AndroidManifest.xml in unityLibrary
- (Optional) We found some Android 7.* devices set frontOfTask to wrong state for activities as a result when finishing/quitting Unity activity whole task goes to background instead of bringing back Main activity. Next workaround keeps expected behavior: add to MainUnityActivity.java from NativeAndroidApp
  ```
  @Override public void onUnityPlayerQuitted() { showMainActivity(""); finish(); }
  ```
