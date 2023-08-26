import { z ,createRoute,OpenAPIHono} from '@hono/zod-openapi'
import YAML from 'js-yaml'

import type {MiddlewareHandler}from 'hono'

const app = new OpenAPIHono()

const ParamsSchema = z.object({
  id: z
    .string()
    .min(3)
    .openapi({
      param: {
        name: 'id',
        in: 'path',
      },
      example: '1212121',
    }),
})

const UserSchema = z
  .object({
    id: z.string().openapi({
      example: '123',
    }),
    name: z.string().openapi({
      example: 'John Doe',
    }),
    age: z.number().openapi({
      example: 42,
    }),
  })
  .openapi('User')

const ErrorSchema = z.object({
  code: z.number().openapi({
    example: 400,
  }),
  message: z.string().openapi({
    example: 'Bad Request',
  }),
})

const route = createRoute({
  method: 'get',
  path: '/users/{id}',
  request: {
    params: ParamsSchema,
  },
  responses: {
    200: {
      content: {
        'application/json': {
          schema: UserSchema,
        },
      },
      description: 'Retrieve the user',
    },
    400: {
      content: {
        'application/json': {
          schema: ErrorSchema,
        },
      },
      description: 'Returns an error',
    },
  },
})


app.openapi(route, (c) => {
    const { id } = c.req.valid('param')
    return c.jsonT({
      id,
      age: 20,
      name: 'Ultra-man',
    })
  },
  (result, c) => {
    if (!result.success) {
      return c.jsonT(
        {
          code: 400,
          message: 'Validation Error',
        },
        400
      )
    }
  }
)

// The OpenAPI documentation will be available at /doc
app.use('/doc/*',(async(c,next)=>{
  await next()

  const yamlParam = c.req.query('yaml')
  if (yamlParam != null ) {
    const obj = await c.res.json()
    const yaml = YAML.dump(obj)
    c.res = new Response(yaml ,c.res)
  }
})satisfies MiddlewareHandler )

app.doc('/doc', {
  openapi: '3.0.0',
  info: {
    version: '1.0.0',
    title: 'My API',
  },
  servers: [{
    url:'http://127.0.0.1:8787',
    description:'Local server'
  }],
})

export default app
