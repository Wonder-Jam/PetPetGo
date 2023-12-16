export enum ErrorStatus {
  NETWORK = -1,
  UNKNOWN = 0,
  PAGE_NOT_FOUND = 404,
  GATEWAY_TIMEOUT = 504,
}

export const ErrorStatusText = {
  [ErrorStatus.NETWORK]: '网络异常',
  [ErrorStatus.UNKNOWN]: '未知错误',
  [ErrorStatus.PAGE_NOT_FOUND]: '网页找不到了',
  [ErrorStatus.GATEWAY_TIMEOUT]: '网络异常',
}

/**
 * The request method enum.
 */
export const enum RequestMethod {
  POST = 'POST',
  GET = 'GET'
}

/**
 * The request content type enum.
 */
export const enum ContentType {
  JSON = 'application/json',
  FORM = 'multipart/form-data'
}

export default class WebConstants {
  /**
   * The http timeout duration.
   */
  static readonly HTTP_READ_TIMEOUT: number = 10000;
  /**
   * The request success status code.
   */
  static readonly SERVER_CODE_SUCCESS: string = 'success';
  /**
   * Http request success status code.
   */
  static readonly HTTP_CODE_200: number = 200;

  static readonly TEST_ENVIRONMENT: string = 'http://124.70.78.16:18000/api/v1'
}