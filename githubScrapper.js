const puppeteer = require('puppeteer');
const rootUrl = "https://github.com/";
const username = "webstain";
const counterXpath = '//*[@id="js-pjax-container"]/div[2]/div/div[2]/div[1]/nav/a[2]/span'
//const username = window.prompt("Enter github username: ");

async function scrapeGithubRepos(url){
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto(url);

    const [Counter] = await page.$x(counterXpath);
    const CounterTxt = await Counter.getProperty('textContent');
    const reposCpt = await CounterTxt.jsonValue();

    let repos = [];

    for(let i=1; i<=reposCpt; i++){
        let repository = new Object();
        const [repo] = await page.$x(`//*[@id="user-repositories-list"]/ul/li[${i}]/div[1]/div[1]/h3/a`);
        const repoTxt= await repo.getProperty('textContent');
        const repoTitle = await repoTxt.jsonValue();
        /*
        const [programmingLang] =  await page.$x(`*[@id="user-repositories-list"]/ul/li[${i}]/div[1]/div[4]/span/span[2]`);
        const programmingLanguageTxt= await programmingLang.getProperty('textContent');
        const programmingLanguage = await programmingLanguageTxt.jsonValue();
        const [description] =  await page.$x(`//*[@id="user-repositories-list"]/ul/li[${i}]/div[1]/div[2]/p`); 
        const descriptionTxt= await description.getProperty('textContent');
        const repoDescription = await descriptionTxt.jsonValue();
        */

        repository.title = repoTitle.trim();
        //repository.programmingLanguage = programmingLang;
        //repository.description = repoDescription;

        repos.push(repository)
    }
   console.log(repos);
   browser.close();

}

scrapeGithubRepos(`${rootUrl}${username}?tab=repositories`)