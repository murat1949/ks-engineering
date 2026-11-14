import re
live=open('/home/claude/ks/live.tpl').read()
put=open('/home/claude/ks/put3.html').read()
# phone blocks
pws=re.findall(r'(<div class="pw">.*?\n</div></div></div>)\n</div></div>',live,re.S)
assert len(pws)==3
keys=['own','pm','resp']
pw_html=''
for k,b in zip(keys,pws):
    b=b.replace('class="ttl"','class="pttl"').replace('class="left"','class="lft"')
    b=b.replace('<div class="pw">',f'<div class="pw" data-k="{k}">',1)
    pw_html+=b+'\n'
# phone css
css=live[live.index('/* phone */'):live.index('.note{')]
css=css.replace('.ttl{','.pttl{')
css+=live[live.index('.needle{'):live.index('</style>')]
css+='''
#ps{position:absolute;left:625px;top:0;width:575px;height:675px;overflow:hidden;opacity:0;pointer-events:none;transition:opacity .5s;background:#FBF8F2}
#ps.on{opacity:1;pointer-events:auto}
#ps .cv{position:absolute;left:62px;top:0;width:450px;height:675px;object-fit:cover;transition:filter .8s,transform .8s}
#ps.open .cv{filter:blur(10px) brightness(.55);transform:scale(1.08)}
#ps .pw{position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) scale(.3);opacity:0;transition:transform .7s cubic-bezier(.2,1.25,.4,1),opacity .4s;display:none}
#ps.open .pw.cur{transform:translate(-50%,-50%) scale(.98);opacity:1}
#ps .pw.cur{display:block}
.mini{display:inline-block;width:170px;margin:0 5px;text-align:center;cursor:pointer;vertical-align:top}
.mini img{width:170px;height:255px;object-fit:cover;border-radius:16px;box-shadow:0 10px 24px rgba(20,30,40,.22);transition:transform .25s}
.mini:hover img{transform:translateY(-4px) scale(1.03)}
.mini span{display:inline-block;margin-top:10px;font-size:14px;font-weight:800;color:#fff;border-radius:10px;padding:5px 12px}
'''
put=put.replace('</style>',css+'</style>',1)
# replace #lv content
i=put.index('<div id="lv"'); j=put.index('<div class="ctl">')
lv='''<div id="lv" style="position:absolute;left:625px;top:0;width:575px;height:675px;background:#FBF8F2;opacity:0;pointer-events:none;transition:opacity .6s;text-align:center;padding-top:150px">
  <div class="mini" onclick="go('own')"><img src="data:image/jpeg;base64,__OWN__"><br><span style="background:#13233A">Собственник</span></div><div class="mini" onclick="go('pm')"><img src="data:image/jpeg;base64,__PM__"><br><span style="background:#D85A30">Руководитель проекта</span></div><div class="mini" onclick="go('resp')"><img src="data:image/jpeg;base64,__RESP__"><br><span style="background:#185fa5">Ответственный</span></div>
  <div style="margin-top:26px;font-size:15px;color:#7a7f86">Нажмите на обложку — или «Дальше» — откроется живая панель</div>
 </div>
 <div id="ps"><img class="cv" src="">
'''+pw_html+''' </div>
</div>
'''
put=put[:i]+lv+put[j:]
# role steps inserted after the 'Каждому — свой уровень' step
ROLE='''
const COV={own:'data:image/jpeg;base64,__OWN__',pm:'data:image/jpeg;base64,__PM__',resp:'data:image/jpeg;base64,__RESP__'};
const ROLES=[
 ['own','ПАНЕЛЬ СОБСТВЕННИКА','Одна картина —<br><span style="color:#D85A30">за 10 секунд</span>','Сколько объектов идёт в срок, сколько денег в работе и <b>где нужно именно ваше решение</b>.<br><br>Без отчётов, звонков и совещаний. Остальное команда решает сама.'],
 ['pm','ПАНЕЛЬ РУКОВОДИТЕЛЯ ПРОЕКТА','Где каждый объект —<br><span style="color:#D85A30">и сколько дней в запасе</span>','Спидометр на каждый объект: зелёный — запас есть, красный — опаздываем.<br><br>Узкое место видно <b>в тот же день</b> — есть время перестроить поставку или бригаду.'],
 ['resp','ПАНЕЛЬ ОТВЕТСТВЕННОГО','Только своё —<br><span style="color:#D85A30">и сразу виден результат</span>','Человек открывает телефон и видит свои задачи на сегодня. Отметил «готово» — руководитель уже знает.<br><br><b>Не нужно звонить и спрашивать</b> «ну что там?».']];
let ROLE_AT=-1;
'''
k=put.index('\n',put.index('ДОПОЛНИТЕЛЬНО К РАЗБОРУ'))+1
put=put[:k]+'ROLE_AT=STEPS.length;\nROLES.forEach(r=>STEPS.push(()=>{mark(-1);badges(0);openRole(r[0]);left(`<div class="kick">${r[1]}</div><div class="ttl" style="font-size:36px">${r[2]}</div><div class="txt">${r[3]}</div><div class="out" style="background:#FFF1EA;color:#B5441C">Цифры условные — на вашем объекте будут ваши</div>`)}));\n'+put[k:]
put=put.replace('const STEPS=[];',ROLE+'const STEPS=[];',1)
# reset hook
put=put.replace("function reset(){","function reset(){closeRole();",1)
LIVEJS='''
const T=[];function later(f,ms){T.push(setTimeout(f,ms))}
const PS=document.getElementById('ps');
function closeRole(){T.forEach(clearTimeout);T.length=0;PS.classList.remove('on','open');PS.querySelectorAll('.pw').forEach(p=>p.classList.remove('cur'))}
function go(k){S=ROLE_AT+['own','pm','resp'].indexOf(k);show()}
function count(e,to,ms){const t0=performance.now();(function s(t){const k=Math.min(1,(t-t0)/ms);e.textContent=Math.round(to*(1-Math.pow(1-k,3)));if(k<1)requestAnimationFrame(s)})(t0)}
function preset(st){
 st.querySelectorAll('.arcA,.arcB,.ringC').forEach(e=>{e.style.transition='none';e.style.strokeDashoffset=100});
 st.querySelectorAll('.needle').forEach(e=>{e.style.transition='none';e.style.transform='rotate(-90deg)'});
 st.querySelectorAll('.bar').forEach(e=>{e.style.transition='none';e.style.width=0});
 st.querySelectorAll('.cnt').forEach(e=>e.textContent=0);
 st.querySelectorAll('.al').forEach(e=>e.classList.remove('sh','hot2'));
 st.querySelectorAll('.tk').forEach((e,i,a)=>{const last=i==a.length-1;e.classList.toggle('dn',last);const c=e.querySelector('.cb');c.classList.toggle('on',last);c.textContent=last?'✓':''});
 st.querySelectorAll('.done').forEach(e=>e.textContent=1);
 const l=st.querySelector('.lft');if(l)l.innerHTML='Сегодня ещё 4 задачи.<br>Одна горит.';
 void st.offsetWidth;
}
function play(st,k){
 later(()=>{
  st.querySelectorAll('.arcA').forEach(e=>{e.style.transition='stroke-dashoffset 1.8s ease';e.style.strokeDashoffset=100-(+e.dataset.v)});
  st.querySelectorAll('.needle').forEach(e=>{e.style.transition='';e.style.transform='rotate('+e.dataset.deg+'deg)'});
  st.querySelectorAll('.arcB').forEach(e=>{e.style.transition='stroke-dashoffset 1.4s ease';e.style.strokeDashoffset=100-(+e.dataset.v)});
  st.querySelectorAll('.bar').forEach(e=>{e.style.transition='';e.style.width=e.dataset.w+'%'});
  st.querySelectorAll('.cnt').forEach(e=>count(e,+e.dataset.to,1600));
  st.querySelectorAll('.ringC').forEach(e=>{e.style.transition='stroke-dashoffset 1s ease';e.style.strokeDashoffset=80});
 },500);
 st.querySelectorAll('.al').forEach(a=>later(()=>{a.classList.add('sh');if(a.style.color=='rgb(180, 35, 24)')later(()=>a.classList.add('hot2'),500)},+a.dataset.t));
 if(k=='resp'){
  const tks=[...st.querySelectorAll('.tk')];let n=1;
  [0,1].forEach((i,j)=>later(()=>{const c=tks[i].querySelector('.cb');c.classList.add('on');c.textContent='✓';tks[i].classList.add('dn');n++;
    st.querySelectorAll('.done').forEach(e=>e.textContent=n);
    st.querySelector('.ringC').style.strokeDashoffset=100-n*20;
    st.querySelector('.lft').innerHTML='Сегодня ещё '+(5-n)+' задачи.<br>'+(n>=2?'Горящих нет 👍':'Одна горит.');
  },1900+j*1300));
 }
}
function openRole(k){
 PS.querySelector('.cv').src=COV[k];
 const st=PS.querySelector('.pw[data-k="'+k+'"]');st.classList.add('cur');preset(st);
 PS.classList.add('on');
 later(()=>{PS.classList.add('open');play(st,k)},900);
}
'''
put=put.replace("let S=0;",LIVEJS+"let S=0;",1)
put=put.replace("document.getElementById('lv').style.opacity=1;","document.getElementById('lv').style.opacity=1;document.getElementById('lv').style.pointerEvents='auto';")
put=put.replace("document.getElementById('lv').style.opacity=0;","document.getElementById('lv').style.opacity=0;document.getElementById('lv').style.pointerEvents='none';")
fs=put.index("STEPS.push(()=>{red=false;jam=false;mark(7);");fe=put.index('\n',fs)
put=put[:fs]+put[fs:fe].replace("ptxt.setAttribute('opacity',1);",'')+put[fe:]
for key,n in [('__OWN__','own'),('__PM__','pm'),('__RESP__','resp')]:
    put=put.replace(key,open(f'/tmp/{n}.b64').read())
import sys;sys.path.insert(0,'/home/claude/ks/build')
from texts import JS as TJS,CSS as TCSS
put=put.replace('</style>',TCSS+'</style>',1)
put=put.replace("let S=0;",TJS+"let S=0;",1)
put=put.replace("function show(){reset();STEPS[S]();","function show(){reset();STEPS[S]();if(TX[S])left(TX[S]);",1)
put=put.replace("document.getElementById('hint').textContent='Шаг '+(S+1)+' из '+STEPS.length+' · пробел или «Дальше»'","chapters()")
open('/home/claude/ks/put4.html','w').write(put)
print(len(put))
