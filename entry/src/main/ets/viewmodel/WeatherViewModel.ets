import WebConstants from '../common/constants/WebConstants'
import geoLocationManager from '@ohos.geoLocationManager';
import {useGet} from '../common/utils/HttpUtil'

interface weatherRes{
  weather: {id:string, main: string, description: string}[]
  main: {temp: Number, feels_like: Number, temp_min: Number, temp_max: Number, humidity: Number}
}

export async function getCurrentWeather() {
  try {
    let requestInfo = {'priority': geoLocationManager.LocationRequestPriority.ACCURACY, 'timeInterval': 0, 'distanceInterval': 0, 'maxAccuracy': 0};
    let locationChange = async (location) => {
      const res = await useGet<weatherRes, undefined>(WebConstants.SERVERLESS_API+`/weather?lat=${location.longitude}&${location.latitude}`)
      console.log('locationChanger: data: ' + JSON.stringify(location));
      console.log('weatherData:'+String(res.data))
      geoLocationManager.on('locationChange', requestInfo, locationChange);
      setTimeout(()=> {
        geoLocationManager.off('locationChange', locationChange);
      }, 2000)
    };
  } catch (err) {
    console.error("weatherData:" + err.code + ",errMessage:" + err.message);
  }
}