import WebConstants from '../common/constants/WebConstants'
import geoLocationManager from '@ohos.geoLocationManager';
import { useGet } from '../common/utils/HttpUtil'

interface weatherRes {
  weather: {
    id: string,
    main: string,
    description: string
  }[]
  main: {
    temp: Number,
    feels_like: Number,
    temp_min: Number,
    temp_max: Number,
    humidity: Number
  }
}

export async function getCurrentWeather() {
  console.log("weatherData undergoing")
  let requestInfo = {'priority': 0x203, 'scenario': 0x300,'maxAccuracy': 0};
  console.log("weatherData halo?")
  let locationChange = async (err,location) => {
    if (location) {
      const res = await useGet<weatherRes, undefined>(WebConstants.SERVERLESS_API + `/weather?lat=${location.latitude}&lon=${location.longitude}`)
      console.log('request:'+ WebConstants.SERVERLESS_API + `/weather?lat=${location.latitude}&&lon=${location.longitude}`)
      console.log('locationChanger: data: ' + JSON.stringify(location));
      console.log('weatherData:' + String(res))
    }
    if (err) {
      console.log("weatherData err!!!"+ err)
    }
  };

  try {
    console.log("weatherData try get location")
    geoLocationManager.getCurrentLocation(requestInfo, locationChange);
  } catch (err) {
    console.error("weatherDataerrCode:" + err.code + ",errMessage:" + err.message);
  }
  // catch (err) {
  //   console.error("weatherData:" + err.code + ",errMessage:" + err.message);
  // }
}