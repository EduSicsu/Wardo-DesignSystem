import {test,expect} from '@playwright/test';
import {mkdir} from 'node:fs/promises';
test('divider orientations and logical insets cover all twelve design configurations',async({page},testInfo)=>{
 await page.goto('/library');await expect(page.getByRole('heading',{name:'Dividers',exact:true})).toBeVisible();
 const fixtures=page.locator('.divider-fixture');await expect(fixtures).toHaveCount(12);
 for(const fixture of await fixtures.all()){
  const dir=await fixture.getAttribute('data-direction');const orientation=await fixture.getAttribute('data-orientation');const inset=await fixture.getAttribute('data-inset');
  const line=fixture.getByRole('separator');await expect(line).toHaveAttribute('aria-orientation',orientation!);
  const box=await fixture.boundingBox();const rect=await line.boundingBox();expect(box).not.toBeNull();expect(rect).not.toBeNull();
  const start=inset==='none'?0:16;const end=inset==='both'?16:0;
  if(orientation==='horizontal'){
   expect(rect!.height).toBeCloseTo(1,0);expect(rect!.width).toBeCloseTo(box!.width-start-end,0);
   expect(rect!.x-box!.x).toBeCloseTo(dir==='rtl'?end:start,0);
  }else{
   expect(rect!.width).toBeCloseTo(1,0);expect(rect!.height).toBeCloseTo(box!.height-start-end,0);
   expect(rect!.y-box!.y).toBeCloseTo(start,0);
  }
 }
 if(testInfo.project.name==='desktop'){await mkdir('coverage/previews/web',{recursive:true});await page.locator('#foundations').screenshot({path:'coverage/previews/web/divider-variants.png'});}
});
