const puppeteer = require('puppeteer');

async function run() {
  console.log('Launching browser...');
  const browser = await puppeteer.launch({
    headless: 'new', // Use new headless mode
    args: ['--no-sandbox', '--disable-setuid-sandbox'], // Common for Docker
  });

  console.log('Creating new page...');
  const page = await browser.newPage();

  console.log('Navigating to Google...');
  await page.goto('https://www.google.com');

  console.log('Taking screenshot...');
  await page.screenshot({ path: 'screenshot.png' });

  console.log('Closing browser...');
  await browser.close();

  console.log('Done!');
}

run().catch(console.error);
