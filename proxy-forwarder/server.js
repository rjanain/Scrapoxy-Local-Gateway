const ProxyChain = require('proxy-chain');

const PORT = process.env.PORT || 8890;
const UPSTREAM_HOST = process.env.UPSTREAM_HOST || 'scrapoxy';
const UPSTREAM_PORT = process.env.UPSTREAM_PORT || 8888;
const UPSTREAM_USERNAME = process.env.UPSTREAM_USERNAME;
const UPSTREAM_PASSWORD = process.env.UPSTREAM_PASSWORD;

if (!UPSTREAM_USERNAME || !UPSTREAM_PASSWORD) {
    console.warn("WARNING: UPSTREAM_USERNAME or UPSTREAM_PASSWORD not set. Forwarding without auth.");
}

// Construct upstream URL
// Format: http://username:password@host:port
let upstreamProxyUrl = `http://${UPSTREAM_HOST}:${UPSTREAM_PORT}`;
if (UPSTREAM_USERNAME && UPSTREAM_PASSWORD) {
    upstreamProxyUrl = `http://${encodeURIComponent(UPSTREAM_USERNAME)}:${encodeURIComponent(UPSTREAM_PASSWORD)}@${UPSTREAM_HOST}:${UPSTREAM_PORT}`;
}

console.log(`Starting No-Auth Proxy on port ${PORT}`);
console.log(`Forwarding to: ${UPSTREAM_HOST}:${UPSTREAM_PORT}`);

const server = new ProxyChain.Server({
    port: PORT,
    verbose: true,
    prepareRequestFunction: ({ request, username, password, hostname, port, isHttp, connectionId }) => {
        return {
            upstreamProxyUrl: upstreamProxyUrl,
        };
    },
});

server.listen(() => {
    console.log(`Proxy server is listening on port ${server.port}`);
});
