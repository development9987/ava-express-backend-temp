class BaseService {
  generateKey(length) {
    let result = '';
    let characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';
    let charactersLength = characters.length;
    for (let i = 0; i < length; i++) {
      result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
  }

  successResponse(data) {
    return {
      ok: true,
      data: data,
    };
  }

  errorResponse(error) {
    return {
      ok: false,
      data: error,
    };
  }
}
module.exports = BaseService;
