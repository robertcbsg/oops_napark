# README

### Install dependencies
  1. run `bundle install`
  2. run `yarn install`

### Initialize database
  1. `rails db:migrate`
  2. `rails db:seed`

### Deployment instructions
  1. run `bin/dev`
  2. go to `http://localhost:3000/` to access the home page

## User Guide

### Welcome to OOPs Parking!
  1. To park and assign a vehicle a parking slot, input the parking entrance name, vehicle's plate number and size, then click submit.
  ![image](https://github.com/robertcbsg/oops_parking/assets/125743601/3f0a4b28-f3ab-4bda-8f16-51d282a76c75)
  2. Refresh the page and the generated parking slips will be displayed
  ![image](https://github.com/robertcbsg/oops_parking/assets/125743601/117b331e-df29-4221-a4c7-18d2653c5ba7)
  3. To unpark a vehicle, in the outgoing form simply input the parking slip id and click submit. The parking fee will be displayed.
  ![image](https://github.com/robertcbsg/oops_parking/assets/125743601/0a3c1dba-bdf4-4860-9118-fce5d97ecf0b)

### Building the Parking Lot

For admin actions, such as adding entry points and setting up the parking lot map, we can access the API.
1. To setup the Parking Lot, let's add the entry points first. 
POST | `/api/v1/parking/entry_points`
```
{
    "entry_points": [
        {
           "name": "Seventh exit"
        },
        {
           "name": "8th park ave."
        }
    ]
}
```
2. Afterwards, we can setup the Parking Slots
POST | `/api/v1/parking/slots`
```
{
    "size": "SP",
    "distance_from_entries": [
        {
            "name": "north exit",
            "distance": 1
        },
        {
            "name": "west exit",
            "distance": 4
        },
        {
            "name": "Southwest exit",
            "distance": 2
        }
    ]
}
```

At this point we should be set to go, but another thing to note is the 'clock' mechanic.
For demo purposes, the time is manually set, as this'll also help to test several scenarios faster.
1. To "move" time forward, simply hit the clock api
POST | `/api/v1/clock`
```
{
    "hours": 0,
    "minutes": 1
}
```
