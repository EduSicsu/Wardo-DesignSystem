import type { HTMLAttributes } from 'react';
import svg0 from '../icons/menu-chevron-right.svg';
import svg1 from '../icons/menu-check.svg';
import svg2 from '../icons/menu-chevron-left.svg';
import svg3 from '../icons/menu-overflow.svg';
import svg4 from '../icons/action-chevron-up.svg';
import svg5 from '../icons/action-close.svg';
import bookmark from '../icons/action-bookmark.svg';
import folder from '../icons/tree-folder.svg';
import document from '../icons/tree-document.svg';
import disclosureLTR from '../icons/tree-disclosure-ltr.svg';
import disclosureRTL from '../icons/tree-disclosure-rtl.svg';
import disclosureExpanded from '../icons/tree-disclosure-expanded.svg';
const assets = {'tree-disclosure-ltr':disclosureLTR,'tree-disclosure-rtl':disclosureRTL,'tree-disclosure-expanded':disclosureExpanded,'action-bookmark':bookmark,'tree-folder':folder,'tree-document':document,'menu-chevron-right':svg0,'menu-check':svg1,'menu-chevron-left':svg2,'menu-overflow':svg3,'action-chevron-up':svg4,'action-close':svg5};
export type ArtworkIconName = keyof typeof assets;
export function ArtworkIcon({name,label,style,className,...props}:HTMLAttributes<HTMLSpanElement>&{name:ArtworkIconName;label?:string}){const mask=`url("${assets[name]}")`;const width=name==='tree-disclosure-expanded'?9:name.startsWith('tree-disclosure')?5:name.startsWith('tree-')?16:24;const height=name.startsWith('tree-disclosure')?24:width;return <span {...props} className={['wardo-artwork-icon',className].filter(Boolean).join(' ')} data-artwork-icon={name} role={label?'img':undefined} aria-label={label} aria-hidden={label?undefined:true} style={{flex:'none',width,height,backgroundColor:'currentColor',maskImage:mask,WebkitMaskImage:mask,maskSize:'contain',maskRepeat:'no-repeat',...style}}/>;}
