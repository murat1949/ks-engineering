<!DOCTYPE html><html lang="ru"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>KS Engineering — живые панели (эскиз)</title>
<style>
*{box-sizing:border-box}
body{margin:0;background:#EDE9E1;font-family:"Segoe UI",Arial,sans-serif;color:#13233A}
.top{text-align:center;padding:24px 10px 4px}
.top .k{font-size:13px;letter-spacing:2px;font-weight:800;color:#D85A30}
.top h1{margin:6px 0 4px;font-size:30px}
.top p{margin:0;color:#5d6773;font-size:16px}
.row{display:flex;justify-content:center;gap:26px;flex-wrap:wrap;padding:22px 10px 30px}
.col{text-align:center}
.role{display:inline-block;font-size:15px;font-weight:800;color:#fff;border-radius:12px;padding:6px 14px;margin-bottom:12px}
.stage{width:380px;height:570px;border-radius:26px;overflow:hidden;position:relative;box-shadow:0 18px 40px rgba(20,30,40,.25);background:#13233A;cursor:pointer}
.stage .cv{position:absolute;inset:0;width:100%;height:100%;object-fit:cover;transition:filter .7s,transform .7s}
.stage.open .cv{filter:blur(10px) brightness(.55);transform:scale(1.08)}
.hot{position:absolute;left:50%;width:62%;height:7%;transform:translate(-50%,-50%);border-radius:40px;animation:pulse 1.8s infinite}
@keyframes pulse{0%{box-shadow:0 0 0 0 rgba(255,140,40,.75)}70%{box-shadow:0 0 0 18px rgba(255,140,40,0)}100%{box-shadow:0 0 0 0 rgba(255,140,40,0)}}
.stage.open .hot{display:none}
.tip{position:absolute;left:0;right:0;bottom:8px;font-size:12.5px;color:#fff;opacity:.85;text-shadow:0 1px 4px #000}
.stage.open .tip{display:none}
.pw{position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) scale(.3);opacity:0;transition:transform .65s cubic-bezier(.2,1.25,.4,1),opacity .4s;pointer-events:none}
.stage.open .pw{transform:translate(-50%,-50%) scale(.88);opacity:1;pointer-events:auto}
.back{position:absolute;top:12px;left:12px;z-index:5;background:rgba(255,255,255,.92);border:0;border-radius:18px;padding:7px 13px;font-weight:700;font-size:13px;color:#13233A;cursor:pointer;display:none}
.stage.open .back{display:block}
/* phone */
.ph{width:300px;height:620px;border-radius:44px;background:#0d1520;padding:11px;box-shadow:0 18px 50px rgba(0,0,0,.5)}
.sc{width:100%;height:100%;border-radius:34px;overflow:hidden;background:#F5F7FA;position:relative;display:flex;flex-direction:column;text-align:left}
.isl{position:absolute;top:10px;left:50%;transform:translateX(-50%);width:92px;height:26px;border-radius:14px;background:#0d1520;z-index:3}
.bar0{padding:44px 16px 14px;color:#fff;position:relative}
.bar0 .r{display:flex;align-items:center;gap:8px}
.lg{width:28px;height:28px;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#fff;font-weight:900;font-size:12px;background:#F07A22}
.bar0 b{font-size:14px}.bar0 small{display:block;font-size:9.5px;letter-spacing:1.2px;font-weight:700;opacity:.8}
.live{margin-left:auto;font-size:10px;font-weight:800;display:flex;align-items:center;gap:5px;background:rgba(255,255,255,.12);padding:4px 8px;border-radius:10px}
.live i{width:7px;height:7px;border-radius:50%;background:#2EE59D;animation:bl 1.2s infinite}
@keyframes bl{50%{opacity:.25}}
.bar0 h3{margin:10px 0 0;font-size:19px;line-height:1.15}
.card{margin:10px 12px 0;background:#fff;border-radius:16px;box-shadow:0 4px 14px rgba(20,30,50,.07);padding:11px 13px}
.kp{display:flex;gap:7px;margin:10px 12px 0}
.kp div{flex:1;background:#fff;border-radius:13px;padding:8px;box-shadow:0 3px 10px rgba(20,30,50,.06)}
.kp b{display:block;font-size:19px;line-height:1.1}.kp b span{font-size:inherit;color:inherit}.kp span{font-size:10px;color:#6b7480}
.ob{display:flex;align-items:center;gap:7px;font-size:11.5px;margin-top:7px}
.ob .n{width:100px;font-weight:700;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.ob .tr{flex:1;height:8px;border-radius:4px;background:#EEF0F4;overflow:hidden}.ob .tr i{display:block;height:100%;border-radius:4px;width:0;transition:width 1.4s ease}
.ob .tg{font-size:10px;font-weight:800;width:44px;text-align:right}
.tk{display:flex;gap:9px;align-items:flex-start;font-size:12px;line-height:1.35;padding:7px 0;border-bottom:1px solid #F0F1F4;transition:opacity .4s}
.tk:last-child{border-bottom:0}.tk .cb{width:19px;height:19px;border-radius:6px;border:2px solid #c8cdd6;flex:none;margin-top:1px;display:flex;align-items:center;justify-content:center;font-size:11px;color:#fff;transition:all .35s}
.tk .cb.on{background:#1FA971;border-color:#1FA971}
.tk small{display:block;color:#8a929c;font-size:10.5px}
.tk.dn{opacity:.5}
.al{margin:10px 12px 0;border-radius:13px;padding:9px 11px;font-size:11.5px;display:flex;gap:8px;align-items:center;opacity:0;transform:translateY(12px);transition:all .5s}
.al.sh{opacity:1;transform:none}
.al.hot2{animation:shk .5s 2}
@keyframes shk{25%{transform:translateX(-4px)}75%{transform:translateX(4px)}}
.ttl{font-size:10.5px;font-weight:800;letter-spacing:1px;color:#6b7480}
.note{max-width:980px;margin:0 auto 40px;font-size:14.5px;color:#5d6773;text-align:center;line-height:1.5}
.needle{transition:transform 1.8s cubic-bezier(.3,1.5,.5,1)}
</style></head><body>
<div class="top"><div class="k">ЭСКИЗ ДЛЯ ОБСУЖДЕНИЯ</div><h1>KS Engineering — живые панели контроля</h1><p>Нажмите на оранжевую кнопку на обложке — откроется панель</p></div>
<div class="row">

<!-- СОБСТВЕННИК -->
<div class="col"><div class="role" style="background:#13233A">Собственник</div>
<div class="stage" data-k="own"><img class="cv" src="data:image/jpeg;base64,__OWN__"><div class="hot" style="top:78.6%"></div><div class="tip">нажмите «Открыть обзор»</div>
<button class="back">← Обложка</button>
<div class="pw"><div class="ph"><div class="sc">
 <div class="isl"></div>
 <div class="bar0" style="background:linear-gradient(135deg,#13233A,#22385a)"><div class="r"><div class="lg">KS</div><div><b>KS Engineering</b><small>СОБСТВЕННИК · ОБЗОР</small></div><div class="live"><i></i>сейчас</div></div><h3>Все объекты под контролем</h3></div>
 <div class="card" style="padding:6px 10px 2px">
  <svg viewBox="0 0 260 150" width="100%"><defs><linearGradient id="g1" x1="0" x2="1"><stop offset="0" stop-color="#E5484D"/><stop offset=".45" stop-color="#F2B300"/><stop offset="1" stop-color="#1FA971"/></linearGradient></defs>
   <path d="M30 128 A100 100 0 0 1 230 128" fill="none" stroke="#EEF0F4" stroke-width="18" stroke-linecap="round"/>
   <path class="arcA" d="M30 128 A100 100 0 0 1 230 128" fill="none" stroke="url(#g1)" stroke-width="18" stroke-linecap="round" pathLength="100" stroke-dasharray="100" stroke-dashoffset="100" data-v="80"/>
   <g class="needle" style="transform-origin:130px 128px;transform:rotate(-90deg)" data-deg="54"><line x1="130" y1="128" x2="130" y2="46" stroke="#13233A" stroke-width="4" stroke-linecap="round"/><circle cx="130" cy="128" r="9" fill="#13233A"/></g>
   <text x="130" y="104" text-anchor="middle" font-size="26" font-weight="800" fill="#13233A"><tspan class="cnt" data-to="80">0</tspan>%</text>
   <text x="130" y="146" text-anchor="middle" font-size="11.5" fill="#6b7480">объектов идут в срок</text></svg>
 </div>
 <div class="kp"><div><b style="color:#1D4ED8" class="cnt" data-to="10">0</b><span>объектов</span></div><div><b style="color:#127A4E"><span class="cnt" data-to="48">0</span> млн</b><span>в работе, ₸</span></div><div><b style="color:#B42318" class="cnt" data-to="2">0</b><span>ждут решения</span></div></div>
 <div class="al" data-t="2300" style="background:#FDE8E8;color:#B42318"><b>⚠</b><span><b>Сеть аптек</b>: открытие под угрозой — нужно ваше решение</span></div>
 <div class="al" data-t="3000" style="background:#E7F6EE;color:#127A4E"><b>✓</b><span><b>Бизнес-центр</b>: монтаж закончен на 2 дня раньше</span></div>
</div></div></div>
</div></div>

<!-- РУКОВОДИТЕЛЬ ПРОЕКТА -->
<div class="col"><div class="role" style="background:#D85A30">Руководитель проекта</div>
<div class="stage" data-k="pm"><img class="cv" src="data:image/jpeg;base64,__PM__"><div class="hot" style="top:84.5%"></div><div class="tip">нажмите «Открыть объекты»</div>
<button class="back">← Обложка</button>
<div class="pw"><div class="ph"><div class="sc">
 <div class="isl"></div>
 <div class="bar0" style="background:linear-gradient(135deg,#13233A,#7a3416)"><div class="r"><div class="lg">KS</div><div><b>KS Engineering</b><small>РУКОВОДИТЕЛЬ · ОБЪЕКТЫ</small></div><div class="live"><i></i>сейчас</div></div><h3>Каждый объект — на своём этапе</h3></div>
 <div class="card">
  <div style="display:flex;gap:6px;justify-content:space-between">
   <svg viewBox="0 0 80 62" width="31%"><path d="M8 54 A32 32 0 0 1 72 54" fill="none" stroke="#EEF0F4" stroke-width="9" stroke-linecap="round"/><path class="arcB" d="M8 54 A32 32 0 0 1 72 54" fill="none" stroke="#1FA971" stroke-width="9" stroke-linecap="round" pathLength="100" stroke-dasharray="100" stroke-dashoffset="100" data-v="70"/><text x="40" y="50" text-anchor="middle" font-size="15" font-weight="800" fill="#127A4E">+5</text><text x="40" y="61" text-anchor="middle" font-size="7" fill="#6b7480">дн. запас</text></svg>
   <svg viewBox="0 0 80 62" width="31%"><path d="M8 54 A32 32 0 0 1 72 54" fill="none" stroke="#EEF0F4" stroke-width="9" stroke-linecap="round"/><path class="arcB" d="M8 54 A32 32 0 0 1 72 54" fill="none" stroke="#F2B300" stroke-width="9" stroke-linecap="round" pathLength="100" stroke-dasharray="100" stroke-dashoffset="100" data-v="40"/><text x="40" y="50" text-anchor="middle" font-size="15" font-weight="800" fill="#9A5A00">+1</text><text x="40" y="61" text-anchor="middle" font-size="7" fill="#6b7480">дн. запас</text></svg>
   <svg viewBox="0 0 80 62" width="31%"><path d="M8 54 A32 32 0 0 1 72 54" fill="none" stroke="#EEF0F4" stroke-width="9" stroke-linecap="round"/><path class="arcB" d="M8 54 A32 32 0 0 1 72 54" fill="none" stroke="#E5484D" stroke-width="9" stroke-linecap="round" pathLength="100" stroke-dasharray="100" stroke-dashoffset="100" data-v="15"/><text x="40" y="50" text-anchor="middle" font-size="15" font-weight="800" fill="#B42318">−3</text><text x="40" y="61" text-anchor="middle" font-size="7" fill="#6b7480">дн. опозд.</text></svg>
  </div>
  <div class="ttl" style="margin-top:6px">МОИ ОБЪЕКТЫ</div>
  <div class="ob"><span class="n">Бизнес-центр</span><span class="tr"><i class="bar" data-w="70" style="background:#1FA971"></i></span><span class="tg" style="color:#127A4E">монтаж</span></div>
  <div class="ob"><span class="n">Бутики, 5 маг.</span><span class="tr"><i class="bar" data-w="45" style="background:#F2B300"></i></span><span class="tg" style="color:#9A5A00">снабж.</span></div>
  <div class="ob"><span class="n">Сеть аптек, 12</span><span class="tr"><i class="bar" data-w="72" style="background:#E5484D"></i></span><span class="tg" style="color:#B42318">монтаж</span></div>
  <div class="ob"><span class="n">ТЦ, счётчики</span><span class="tr"><i class="bar" data-w="25" style="background:#1FA971"></i></span><span class="tg" style="color:#127A4E">проект</span></div>
 </div>
 <div class="al" data-t="2200" style="background:#FFF3DC;color:#9A5A00"><b>⏱</b><span><b>Снабжение</b>: 3 объекта у одного человека — узкое место</span></div>
 <div class="al" data-t="3000" style="background:#FDE8E8;color:#B42318"><b>⚠</b><span><b>Сеть аптек</b>: ворота не отгружены — минус 3 дня</span></div>
</div></div></div>
</div></div>

<!-- ОТВЕТСТВЕННЫЙ -->
<div class="col"><div class="role" style="background:#185fa5">Ответственный</div>
<div class="stage" data-k="resp"><img class="cv" src="data:image/jpeg;base64,__RESP__"><div class="hot" style="top:82%"></div><div class="tip">нажмите «Открыть задачи»</div>
<button class="back">← Обложка</button>
<div class="pw"><div class="ph"><div class="sc">
 <div class="isl"></div>
 <div class="bar0" style="background:linear-gradient(135deg,#13233A,#0f5f73)"><div class="r"><div class="lg">KS</div><div><b>KS Engineering</b><small>ОТВЕТСТВЕННЫЙ · МОЙ ДЕНЬ</small></div><div class="live"><i></i>сейчас</div></div><h3>Мой день — без лишнего</h3></div>
 <div class="card" style="display:flex;align-items:center;gap:12px">
  <svg viewBox="0 0 80 80" width="86" height="86"><circle cx="40" cy="40" r="31" fill="none" stroke="#EEF0F4" stroke-width="10"/><circle class="ringC" cx="40" cy="40" r="31" fill="none" stroke="#14B8A6" stroke-width="10" stroke-linecap="round" pathLength="100" stroke-dasharray="100" stroke-dashoffset="100" transform="rotate(-90 40 40)" style="transition:stroke-dashoffset 1s ease"/><text x="40" y="45" text-anchor="middle" font-size="17" font-weight="800" fill="#13233A"><tspan class="done">1</tspan>/5</text></svg>
  <div><div style="font-size:15px;font-weight:800"><span class="done">1</span> из 5 готово</div><div style="font-size:11.5px;color:#6b7480;margin-top:3px" class="left">Сегодня ещё 4 задачи.<br>Одна горит.</div></div>
 </div>
 <div class="card" style="padding:6px 13px">
  <div class="tk"><span class="cb"></span><div><b style="color:#B42318">Подтвердить отгрузку ворот</b><small>Сеть аптек · до 12:00 · горит</small></div></div>
  <div class="tk"><span class="cb"></span><div>Камеры: проверить обзор зала<small>Бутики · до 15:00</small></div></div>
  <div class="tk"><span class="cb"></span><div>Передать спецификацию в снабжение<small>Бутики · до 17:00</small></div></div>
  <div class="tk"><span class="cb"></span><div>Фото готового объекта в группу<small>Бизнес-центр · до 18:00</small></div></div>
  <div class="tk dn"><span class="cb on">✓</span><div>Сдать акты<small>Бизнес-центр · готово</small></div></div>
 </div>
 <div class="al" data-t="4200" style="background:#E7F6EE;color:#127A4E"><b>👍</b><span>Руководитель видит: <b>горящая задача закрыта</b></span></div>
</div></div></div>
</div></div>

</div>
<div class="note">Эскиз: обложка → нажатие → живая панель своего уровня. Цифры условные. «← Обложка» — вернуться и посмотреть снова.</div>
<script>
const T=[];function later(f,ms){T.push(setTimeout(f,ms))}
function reset(st){
 st.querySelectorAll('.arcA,.arcB,.ringC').forEach(e=>{e.style.transition='none';e.style.strokeDashoffset=100});
 st.querySelectorAll('.needle').forEach(e=>{e.style.transition='none';e.style.transform='rotate(-90deg)'});
 st.querySelectorAll('.bar').forEach(e=>{e.style.transition='none';e.style.width=0});
 st.querySelectorAll('.cnt').forEach(e=>e.textContent=0);
 st.querySelectorAll('.al').forEach(e=>e.classList.remove('sh','hot2'));
 st.querySelectorAll('.tk').forEach((e,i,a)=>{const last=i==a.length-1;e.classList.toggle('dn',last);const c=e.querySelector('.cb');c.classList.toggle('on',last);c.textContent=last?'✓':''});
 st.querySelectorAll('.done').forEach(e=>e.textContent=1);
 const l=st.querySelector('.left');if(l)l.innerHTML='Сегодня ещё 4 задачи.<br>Одна горит.';
 void st.offsetWidth;
}
function count(e,to,ms){const t0=performance.now();(function s(t){const k=Math.min(1,(t-t0)/ms);e.textContent=Math.round(to*(1-Math.pow(1-k,3)));if(k<1)requestAnimationFrame(s)})(t0)}
function play(st){
 later(()=>{
  st.querySelectorAll('.arcA').forEach(e=>{e.style.transition='stroke-dashoffset 1.8s ease';e.style.strokeDashoffset=100-(+e.dataset.v)});
  st.querySelectorAll('.needle').forEach(e=>{e.style.transition='';e.style.transform='rotate('+e.dataset.deg+'deg)'});
  st.querySelectorAll('.arcB').forEach(e=>{e.style.transition='stroke-dashoffset 1.4s ease';e.style.strokeDashoffset=100-(+e.dataset.v)});
  st.querySelectorAll('.bar').forEach(e=>{e.style.transition='';e.style.width=e.dataset.w+'%'});
  st.querySelectorAll('.cnt').forEach(e=>count(e,+e.dataset.to,1600));
  st.querySelectorAll('.ringC').forEach(e=>{e.style.transition='stroke-dashoffset 1s ease';e.style.strokeDashoffset=80});
 },500);
 st.querySelectorAll('.al').forEach(a=>later(()=>{a.classList.add('sh');if(a.style.color=='rgb(180, 35, 24)')later(()=>a.classList.add('hot2'),500)},+a.dataset.t));
 if(st.dataset.k=='resp'){
  const tks=[...st.querySelectorAll('.tk')];let n=1;
  [0,1].forEach((i,j)=>later(()=>{const c=tks[i].querySelector('.cb');c.classList.add('on');c.textContent='✓';tks[i].classList.add('dn');n++;
    st.querySelectorAll('.done').forEach(e=>e.textContent=n);
    st.querySelector('.ringC').style.strokeDashoffset=100-n*20;
    st.querySelector('.left').innerHTML='Сегодня ещё '+(5-n)+' задачи.<br>'+(n>=2?'Горящих нет 👍':'Одна горит.');
  },1900+j*1300));
 }
}
document.querySelectorAll('.stage').forEach(st=>{
 st.addEventListener('click',e=>{
  if(e.target.closest('.back')){st.classList.remove('open');return}
  if(st.classList.contains('open'))return;
  reset(st);st.classList.add('open');play(st);
 });
});
</script>
</body></html>
