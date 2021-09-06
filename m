Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0D402125
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 23:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhIFVsr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 17:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhIFVsr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Sep 2021 17:48:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97968C061575;
        Mon,  6 Sep 2021 14:47:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q14so11547006wrp.3;
        Mon, 06 Sep 2021 14:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KG0UOJO9FIg3faHzaCpoBO7pUx3MduUnPiBh4J3eP+s=;
        b=QyMuAjVuVb5LZUsslSeReklUbU/hlfuyEeMIGZLz57GYDX+cxQ4lFNin9R90WJVLEz
         xIhKHEid4gTwXt2TEZN1gefhiswaMyiXH3QAqR99wSlXCl+RNO3VoDlVWmgUm4qInyau
         +pL8D/OGYoQb6g64X+6//rQYQxsEMSNodLyDgcGFL5cWLt9tyr/kCC9S9FiI7UY/USzC
         vaFeO9NMaKJ+vs53spGoYkGWVZoQVIn+psOBMycdCQquaQtva8J+AJILJ1mShggNp2t/
         4qGs8rrGE3nItoauf8PtUvo3QoneQYOHzVvjBFs6rqFOXWgjxqudLtpJVgF3ehoeW62r
         iB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KG0UOJO9FIg3faHzaCpoBO7pUx3MduUnPiBh4J3eP+s=;
        b=t9OEDNN/a5Y8JW5OHLWrX+/GNtk2znmHiCVd7zLJ/AwGuanfcSTzEu5VGgP+mQPvh/
         dR2BRVfBZtSqV8EMf7uG8aaaHAVKAjyYoVWsHyyyrm0jw59RgY2B/Grw61pAWGjBhZir
         WRiNHzm6CPPqcQLHsFPEp3zMWQ1BcobdR0lQLopFEtejgIWZNVbO+UegW/XB6T2a/YCx
         rheKxdu/OaOI1zPlR3uLn+F3ETEKNunlF/87gWagYf/ZCV1UVHwSEOn9eNgonXSv+iMX
         sq6VAv/uWFhh4SSygcRiAxaAlJ5ID533shLBmACY2tTcYx/pjOpL02YgqJ1KJQDUA7OS
         sAWQ==
X-Gm-Message-State: AOAM533ltV+7hNa7v++zs8X3nAz2hOYD3R+Ls83ia/ctxt9Rm0CMSndu
        CG+nuRByKQjL1/UhVuDkJyQ=
X-Google-Smtp-Source: ABdhPJzR+Z2G9zr+q15gCLzR3lqZUyMyEoHxvTinzS7cSFY25a5kj+i+meBbCc+j2evSX/k8Ow0l6w==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr15385715wrt.33.1630964859906;
        Mon, 06 Sep 2021 14:47:39 -0700 (PDT)
Received: from [10.8.0.18] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id z6sm643183wmp.1.2021.09.06.14.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 14:47:39 -0700 (PDT)
Subject: Re: [PATCH] filename.7: new manual page
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     "Thaddeus H. Black" <thb@debian.org>, linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Dr. Tobias Quathamer" <toddy@debian.org>,
        linux-ext4@vger.kernel.org, debian-doc@lists.debian.org
References: <YTX+PEtj60O/TdMh@b-tk.org>
 <a18a8f3d-78a7-15e5-7a6e-0f4740c84667@gmail.com>
 <20210906165926.jujqqjkzraxvsgmc@localhost.localdomain>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <65e77f99-cc6d-9eec-486d-492eb5234c63@gmail.com>
Date:   Mon, 6 Sep 2021 23:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210906165926.jujqqjkzraxvsgmc@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Branden and Thaddeus,

On 9/6/21 6:59 PM, G. Branden Robinson wrote:
>> You could move sections into subsections of DESCRIPTION, and the
>> current subsections into tagged paragraphs (.TP).
> 
> In the groff man page corpus, the rule above is honored in general but
> slightly relaxed for section 7 pages, due to that section's
> miscellaneous nature--it's hard to argue that section naming conventions
> for commands, library interfaces, device drivers, or file formats should
> apply to section 7 pages, because if they did, the page in question
> would be in one of those sections instead (or portions of it moved
> thence).

