puppeteer = require('puppeteer');

(async () => {
  const delay = ms => new Promise(resolve => setTimeout(resolve, ms*1000));
  await delay(1);
  const timeout = delay(30);
  timeout.then(() => { throw new Error('timed out') });

  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  page.on('response', async response => {
    if (response.url().startsWith('https://meeting.tencent.com/web-service/query-download-info')) {
      downloadInfo = await response.json();
      for (const platformInfo of downloadInfo['info-list']) {
        if (platformInfo['platform'] == 'linux') {
          console.log(`wemeet_url=${platformInfo['url']}`);
          console.log(`wemeet_version=${platformInfo['version']}`);
          process.exit();
        }
      }
    }
  });

  await page.goto('https://meeting.tencent.com/download/');

  await page.setViewport({ width: 1080, height: 1024 });

  const linuxDownloadSelector = 'div.mt-download-card-mini.linux';
  await page.waitForSelector(linuxDownloadSelector);
  await page.click(linuxDownloadSelector);

  const downloadSelector = 'button.tea-btn';
  await page.waitForSelector(downloadSelector);
  const buttons = await page.$$(downloadSelector);
  // There should be 3 buttons with class names:
  // ['tea-btn tea-btn--icon', 'tea-btn', 'tea-btn tea-btn--weak']
  // The second one shoud be of x86_64.
  for (let button of buttons) {
    const name = await page.evaluate(e => e.className, button);
    if (name.split(' ').length == 1) {
      await button.click();
      break;
    }
  }

  await timeout;
})();