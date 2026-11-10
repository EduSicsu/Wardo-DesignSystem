import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

test('compact navigation search preserves geometry, app state and keyboard focus',async({page},testInfo)=>{
 const errors:string[]=[];page.on('pageerror',error=>errors.push(error.message));page.on('console',message=>{if(message.type()==='error')errors.push(message.text());});
 await page.goto('/search-fields');await expect(page).toHaveTitle('Wardo — Component library');
 await expect(page.getByRole('heading',{name:'Search field examples'})).toBeVisible();
 const input=page.getByRole('searchbox',{name:'Search navigation'});
 const chrome=page.locator('.wardo-search--navigation .wardo-field-control');
 const searchIcon=chrome.locator('[data-artwork-icon="input-search"]');
 const clearIcon=chrome.locator('[data-artwork-icon="input-clear"]');
 const clear=page.getByRole('button',{name:'Clear search'});
 await expect(input).toHaveValue('Ceramics');
 expect(await page.locator('.wardo-search--navigation > label').evaluate(el=>getComputedStyle(el).clipPath)).toBe('inset(50%)');
 expect((await chrome.boundingBox())?.width).toBe(320);
 expect((await chrome.boundingBox())?.height).toBe(48);
 for(const icon of [searchIcon,clearIcon]){
  expect((await icon.boundingBox())?.width).toBe(20);expect((await icon.boundingBox())?.height).toBe(20);
  expect(await icon.evaluate(el=>getComputedStyle(el).maskImage)).not.toBe('none');
 }
 expect((await clear.boundingBox())?.width).toBeGreaterThanOrEqual(44);
 await chrome.screenshot({path:`/tmp/wardo-web-navigation-search-${testInfo.project.name}-ltr.png`});
 await input.focus();await page.keyboard.press('Enter');await expect(page.getByRole('status').filter({hasText:'Search submitted:'})).toHaveText('Search submitted: Ceramics');
 await page.keyboard.press('Tab');await expect(clear).toBeFocused();await page.keyboard.press('Enter');
 await expect(input).toHaveValue('');await expect(input).toBeFocused();await expect(page.getByLabel('Current search query')).toHaveText('Empty query');
 await expect(clear).toHaveCount(0);await expect(input).toHaveAttribute('placeholder','Search events');
 await input.fill('Ceramics');
 await page.getByRole('checkbox',{name:'Right-to-left search'}).check();
 const searchBounds=await searchIcon.boundingBox();const clearBounds=await clearIcon.boundingBox();expect(searchBounds!.x).toBeGreaterThan(clearBounds!.x);
 await page.getByLabel('Search theme').selectOption('wardo-dark');
 await chrome.screenshot({path:`/tmp/wardo-web-navigation-search-${testInfo.project.name}-rtl-dark.png`});
 expect((await new AxeBuilder({page}).include('form').withTags(['wcag2a','wcag2aa','wcag21aa']).analyze()).violations).toEqual([]);
 await page.getByRole('checkbox',{name:'Disable search'}).check();await expect(input).toBeDisabled();await expect(clear).toBeDisabled();
 await page.getByRole('checkbox',{name:'Disable search'}).uncheck();
 await page.evaluate(()=>{document.documentElement.style.fontSize='200%';});
 expect((await chrome.boundingBox())!.height).toBeGreaterThan(48);
 await expect(input).toBeVisible();
 expect(await page.evaluate(()=>Array.from(document.querySelectorAll('main *')).filter(el=>el.getBoundingClientRect().right>innerWidth+1).map(el=>({tag:el.tagName,class:el.className,right:el.getBoundingClientRect().right})))).toEqual([]);
 await page.screenshot({path:`/tmp/wardo-web-navigation-search-${testInfo.project.name}-scaled.png`});
 expect(await page.evaluate(()=>({width:document.documentElement.scrollWidth,viewport:innerWidth})),'No horizontal scroll at 200% text size').toEqual({width:testInfo.project.use.viewport!.width,viewport:testInfo.project.use.viewport!.width});
 expect(errors).toEqual([]);
});
