const _ = require('lodash')
const vcap = JSON.parse(process.env.VCAP_APPLICATION || '{}')
const defaultUI = 'staging-ui-microservices-toolchain-20190116165744205.mybluemix.net' // for localhost
const uiServer = `http://${_.get(vcap, ['application_uris',0], defaultUI)}`
const catalogServer = uiServer.replace('ui-', 'catalog-api-')
const orderServer = uiServer.replace('ui-', 'orders-api-')
const bodyParser = require('body-parser');
global.microserviceUrls = { uiServer, catalogServer, orderServer }