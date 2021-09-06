Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D744401ED6
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242384AbhIFRAj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhIFRAj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Sep 2021 13:00:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45133C061575;
        Mon,  6 Sep 2021 09:59:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e16so6039619pfc.6;
        Mon, 06 Sep 2021 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LbmbODO2XgyJHg+9zR2DM8q7C1AesTEfCDvPSCrjIAs=;
        b=k2oZ/UztegenpkYwayx9lg5qMWRqlnuajodeUcqCZuHRrPq0EXfbw8B06kPJ/gpoY9
         Fpl8RhHvI6aBPhz5HCn9/IidBY0Amnr5I/QuDerl8hEh8wpJ2fYldv+6c0jdeC55XXlH
         jLjF48iixfBrpAIIjZtUaMDcTjk7S2RHNY07jNjgggu7WmgH31JLwWAOhYQbKDU6G587
         N+m1pMJjOQLCeaHtjf0kpdK3oMERB7JYFJ38k/cHIR5va9t0OIIZE45IQNP7yyBLuJnP
         ovcCZWv3LLNnxoksJe14J1c4ottANAO9j+/ndCoApRGcNFol0//1EwQ2QTfaUwl8iard
         qJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LbmbODO2XgyJHg+9zR2DM8q7C1AesTEfCDvPSCrjIAs=;
        b=CLabPNa+RShE7bGRa5gcpG3WP83dKr1uMmk1AwNGIaMjLKlCxArV1MXt7HODU0nXSC
         LTJfe4QtzLBDgHScNTI/oX7rMg2i3U03UpYW/9CbMlxv/+eo7gOlS/CJGMPmjY6q55JQ
         +LJXUvTEoC77885nqoZC/9NvAT/mVoplmFmUrLFVbRXxtio9NuBrv5gHwpiTFfAf3eox
         Q7dwai+oBW01ewufaBzptCacG4WLM1x5b1ox2ynebYd5LGZsViT3uYFFJuTerK/tn/HW
         0Gul8ZsOoWLCt8NZYwMIWyWvZO4wla2KWvq8QNGDCi9FtD+q0B6G7m1XwpuPegyId8KM
         8Ohg==
X-Gm-Message-State: AOAM533U0B6J/s8Sc4l2gAP0/6ieYpOKfa6TLEsBepqEXpwpmNyStd4P
        iQ3tYnh3po/4guMz/kajAGtgiUFiX/Jwig==
X-Google-Smtp-Source: ABdhPJzgRPHY2GqCZymeLiE+F1+8+Ip2G70h742QIkbrqNNBPN5NRRnhArOmY5I2Abospy6pxxcL9w==
X-Received: by 2002:a62:8287:0:b0:3ec:f6dc:9672 with SMTP id w129-20020a628287000000b003ecf6dc9672mr12609400pfd.65.1630947573695;
        Mon, 06 Sep 2021 09:59:33 -0700 (PDT)
Received: from localhost.localdomain ([1.145.127.201])
        by smtp.gmail.com with ESMTPSA id t23sm42243pjs.16.2021.09.06.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:59:33 -0700 (PDT)
Date:   Tue, 7 Sep 2021 02:59:28 +1000
From:   "G. Branden Robinson" <g.branden.robinson@gmail.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     "Thaddeus H. Black" <thb@debian.org>, linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Dr. Tobias Quathamer" <toddy@debian.org>,
        linux-ext4@vger.kernel.org, debian-doc@lists.debian.org
Subject: Re: [PATCH] filename.7: new manual page
Message-ID: <20210906165926.jujqqjkzraxvsgmc@localhost.localdomain>
References: <YTX+PEtj60O/TdMh@b-tk.org>
 <a18a8f3d-78a7-15e5-7a6e-0f4740c84667@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5zodxzmwhnjcmrik"
Content-Disposition: inline
In-Reply-To: <a18a8f3d-78a7-15e5-7a6e-0f4740c84667@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--5zodxzmwhnjcmrik
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc recipients: this message is only about typography and man(7) style]

Hi Alex,

At 2021-09-06T16:21:09+0200, Alejandro Colomar (man-pages) wrote:
> > +.TH FILENAME 7 2021-09-06 "Linux" "Linux Programmer's Manual"
> > +.SH NAME
> > +.P
>=20
> I don't know the history of this (actually, I've always wondered why),
> but .PP and .P are equivalent, AFAIK, and we use .PP.