I would still use DESCRIPTION, I think.  I think we don't lose much by 
using subsections instead, and we gain consistency.

> 
>>> +.P
>>> +A filename on a Linux system can consist of almost any sequence of UTF-8
>>
>> See man-pages(7):
>>
>>     Use semantic newlines
>>         In the source of a manual page,  new  sentences  should  be
>>         started  on  new  lines, and long sentences should be split
>>         into lines at clause breaks  (commas,  semicolons,  colons,
>>         and  so on).  This convention, sometimes known as "semantic
>>         newlines", makes it easier to see the  effect  of  patches,
>>         which often operate at the level of individual sentences or
>>         sentence clauses.
>>
>>
>>> +characters or, indeed, almost any sequence of bytes.
>>> +The exceptions are as follows.
> 
> Maybe I've developed temporary blindness, but I don't see where Thaddeus
> didn't use semantic newlines in the adjacent quoted material.

"UTF-8" is an adjective to "characters"; I'd break just after "of", 
since everything after it is a single nominal phrase (I hope I used the 
correct term; I only did syntactical analysis in Spanish at school).

There were more obvious points below that infringed this rule, but I 
wanted to point out the first one.

> 
>> Please, use a separate line and
>> .B \e0
>>
>> We avoid \f.
> 
> Yes!  Thus does the moral arc of the universe bend toward justice!
> 
> ...or at least readable man(7) source.
> 
>>> +from\~\fB0\fR, the printable digit-zero character.
>>
>> Why did you use the non-breaking space here (and other places)?  I
>> don't think it's necessary.
> 
> It is a typographical best practice.  It is often good typography to
> keep a line break from occurring between a preposition and its object,
> or between nouns where one is used as a determiner for the other.
> Thaddeus has supplied an example of the former above, and for the latter
> consider the following[3].
> 
> Integer overflow is guaranteed for large values
> .RI of\~ n .
> 
> I know of no hard rule here, but I have inferred that such break
> prevention tends to be applied much more frequently adjacently to one-
> or two-character nouns, and seldom to never for longer ones.  I believe
> the reason for the practice is to make reading more comfortable; it
> would be nice to only _ever_ break lines at phrase and clause
> boundaries, but applying a hard rule along these lines leads to worse
> esthetics (if the line is adjusted to both margins with large amounts of
> inter-word space) or ergonomics (if the line length varies dramatically
> within a paragraph).

Okay, looks good to me.

> 
>>> +Workarounds typically exist, chiefly via quotation, escape and the
>>> explicit +termination of options processing [see
>>> +.BR sh (1)];
>>
>> I'd have used parentheses there. No?  Was it, as in Mathematics, to
>> clearly differentiate the inner from the outer parentheses?  If so, we
>> typically nest parentheses in the manual pages (as in here (see?)).
>>
>> However, I don't think it's wrong per se to use brackets...  Is it
>> common in other places?  Maybe the add some readability to the text,
>> and we hould use them.
> 
> English style manuals tend to discourage the Lisp effect of nested
> parentheses[5].

Actually, [4].

Okay, logically it seems good to me; more so when Mathematical language 
already uses that.  I didn't know if it was typically used in prose, as 
I haven't seen its usage in Spanish, but since you referenced a guide 
that recommends its usage, it seems fair.

>  The reference I've cited is consistent with other
> practices I've seen in the humanities, which is to turn to parentheses
> as a first resort and then adopt brackets only when already within a
> parenthesized context, whereas mathematical usage is to apply
> parentheses to the innermost level of nesting.
> 
> Here, however, it would be jarring to change the man page citation style
> in a context-dependent manner, so Thaddeus inverted the ordering.  This
> is a good practice.  In technical writing, and arguably in _all_
> writing, the demands of clarity must outweigh any syntactical or
> semantic rules.  Our brains are more powerful parsing engines than any
> machine we have yet been able to contrive; it's okay to expect people to
> use them.  :D
> 
> That blank check having been written, a Hegelian synthesis applies: if
> your construction cannot simultaneously serve the demands of grammar,
> clarity, and good style...recast until it does!

