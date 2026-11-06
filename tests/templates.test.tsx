import { readFileSync } from 'node:fs';
import { Script } from 'node:vm';
import ts from 'typescript';
import { describe, expect, it } from 'vitest';
function renderTemplate(file:string, values:Record<string,string|boolean>){
 const source=readFileSync(`figma/${file}.figma.ts`,'utf8');
 const compiled=ts.transpileModule(source,{compilerOptions:{module:ts.ModuleKind.CommonJS,target:ts.ScriptTarget.ES2022,esModuleInterop:true}}).outputText;
 const figma={selectedInstance:{getEnum:(name:string,map:Record<string,unknown>)=>map[String(values[name])],getString:()=>String(values.Label),getBoolean:(name:string)=>Boolean(values[name]),getInstanceSwap:()=>({type:'INSTANCE',executeTemplate:()=>({example:'<Icon name="plus" />'})})},code:(parts:TemplateStringsArray,...values:unknown[])=>parts.reduce((s,p,i)=>s+p+(values[i]??''),'')};
 const exports:Record<string,unknown>={};new Script(compiled).runInNewContext({exports,require:()=>figma});
 return (exports.default as {example:string}).example;
}
describe('Code Connect templates',()=>{
 for(const name of ['Button','ActionChip'])it(`${name} covers every variant and safely emits labels and nested icons`,()=>{
 const context=JSON.parse(readFileSync(`figma/context/${name}.json`,'utf8'))[0];
 const props=context.properties as Record<string,{name:string;type:string;variantOptions?:string[]}>;
 const variants=Object.values(props).filter(p=>p.type==='VARIANT');
 let cases:Record<string,string|boolean>[]=[{Label:'A "quoted" <label> {with braces}', 'Show leading icon':true,'Show trailing icon':true,'Show label':true,Selected:true}];
 for(const p of variants)cases=cases.flatMap(c=>p.variantOptions!.map(value=>({...c,[p.name]:value})));
 for(const values of cases){
 const example=renderTemplate(name,values);
 expect(example).not.toContain('undefined');expect(example).not.toContain('[object Object]');expect(example).toContain('leadingIcon={<Icon name="plus" />}');
 expect(example).toContain(`hierarchy="${String(values.Hierarchy).toLowerCase()}"`);
 const parsed=ts.transpileModule(`const example = (${example});`,{compilerOptions:{jsx:ts.JsxEmit.ReactJSX},reportDiagnostics:true});
 expect(parsed.diagnostics?.filter(d=>d.category===ts.DiagnosticCategory.Error)).toEqual([]);
 }
 });
});