Yes, they are equivalent.  I know of no man(7) implementation that
distinguishes .LP, .PP, and .P semantically.  groff_man(7)[1] briefly
summarizes the historical growth of the man(7) macro, register, and
string name repertoire.

In the groff project, after years of being on the fence about the issue,
as a style matter I settled on using and recommending simply ".P"[2].  I
think it relieves the occasional man page author from having to retain
a small amount of knowledge, the kind that has you wondering above.

> > +.SH LEGAL FILENAMES
>=20
> See man-pages(7):
>=20
>    Sections within a manual page
>        The  list  below  shows conventional or suggested sections.
>        Most manual pages should include at least  the  highlighted
>        sections.   Arrange  a new manual page so that sections are
>        placed in the order shown in the list.
>=20
>               NAME
>               SYNOPSIS
>               CONFIGURATION    [Normally only in Section 4]
>               DESCRIPTION
>               OPTIONS          [Normally only in Sections 1, 8]
>               EXIT STATUS      [Normally only in Sections 1, 8]
>               RETURN VALUE     [Normally only in Sections 2, 3]
>               ERRORS           [Typically only in Sections 2, 3]
>               ENVIRONMENT
>               FILES
>               VERSIONS         [Normally only in Sections 2, 3]
>=20
>               ATTRIBUTES       [Normally only in Sections 2, 3]
>               CONFORMING TO
>               NOTES
>               BUGS
>               EXAMPLES
>               AUTHORS          [Discouraged]
>               REPORTING BUGS   [Not used in man=E2=80=90pages]
>               COPYRIGHT        [Not used in man=E2=80=90pages]
>               SEE ALSO
>=20
>        Where a traditional heading would  apply,  please  use  it;
>        this kind of consistency can make the information easier to
>        understand.  If you must, you can create your own  headings
>        if they make things easier to understand (this can be espe=E2=80=90
>        cially useful for pages in Sections 4 and 5).  However, be=E2=80=90
>        fore  doing this, consider whether you could use the tradi=E2=80=90
>        tional headings, with some subsections (.SS)  within  those
>        sections.
>=20
> You could move sections into subsections of DESCRIPTION, and the
> current subsections into tagged paragraphs (.TP).

In the groff man page corpus, the rule above is honored in general but
slightly relaxed for section 7 pages, due to that section's
miscellaneous nature--it's hard to argue that section naming conventions
for commands, library interfaces, device drivers, or file formats should
apply to section 7 pages, because if they did, the page in question
would be in one of those sections instead (or portions of it moved
thence).

> > +.P
> > +A filename on a Linux system can consist of almost any sequence of UTF=
-8
>=20
> See man-pages(7):
>=20
>    Use semantic newlines
>        In the source of a manual page,  new  sentences  should  be
>        started  on  new  lines, and long sentences should be split
>        into lines at clause breaks  (commas,  semicolons,  colons,
>        and  so on).  This convention, sometimes known as "semantic
>        newlines", makes it easier to see the  effect  of  patches,
>        which often operate at the level of individual sentences or
>        sentence clauses.
>=20
>=20
> > +characters or, indeed, almost any sequence of bytes.
> > +The exceptions are as follows.

Maybe I've developed temporary blindness, but I don't see where Thaddeus
didn't use semantic newlines in the adjacent quoted material.

> Please, use a separate line and
> .B \e0
>=20
> We avoid \f.

Yes!  Thus does the moral arc of the universe bend toward justice!

=2E..or at least readable man(7) source.

> > +from\~\fB0\fR, the printable digit-zero character.
>=20
> Why did you use the non-breaking space here (and other places)?  I
> don't think it's necessary.

It is a typographical best practice.  It is often good typography to
keep a line break from occurring between a preposition and its object,
or between nouns where one is used as a determiner for the other.
Thaddeus has supplied an example of the former above, and for the latter
consider the following[3].

Integer overflow is guaranteed for large values
=2ERI of\~ n .

I know of no hard rule here, but I have inferred that such break
prevention tends to be applied much more frequently adjacently to one-
or two-character nouns, and seldom to never for longer ones.  I believe
the reason for the practice is to make reading more comfortable; it
would be nice to only _ever_ break lines at phrase and clause
boundaries, but applying a hard rule along these lines leads to worse
esthetics (if the line is adjusted to both margins with large amounts of
inter-word space) or ergonomics (if the line length varies dramatically
within a paragraph).

