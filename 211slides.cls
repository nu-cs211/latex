\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{211slides}[2020/09/17 0.3]
\LoadClass[xetex,aspectratio=169]{beamer}

\def\CourseName{CS 211}

\newcommand\LecInfo[1]{
  \title{#1}
  \author{\CourseName}
}

\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{211lang}}
\ProcessOptions\relax

\RequirePackage{mathspec}
\RequirePackage{xltxtra}
\RequirePackage{xunicode}
\RequirePackage{solarslides}
\RequirePackage{solarpandoc}
\RequirePackage{graphicx}
\RequirePackage{alltt}
\RequirePackage{tikz}
\RequirePackage{boxnarrow}
\RequirePackage{booktabs}
\RequirePackage{underscore}
\RequirePackage{211base}
\RequirePackage{211lang}
\RequirePackage{hyperref}

\usetikzlibrary{
  backgrounds,
  bending,
  fit,
  decorations.pathmorphing,
  shapes.callouts,
  shapes.symbols,
}

% Fix to make PGF get along with xelatex
% from https://tex.stackexchange.com/questions/339827/draw-connection-between-node-in-forest-tree-diagram-and-something-outside-it/339975#339975
\def\pgfsys@hboxsynced#1{%
  {%
    \pgfsys@beginscope%
    \setbox\pgf@hbox=\hbox{%
      \hskip\pgf@pt@x%
      \raise\pgf@pt@y\hbox{%
        \pgf@pt@x=0pt%
        \pgf@pt@y=0pt%
        \special{pdf: content q}%
        \pgflowlevelsynccm% 
        \pgfsys@invoke{q -1 0 0 -1 0 0 cm}%
        \special{pdf: content -1 0 0 -1 0 0 cm q}% translate to original coordinate system
        \pgfsys@invoke{0 J [] 0 d}% reset line cap and dash
        \wd#1=0pt%
        \ht#1=0pt%
        \dp#1=0pt%
        \box#1%
        \pgfsys@invoke{n Q Q Q}%
      }%
      \hss%
    }%
    \wd\pgf@hbox=0pt%
    \ht\pgf@hbox=0pt%
    \dp\pgf@hbox=0pt%
    \pgfsys@hbox\pgf@hbox%
    \pgfsys@endscope%
  }%
}

%% booktabs config
\heavyrulewidth=2pt
\lightrulewidth=1.25pt

%% Font setup
\def  \MainFace                 {NHaasGroteskDSPro-55Rg}
\def  \MainFaceLight            {NHaasGroteskDSPro-35XLt}
\def  \MonoFace                 {Input Mono Compressed}

\setallmainfonts[Numbers=Lining]{\MainFace}
\setallsansfonts[Numbers=Lining]{\MainFace}
\setallmonofonts[Scale=MatchLowercase]{\MonoFace}
\def\commentFont{\fontspec{\MonoFace}\itshape}

\setbeamertemplate{title page}{%
  \begin{center}
    {%
      \color{solarizedBlue}%
      \fontspec{\MainFaceLight}%
      \fontsize{48pt}{50pt}%
      \selectfont
      \inserttitle
      \par\bigskip
    }
    {%
      \fontspec{\MainFace}%
      \fontsize{20pt}{22pt}%
      \selectfont
      \insertauthor
    }%
  \end{center}
}

\setbeamersize{text margin left=.75in,text margin right=.75in}

\setbeamercolor{alerted text}{fg=solarizedViolet}
\setbeamercolor*{frametitle}{fg=solarizedCyan}
\setbeamercolor*{title}{fg=solarizedBlue}

\tikzset{
  common object/.style={
    draw = #1,
    very thick,
  },
  every object/.style={
    common object = solarizedOrange,
    font = \ttfamily\slshape\color{solarizedCyan},
    fill = white,
  },
  every vector/.style={
    common object = solarizedGreen,
  },
  every struct/.style={
    common object = solarizedYellow,
  },
  every pointer anchor/.style={
    very thick,
    draw = solarizedMagenta,
    fill = solarizedMagenta!30!solarizedBase2,
  },
  every pointer arrow/.style={
    very thick,
    draw = solarizedMagenta,
  },
  every null pointer/.style={
    very thick,
    draw = solarizedRed,
  },
  wild pointer/.style={
    looseness = 33,
    bend right,
    decorate,
    decoration={
      random steps,
      segment length=20pt,
      amplitude=2pt,
    },
  },
}

