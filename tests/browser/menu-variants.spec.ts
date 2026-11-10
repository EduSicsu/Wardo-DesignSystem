import {test,expect} from '@playwright/test';
test('configured menu buttons retain native menu interaction and rotating chevrons',async({page})=>{
 await page.goto('/library');const trigger=page.getByRole('button',{name:'Styled options',exact:true});await expect(trigger).toBeVisible();
 await expect(trigger).toHaveAttribute('data-hierarchy','primary');await expect(trigger).toHaveAttribute('data-tone','confirmation');await expect(trigger).toHaveAttribute('dir','rtl');
 await expect(trigger.locator('.wardo-icon')).toHaveCount(2);
 await trigger.click();await expect(trigger).toHaveAttribute('aria-expanded','true');const menu=page.getByRole('menu',{name:'Styled options',exact:true});await expect(menu).toBeVisible();
 await expect.poll(()=>trigger.locator('.wardo-menu-chevron').evaluate(el=>new DOMMatrixReadOnly(getComputedStyle(el).transform).a)).toBeCloseTo(-1,1);
 await expect(menu.locator('..')).toHaveAttribute('dir','rtl');await page.keyboard.press('Escape');await expect(menu).not.toBeVisible();await expect(trigger).toBeFocused();
 await expect(page.getByRole('button',{name:'Unavailable options',exact:true})).toBeDisabled();
});
