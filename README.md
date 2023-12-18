//[chat prompts](https://github.com/Pleiadem/Chat_Prompts/blob/main/README_chat.md)

//[old cfg](https://github.com/Pleiadem/Chat_Prompts/blob/main/README_oldcfg.md)

//[左右无冲_准星跟随](https://github.com/Pleiadem/Chat_Prompts/blob/main/%E5%B7%A6%E5%8F%B3%E6%97%A0%E5%86%B2_%E5%87%86%E6%98%9F%E8%87%AA%E9%80%82%E5%BA%94.md?plain=1)




viewmodel_fov "61.000000"

viewmodel_offset_x "-2.0"

viewmodel_offset_y "2.0"

viewmodel_offset_z "-2.0"

bind p "toggle cl_crosshair_recoil"


cl_radar_scale 0.30 //雷达缩放

cl_hud_radar_scale 1.3 //雷达大小（0.8-1.3）
snd_tensecondwarning_volume 0.1 //十秒警告音量
//默认准星跟随

cl_teamid_overhead_always 2 //隔墙显示队友（1透视队友位置 2透视队友位置与装备）

cl_hud_color 12 //默认自己队伍颜色HUD
toggle fps_max 999//默认FPS999
//默认绑定
bind a +fa
bind d +fd
bind w +fw
bind s +fs
qiehuan3//默认切换模式(无冲松手急停)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*以下是急停代码,不需要跑打准星跟随的将和都删掉
//一键急停
alias "+_forward" "+forward; rightleft 0 1 0; !forwardback 0 1 0";
alias "-_forward" "-forward; !forwardback 0.00000000000001 0 0";

alias "+_back" "+back; rightleft 0 1 0; forwardback 0 1 0";
alias "-_back" "-back; forwardback 0.00000000000001 0 0";

alias "+_left" "+left; forwardback 0 1 0; rightleft 0 1 0";
alias "-_left" "-left; rightleft 0.00000000000001 0 0";

alias "+_right" "+right; forwardback 0 1 0; !rightleft 0 1 0";
alias "-_right" "-right; !rightleft 0.00000000000001 0 0";

//左右无冲
alias "+fa" "o_lh1"
alias "-fa" "lh1_o;"
alias "+fd" "o_rh1"
alias "-fd" "rh1_o;"
alias "+fw" "o_wh1"
alias "-fw" "wh1_o;"
alias "+fs" "o_sh1"
alias "-fs" "sh1_o;"
// L1
alias "o_lh1" "+_left;alias -fa lh1_o;alias +fd lh1_lh2;"
alias "lh1_o" "-_left;alias +fd o_rh1;alias +fa o_lh1;"
// R1
alias "o_rh1" "+_right;alias -fd rh1_o;alias +fa rh1_rh2;"
alias "rh1_o" "-_right;alias +fa o_lh1;alias +fd o_rh1;"
// W1
alias "o_wh1" "+_forward;alias -fw wh1_o;alias +fs wh1_wh2;"
alias "wh1_o" "-_forward;alias +fs o_sh1;alias +fw o_wh1;"
// S1
alias "o_sh1" "+_back;alias -fs sh1_o;alias +fw sh1_sh2;"
alias "sh1_o" "-_back;alias +fw o_wh1;alias +fs o_sh1;"
// W2
alias "wh1_wh2" "+_back;-_forward;alias -fs wh2_wh1;alias -fw wh2_sh1;"
alias "wh2_wh1" "-_back;+_forward;alias -fw wh1_o;alias +fs wh1_wh2"
// S2
alias "sh1_sh2" "+_forward;-_back;alias -fw sh2_sh1;alias -fs sh2_wh1;"
alias "sh2_sh1" "-_forward;+_back;alias -fs sh1_o;alias +fw sh1_sh2"
// L2
alias "lh1_lh2" "+_right;-_left;alias -fd lh2_lh1;alias -fa lh2_rh1;"
alias "lh2_lh1" "-_right;+_left;alias -fa lh1_o;alias +fd lh1_lh2"
// R2
alias "rh1_rh2" "+_left;-_right;alias -fa rh2_rh1;alias -fd rh2_lh1;"
alias "rh2_rh1" "-_left;+_right;alias -fd rh1_o;alias +fa rh1_rh2"
// RtoL
alias "rh2_lh1" "alias -fa lh1_o;alias +fd lh1_lh2;"
// LtoR
alias "lh2_rh1" "alias -fd rh1_o;alias +fa rh1_rh2;"
// StoW
alias "sh2_wh1" "alias -fw wh1_o;alias +fs wh1_wh2;"
// WtoS
alias "wh2_sh1" "alias -fs sh1_o;alias +fw sh1_sh2;"

