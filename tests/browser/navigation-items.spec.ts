import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
import { mkdir } from 'node:fs/promises';

test('navigation items retain all three source layouts and logical badge positions',async({page},testInfo)=>{
 await page.goto('/navigation-items');await page.evaluate(()=>document.fonts.ready);
 const fixtures=page.locator('.navigation-item-fixture');await expect(fixtures).toHaveCount(12);
 for(const fixture of await fixtures.all()) {
  const layout=await fixture.getAttribute('data-layout');const dir=await fixture.getAttribute('data-direction');const current=await fixture.getAttribute('data-current')==='true';
  const link=fixture.getByRole('link',{name:'Events',exact:true});const box=(await link.boundingBox())!;
  expect(box.width).toBeCloseTo(layout==='vertical'?88:layout==='horizontal'?240:148,0);
  expect(box.height).toBeCloseTo(layout==='vertical'?64:48,0);
  await expect(link).toHaveAccessibleDescription('3 unread events');
  if(current) await expect(link).toHaveAttribute('aria-current','page');else await expect(link).not.toHaveAttribute('aria-current');
  const badge=(await link.locator('.wardo-navigation-badge').boundingBox())!;
  const colors=await link.evaluate(el=>{
   const style=getComputedStyle(el);const color=(token:string)=>{const probe=document.createElement('i');probe.style.backgroundColor=style.getPropertyValue(token);return probe.style.backgroundColor;};
   return {background:style.backgroundColor,primary:color('--color-action-primary'),subtle:color('--color-background-subtle'),indicator:el.querySelector('.wardo-navigation-indicator')?getComputedStyle(el.querySelector('.wardo-navigation-indicator')!).backgroundColor:null};
  });
  expect(colors.background).toBe(!current||layout==='vertical'?'rgba(0, 0, 0, 0)':layout==='text-only'?colors.subtle:colors.primary);
  if(current&&layout==='vertical')expect(colors.indicator).toBe(colors.primary);
  const inset=layout==='vertical'?24:28;
  expect(dir==='rtl'?box.x+box.width-badge.x-badge.width:badge.x-box.x).toBeCloseTo(box.width-inset,0);
  if(layout==='text-only') await expect(link.locator('.wardo-navigation-icon')).toHaveCount(0);
  else {
   const indicator=(await link.locator('.wardo-navigation-indicator').boundingBox())!;
   expect(indicator.width).toBeCloseTo(layout==='vertical'?48:24,0);
   const icon=(await link.locator('svg').boundingBox())!;expect(icon.width).toBeCloseTo(24,0);expect(icon.height).toBeCloseTo(24,0);
   if(layout==='horizontal') {const label=(await link.locator('.wardo-navigation-label').boundingBox())!;expect(dir==='rtl'?icon.x>label.x:icon.x<label.x).toBe(true);}
  }
  expect(await link.locator('.wardo-navigation-label').evaluate(el=>getComputedStyle(el).fontSize)).toBe(layout==='vertical'?'12px':'14px');
 }
 expect(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth)).toBe(true);
 if(testInfo.project.name==='desktop'){await mkdir('coverage/previews/web',{recursive:true});await page.locator('main').screenshot({path:'coverage/previews/web/navigation-item-variants.png'});}
});

test('navigation keyboard activation and disabled state remain application-owned',async({page})=>{
 await page.goto('/navigation-items');const link=page.locator('.navigation-item-fixture').first().getByRole('link',{name:'Events',exact:true});
 await link.focus();await page.keyboard.press('Enter');await expect(page.getByRole('status')).toHaveText('Activated: ltr-horizontal-idle');
 expect(await link.evaluate(el=>getComputedStyle(el).outlineWidth)).toBe('3px');
 await page.getByLabel('Disable destinations').check();await expect(link).toHaveAttribute('aria-disabled','true');await expect(link).not.toHaveAttribute('href');
 await page.locator('.navigation-item-fixture').nth(1).getByRole('link',{name:'Events',exact:true}).click({force:true});await expect(page.getByRole('status')).toHaveText('Activated: ltr-horizontal-idle');
 await page.getByLabel('Disable destinations').focus();await page.keyboard.press('Tab');await expect(page.locator('.wardo-navigation-item:focus')).toHaveCount(0);
});

test('navigation variants retain contrast in every theme and reflow on narrow screens',async({page})=>{
 await page.goto('/navigation-items');
 for(const theme of ['wardo-light','wardo-dark','ocean-light','ocean-dark','orchid-light','orchid-dark','ember-light','ember-dark','cloud-light','cloud-dark']) {
  await page.getByLabel('Preview theme').selectOption(theme);
  const findings=await new AxeBuilder({page}).include('main').withTags(['wcag2a','wcag2aa','wcag21aa']).analyze();expect(findings.violations,theme).toEqual([]);
 }
 await page.setViewportSize({width:320,height:900});expect(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth)).toBe(true);
 await page.emulateMedia({forcedColors:'active'});const link=page.locator('.navigation-item-fixture').first().getByRole('link',{name:'Events',exact:true});await link.focus();expect(await link.evaluate(el=>getComputedStyle(el).outlineStyle)).toBe('solid');
});
