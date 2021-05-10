---
layout: post
title: Literate adventures in C - warming up
tags:
  - programming
  - refactoring
  - polyglot
  - books
author: Willem van den Ende
image: /attachments/blogposts/2021/tpop-book-cover.jpg
---

[Jez Higgins](https://www.jezuk.co.uk/about.html) and [Chris Oldwood](http://www.chrisoldwood.com/articles.htm) recommended [The Practice of Programming](https://www.cs.princeton.edu/~bwk/tpop.webpage/) book to me when we were working on an enterprise C++ project. It is from the same vintage as Extreme Programming Explained and Refactoring, but quite different. It is multi-language, but some of the exercises are in `C` (not surprising, given the authors&rsquo; backgrounds). I got started on it last year, but life got in the way, and I needed to practice my C a bit before being able to do anything meaningful in it. Now that Rob and I are prepping for a C++ TDD / Legacy code training next month, I&rsquo;m in the right frame of mind to also dive deeper into C.

![img](/attachments/blogposts/2021/tpop-book-cover.jpg "The Practice of Programming book cover.")


## Table of Contents

1.  [Why on earth would you program in C?](#org46c8e62)
2.  [The one thing I wished I had known when learning C](#orgf9c3736)
    1.  [How to do baby steps in C then?](#org8e18193)
    2.  [What is this magic?](#org9892b7e)
3.  [My warm-up has warm-ups, exploring literate C programming](#org7e99251)
    1.  [First named function with parameter: square](#orgd7ad7d5)
    2.  [Call a block by name](#org7bec954)
4.  [An editors&rsquo; table as input](#orgc3fbddf)
5.  [Two steps forward, one step back](#org3cf1d0b)
6.  [Now we can call the built-in qsort.](#org4cd927a)
7.  [Extract the comparator](#org2a0247c)
8.  [A horizontal table](#org943fe32)
9.  [Some of the blocks re-refactored by the QWAN ensemble](#orge160085)
10. [Extract the print code into a function](#orgc0d8c30)
11. [Four tabs for tangling code blocks in org-mode](#org43809ad)
12. [What next?](#orgc596a48)

I showed this to Marc and Rob and they thought it was fun. I&rsquo;m also sharing some of my failures, following a recent discussion on twitter that people only publish things when they gone well, or when they have been heavily edited. This may lead readers to believe that they could not possibly do such a thing.

## <a id="org46c8e62"></a>Why on earth would you program in C?

The &rsquo;logical&rsquo; reason is that `C` is still one of the best languages to maintain existing `C` programs in. Your house probably runs on a few million lines of `C` code (in your heating, your ovens, kitchen timers, smart meters, and for me every year since 2000 has been the year of linux on the desktop, and guess what the linux kernel is made of?. My editor may look lispy, but is also built on C). So learning a bit of C is good, even if it just to get over ones&rsquo; fear of the unknown.

The illogical reason is that programming in `C` is like leaving your comfy dwelling, and going camping in a tent, possibly with some thunder storms around. Programming in a language where the `unsafe` keyword is called `int main()` is just fun!

If you told me 25 years ago I would say I would program C for relaxation, I might have disagreed. I had been taught program with pointers, but making a mistake often meant a blue screen, and a minutes long reboot of my computer. So I dabbled in C, and soon left for more comfortable environments. In a Unix (this post was written on MacOs and Linux), C&rsquo;s natural habitat, the experience is different: a segfault just means a message in my editors&rsquo; window and another quick try. Computers are now fast enough to compile a bit of `C` in an instant.


## <a id="orgf9c3736"></a>The one thing I wished I had known when learning C

Was *working in baby steps*. Admittedly, getting evenings full of blue screens and reboots was not very motivating. I figured this out a couple of years later, when I was working in a C++ codebase. The Solaris tooling had a debugger that would let me make some changes in an implementation (.cpp) file, and restart an execution from where it was. I couldn&rsquo;t believe it was not Smalltalk. I learnt working in baby steps, because the compile times in that project were long, and it took me a month of working like that to get them into a doable state (45 minutes down to 5 or so).


### <a id="org8e18193"></a>How to do baby steps in C then?

I decided to not leave the comfort of my editor ([org-roam](https://www.orgroam.com) inside [Doom Emacs](https://github.com/hlissner/doom-emacs)), and do literate programming for a bit. This means I can write a bit of code, and write my thoughts about it right where I am. The warm up was easy, refactoring required learning a bit more about org-babel. I&rsquo;ve put the resources I found useful at the end of the post.

I&rsquo;ve used this setup before for emacs lisp, but not for C, so I wasn&rsquo;t sure what to expect. Let&rsquo;s start with hello world.

    printf("Hello org-babel again!");

Pressing ctrl-c, ctrl-c generates a `main()` function, builds it, and if successful, runs it. And puts the results in the text. So far so good. That was easy, and got me hooked into doing more of it.

### <a id="org9892b7e"></a>What is this magic?

I&rsquo;m using [Doom Emacs](https://github.com/hlissner/doom-emacs), installing things like C compilers and wiring them up is relatively easy, as Doom doctor told me which bits I was missing.
The  [C, C++, D Source Code Blocks in Org Mode](https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-C.html) documentation got me through the first couple of code blocks.

This is a kind of magic, it also works on mac, and I don&rsquo;t even know which C compiler was used. Instead of typing commands, I can edit code live, and see the results instantly. Fast feedback is fun.

## <a id="org7e99251"></a>My warm-up has warm-ups, exploring literate C programming

I wanted to do an exercise around quicksort from the book, but first, how can I use variables and stuff in my code.

## An editors&rsquo; table as input

One of the more &rsquo;tent&rsquo; like aspects of C is that it does not have a package manager. There is [Theft - Property-Based Testing for C](https://github.com/silentbicycle/theft), but I thought i&rsquo;d get to installing that later. Having a list of numbers as input would be good enough to start with.

I started with a table with just one column. org-mode graciously adds a header when calling `org-create-table`, so in good `C` style I used one letter for the header, as it is just a bunch of numbers.

<table id="orgf022b17" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-right">n</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-right">2000</td>
</tr>


<tr>
<td class="org-right">10</td>
</tr>


<tr>
<td class="org-right">300</td>
</tr>
</tbody>
</table>

Let&rsquo;s just print the numbers, and see what we got, passing our named table as `:var`. I renamed it to highlight what is source and destination.

I wanted to print the cell contents, copying some code out of documentation I found. But I got segfaults instead. So I took a step back, and print just the row numbers, to see that we can get a table as output:

    #include "stdlib.h"
    #include "stdio.h"
    int main()
    {
      for (int i=0; i<somedata_rows; i++) {
        printf ("%2d ", i); // print the column number
        // here I wanted to print the cell contents, but got segfaults on my initial code.
        printf("\n");
      }
      return 0;
    }

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />
</colgroup>
<tbody>
<tr>
<td class="org-right">0</td>
</tr>


<tr>
<td class="org-right">1</td>
</tr>


<tr>
<td class="org-right">2</td>
</tr>
</tbody>
</table>

Tapping C-c C-v v, per the manual, gives us the generated source code. We get a two dimensional array out.
Here is part of the generated code that shows our &rsquo;unsorted&rsquo; as &rsquo;somedata&rsquo;.

    int somedata[3][1] = {
     {1},
     {10},
     {3}
    };
    const int somedata_rows = 3;
    const int somedata_cols = 1;

Our table has been turned into a two-dimensional array, with the rows first, and the columns second. We are only interested in one column

> narrator: To prevent a segfault, willem should have read the copy-pasted types more closely, that would have saved him some debugging time. Using org syntax for the table did save him from looking up how to write this bit of boilerplate out in C.

Rob later pointed out that a two-dimensional array in `C` is just a figment of your imagination. Nothing is stopping you from accessing it as a one dimensional array, or even a struct, if you feel so inclined.

## <a id="org3cf1d0b"></a>Two steps forward, one step back

The previous was an iteration of many steps. I kept getting segfaults when
trying to print the cell. So I was tempted to break out a debugger, since print
driven development does not seem to work for me here.

But stepping away for a bit, and actually reading the code that I dilligently
copy pasted&#x2026; the column has already been converted to ints.

Since printf is stringly typed, we don&rsquo;t get a compiler error, but a segfault.
The code I pasted had `const char*` for the cell. We don&rsquo;t have char pointers (also known as strings) here, we have ints. So when we write that correctly, we can print the values.

    #include "stdlib.h"
    #include "stdio.h"
    int main()
    {
      for (int i=0; i<somedata_rows; i++) {
        printf ("%2d ", i);
        printf("%2d ", somedata_cols);
        // should have called this row, but kept name from documentation code...
        int j=0;
        const int cell = somedata[i][j];
        printf("%2d ", cell);
        printf("\n");
      }
      return 0;
    }

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<tbody>
<tr>
<td class="org-right">0</td>
<td class="org-right">1</td>
<td class="org-right">2000</td>
</tr>


<tr>
<td class="org-right">1</td>
<td class="org-right">1</td>
<td class="org-right">10</td>
</tr>


<tr>
<td class="org-right">2</td>
<td class="org-right">1</td>
<td class="org-right">300</td>
</tr>
</tbody>
</table>

Ok, so we know how to input, and output a table of numbers. We can use this as a kind of example based test for our QuickSort.

## <a id="org4cd927a"></a>Now we can call the built-in qsort.

So The Practice Of Programming has a QuickSort example, and asks the reader to convert it from recursive to iterative. In C. I managed to sketch out an iterative example on paper, but I know too little of allocation in C to do that in one go. A baby step would be to convert the recursive calls to pushes on our own stack, and iterate until the stack is empty. Starting off with pushing the initial interval on the stack.

An optimization could then be to keep current<sub>interval</sub>, and only push the right hand side of the division on the stack. But we&rsquo;d need some kind of test. Tables are a nice start. Further on in the book, they remark there is a standard implementation called &rsquo;qsort&rsquo;.

So lets&rsquo; start with using `qsort` from the standard library. Ths took me a couple of tries, I had accidentally put my `#include` s inside the `main`. It requires a comparator function. The book, provided `icmp`, so I typed that in:

    #include "stdlib.h"
    #include "stdio.h"
    
    /* icmp: integer compare of *p1 and *p2 */
    int icmp(const char * p1, const char * p2) {
      int v1, v2;
    
      v1 = *p1;
      v2 = *p2;
    
      if (v1 < v2)
          return -1;
      else if (v1 == v2)
          return 0;
      else
          return 1;
    }
    
    int main() {
        const int N = 3;
        int arr[3] = { -100, 10, 3 };
        qsort(arr, N, sizeof(int), icmp );
        // qsort modifies arr in place, and we can't
        // return a list from main. so print it instead
        for(int i=0; i<N;i++) {
           printf("%2d ", arr[i]);
           printf("\n"); // newline gives us the table rendering
        }
    }

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />
</colgroup>
<tbody>
<tr>
<td class="org-right">-100</td>
</tr>


<tr>
<td class="org-right">3</td>
</tr>


<tr>
<td class="org-right">10</td>
</tr>
</tbody>
</table>

So, we can call a library function. C doesn&rsquo;t come with much out of the box, don&rsquo;t try finding data structures such as a stack in it. This was common for mainstream languages up until about Java. But we have `qsort`, so we can build the scaffolding we need for our own version of it.

## <a id="org2a0247c"></a>Extract the comparator

Extract out `icmp` in its&rsquo; own org-mode block, so I don&rsquo;t have to repeat it all the time:

    /* icmp: integer compare of *p1 and *p2 */
    int icmp(const void * p1, const void * p2) {
      int v1, v2;
    
      v1 = *(int *) p1;
      v2 = *(int *) p2;
    
      if (v1 < v2)
          return -1;
      else if (v1 == v2)
          return 0;
      else
          return 1;
    }

This broke down, and was a large step, as it was / is not obvious how to export just some code to a file, in the same location as the next block.
Eventually, I got it working, after [Four browser tabs](#org43809ad). I almost gave up - there is always the option to use `.h` and `.c` files in an IDE,  and not use literate programming for learning. **Almost**, I am glad I got this working. The `:tangle` headers above are now unnecessary. The `:exports` header prevents execution of the code block, which is useful, as there is nothing to execute. I&rsquo;ll leave them in the text as evidence of my going around in circles.~

Cool, we have a function. Now we need to tell org-babel how to use it. `<<icmp>>` works, as long as we have the `:noweb yes` header in both the source and destination block.

## <a id="org943fe32"></a>A horizontal table

I sort of started almost writing a test there, at the top of main. Some sample data to kick off the sort. I didn&rsquo;t use org-mode for a table, because I got all rows, and didn&rsquo;t want to do array manipulation just to get some data.

Stepping away from the keyboard, I realised that if I layed out the table in org-mode horizontally, I didn&rsquo;t need much magic.
Now for our horizontal table:

<table id="org3186330" border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<tbody>
<tr>
<td class="org-right">1</td>
<td class="org-right">0</td>
<td class="org-right">-100</td>
<td class="org-right">10</td>
<td class="org-right">420</td>
</tr>
</tbody>
</table>

Then assign it to the variable we had before, so we can take a tiny step.

Let&rsquo;s give this block a separate name, otherwise the RESULTS block will end up with the previous one.

    #include "stdlib.h"
    #include "stdio.h"
    /* icmp: integer compare of *p1 and *p2 */
    int icmp(const void * p1, const void * p2) {
      int v1, v2;
    
      v1 = *(int *) p1;
      v2 = *(int *) p2;
    
      if (v1 < v2)
          return -1;
      else if (v1 == v2)
          return 0;
      else
          return 1;
    }
    
    int main() {
        int N = 5;
        // get the first row of our one-row table
        int* arr = unsorted[0];
    
        qsort(arr, N, sizeof(int), icmp );
        // print the array
        for(int i=0; i<N;i++) {
           printf("%2d ", arr[i]);
        }
        printf("\n");
    }

    -100  0  1 10 420

And it works as expected, all nicely sorted :-).

## <a id="orge160085"></a>Some of the blocks re-refactored by the QWAN ensemble

So this post isn&rsquo;t even going to make it to QuickSort by the book. I showed the above to Rob and Marc yesterday, and we had some more fun. Marc and I learnt C in trial by fire style, as part of our operating systems class in Uni. &rsquo;but we don&rsquo;t know C&rsquo;, &rsquo;You&rsquo;ll pick it up&rsquo;. Rob was actually taught C for a whole two weeks (not much, given the care one needs to use it safely. ).

Anyway. Marc and Rob remembered some things to make the code more interesting, and in some cases, tidier. So the `const void *` in the `icmp` parameter list could be `const int *`

aside: reading the symbols aloud

> I notice I&rsquo;m not reading `const int star` but `const int pointer`. Reading the symbols out loud (for some definition of out loud) helps in understanding the code while you read. I&rsquo;m pointing this out, because I forgot about this while practicing Haskell, and a freshly graduated hire that I was on-boarding through bits of pair-programming asked me what I called the symbols. After about two symbols I went ehhh&#x2026; and had to look up the documentation.
> C and C++ code can be equally cryptic, verbalising the symbols can help reinforce your understanding of the code. When you don&rsquo;t know how to pronounce a symbol, look it up.

Mind you, I&rsquo;m not saying &rsquo;curly brace&rsquo;, there are limits. Maybe I should try that some time.

Anyway, changing the coid pointers to int pointers allows us to get rid of a cast, so  `v1 = *(int *) p1` becomes `v1 = *p1`. Since I got the definition of `icmp` from [The Practice Of Programming](https://www.cs.princeton.edu/~bwk/tpop.webpage/) , there may be something we overlooked here, let us know if you know what it is.

I find it interesting that the only place in `qsort` where the type of the actual data is needed is the `icmp` function. When I learnt C I thought function pointers, like `icmp` here, were some kind of voodoo. After wrting endless `collect:` (smalltalk, ruby) blocks, `folds` and `traverses` (Haskell, Purescript) and similar in Python, C# and finally even Java it is now an oasis of calm in a sea of void pointers and typecasts.

Another thing I didn&rsquo;t like about my solution above, with the array in the code, was that I failed to get rid of the magic number &rsquo;3&rsquo; for the size of the array. I hadn&rsquo;t figured out how to use N instead.

Marc found an answer, and then we iterated on it. &ldquo;If you make that N a const, then you can use it in the array inialiser&rdquo; Marc said.

    const int N = 3;
    int arr[N] = { -100, 10, 3 };

That compiles, and more importantly, works. We still weren&rsquo;t as happy with the `3` there. It is duplicated implicitly, since we have 3 items in the array, and we write it in the const declaration. Can we find out the length of the array? &ldquo;Yes we can&rdquo; goes Rob. But it is not what you think it is. I go: I don&rsquo;t think there is &rsquo;length&rsquo;, or &rsquo;len&rsquo; since typing &rsquo;th&rsquo; would surely be too strenuous. Let alone reading it. Rob came up with this gem:

    int arr[] = { 42, -100, 10, 3 };
    const int N = sizeof(arr) / sizeof(int);

The size in the array initializer is not needed. I just got sucked in by the overly communicative code generated by org-mode.

> Narrator: this was snark, there is no such thing as being overly communicative in code. Willem found comfort in seeing the dimensions of the table he had in text reflected in the generated code.

`sizeof(arr) / sizeof(int)` I don&rsquo;t know how Rob came up with this, I hadn&rsquo;t seen it before. Brilliant, if a bit scary. It should be fine, assuming we don&rsquo;t have zero sized integers, and the array&rsquo;s size is a clean multiple of the size of the int.

Meanwhile I&rsquo;m changing some of the numbers each time, just to be sure the code is actually run. Focusing on one thing at a time is hard, and I still am not fully confident in my code-in-org-mode abilities.

The reason we have to pass the length of the array to `qsort` is probably that we can&rsquo;t pass the name of our type `int` as a a parameter, so `qsort` has no way to ask the length of the array.

Anwyay, having our int pointers makes it more obvious what is going on here. In C, usually pointers have the same size as integers. Qsort doesn&rsquo;t care if we sort pointers to structs, or integers, as long as it gets it&rsquo;s `icmp`. So we dereference our fake int pointer to an int `v1 = *p1`; and everyone is happy.


## <a id="orgc0d8c30"></a>Extract the print code into a function

We&rsquo;ll extract the printing code into its&rsquo; own `print_array` function, in its&rsquo; own
block, it is getting a bit repetitive.

    #include "stdio.h"
    /* print_array: print an array of integers of length N to stdout */
    void print_array(const int* xs, int N) {
        for(int i=0; i<N;i++) {
           printf("%2d ", xs[i]);
        }
        printf("\n");
    }

    #include "stdlib.h"
    #include "stdio.h"
    /* icmp: integer compare of *p1 and *p2 */
    int icmp(const void * p1, const void * p2) {
      int v1, v2;
    
      v1 = *(int *) p1;
      v2 = *(int *) p2;
    
      if (v1 < v2)
          return -1;
      else if (v1 == v2)
          return 0;
      else
          return 1;
    }
    
    #include "stdio.h"
    /* print_array: print an array of integers of length N to stdout */
    void print_array(const int* xs, int N) {
        for(int i=0; i<N;i++) {
           printf("%2d ", xs[i]);
        }
        printf("\n");
    }
    int main() {
        int arr[] = { 20000, 1, 42, -100, 10, 3 };
        const int N = sizeof(arr) / sizeof(int);
        qsort(arr, N, sizeof(int), icmp );
        print_array(arr, N);
    }

    -100  1  3 10 42 20000

> Documenting my steps helped here already. I had forgotten how to include blocks like `<<icmp>>` and `<<print_array>>`. My notes above said I need :noweb yes.

## <a id="org43809ad"></a>Four tabs for tangling code blocks in org-mode

1.  [Noweb Reference Syntax (The Org Manual)](https://orgmode.org/manual/Noweb-Reference-Syntax.html#Noweb-Reference-Syntax) how to reuse code in multiple blocks.
2.  [Working with Source Code (Org Mode Compact Guide)](https://orgmode.org/guide/Working-with-Source-Code.html) how to evaluate source code and using header arguments.
3.  [Using results from one code block in another](https://kitchingroup.cheme.cmu.edu/blog/2019/02/12/Using-results-from-one-code-block-in-another-org-mode/)  was more useful for evaluating code than combining multiple blocks. I did learn about the :cache
header for caching output that takes a long time to compute, only updating it
when the source code block changes. I didn&rsquo;t need it here, but useful for future
reference.
4. [C, C++, D Source Code Blocks in Org Mode](https://orgmode.org/worg/org-contrib/babel/languages/ob-doc-C.html) This is the one I started
with. Very useful, but doesn&rsquo;t have the information on reusing code from another block.

I still would like to know how to output `icmp` to its&rsquo; own .h file, and use that in another block. Something to explore for next time.

## <a id="orgc596a48"></a>What next?

I'm not yet entirely happy with the rendering of my literate code, but, here too, baby steps. I&rsquo;ve got my environment set up, I&rsquo;m thinking of two follow up posts, one on implementing quicksort by the book, and then finally the iterative quicksort. Those should be a bit briefer and, at least the middle one, straightforward. As the book said, Tony Hoare found recursive quicksort much simpler than the iterative one.

Why continue? It is fun, and quite often, in hindsight, I find I benefit in my work from doing small exercises, even though it sometimes escapes me in the moment.

<aside>
  <h3>(Improve your) Practice with us</h3>
  <p>Mastery happens by doing, reflecting, and more doing. And more reflecting. Practicing together with your colleagues in one of our training courses is fun! Our training courses are modular, focused and tailored to your needs, so you can experience the benefits on your product sooner, rather than later. Available now in a variety of languages, e.g. Java, C#, Python and C++.</p>
  <p><div>
    <a href="/training/mastering-legacy-code">See the Mastering Legacy Code Course</a>
  </div></p>
</aside>
