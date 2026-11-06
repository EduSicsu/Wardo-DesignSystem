import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
test('library loads, themes change, keyboard disclosures and forms work',async({page})=>{
 const errors:string[]=[];page.on('pageerror',e=>errors.push(e.message));
 await page.emulateMedia({reducedMotion:'reduce'});await page.goto('/');await expect(page).toHaveTitle('Wardo — Component library');await expect(page.getByRole('heading',{level:1})).toBeVisible();
 const before=await page.locator('.preview').evaluate(el=>getComputedStyle(el).backgroundColor);
 await page.getByLabel('Color theme').selectOption('Wardo Dark');const after=await page.locator('.preview').evaluate(el=>getComputedStyle(el).backgroundColor);expect(before).not.toBe(after);
 await page.getByLabel('Color theme').selectOption('Wardo Light');
 await page.getByRole('button',{name:'Favorites',exact:true}).click();await expect(page.getByRole('button',{name:'Favorites',exact:true})).toHaveAttribute('aria-pressed','true');
 await page.getByLabel('Password',{exact:true}).fill('correct-horse');await page.getByRole('button',{name:'Show password'}).click();await expect(page.getByLabel('Password',{exact:true})).toHaveAttribute('type','text');
 const trigger=page.getByRole('button',{name:'How do themes work?'});await trigger.focus();await page.keyboard.press('Enter');await expect(trigger).toHaveAttribute('aria-expanded','true');await expect(page.getByRole('button',{name:'What is Wardo?'})).toHaveAttribute('aria-expanded','false');
 const toggle=page.getByRole('switch',{name:/Email updates/});await toggle.focus();await page.keyboard.press('Space');await expect(toggle).not.toBeChecked();
 await page.getByLabel('Your name').fill('Alex Morgan');await page.getByLabel('Email address').fill('alex@example.com');await page.getByRole('button',{name:'Save preferences'}).click();await expect(page.getByRole('status')).toHaveText('Preferences saved');
 expect(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth)).toBe(true);
 expect(errors).toEqual([]);
});
test('WCAG automated checks pass in light and dark themes',async({page})=>{
 await page.emulateMedia({reducedMotion:'reduce'});await page.goto('/');for(const theme of ['Wardo Light','Wardo Dark','Ocean Light','Ocean Dark','Orchid Light','Orchid Dark','Ember Light','Ember Dark','Cloud Light','Cloud Dark']){
 await page.getByLabel('Color theme').selectOption(theme);
 const results=await new AxeBuilder({page}).withTags(['wcag2a','wcag2aa','wcag21aa']).analyze();
 expect(results.violations,`${theme}: ${JSON.stringify(results.violations.map(v=>({id:v.id,nodes:v.nodes.map(n=>n.target)})))}`).toEqual([]);
 }
});