\newcommand\don@tHyphenate{\hyphenpenalty=10000\relax}
\tikzset{
  note/.style={
    rectangle callout,
    anchor = pointer,
    very thick,
    align = center,
    callout relative pointer = {(#1)},
    font = \color{solarizedBase01}\footnotesize\don@tHyphenate,
    note width,
    note color,
  },
  note/.default = {0,-.5},
  note width/.style={
      text width = #1\paperwidth,
  },
  note width/.default = 0.2,
  note color/.style={
    draw = #1!50!solarizedBase00,
    fill = #1!8!solarizedBase2,
  },
  note color/.default = solarizedGreen,
}

\newcommand<>\Note[3][]{%
  {%
    \tikz[overlay, remember picture]
      \node#4 [note={#2}, #1] {%
        \lstset{basicstyle=\ttfamily\color{black}}%
        \ignorespaces #3};%
  }\ignorespaces
}

\def\wasp{%
  \includegraphics[height=.7em]{images/wasp.png}%
}
\def\dwasp{\wasp\hfill\wasp\hfill}
\def\qwasp{\dwasp\dwasp}
\def\owasp{\qwasp\qwasp}

\colorlet{BloodRed}{solarizedRed!75!black}
\colorlet{BloodPink}{solarizedRed!50!white}

\newcommand\textUB@common[3]{{%
  \fontspec[Scale=#1]{#2}%
  \ifsolarizedlight
    \color{BloodRed}%
  \else
    \color{BloodPink}%
  \fi
  #3%
}}

\newcommand\textUB[1][1.2]{\textUB@common{#1}{Shlop}}
\newcommand\TEXTUB[1][1.2]{\textUB@common{#1}{ShlopShloppy-Regular}}

\newcommand\BigMenlo{\normalsize\fontspec[Scale=3]{Menlo}}

\newcommand<>\SUCCESS[1][]{%
  \tikz \node#2[
    overlay,
    anchor=west,
    circle,
    draw,
    fill=green!35!white,
    green!50!black,
    font=\BigMenlo,
    line width=2pt,
    #1
  ] {✔};
}

\newcommand<>\FAILURE[1][]{%
  \tikz \node#2[
    overlay,
    anchor=west,
    circle,
    draw,
    fill=yellow!35!white,
    red,
    font=\BigMenlo,
    line width=2pt,
    decorate,
    decoration={
      random steps,
      segment length=3pt,
      amplitude=1pt,
    },
    #1
  ] {✘};
}

\newcommand<>\BOOM[1][]{%
  \tikz \node#2[
    overlay,
    anchor=west,
    starburst,
    draw,
    fill=solarizedOrange!35!white,
    solarizedRed,
    font=\rmfamily\scshape,
    line width=2pt,
    #1
  ] {!?!?!};%
}

\def\VarObj#1 = #2;{%
  \quad\textit{\strut #1}:%
  \Var{}{\strut #2}\quad%
}

\newcommand\Cons[3][]{%
  \Struct[#1] {
    \Field car: #2\\
    \Field cdr: #3\\
  }%
}

\newcommand\StackFrame[2][]
  {\tikz [baseline, remember picture]
     \node [
       anchor=base,
       font=\color{solarizedBase01},
       draw=solarizedYellow,
       very thick,
       dotted,
       fill=solarizedBase2,
       #1
     ] {\begin{tabular}{@{}r@{\VarSep}l@{}}#2\end{tabular}};}

\def\ZII@hyper#1{%
  \if#1\relax
    \let\@ZII@hyper@wrap\relax
  \else
    \def\@ZII@hyper@wrap{\hypertarget{#1}}
  \fi
  \@ZII@hyper@wrap
}
% ZII means 211

\newcommand\PlainFrame[3][t]{
  \begin{frame}[#1]{#2}{}
    \thispagestyle{empty}
    #3
  \end{frame}
}

\newcommand\DarkFrame[3][t]{
  \setSolarizedDark
  \PlainFrame[#1]{#2}{#3}
  \setSolarizedLight
}

\newcommand\TitleFrame{
  \PlainFrame[c]{}{\titlepage}
}

\newcommand\CenterFrame[3][c]{
  \PlainFrame[#1]{#2}{
    \begin{center}
      #3
    \end{center}
  }
}

\newcommand\NextTimeFrame[1]{
  \CenterFrame{}{-- Next time: #1 --}
}

\newcommand\IntentionallyBlankFrame{
  \CenterFrame{}{
    \tiny
    \if@cxx
      \textCode{Page* intentionally_blank = nullptr;}
    \else
      \textCode{struct page* intentionally_blank = NULL;}
    \fi
  }
}

\newcommand\TitleHead{
  \hfill
  \fontspec{\MainFaceLight}%
  \color{solarizedBlue}%
  \hyperlink{page.1}{\inserttitle}%
}

\newcommand\RoadMapFrame{
  \PlainFrame[t]{Road map\TitleHead}{
    \tableofcontents[pausesections]%
    \vskip0pt plus10fill\relax
  }
}

\newcommand\ProgressFrame[1]{
  \DarkFrame[t]{Up next\TitleHead}{
    \tableofcontents[#1]
    \vskip0pt plus10fill\relax
  }
}

\newcommand\SectionFrame[1][]{
  \ProgressFrame{sectionstyle=show/shaded,subsectionstyle=shaded}
}

\newcommand\SubsectionFrame[1][]{
  \ProgressFrame{sectionstyle=shaded,subsectionstyle=show/shaded}
}

\newcommand\progname[1]{\BasicCodeText{\textsl{#1}}}
\newcommand\hostname[1]{\BasicCodeText{#1}}
\newcommand\filename[1]{\BasicCodeText{#1}}
\newcommand\varname[1]{\BasicCodeText{\textsl{#1}}}
\newcommand\functionname[1]{\FunctionText{#1}}
\newcommand\functionref[2]{\functionname{#1}\BasicCodeText{(#2)}}
\newcommand\keycombo[1]{\underline{#1}}

\newcommand\hibox[1]
  {\fcolorbox{solarizedBase00}{solarizedBase2}
    {\color{solarizedBase01}{#1}}}
\newcommand\varbox[2][2]
  {\hibox{\hskip#1cm\llap{#2}}}

\newcommand\footmark{\@ifnextchar*{\footmarkast\@gobble}\footmarkother}
\newcommand\footmarkast{\,{\normalsize*}\,\ignorespaces}
\newcommand\footmarkother[1]{\,\raisebox{4pt}{\scriptsize#1}\,\ignorespaces}

\def\InstructionPointerColor{\color{solarizedRed}}
\def\ReturnAddressColor{\color{solarizedBlue}}

\newcommand\ErrorText[1]{\textcolor{solarizedRed}{#1}}

\colorlet{PlainCode}{solarizedRebase2}

\newcommand\BasicCodeText[1]{\textcolor{PlainCode}{\normalfont\ttfamily #1}}
\newcommand\KeywordText[1]{\BasicCodeText{\textKeyword*{#1}}}
\newcommand\DataTypeText[1]{\BasicCodeText{\textData*{#1}}}
\newcommand\FunctionText[1]{\BasicCodeText{\textFunction*{#1}}}
\newcommand\PreprocessorText[1]{\BasicCodeText{\textPragma*{#1}}}
\newcommand\LiteralText[1]{\BasicCodeText{\textLiteral*{#1}}}
\newcommand\StringText[1]{\LiteralText{#1}}
\newcommand\CommentText[1]{\BasicCodeText{\textC{#1}}}

% Improving comment font:
\let\oldTextC\textC
\def\textC#1{\oldTextC{\commentFont#1}}

\lstset{
  escapeinside={«»},
  upquote=true,
  basicstyle=\ttfamily\color{PlainCode},
  commentstyle=\textC, % Comment
  directivestyle=\textP, % Comment
  stringstyle=\textL, % Literal
  numberstyle=\textL, % Literal
  keywordstyle=[1]\textF, % Function
  keywordstyle=[2]\textK, % Keyword
  keywordstyle=[3]\relax, % [empty]
  keywordstyle=[4]\textT, % Type
  keywordstyle=[5]\textM, % Macro
  keywordstyle=[6]\textT, % Type
  keywordstyle=[7]\textD, % Data
}

\lstnewenvironment{ShellScript}[1][]
{%
  \begingroup
  \lstset{language=sh,
    basicstyle=\ttfamily\color{PlainCode},
    keywordstyle=\color{solarizedGreen},
    stringstyle=\color{solarizedCyan},
    commentstyle=\color{solarizedBase00}\rmfamily\slshape,
    morecomment=[l][\color{solarizedMagenta}\slshape]{\#},
  #1}%
}
{%
  \endgroup
}

\newcommand\shelltext[1]{\texttt{\textcolor{solarizedGreen}{#1}}}
\newcommand\shellprompt{{\color{solarizedCyan}\%}}
\newcommand\SH{\@ifnextchar*{\@firstoftwo\SH@one@star}\SH@two@pause}
\newcommand\SH@one@star{\@ifnextchar*{\@firstoftwo\SH@no@pause}\SH@one@pause}
\newcommand\SH@no@pause[2][\shellprompt]{#1 \shelltext{#2}}
\newcommand\SH@one@pause[2][\shellprompt]{\SH@no@pause[#1]{#2\pause}}
\newcommand\SH@two@pause[2][\shellprompt]{\SH@one@pause[#1]{\pause#2}}

\newcommand\shellcomment{\textcolor{solarizedCyan}}
\newcommand\CO[1]{\shellcomment{\# #1}}

\newdimen\seq@ht
\newdimen\seq@wd

\newcommand\seq@next[1]{%
  \@ifnextchar<
    {\seq@continue{#1}}
    {\seq@finish{#1}}%
}

\def\seq@continue#1<#2>#3{%
  \setbox0=\hbox{#3}%
  \@tempdima=\wd0%
  \@tempdimb=\ht0%
  \ifdim\@tempdima>\seq@wd\seq@wd=\@tempdima\fi
  \ifdim\@tempdimb>\seq@ht\seq@ht=\@tempdimb\fi
  \seq@next{#1\only<#2>{#3}}%
}

\newcommand\seq@finish[1]{%
  \vbox to \seq@ht{\hbox to \seq@wd{\hfill#1\hfill}}%
}

\newcommand\seq[1]{{%
  \seq@wd=0pt%
  \seq@ht=0pt%
  \seq@next{}#1%
}}

\newcounter{index@count}
\newcounter{index@step}
\newcommand\index@style{}

\newcommand\setIndexCounterStyle[1]{%
  \renewcommand\index@style{#1}%
}

\newcommand\resetIndexCounter[2][100]{%
  \setcounter{index@count}{#1}%
  \setcounter{index@step}{#2}%
}

\newcommand\changeIndexCounterStep{%
  \setcounter{index@step}%
}

\newcommand\useIndexCounter{%
  {\index@style{\theindex@count}}%
  \addtocounter{index@count}{\value{index@step}}%
}

\newcommand<>\keyterm[1]{%
  \textcolor#2{solarizedCyan}{#1}%
}

\newcommand\metavar[1]{%
  \textcolor{solarizedBase01}{%
    \normalfont
    \ensuremath{
      \langle
      \text{%
        \color{solarizedViolet}%
        \rmfamily
        \itshape
        #1}
      \rangle
    }%
  }%
}

\newcommand\listingfiletext[1]{%
  {\color{solarizedViolet}\ttfamily\small#1}%
}

\newcommand\listingfileframe[1]{%
  \fcolorbox{black}{white}{#1}%
}

\newcommand\listingfile[1]{%
  \hfill\listingfileframe{\listingfiletext{#1}}%
}

\newcommand\UseVar[1]{\csname ZII@Var@#1\endcsname}

\newcommand\SetVar[3][1]{%
  \only<#1->{%
    \expandafter\def\csname ZII@Var@#2\endcsname{#3}}}

\newcommand<>\CodeCursor[1][solarizedRed]{%
  \uncover#2{\textcolor{#1}{$\blacktriangleright$}}%
}

\def\@long@link@fmt#1{\mbox{\footnotesize#1}}

\def\CodeSetup@link@long{\url{\WEBROOT/\jobname.zip}}

\def\CodeSetup@link{\@long@link@fmt{\CodeSetup@link@long}}

\newcommand\CodeSetupFrame@web{
  \begin{center}
    The code in this video is available on the web at
    \par\medskip
    \CodeSetup@link
  \end{center}
}

\newcommand\CodeSetupFrame@shell{
  The code in this course is available in your Unix shell account.
  You can get your own copy like this:
  \par
  \begingroup
  \ttfamily
  \begin{tabular}{l}
    \SH**{cd cs211} \\
    \SH**{tar -xvkf \~{}cs211/lec/\jobname.tgz} \\
    \vdots \\
    \SH**{cd \jobname} \\
  \end{tabular}
  \endgroup
}

\newcommand\CodeSetupFrame[1][\relax]{
  \begin{frame}{Initial code setup}
    \if@cxx
      \CodeSetupFrame@web
    \else
      \CodeSetupFrame@shell
    \fi
    #1
  \end{frame}
}

\newcommand\CodeSetupFrameUrl[2][\relax]{
  \def\CodeSetup@link{
    \url{#2}
    \par
    \@long@link@fmt{(\CodeSetup@link@long)}
  }
  \CodeSetupFrame[#1]
}

% Deprecated
\let\CSetupFrame\CodeSetupFrame

\AtBeginSection[]{\SectionFrame}
\AtBeginSubsection[]{\SubsectionFrame}

\newcommand\UnSkip[1][1]{\vspace{-#1\baselineskip}}

\CaretCode
