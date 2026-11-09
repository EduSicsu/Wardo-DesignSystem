import {test,expect} from '@playwright/test';
import {mkdir} from 'node:fs/promises';
import AxeBuilder from '@axe-core/playwright';
test('all six example screens load their artwork and retain responsive bounds',async({page},testInfo)=>{
 await page.goto('/examples');await expect(page.getByRole('heading',{name:'Wardo example screens'})).toBeVisible();
 for(const screen of ['upcoming-mobile','upcoming-web','reviews-mobile','reviews-web','messaging-mobile','messaging-web']){
  await page.getByLabel('Example screen').selectOption(screen);await expect(page.locator('.wardo-example')).toBeVisible();await page.locator('.wardo-example img').first().waitFor();
  await expect.poll(()=>page.locator('.wardo-example img').evaluateAll(images=>images.every(image=>(image as HTMLImageElement).complete&&(image as HTMLImageElement).naturalWidth>0))).toBe(true);
  expect(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth)).toBe(true);
  if(testInfo.project.name==='desktop'){await page.evaluate(()=>document.fonts.ready);await mkdir('coverage/previews/web',{recursive:true});await page.locator('.wardo-example').screenshot({path:`coverage/previews/web/${screen}.png`});}
 }
});
test('example saves, message sending and conversation search update state',async({page})=>{
 await page.goto('/examples');await page.getByLabel('Example screen').selectOption('reviews-mobile');
 await page.getByRole('button',{name:'Save Morning Bakes',exact:true}).click();await expect(page.getByRole('button',{name:'Unsave Morning Bakes',exact:true})).toHaveAttribute('aria-pressed','true');
 await page.getByLabel('Example screen').selectOption('messaging-mobile');await page.getByRole('button',{name:'7 works',exact:true}).click();await expect(page.getByRole('log')).toContainText('7 works');
 await page.getByLabel('Message',{exact:true}).fill('See you at the market');await page.getByRole('button',{name:'Send',exact:true}).click();await expect(page.getByRole('log')).toContainText('See you at the market');
 await page.getByRole('button',{name:'Search conversation'}).click();await page.getByRole('searchbox',{name:'Search messages'}).fill('market');await expect(page.getByRole('log')).not.toContainText('Friday is free!');await expect(page.getByRole('log')).toContainText('See you at the market');
 const result=await new AxeBuilder({page}).withTags(['wcag2a','wcag2aa','wcag21aa']).analyze();expect(result.violations.map(v=>({id:v.id,nodes:v.nodes.map(n=>n.target)}))).toEqual([]);
});