> > +Workarounds typically exist, chiefly via quotation, escape and the
> > explicit +termination of options processing [see
> > +.BR sh (1)];
>=20
> I'd have used parentheses there. No?  Was it, as in Mathematics, to
> clearly differentiate the inner from the outer parentheses?  If so, we
> typically nest parentheses in the manual pages (as in here (see?)).
>=20
> However, I don't think it's wrong per se to use brackets...  Is it
> common in other places?  Maybe the add some readability to the text,
> and we hould use them.

English style manuals tend to discourage the Lisp effect of nested
parentheses[5].  The reference I've cited is consistent with other
practices I've seen in the humanities, which is to turn to parentheses
as a first resort and then adopt brackets only when already within a
parenthesized context, whereas mathematical usage is to apply
parentheses to the innermost level of nesting.

Here, however, it would be jarring to change the man page citation style
in a context-dependent manner, so Thaddeus inverted the ordering.  This
is a good practice.  In technical writing, and arguably in _all_
writing, the demands of clarity must outweigh any syntactical or
semantic rules.  Our brains are more powerful parsing engines than any
machine we have yet been able to contrive; it's okay to expect people to
use them.  :D

That blank check having been written, a Hegelian synthesis applies: if
your construction cannot simultaneously serve the demands of grammar,
clarity, and good style...recast until it does!

> Non-native English speakers may have trouble understanding "all but".
> Maybe s/all but/not/?

I think it's okay.  From my limited knowledge of non-English languages,
I expect it to calque in a way that will not startle the intuition.
Personally, I acquired the construction when I was in primary school,
but I admit that saying so invites a charge of being anecdotal.  Or
precocious.  Or loquacious.

> > +.SS Capitalization
> > +.P
> > +A loosely observed convention favors small letters in filenames where =
no
> > +reason to use capitals exists.
>=20
> Most manual pages talking about capitalization typically use the term
> 'case' (uppercase, lowercase, case sensitive, ...); probably because
> of 'toupper()' and 'tolower()'.  I think, for consistency, using the
> same terminology would be better.

This circle could be squared with the subsection heading "Letter case".

> > +.P
> > +Names of types and of certain other entities are sometimes capitalized=
 in
> > +programming languages like\~C++ and Python.
>=20
> Do you mean normal user conventions?  I mean, the standard C++ library
> (and the language) doesn't use uppercase, AFAIR.  Not even in the
> cases where C used it (e.g., _Bool)

Stroustrup models first-letter capitalization of namespace, exception,
class, and struct names in _The C++ Programming Language_ (3rd edition,
1997), so it's reasonably likely to show up in projects written in that
language even if it's not in the standard library (which is much too
huge for me to characterize in this respect).

> > +.SH CONFORMING TO
> > +.P
> > +POSIX.1-2008, SUSv4.
> The SUSv4 part of the standard is the same that is in POSIX.1-2008?
> Or does it have any extensions regarding filenames that isn't in
> POSIX?
>=20
> If both standards have the same exact contents about filenames, I'd
> simplify this with POSIX.1-2008 only.

Thaddeus is using a citation form modeled in standards(7), a Linux
man-pages project page.  Perhaps that page should offer some guidance
for standards that appear in a comma-separated list in the paragraph
tags.

> > +.BR iswcntrl (3),
> > +.BR iswgraph (3),
> > +.BR mbrtowc (3),
> > +.BR wcrtomb (3),

I think it suffices to mention these functions only in passing in the
body of the man page.  Few readers are going to go straight from
learning what a Unix filename is to multi-byte and wide character string
encoding in C, and the few with that degree of ambition have already
been steered in the right direction.

In my opinion the "See also" section of a man page serves us best if
there are two things it is _not_:

(1) a recapitulation of all man page cross-references encountered in the
    page so far; and
(2) a militantly strict subset of (1).

In my view, "See also" is there to help two kinds of reader:

(A) the kind who has not found the man page they were seeking, but might
    be in the right "neighborhood", and needs a hint to find the correct
    one (a wholly irrelevant page is best abandoned, and the output of
    "man -k" returned to); and
(B) the kind who has found the page they are looking for but require
    greater depth on subsidiary, dependent, or closely-related topics.

As with many things, identifying the members of such a set demands
judgment, and judgment can be difficult, which is why some man page
writers have a tendency to degenerate toward the more robotic
interpretation that I discourage above.  But if that roboticism is what
is sought, we should design a robot to take care of it.  One such
automaton could be a man page cross-reference macro like mdoc(7) has
(possibly with an optional argument to suppress inclusion for case (2)
above), enabling the macro package to generate the "See also" section by
itself.

But I think that machine is something we _don't_ want[5].  We _want_ the
"See also" section of a man page to be a curated product of judgment.

