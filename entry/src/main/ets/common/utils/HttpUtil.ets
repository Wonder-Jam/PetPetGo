import http from '@ohos.net.http';
import ResponseResult from '../bean/ResponseResult';
import WebConstants, { ContentType, ErrorStatusText } from '../constants/WebConstants';


export function useGet(url: string) {
  return useHttpRequest(url, http.RequestMethod.GET);
}

export function usePost<RequestData>(url: string, params: RequestData) {
  return useHttpRequest<RequestData>(url, http.RequestMethod.POST, params)
}

function useHttpRequest<RequestData>(url: string, method: http.RequestMethod, params?: RequestData): Promise<ResponseResult> {
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
  let serverData = new ResponseResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === http.ResponseCode.OK) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      // if (resultJson.code === WebConstants.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      // } else {
      //   serverData.data = 'error';
      // }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      throw new Error(value.responseCode.toString());
    }
    return serverData;
  }).catch((value: http.ResponseCode) => {
    serverData.msg = `${ErrorStatusText[value]}&${value}`;
    return serverData;
  });
}