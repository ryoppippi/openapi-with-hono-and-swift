# OpenAPI + Hono + swift-openapi-generator Example

https://github.com/ryoppippi/openapi-with-hono-and-swift/assets/1560508/5c5889e5-4946-48da-a2a2-4cd584707667

- [hono](https://hono.dev/)
- [zod-openapi hono middleware](https://github.com/honojs/middleware/tree/main/packages/zod-openapi)
- [swift-openapi-generator](https://github.com/apple/swift-openapi-generator)

## Setup
```sh
make setup
```

## Generate Schema
```sh
 cd backend
 pnpm run generate
```
You can use watch build so that you will get a tRPC-like experience between Swift <- -> TypeScript.

```sh
cd backend
pnpm run generate --watch
```

## Run

### backend
```sh
cd backend
pnpm run dev
```

### ios
```sh
make open
```
Then, run on Xcode.

## Authors

- Ryotaro "Justin" Kimura http://github.com/ryoppippi

## License
MIT