I'll go for the brackets in the outer ones, as Maths do, as Thaddeus 
did, and as you pointed out, as man references already use () and 
changing those would be weird at least; printf[3] seems like you're 
pointing to a [3] at the bottom of a page.


> 
>> Non-native English speakers may have trouble understanding "all but".
>> Maybe s/all but/not/?
> 
> I think it's okay.  From my limited knowledge of non-English languages,
> I expect it to calque in a way that will not startle the intuition.
> Personally, I acquired the construction when I was in primary school,
> but I admit that saying so invites a charge of being anecdotal.  Or
> precocious.  Or loquacious.

I have trouble myself when reading those expressions, especially when 
mixing that with another negation.  I have to mentally cancel out 
negations first :D

> 
>>> +.SS Capitalization
>>> +.P
>>> +A loosely observed convention favors small letters in filenames where no
>>> +reason to use capitals exists.
>>
>> Most manual pages talking about capitalization typically use the term
>> 'case' (uppercase, lowercase, case sensitive, ...); probably because
>> of 'toupper()' and 'tolower()'.  I think, for consistency, using the
>> same terminology would be better.
> 
> This circle could be squared with the subsection heading "Letter case".
> 
>>> +.P
>>> +Names of types and of certain other entities are sometimes capitalized in
>>> +programming languages like\~C++ and Python.
>>
>> Do you mean normal user conventions?  I mean, the standard C++ library
>> (and the language) doesn't use uppercase, AFAIR.  Not even in the
>> cases where C used it (e.g., _Bool)
> 
> Stroustrup models first-letter capitalization of namespace, exception,
> class, and struct names in _The C++ Programming Language_ (3rd edition,
> 1997), so it's reasonably likely to show up in projects written in that
> language even if it's not in the standard library (which is much too
> huge for me to characterize in this respect).

Okay.

> 
>>> +.SH CONFORMING TO
>>> +.P
>>> +POSIX.1-2008, SUSv4.
>> The SUSv4 part of the standard is the same that is in POSIX.1-2008?
>> Or does it have any extensions regarding filenames that isn't in
>> POSIX?
>>
>> If both standards have the same exact contents about filenames, I'd
>> simplify this with POSIX.1-2008 only.
> 
> Thaddeus is using a citation form modeled in standards(7), a Linux
> man-pages project page.  Perhaps that page should offer some guidance
> for standards that appear in a comma-separated list in the paragraph
> tags.

Yes, that's something that could go into man-pages(7).  We had a similar 
discussion about this when designing system_data_types(7).

There, we only cared about the C standard and the POSIX standard, and 
only the first one of each that standardized the type.  If a type were 
only in SUSv4 and not in POSIX, we would use SUSv4 for that type, but 
that hasn't happened yet in the types we documented.

Example:
Conforming to: C99 and later; POSIX.1‐2001 and later.


While we don't have a written rule, I'd use that one for now.
Of course if something is in POSIX.1-2008, it must be in SUSv4 (as it is 
a superset of POSIX), so to simplify, we'll omit that.

