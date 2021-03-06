# Project 2 - *YelpLite*

**YelpLite** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

[Project Overview](OVERVIEW.md)

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Search results page
   - [x] Table rows should be dynamic height according to the content height.
   - [x] Custom cells should have the proper Auto Layout constraints.
   - [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [x] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [x] The filters table should be organized into sections as in the mock.
   - [x] You can use the default UISwitch for on/off states.
   - [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [x] Search results page
   - [x] Infinite scroll for restaurant results.
   - [x] Implement map view of restaurant results.
- [x] Filter page
   - [x] Implement a custom switch instead of the default UISwitch.
   - [x] Distance filter should expand as in the real Yelp app
   - [x] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [x] Implement the restaurant detail page.

The following **additional** features are implemented:

- [x] Support **Force Touch "Peek and Pop"** on Business Cells.
   - [x] 3D Touch a cell and see a preview of the location on a map.
   - [x] Swipe up for options of **deep-linking** to the following apps:
      - [x] 1. **Apple Maps** that shows the business as a destination
      - [x] 2. **Google Maps** that shows the business as a destination
      - [x] 3. **The real Yelp app** that shows the business directly
      - [x] 4. **Phone app** that allows the user to call the business directly
- [x] Search bar is not only local results filtering. When the user clicks on "Search", it triggers an API call and returns the relevant businesses matching what the user has typed.
- [x] Prompt user for **location permission** and base searches on user's current location instead of the default San Francisco.
- [x] Within the Map View, which shows all the restaurants as pins, user can select/highlight a pin and tap on the "little i" button to go to the detail page for that certain restaurant/business.
- [x] Improve user experience by showing a loading indicator when querying the Yelp API.
- [x] Improve user experience by adding expandable table rows for "Distance" and "Sort" by section.
- [x] Improve user experience by replacing all switched in the Filter page with [Badges](https://www.yelp.com/styleguide/illustrations#badges)
- [x] Use official Yelp color according to Yelp's [StyleGuide](https://www.yelp.com/styleguide/color)
   - [x] Disabled NavBar translucency to make it look just like the real Yelp app.
- [x] Customized UIFont across the app to better differentiate itself from the real Yelp App (hehe..)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I am not implementing the Map View like the real Yelp app does. Even though it's a horizontal flip animation, I am bring in a new view controller instead of a new view.
2. If I have more time, I can make my code structure look much better. There is a lot of code refactoring that could be done. It is not so convenient that XCode still doesn't support variable/function refactoring for Swift.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://github.com/zihanzzz/ios_yelp_swift/blob/master/YelpLite.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

1. This is my first time doing Auto-Layout using Storyboards. I have only worked with Masonry programatically before. I had to be really careful when adding constraints and it was really easy to make mistakes.
2. BusinessViewController and FiltersViewController are really logic intensive. In fact, a lot of code could be factored out.

## License

    Copyright [2016] [James Zhou]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
