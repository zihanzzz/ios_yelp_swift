# Project 2 - *Yelp*

**Yelp** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

[Project Overview](OVERVIEW.md)

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Search results page
   - [x] Table rows should be dynamic height according to the content height.
   - [x] Custom cells should have the proper Auto Layout constraints.
   - [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [ ] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [ ] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [ ] The filters table should be organized into sections as in the mock.
   - [x] You can use the default UISwitch for on/off states.
   - [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results.
   - [x] Implement map view of restaurant results.
- [ ] Filter page
   - [ ] Implement a custom switch instead of the default UISwitch.
   - [ ] Distance filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [x] Implement the restaurant detail page.

The following **additional** features are implemented:

- [x] Use official Yelp color according to Yelp [guidelines](https://www.yelp.com/styleguide/color)
   - [x] Disabled NavBar translucency to make it look just like the real Yelp app.
- [x] Support Force Touch Peek and Pop on Business Cells.
   - [x] 3D Touch a cell and show a preview of the location in a map.
   - [x] Swipe up for options to switch to Apple Maps App or Google Maps App for navigation.
- [x] Search bar is not only local results filtering. When the user clicks on "Search", it triggers an API call and returns the relevant businesses matching what the user has typed.
- [x] Prompt user for location permission and base searches on user's current location instead of the default San Francisco.
- [x] Within the Map View, which shows all the restaurants as pins, user can select/highlight a pin and tap on the "little i" button to go to the detail page for that certain restaurant.


Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1.
2.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

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