Regards,
Branden

[1] https://man7.org/linux/man-pages/man7/groff_man.7.html

[2] https://git.savannah.gnu.org/cgit/groff.git/commit/?id=3Dcf49e0fe7fdbaf=
f94e21ebdcd3380c3559c2525d

commit cf49e0fe7fdbaff94e21ebdcd3380c3559c2525d
Author: G. Branden Robinson <g.branden.robinson@gmail.com>
Date:   Wed Jun 16 00:24:38 2021 +1000

    [man]: Elevate "P" as canonical paragraph macro.

    Unfairly and capriciously elevate "P" as the preferred paragraphing
    macro for the man(7) language.  This is slightly ahistorical; the
    original man macro package from 1979 in fact did not recognize the
    name "P" at all, but did support "LP" and "PP".

    However, "P" did show up in AT&T System III Unix (1980) and later in
    4.3BSD (1986).  I speculate that "LP" and "PP" were supported to
    accommodate the varying paragraphing preferences of those accustomed
    to the ms(7) macro package.  However, anyone familiar with that
    package knows that these two macros mean different things, and have
    differing indentation behavior, which man(7) does not simulate.  In
    that respect, "LP" and "PP" imply too much to ms veterans, and
    nothing useful at all to other man(7) users; the "L" and first "P"
    are superfluous.

    Further, ".P" is frequently typed, and per sound principles of
    Huffman coding, it should be short.  Thus do I hope to buy the
    complaisance of grognards with the cheap bribe of "less typing", a
    preoccupation whose star has not dimmed among Unix geeks in 50
    years.

    * tmac/an-old.tmac (P): Define this is as the "canonical"
      paragraphing macro.

      (LP, PP): Make these aliases of P.

[3] You could also say the following.

Integer overflow is guaranteed for large values of\~\c
=2EIR n .

But I discourage the use of \c except where necessary because it tends
to confuse people (although in groff Git HEAD I've finally got this
escape sequence described carefully enough that it no longer maddens me
as it did when I first became a contributor[6]).  In the above, if we
omit the output line continuation escape sequence \c, then the line can
break after "of" because that's what a newline in the *roff input stream
_means_.

[4] https://www.eliteediting.com.au/parentheses-within-parentheses/

[5] I do still want an "MR" man page cross referencing macro[7] (and
mandoc(1) maintainer Ingo Schwarze is still trying to talk me out of
it), but not so that "See also" can be autogenerated.

[6] https://man7.org/linux/man-pages/man7/groff.7.html#Line_continuation
[7] https://lists.gnu.org/archive/html/groff/2021-08/msg00000.html

--5zodxzmwhnjcmrik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmE2SOUACgkQ0Z6cfXEm
bc4oFxAApK7aeXnxj9BSChPZIe8kkdBuve8MRTQEL6B683J0gsOCS5436wfNIMZB
Be5kqrdKhB4P708/CtgulL9C/62jakj8723Bd6QQpuwmw2GoJbhvs5jEkmyKYPe9
FXcpWxqrckZVXRjI1Fay48OVbEDwgKzPFQiZk2sm4YZRAUw1cBoe3sbE0QEr0Yy3
xc2Aknt/C6jr5UYE/KnYe7PvXBdYrLmlrw7vGE4ZGdHxgIJvCnqHWfh3+wrJvbbb
aOH4vAZazFOfKnMkwQdEA6qF4l1WxQQ3z/CPdGWewqqSk3hNMPwTiUbv2tbUBvJL
R2edRI1ZmgGoXhmlRooufCiMt+ST25zDCrqk9np/nQgSLQIrSJPDqMpSE6qBSEd0
VeGINM6czLefP0Enfe0ltDmT8xf1Xe5Shxi+Gsp3JXBbkB50IQfdwCqeVIlNb8KK
VgAzDFCzPg6IkhMyoI7x5RPp+5E4IIz1IbVFCgdytcvp7IO6H6A+Bl2unF3Sc2wz
pS7ZCOvgsLS5yoATJEF6r8JKdIKAXmkdJXr7v+4twoWhFShaFGA5xhyyzQbtRPdh
HwEiEWkQ0wrNnPq3Aydh+TcS6o7D3wA0ybNxxTrdE109JIeiODIKVlJb8KAAPdLs
TNsGTHZQVlN/N7ukpL2VyuiC1vNNdJhu27Fn7rO3tS+cZlZpnAQ=
=3zhT
-----END PGP SIGNATURE-----

--5zodxzmwhnjcmrik--
