# firebase_cloud_messaging

A new Flutter project.

## Getting Started
Package List :

Firebase Core,
firebase Messaging
Local Notification
Foreground : When the application is open, in view, and in use.

FirebaseMessaging.onMessage.listen((message) {
print('i am message');
if (message.notification != null) {
print(message.notification!.body);
print(message.notification!.title);
} else {
print(message);
}
NotificationService.display(message);
});

Background : When the application is open, but in the background (minimized). This typically occurs when the user has pressed the "home" button on the device, has switched to another app using the app switcher, or has the application open in a different tab (web).

FirebaseMessaging.onMessageOpenedApp.listen((message) {
NotificationService.display(message);
});

Terminated : When the device is locked or the application is not running.

Future backgroundHandler(RemoteMessage message) async {
NotificationService.display(message);
print(message.data.toString());
print(message.notification!.title);
}
