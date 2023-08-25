import app from '.'
import * as fs from 'fs';

async function main(){
const res = await app.request('/doc')
const text = await res.text()

fs.writeFileSync(`./openapi-docs.yaml`, text, {
  encoding: 'utf-8',
});
}
main()
