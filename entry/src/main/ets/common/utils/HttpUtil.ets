import http from '@ohos.net.http';
import WebConstants, { ContentType, ErrorStatusText } from '../constants/WebConstants';
import PreferencesUtils from '../utils/PreferencesUtils'
import router from '@ohos.router';

export interface Response<T> {
  code: string;
  msg: string | Resource;
  data: T;
}

export function useGet<ResponseData, RequestData extends object | undefined = undefined>(url: string) {
  return useHttpRequest<ResponseData, RequestData>(url, http.RequestMethod.GET);
}

export function usePost<ResponseData, RequestData extends object | undefined = undefined>(url: string, params: RequestData) {
  return useHttpRequest<ResponseData, RequestData>(url, http.RequestMethod.POST, params)
}

async function useHttpRequest<ResponseData, RequestData extends object | undefined = undefined>(url: string, method: http.RequestMethod, params?: RequestData): Promise<Response<ResponseData>> {
  console.log('httputil start')
  let token = await PreferencesUtils.preferencesGet("Token")
  console.log('httputil gettoken', token)
  let httpRequest = http.createHttp();
  let serverData: Response<ResponseData> = {
    code: '-1', // 默认的code不要用0，否则当请求失败时，外部的页面会因为code===0以为请求成功，进行赋值导致程序崩溃
    msg: 'default message',
    data: {} as ResponseData
  };
  let responseResult = httpRequest.request(url, {
    method: method,
    readTimeout: WebConstants.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON,
      'Authorization': 'Bearer ' + (token==='default' ? '':token)
    },
    connectTimeout: WebConstants.HTTP_READ_TIMEOUT,
    extraData: params
  }).catch((error: Error) => {
    // 请求本身也可能不合法（比如url不合法），需要catch
    console.log('httputil error received!' + error.message)
    console.error(error.name, error.message, error.stack)
    return serverData;
  });
  console.log('httputil request sent!')
  return responseResult.then(async (value: http.HttpResponse) => {
    console.log('httputil request received!')

    let isTokenInvalid: boolean = true;
    isTokenInvalid = value.responseCode === http.ResponseCode.UNAUTHORIZED
    if (value.responseCode === http.ResponseCode.OK) {
      let result = `${value.result}`;
      let resultJson: Response<ResponseData> = JSON.parse(result);
      Object.entries(value.header).forEach(([key, value]) => {
        console.log(`httputil: ${key}: ${value}`);
      });
      if ('x-set-cookie' in value.header) {
        console.log('httputil: save token'+ value.header['x-set-cookie'])
        await PreferencesUtils.preferencesPut('Token', value.header['x-set-cookie'])
      }
      serverData.data = resultJson.data;
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      throw new Error(value.responseCode.toString());
    }
    if (isTokenInvalid) {
      console.log('httputil: try redirect to login')
      router.pushUrl({
        url: 'pages/LoginPage'
      })
      return serverData; // todo 中断请求的逻辑可能有问题
    }
    return serverData;
  }).catch((error: Error) => {
    console.log('httputil error received!' + error.message)
    console.error(error.name, error.message, error.stack)
    return serverData;
  });
}