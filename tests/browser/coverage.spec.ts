import {test,expect} from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';
test('coverage catalogue searches the published inventory',async({page})=>{
 await page.goto('/coverage');await expect(page.getByRole('heading',{name:'Wardo coverage catalogue'})).toBeVisible();
 await page.getByRole('searchbox',{name:'Find a design or component'}).fill('1531:158362');
 await expect(page.getByRole('status')).toContainText('1 matching entry');await expect(page.locator('article')).toHaveCount(1);await expect(page.locator('article')).toContainText('SearchField');
 await page.getByRole('button',{name:'Clear search'}).click();await expect(page.getByRole('searchbox')).toBeFocused();await expect(page.getByRole('status')).toContainText('765 matching entries');
 await page.getByLabel('Coverage',{exact:true}).selectOption('references');await expect(page.getByRole('status')).toContainText('197 matching entries');
 await page.getByLabel('Coverage',{exact:true}).selectOption('all');await page.getByRole('searchbox').fill('no-such-component');await expect(page.getByText('No matching entries. Try a different name or remove a filter.')).toBeVisible();
 expect(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth)).toBe(true);
});
test('search and select use a single focus ring and Wardo affordances',async({page})=>{
 await page.goto('/');const input=page.getByRole('searchbox',{name:'Find a component'});await input.fill('Ceramics');await input.focus();
 expect(await input.evaluate(el=>getComputedStyle(el).outlineStyle)).toBe('none');expect(await input.locator('..').evaluate(el=>getComputedStyle(el).outlineStyle)).toBe('solid');
 await page.getByRole('button',{name:'Clear search'}).click();await expect(input).toHaveValue('');await expect(input).toBeFocused();
 const workspace=page.getByLabel('Workspace');await workspace.selectOption({label:'Design team'});await expect(workspace).toHaveValue('Design team');expect(await workspace.evaluate(el=>getComputedStyle(el).appearance)).toBe('none');
 const findings=await new AxeBuilder({page}).withTags(['wcag2a','wcag2aa','wcag21aa']).analyze();expect(findings.violations).toEqual([]);
});
test('native sample previews expose nonempty captured images',async({page})=>{
 await page.goto('/coverage');await expect(page.getByRole('heading',{name:'Wardo coverage catalogue'})).toBeVisible();
 await page.getByText('Native sample previews',{exact:true}).click();
 const images=page.locator('.coverage-native-previews img');await expect(images).toHaveCount(5);
 await images.last().scrollIntoViewIfNeeded();
 await expect.poll(()=>images.evaluateAll(nodes=>nodes.every(node=>(node as HTMLImageElement).complete&&(node as HTMLImageElement).naturalWidth>1&&(node as HTMLImageElement).naturalHeight>1))).toBe(true);
 await expect(page.getByText('Vision Pro sample — rendered scene',{exact:true})).toBeVisible();
 expect(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth)).toBe(true);
});
test('a verified native glyph retains its separate Figma connection state',async({page})=>{
 await page.goto('/coverage');
 await page.getByRole('searchbox',{name:'Find a design or component'}).fill('1945:10775');
 await page.getByLabel('Platform',{exact:true}).selectOption('Android');
 const entry=page.locator('article');await expect(entry).toHaveCount(1);
 await expect(entry.getByRole('link',{name:'WardoToolbarArtwork'})).toBeVisible();
 await expect(entry.locator('.coverage-states dd').nth(1)).toHaveText('verified');
 await expect(entry.locator('.coverage-states dd').nth(2)).toHaveText('not connected');
 await expect(entry.getByRole('img')).toBeVisible();
});

test('platform filtering shows native code and its own verification state',async({page})=>{
 await page.goto('/coverage');
 await page.getByRole('searchbox',{name:'Find a design or component'}).fill('2277:12775');
 await page.getByLabel('Platform',{exact:true}).selectOption('Android');
 const entry=page.locator('article');await expect(entry).toHaveCount(1);
 await expect(entry.getByRole('region',{name:'SwiftUI implementation'})).toHaveCount(0);
 await expect(entry.getByRole('region',{name:'Jetpack Compose implementation'})).toHaveCount(1);
 await expect(entry.locator('.coverage-states dd').nth(1)).toHaveText('pending');
 await page.getByRole('searchbox').fill('1159:29');
 await page.getByLabel('Platform',{exact:true}).selectOption('iOS');
 await expect(entry.getByRole('link',{name:'wardoNavigationImage'})).toBeVisible();
 await expect(entry.getByRole('region',{name:'React implementation'})).toHaveCount(0);
 await expect(entry.locator('.coverage-states dd').nth(1)).toHaveText('verified');
 await expect(entry.locator('.coverage-states dd').nth(2)).toHaveText('not connected');
 await expect(entry.getByText('A React source connection is saved separately for this design.')).toBeVisible();
 await page.getByLabel('Coverage',{exact:true}).selectOption('validated');
 await expect(entry).toHaveCount(1);
 await page.getByRole('searchbox').fill('2277:12775');
 await expect(page.locator('article')).toHaveCount(0);
});
