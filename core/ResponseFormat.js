const ResponseFormat = {
  build: (object, message, statusCode, statusType) => {
    return {
      data: object,
      statusCode,
      message,
      statusType,
    };
  },
  error: (object, message, statusCode, statusType) => {
    return {
      error: object,
      statusCode,
      message,
      statusType,
    };
  },
};

module.exports = ResponseFormat;
