require 'rails_helper'

RSpec.describe Forecast do
  before(:each) do
    @data = { current: {
        dt: 1632692756,
        sunrise: 1632660694,
        sunset: 1632703840,
        temp: 83.88,
        feels_like: 81.01,
        pressure: 1008,
        humidity: 12,
        visibility: 10000,
        weather: [
            {
                description: "broken clouds",
                icon: "04d"
            }
        ]
    },
    hourly: [
        {
          dt: 1632690000,
          temp: 84.7,
          weather: [
            {
              description: "broken clouds",
              icon: "04d"
            }
          ]
        },
        {
          dt: 1632693600,
          temp: 84.7,
          weather: [
            {
              description: "broken clouds",
              icon: "04d"
            }
          ]
        },
        {
          dt: 1632690000,
          temp: 84.7,
          weather: [
            {
              description: "broken clouds",
              icon: "04d"
            }
          ]
        },
        {
          dt: 1632693600,
          temp: 84.7,
          weather: [
            {
              description: "broken clouds",
              icon: "04d"
            }
          ]
        },
        {
          dt: 1632690000,
          temp: 84.7,
          weather: [
            {
              description: "broken clouds",
              icon: "04d"
            }
          ]
        },
        {
          dt: 1632693600,
          temp: 84.7,
          weather: [
            {
              description: "broken clouds",
              icon: "04d"
            }
          ]
        },
        {
          dt: 1632690000,
          temp: 84.7,
          weather: [
            {
              description: "broken clouds",
              icon: "04d"
            }
          ]
        },
        {
          dt: 1632693600,
          temp: 84.7,
          weather: [
            {
              description: "broken clouds",
              icon: "04d"
            }
          ]
        }
      ],
    daily: [
        {
          dt: 1632692756,
          sunrise: 1632660694,
          sunset: 1632703840,
            temp: {
                min: 57.31,
                max: 77.9,
            },
            weather: [
                {
                    description: "few clouds",
                    icon: "02d"
                }
            ]
        },
        {
          dt: 1632692756,
          sunrise: 1632660694,
          sunset: 1632703840,
          temp: {
              min: 55.71,
              max: 74.05,
          },
          weather: [
              {
                description: "broken clouds",
                icon: "04d"
              }
          ]
        },
        {
          dt: 1632692756,
          sunrise: 1632660694,
          sunset: 1632703840,
          temp: {
            min: 57.31,
            max: 77.9,
          },
          weather: [
              {
                description: "few clouds",
                icon: "02d"
              }
            ]
        },
        {
          dt: 1632692756,
          sunrise: 1632660694,
          sunset: 1632703840,
          temp: {
            min: 55.71,
            max: 74.05,
          },
          weather: [
              {
                description: "broken clouds",
                icon: "04d"
              }
            ]
        },
        {
          dt: 1632692756,
          sunrise: 1632660694,
          sunset: 1632703840,
          temp: {
            min: 55.71,
            max: 74.05,
          },
          weather: [
              {
                description: "broken clouds",
                icon: "04d"
              }
            ]
        }
    ]
  }
    @forecast = Forecast.new(@data)
  end

  it 'can hash current weather' do
    expected = {
      datetime: '2021-09-26 14:45:56 -0700',
      sunrise: '2021-09-26 05:51:34 -0700',
      sunset: '2021-09-26 17:50:40 -0700',
      temperature: 83.88,
      feels_like: 81.01,
      humidity: 12.0,
      visibility: 10000.0,
      conditions: 'broken clouds',
      icon: '04d',
    }

    expect(@forecast.current(@data[:current])).to eq(expected)
  end

  it 'can create array of 5 days of weather' do
    expected = [
    {
      datetime: '2021-09-26 14:45:56 -0700',
      sunrise: '2021-09-26 05:51:34 -0700',
      sunset: '2021-09-26 17:50:40 -0700',
      min_temp: 57.31,
      max_temp: 77.9,
      conditions: "few clouds",
      icon: "02d",
    },
    {
      datetime: '2021-09-26 14:45:56 -0700',
      sunrise: '2021-09-26 05:51:34 -0700',
      sunset: '2021-09-26 17:50:40 -0700',
      min_temp: 55.71,
      max_temp: 74.05,
      conditions: 'broken clouds',
      icon: '04d',
    },
    {
      datetime: '2021-09-26 14:45:56 -0700',
      sunrise: '2021-09-26 05:51:34 -0700',
      sunset: '2021-09-26 17:50:40 -0700',
      min_temp: 57.31,
      max_temp: 77.9,
      conditions: "few clouds",
      icon: "02d",
    },
    {
      datetime: '2021-09-26 14:45:56 -0700',
      sunrise: '2021-09-26 05:51:34 -0700',
      sunset: '2021-09-26 17:50:40 -0700',
      min_temp: 55.71,
      max_temp: 74.05,
      conditions: 'broken clouds',
      icon: '04d',
    },
    {
      datetime: '2021-09-26 14:45:56 -0700',
      sunrise: '2021-09-26 05:51:34 -0700',
      sunset: '2021-09-26 17:50:40 -0700',
      min_temp: 55.71,
      max_temp: 74.05,
      conditions: 'broken clouds',
      icon: '04d',
    }]
    expect(@forecast.daily(@data[:daily]).length).to eq(5)
    expect(@forecast.daily(@data[:daily])).to eq(expected)
  end

  it 'can create array of 8 hours of weather' do
    expected = [
      {
        datetime: '2021-09-26 14:00:00 -0700',
        temperature: 84.7,
        conditions: "broken clouds",
        icon: "04d"
      },
      {
        datetime: '2021-09-26 15:00:00 -0700',
        temperature: 84.7,
        conditions: "broken clouds",
        icon: "04d"
      },
      {
        datetime: '2021-09-26 14:00:00 -0700',
        temperature: 84.7,
        conditions: "broken clouds",
        icon: "04d"
      },
      {
        datetime: '2021-09-26 15:00:00 -0700',
        temperature: 84.7,
        conditions: "broken clouds",
        icon: "04d"
      },
      {
        datetime: '2021-09-26 14:00:00 -0700',
        temperature: 84.7,
        conditions: "broken clouds",
        icon: "04d"
      },
      {
        datetime: '2021-09-26 15:00:00 -0700',
        temperature: 84.7,
        conditions: "broken clouds",
        icon: "04d"
      },
      {
        datetime: '2021-09-26 14:00:00 -0700',
        temperature: 84.7,
        conditions: "broken clouds",
        icon: "04d"
      },
      {
        datetime: '2021-09-26 15:00:00 -0700',
        temperature: 84.7,
        conditions: "broken clouds",
        icon: "04d"
      }
    ]

    expect(@forecast.hourly(@data[:hourly])).to eq(expected)
    expect(@forecast.hourly(@data[:hourly]).length).to eq(8)
  end
end
