# Discover-Photo
An iOS photo discovery app using Unsplash API

## Requirements

- iOS 10.0 or later
- Xcode 10.2

## Problems

Assume that a user wants find some specific photos.

The user might want to search a keyword such as “food”, “lake”, “car”, etc.

The user could tap on a photo, and might want see more related photos about that photo.

## Solves

Put a search bar on top of the first view controller. Users can search keywords as soon as they want. The idea came from Pinterest.

Below the search bar put a waterfall layout collection view. Users can explore photos easily. Same spacing between cells. And rounded corner makes user comfortable.

When user scroll down. Collection view will load more contents.

Users can tap a photo and view it in larger size.

## Things I'm considering to do in the future

Add shadow to cells to make it feel 3D.

Show detail information and related photos after tap on a cell. I think related photos are important. Because it is easy to find a user's preference.

Add database and bookmark feature.

Get user's preference from bookmarks.

## Screenshots

![home.png](https://github.com/HackingGate/Discover-Photo/raw/master/screenshots/home.png)

![search.png](https://github.com/HackingGate/Discover-Photo/raw/master/screenshots/search.png)