> 
>>> +.BR iswcntrl (3),
>>> +.BR iswgraph (3),
>>> +.BR mbrtowc (3),
>>> +.BR wcrtomb (3),
> 
> I think it suffices to mention these functions only in passing in the
> body of the man page.  Few readers are going to go straight from
> learning what a Unix filename is to multi-byte and wide character string
> encoding in C, and the few with that degree of ambition have already
> been steered in the right direction.
> 
> In my opinion the "See also" section of a man page serves us best if
> there are two things it is _not_:
> 
> (1) a recapitulation of all man page cross-references encountered in the
>      page so far; and
> (2) a militantly strict subset of (1).
> 
> In my view, "See also" is there to help two kinds of reader:
> 
> (A) the kind who has not found the man page they were seeking, but might
>      be in the right "neighborhood", and needs a hint to find the correct
>      one (a wholly irrelevant page is best abandoned, and the output of
>      "man -k" returned to); and
> (B) the kind who has found the page they are looking for but require
>      greater depth on subsidiary, dependent, or closely-related topics.
> 
> As with many things, identifying the members of such a set demands
> judgment, and judgment can be difficult, which is why some man page
> writers have a tendency to degenerate toward the more robotic
> interpretation that I discourage above.  But if that roboticism is what
> is sought, we should design a robot to take care of it.  One such
> automaton could be a man page cross-reference macro like mdoc(7) has
> (possibly with an optional argument to suppress inclusion for case (2)
> above), enabling the macro package to generate the "See also" section by
> itself.
> 
> But I think that machine is something we _don't_ want[5].  We _want_ the
> "See also" section of a man page to be a curated product of judgment.

Agree.

> 
> Regards,
> Branden
> 
> [1] https://man7.org/linux/man-pages/man7/groff_man.7.html
> 
> [2] https://git.savannah.gnu.org/cgit/groff.git/commit/?id=cf49e0fe7fdbaff94e21ebdcd3380c3559c2525d
> 
> commit cf49e0fe7fdbaff94e21ebdcd3380c3559c2525d
> Author: G. Branden Robinson <g.branden.robinson@gmail.com>
> Date:   Wed Jun 16 00:24:38 2021 +1000
> 
>      [man]: Elevate "P" as canonical paragraph macro.
> 
>      Unfairly and capriciously elevate "P" as the preferred paragraphing
>      macro for the man(7) language.  This is slightly ahistorical; the
>      original man macro package from 1979 in fact did not recognize the
>      name "P" at all, but did support "LP" and "PP".
> 
>      However, "P" did show up in AT&T System III Unix (1980) and later in
>      4.3BSD (1986).  I speculate that "LP" and "PP" were supported to
>      accommodate the varying paragraphing preferences of those accustomed
>      to the ms(7) macro package.  However, anyone familiar with that
>      package knows that these two macros mean different things, and have
>      differing indentation behavior, which man(7) does not simulate.  In
>      that respect, "LP" and "PP" imply too much to ms veterans, and
>      nothing useful at all to other man(7) users; the "L" and first "P"
>      are superfluous.
> 
>      Further, ".P" is frequently typed, and per sound principles of
>      Huffman coding, it should be short.  Thus do I hope to buy the
>      complaisance of grognards with the cheap bribe of "less typing", a
>      preoccupation whose star has not dimmed among Unix geeks in 50
>      years.
> 
>      * tmac/an-old.tmac (P): Define this is as the "canonical"
>        paragraphing macro.
> 
>        (LP, PP): Make these aliases of P.

I like that reasoning.  I'd like to be able to use .P.  But that would 
mean adding even more inconsistency to the man-pages (of course we 
wouldn't change existing pages to use .P at this point).

> 
> [3] You could also say the following.
> 
> Integer overflow is guaranteed for large values of\~\c
> .IR n .
> 
> But I discourage the use of \c except where necessary because it tends
> to confuse people (although in groff Git HEAD I've finally got this
> escape sequence described carefully enough that it no longer maddens me
> as it did when I first became a contributor[6]).  In the above, if we
> omit the output line continuation escape sequence \c, then the line can
> break after "of" because that's what a newline in the *roff input stream
> _means_.
> 
> [4] https://www.eliteediting.com.au/parentheses-within-parentheses/
> 
> [5] I do still want an "MR" man page cross referencing macro[7] (and
> mandoc(1) maintainer Ingo Schwarze is still trying to talk me out of
> it), but not so that "See also" can be autogenerated.

I keep reading that list :)

> 
> [6] https://man7.org/linux/man-pages/man7/groff.7.html#Line_continuation
> [7] https://lists.gnu.org/archive/html/groff/2021-08/msg00000.html
> 

Thanks as always for your great contributions, Branden!

Regards,
Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
