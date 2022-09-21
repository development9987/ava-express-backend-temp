module.exports = {
  openapi: '3.0.1',
  info: {
    version: '1.3.0',
    title: 'Cultbay',
    description: 'Cultbay API',
  },
  servers: [
    {
      url: 'http://localhost:8000/',
      description: 'Local server',
    },
    {
      url: 'http://95.217.236.14:8000/',
      description: 'Testing server',
    },
    {
      url: 'http://95.217.236.14:8000/',
      description: 'Production server',
    },
  ],

  // securityDefinitions: {
  //   Bearer: {
  //     type: "apiKey",
  //     name: "Authorization",
  //     in: "header"
  //   },
  //   JWT: {
  //     type: "apiKey",
  //     name: "token",
  //     in: "header"
  //   }
  // },
  security: [
    {
      ApiKeyAuth: [],
    },
  ],
  tags: [
    {
      name: 'Auth',
      description: 'authentication functions',
    },
  ],
  paths: {
    '/auth/signin': {
      post: {
        tags: ['Auth'],
        summary: '',
        description: '',
        operationId: 'signin',
        consumes: ['application/json'],
        produces: ['application/json'],
        requestBody: {
          content: {
            'application/json': {
              schema: {
                $ref: '#/definitions/auth/signin',
              },
            },
          },
          required: true,
        },

        responses: {
          200: {
            description:
              "result: true/signin success, result: false/ status: 1 => 'This email does not exist', status: 2 => 'Password is wrong'",
          },
          400: {
            description: 'Invalid input',
          },
        },
      },
    },
    '/auth/signup': {
      post: {
        tags: ['Auth'],
        summary: '',
        description: '',
        operationId: 'signup',
        consumes: ['application/json'],
        produces: ['application/json'],
        requestBody: {
          content: {
            'application/json': {
              schema: {
                $ref: '#/definitions/auth/signup',
              },
            },
          },
          required: true,
        },
        responses: {
          200: {
            description:
              "result: true/User Create Successfully, result: false/ status: 1 => 'This email is already used'",
          },
          400: {
            description: 'Invalid input',
          },
        },
      },
    },
    '/auth/resend': {
      post: {
        tags: ['Auth'],
        summary: '',
        description: '',
        operationId: 'resend',
        consumes: ['application/json'],
        produces: ['application/json'],
        requestBody: {
          content: {
            'application/json': {
              schema: {
                $ref: '#/definitions/auth/resend',
              },
            },
          },
          required: true,
        },
        security: [
          {
            bearerAuth: [],
          },
        ],
        responses: {
          400: {
            description: 'Invalid input',
          },
        },
      },
    },
    '/auth/confirm/{token}': {
      get: {
        tags: ['Auth'],
        summary: '',
        description: '',
        operationId: 'confirm/token',
        consumes: ['application/json'],
        produces: ['application/json'],
        parameters: [
          {
            in: 'path',
            name: 'token',
            required: false,
            type: 'string',
          },
        ],
        responses: {
          400: {
            description: 'Invalid input',
          },
        },
      },
    },
    '/auth/forgot': {
      post: {
        tags: ['Auth'],
        summary: '',
        description: '',
        operationId: 'forgot',
        consumes: ['application/json'],
        produces: ['application/json'],
        requestBody: {
          content: {
            'application/json': {
              schema: {
                $ref: '#/definitions/auth/forgot',
              },
            },
          },
          required: true,
        },
        responses: {
          400: {
            description: 'Invalid input',
          },
        },
      },
    },
    '/auth/reset': {
      post: {
        tags: ['Auth'],
        summary: '',
        description: '',
        operationId: 'reset',
        consumes: ['application/json'],
        produces: ['application/json'],
        requestBody: {
          content: {
            'application/json': {
              schema: {
                $ref: '#/definitions/auth/reset',
              },
            },
          },
          required: true,
        },
        responses: {
          400: {
            description: 'Invalid input',
          },
        },
      },
    },
    '/auth/reset/{token}': {
      get: {
        tags: ['Auth'],
        summary: '',
        description: '',
        operationId: 'reset/token',
        consumes: ['application/json'],
        produces: ['application/json'],
        parameters: [
          {
            in: 'path',
            name: 'token',
            required: false,
            type: 'string',
          },
        ],
        responses: {
          400: {
            description: 'Invalid input',
          },
        },
      },
    },
  },

  definitions: {
    auth: {
      signin: {
        type: 'object',
        properties: {
          email: {
            type: 'string',
          },
          password: {
            type: 'string',
          },
        },
      },
      signup: {
        type: 'object',
        properties: {
          name: {
            type: 'string',
          },
          email: {
            type: 'string',
          },
          password: {
            type: 'string',
          },
        },
      },
      resend: {
        type: 'object',
        properties: {
          email: {
            type: 'string',
          },
          name: {
            type: 'string',
          },
          id: {
            type: 'integer',
            format: 'int64',
          },
        },
      },
      reset: {
        type: 'object',
        properties: {
          password: {
            type: 'string',
          },
        },
      },
      forgot: {
        type: 'object',
        properties: {
          email: {
            type: 'string',
          },
        },
      },
    },
  },
  components: {
    securitySchemes: {
      bearerAuth: {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
      },
    },
  },
};
