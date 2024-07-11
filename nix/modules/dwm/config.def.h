/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */ static const unsigned int borderpx  = 5;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrains Mono:size=12" };
static const char dmenufont[]       = "monospace:size=12";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_purple1[]     = "#864AF9";
static const char col_purple2[]     = "#7E30E1";
static const char col_blue1[]       = "#3B3486";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray1 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_purple1  },
   	[SchemeStatus]  = { col_gray3, col_gray1,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { col_gray4, col_gray2,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
	[SchemeTagsNorm]  = { col_gray3, col_gray1,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
	[SchemeInfoSel]  = { col_gray4, col_gray1,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
	[SchemeInfoNorm]  = { col_gray3, col_gray1,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}

};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "copyq",    NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "III",      horizontal },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };

static const char *termcmd[]  = { "st", NULL };
static const char *telegram[] = { "telegram-desktop", NULL };
static const char *obsidian[] = { "obsidian", NULL };
static const char *copyq[] = { "copyq", "clipboard", NULL };
static const char *flameshot[] = { "flameshot", "gui", NULL };
static const char *full_screenshot[] = { "flameshot", "full", NULL };
static const char *browser[] = {"chromium", NULL}; 

static const char *suspend[] = { "systemctl", "suspend", NULL };
static const char *reboot[] = { "reboot", NULL };
static const char *poweroff[] = { "poweroff", NULL };
static const char *logout[] = { "logout_system", NULL };

static const char *volume_mute[] = { "/etc/nixos/dwm/scripts/change_volume", "-m", NULL };
static const char *volume_up[] = { "/etc/nixos/dwm/scripts/change_volume", "-i", NULL };
static const char *volume_down[] = { "/etc/nixos/dwm/scripts/change_volume", "-d", NULL };

static const char *brightness_up[] = { "/etc/nixos/dwm/scripts/change_brightness", "-i", NULL };
static const char *brightness_down[] = { "/etc/nixos/dwm/scripts/change_brightness", "-d", NULL };

static const char *toggle_grey[] = {"/etc/nixos/dwm/scripts/toggle_grey", NULL};


static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ Mod1Mask,                     XK_t,      spawn,          {.v = telegram } },
	{ MODKEY,                       XK_o,      spawn,          {.v = obsidian } },
	{ MODKEY,                       XK_v,      spawn,          {.v = copyq} },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = flameshot} },
	{ MODKEY,                       XK_b,      spawn,          {.v = browser } },

	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
	{ MODKEY|Mod1Mask,              XK_b,      hideborder,     {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ Mod1Mask,                     XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_minus,  setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },

	{ MODKEY|Mod1Mask,              XK_j,   moveresize,     	{.v = "0x 25y 0w 0h" } },
	{ MODKEY|Mod1Mask,              XK_k,   moveresize,     	{.v = "0x -25y 0w 0h" } },
	{ MODKEY|Mod1Mask,              XK_l,  	moveresize,    		{.v = "25x 0y 0w 0h" } },
	{ MODKEY|Mod1Mask,              XK_h,   moveresize,     	{.v = "-25x 0y 0w 0h" } },
	{ MODKEY|ShiftMask,             XK_j,   moveresize,     	{.v = "0x 0y 0w 25h" } },
	{ MODKEY|ShiftMask,             XK_k,   moveresize,     	{.v = "0x 0y 0w -25h" } },
	{ MODKEY|ShiftMask,             XK_l,  	moveresize,    		{.v = "0x 0y 25w 0h" } },
	{ MODKEY|ShiftMask,             XK_h,   moveresize,     	{.v = "0x 0y -25w 0h" } },
	{ MODKEY|ControlMask,           XK_k,   moveresizeedge, 	{.v = "t"} },
	{ MODKEY|ControlMask,           XK_j,   moveresizeedge, 	{.v = "b"} },
	{ MODKEY|ControlMask,           XK_h,   moveresizeedge, 	{.v = "l"} },
	{ MODKEY|ControlMask,           XK_l,  	moveresizeedge,		{.v = "r"} },
	{ MODKEY|ControlMask|ShiftMask, XK_k, 	moveresizeedge, 	{.v = "T"} },
	{ MODKEY|ControlMask|ShiftMask, XK_j,   moveresizeedge, 	{.v = "B"} },
	{ MODKEY|ControlMask|ShiftMask, XK_h,   moveresizeedge, 	{.v = "L"} },
	{ MODKEY|ControlMask|ShiftMask, XK_l,  	moveresizeedge,		{.v = "R"} },

	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },

	{ MODKEY|Mod1Mask,              XK_s,      spawn,          {.v = suspend } },
	{ MODKEY|Mod1Mask,              XK_r,      spawn,          {.v = reboot } },
	{ MODKEY|Mod1Mask,              XK_l,      spawn,          {.v = logout } },
	{ MODKEY|Mod1Mask,              XK_p,      spawn,          {.v = poweroff } },

	{ 0,                            XF86XK_AudioMute,        spawn, {.v = volume_mute } },
	{ 0,                            XF86XK_AudioRaiseVolume, spawn, {.v = volume_up} },
	{ 0,                            XF86XK_AudioLowerVolume, spawn, {.v = volume_down} },

	{ 0,                            XF86XK_MonBrightnessUp,    spawn, {.v = brightness_up} },
	{ 0,                            XF86XK_MonBrightnessDown,  spawn, {.v = brightness_down} },

	{ MODKEY,                       XK_x,      movecenter,     {0} },

	{ MODKEY,			XK_g,			spawn,	{.v = toggle_grey} },
	{ 0,         			XK_Print, 		spawn, 	{.v = full_screenshot} },
};

/* button definitions */ /* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */ static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