bind ctrl "+duck;;+gensui"
bind shift "+sprint;;+gensui"
alias +gensui ";alias -gensui +gensui;" //重复执行准星不跟随
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*恢复初始键位代码不建议删，上梯要用
alias huifu huifu_on;
alias huifu_on "alias huifu huifu_off; -fa;-fd;-fw;-fs;-back;-forward;-right;-left;bind w "+forward"; bind s "+back"; bind a "+left"; bind d "+right" ;forwardback 0 0 0;rightleft 0 0 0;";
alias huifu_off "alias huifu huifu_on; -fa;-fd;-fw;-fs;-back;-forward;-right;-left;bind a "+fa";bind s "+fs";bind d "+fd";bind w "+fw";forwardback 0 0 0;rightleft 0 0 0;";
bind "v" "huifu"//上梯键位
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*连跳代码，不需要可全删掉，后两行的bind MWHEELDOWN和bind MWHEELUP是滚轮绑定键位，第一行是连跳键位，第二行是恢复成自己的键位(需要设置)
// alias +jump_ "+jump;+jump"
// alias -jump_ "-jump;-jump;-jump"
// alias jomp "+jump_;-jump_"
// alias gunlun gunlun_on //滚轮+帧数
// alias gunlun_on "alias gunlun gunlun_off;bind MWHEELDOWN jomp;bind MWHEELUP jomp;toggle fps_max 32"//滚轮链条+锁帧32
// alias gunlun_off "alias gunlun gunlun_on;bind MWHEELDOWN radio;bind MWHEELUP invprev;toggle fps_max 999"//滚轮恢复原设置+最大帧数
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*内格夫加速无声走(不可同时按wa或wd或sa或sd只能单独按方向键)不需要可全删掉
alias +ngfjb_w "+forward;forwardback -0.899 0 0;"
alias -ngfjb_w "forwardback 0 0 0;-forward"
alias +ngfjb_s "+back;forwardback +0.899 0 0;"
alias -ngfjb_s "forwardback 0 0 0;-back"
alias +ngfjb_a "+left;rightleft 0.899 0 0;"
alias -ngfjb_a "rightleft 0 0 0;-left"
alias +ngfjb_d "+right;rightleft -0.899 0 0;"
alias -ngfjb_d "rightleft 0 0 0;-right"
alias -ngfjb "forwardback 0 0 0;-forward"
alias ngfwsz "bind a +ngfjb_a;bind d +ngfjb_d;bind w +ngfjb_w;bind s +ngfjb_s;"
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*N键模式切换，建议保留，避免出错如果只要急停可以把N改为其他的键位
alias ALLsongkai "-fa;-fd;-fw;-fs;-back;-forward;-right;-left;forwardback 0 0 0;rightleft 0 0 0"//防止自动走路bug
alias qiehuan1 "ALLsongkai;gunlun_on ;alias qiehuan qiehuan2;cl_hud_color 6;"//红色HUD(连跳模式)
alias qiehuan2 "ALLsongkai;gunlun_off;ngfwsz;alias qiehuan qiehuan3;cl_hud_color 7;"//橙色HUD(内格夫速度叠加模式)
alias qiehuan3 "ALLsongkai;alias qiehuan qiehuan1;bind a "+fa";bind s "+fs";bind d "+fd";bind w "+fw";cl_hud_color 2;"//恢复为无冲松键急停模式
alias qiehuan qiehuan1//默认第一个切换
bind N "qiehuan"//N键切换alias "sh2_wh1" "alias -fw wh1_o;alias +fs wh1_wh2;toggle cl_crosshair_recoil 1"
// WtoS
alias "wh2_sh1" "alias -fs sh1_o;alias +fw sh1_sh2;toggle cl_crosshair_recoil 1"

