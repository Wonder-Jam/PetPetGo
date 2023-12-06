import http from '@ohos.net.http';
import WebConstants, { ContentType, ErrorStatusText } from '../constants/WebConstants';

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

function useHttpRequest<ResponseData, RequestData extends object | undefined = undefined>(url: string, method: http.RequestMethod, params?: RequestData): Promise<Response<ResponseData>> {
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: method,
    readTimeout: WebConstants.HTTP_READ_TIMEOUT,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: WebConstants.HTTP_READ_TIMEOUT,
    extraData: params
  });
  let serverData: Response<ResponseData> = {
    code: '0',
    msg: 'default message',
    data: {} as ResponseData
  };
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === http.ResponseCode.OK) {
      let result = `${value.result}`;
      let resultJson: Response<ResponseData> = JSON.parse(result);
      serverData.data = resultJson.data;
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      throw new Error(value.responseCode.toString());
    }
    return serverData;
  }).catch((error: Error) => {
    console.error(error.name, error.message, error.stack)
    return serverData;
  });
}