bind ctrl "+duck;toggle cl_crosshair_recoil 0;+gensui"
bind shift "+sprint;toggle cl_crosshair_recoil 0;+gensui"
alias +gensui "toggle cl_crosshair_recoil 0;alias -gensui +gensui;toggle cl_crosshair_recoil 0" //重复执行准星不跟随
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*恢复初始键位代码不建议删，上梯要用
alias huifu huifu_on;
alias huifu_on "alias huifu huifu_off; -fa;-fd;-fw;-fs;-back;-forward;-right;-left;bind w "+forward"; bind s "+back"; bind a "+left"; bind d "+right" ;forwardback 0 0 0;rightleft 0 0 0;";
alias huifu_off "alias huifu huifu_on; -fa;-fd;-fw;-fs;-back;-forward;-right;-left;bind a "+fa";bind s "+fs";bind d "+fd";bind w "+fw";forwardback 0 0 0;rightleft 0 0 0;";
bind "v" "huifu"//上梯键位
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*连跳代码，不需要可全删掉，后两行的bind MWHEELDOWN和bind MWHEELUP是滚轮绑定键位，第一行是连跳键位，第二行是恢复成自己的键位(需要设置)
// alias +jump_ "+jump;+jump"
// alias -jump_ "-jump;-jump;-jump"
// alias jomp "+jump_;-jump_"
// alias gunlun gunlun_on //滚轮+帧数
// alias gunlun_on "alias gunlun gunlun_off;bind MWHEELDOWN jomp;bind MWHEELUP jomp;toggle fps_max 32"//滚轮链条+锁帧32
// alias gunlun_off "alias gunlun gunlun_on;bind MWHEELDOWN radio;bind MWHEELUP invprev;toggle fps_max 999"//滚轮恢复原设置+最大帧数
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*内格夫加速无声走(不可同时按wa或wd或sa或sd只能单独按方向键)不需要可全删掉
alias +ngfjb_w "+forward;forwardback -0.899 0 0;"
alias -ngfjb_w "forwardback 0 0 0;-forward"
alias +ngfjb_s "+back;forwardback +0.899 0 0;"
alias -ngfjb_s "forwardback 0 0 0;-back"
alias +ngfjb_a "+left;rightleft 0.899 0 0;"
alias -ngfjb_a "rightleft 0 0 0;-left"
alias +ngfjb_d "+right;rightleft -0.899 0 0;"
alias -ngfjb_d "rightleft 0 0 0;-right"
alias -ngfjb "forwardback 0 0 0;-forward"
alias ngfwsz "bind a +ngfjb_a;bind d +ngfjb_d;bind w +ngfjb_w;bind s +ngfjb_s;"
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//*N键模式切换，建议保留，避免出错如果只要急停可以把N改为其他的键位
alias ALLsongkai "-fa;-fd;-fw;-fs;-back;-forward;-right;-left;forwardback 0 0 0;rightleft 0 0 0"//防止自动走路bug
alias qiehuan1 "ALLsongkai;gunlun_on ;alias qiehuan qiehuan2;cl_hud_color 6;"//红色HUD(连跳模式)
alias qiehuan2 "ALLsongkai;gunlun_off;ngfwsz;alias qiehuan qiehuan3;cl_hud_color 7;"//橙色HUD(内格夫速度叠加模式)
alias qiehuan3 "ALLsongkai;alias qiehuan qiehuan1;bind a "+fa";bind s "+fs";bind d "+fd";bind w "+fw";cl_hud_color 2;"//恢复为无冲松键急停模式
alias qiehuan qiehuan1//默认第一个切换
bind N "qiehuan"//N键切换
