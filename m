Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1F403322
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 05:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347550AbhIHDzR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Sep 2021 23:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbhIHDzQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Sep 2021 23:55:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7048CC061575;
        Tue,  7 Sep 2021 20:54:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a591700b001976d2db364so544038pji.2;
        Tue, 07 Sep 2021 20:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BpROgBoUWziiTlHd3ekkfEDpxv0/uRC2Zk7QsVSREkU=;
        b=QjAzr3HCux8NUZz4itoxsMkalorWrydmdvYub9D7r7SaRV1P8qEXw/OVX7tT9q45dv
         9nFtGXyXsGwzX5wSw1VLwmkLDjug26rQFpIiD6O/NlKNdEN5EN4yUMo5EUoM9g5vKLDU
         ubSQGS/x73s8Od1d/m4RDjpLKRbKDxHI+hOYRqKKEPgpZEmskwm66r/xnwCdn39e4aqI
         sqvF+kAIf3gb75dyLmjgWnFAjDIVe9soKq7BTEvTi+zuvBLcaZ0oC+kxlJ710fWT+jr2
         ThoCnNK8sQggyr7khrVklNhn+CjHBLpVYuzPUeHFDM5tM/jvvRcuVFxsI6D+TgzpySdt
         zWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BpROgBoUWziiTlHd3ekkfEDpxv0/uRC2Zk7QsVSREkU=;
        b=VuiN9dbwTzGWpuQnzHzSr5FWlypGwgn0ebw4UOCuiGROx1a1F73/panAPK4mhjqim+
         /eNViUO2BYAbjhjRdC1zrjb6ZOq+h8hBPFYyWKROjI0wVGDlHNzQ1xjtsFEnRoTZpEN2
         CULwuexAwP+PPBj1wDql3DwrYIPccT5GyoZc1PGNjgVP4MmIBiK/A/yF1TPu4A+CT1dM
         pDk8k+3yNjkEZm3yLipST+g3VqXbyvQZYJ3IpWSdqJ2hIRKrezoo0HkJMjC+xGT2Ta+F
         q02XWHP4REP88ADnteicxKIC4YJOisqWaYw728GbjldMdZWLMjAIxbMgceTQNT6IaIZr
         vYFA==
X-Gm-Message-State: AOAM531DyCc+XTSa4yJGEXCNz05mIn1pm9ysEhKQSRfymS4rYdu/Xpmg
        hqAJgsfPMSGgfLoekysZYi0LIQ3r9WDbng==
X-Google-Smtp-Source: ABdhPJxODf6C6yie7+hG4rKspJaBg9fWIgK+rp2mYulzWPMZZAYNZVNptxHj3V6bfErkpD/0zytqug==
X-Received: by 2002:a17:90b:1981:: with SMTP id mv1mr1839255pjb.45.1631073248917;
        Tue, 07 Sep 2021 20:54:08 -0700 (PDT)
Received: from localhost.localdomain ([1.145.127.201])
        by smtp.gmail.com with ESMTPSA id a15sm688004pgn.25.2021.09.07.20.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 20:54:08 -0700 (PDT)
Date:   Wed, 8 Sep 2021 13:54:03 +1000
From:   "G. Branden Robinson" <g.branden.robinson@gmail.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     "Thaddeus H. Black" <thb@debian.org>, linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Dr. Tobias Quathamer" <toddy@debian.org>,
        linux-ext4@vger.kernel.org, debian-doc@lists.debian.org
Subject: Re: [PATCH] filename.7: new manual page
Message-ID: <20210908035359.rcdgo43qw34yf2ia@localhost.localdomain>
References: <YTX+PEtj60O/TdMh@b-tk.org>
 <a18a8f3d-78a7-15e5-7a6e-0f4740c84667@gmail.com>
 <20210906165926.jujqqjkzraxvsgmc@localhost.localdomain>
 <65e77f99-cc6d-9eec-486d-492eb5234c63@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yq6auqkvkwrvebpt"
Content-Disposition: inline
In-Reply-To: <65e77f99-cc6d-9eec-486d-492eb5234c63@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--yq6auqkvkwrvebpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc recipients: more typography and man(7) style issues]

Hi Alex,

At 2021-09-06T23:47:37+0200, Alejandro Colomar (man-pages) wrote:
> On 9/6/21 6:59 PM, G. Branden Robinson wrote:
> > In the groff man page corpus, the rule above is honored in general
> > but slightly relaxed for section 7 pages, due to that section's
> > miscellaneous nature--it's hard to argue that section naming
> > conventions for commands, library interfaces, device drivers, or
> > file formats should apply to section 7 pages, because if they did,
> > the page in question would be in one of those sections instead (or
> > portions of it moved thence).
>=20
> I would still use DESCRIPTION, I think.

I do as well[1]; while I haven't yet encountered a situation where it
seemed sensible to dispose of it, I would lend writers of section 7
pages that freedom.

> I think we don't lose much by using subsections instead, and we gain
> consistency.

I'm a little uneasy with some of the hacks I've seen to contrive
sub-subsections in man pages.  I saw one within the past few months but
can't remember the specifics.  Sending this mail may prompt my
recollection since that's how my memory seems to work.  I'll follow up
if it does.

> > > See man-pages(7):
> > >=20
> > >     Use semantic newlines
> > >         In the source of a manual page,  new  sentences  should
> > >         be started  on  new  lines, and long sentences should be
> > >         split into lines at clause breaks  (commas,  semicolons,
> > >         colons, and  so on).  This convention, sometimes known as
> > >         "semantic newlines", makes it easier to see the  effect
> > >         of  patches, which often operate at the level of
> > >         individual sentences or sentence clauses.
> > >=20
> > Maybe I've developed temporary blindness, but I don't see where
> > Thaddeus didn't use semantic newlines in the adjacent quoted
> > material.
>=20
> "UTF-8" is an adjective to "characters"; I'd break just after "of",
> since everything after it is a single nominal phrase (I hope I used
> the correct term; I only did syntactical analysis in Spanish at
> school).

Ah, that's a "phrase" rather than a "clause".  The terms are
distinguished in traditional (schoolhouse) English grammar; loosely, a
"phrase" is a set of words operating as a "part of speech" (noun, verb,
adjective, adverb) whereas a "clause" is a group of phrases with a
"subject" and a "predicate".  Generally, sentence can be decomposed into
one or more clauses, each of which can itself be expressed as a sentence
with little or no recasting.

There's nothing about phrases or phrase boundaries in the guidance
quoted above.  At first blush I would recommend against adding it
because it's harder to find such boundaries automatically.  When I
revise man pages in the groff project it's easy to find clause
boundaries with the vi search pattern "/[;!?.]."  (I usually add a
comma and a closing parenthesis to this pattern because I also prefer to
break after commas and multi-word parentheticals, but I'm not militant
about prescribing this expanded sense of semantic newlines.))

Someone trained in linguistics at the university level could doubtless
speak about this subject with much greater precision.  (And then there's
Huddleston and Pullum's iconoclastic _Cambridge Grammar of the English
Language_...)

> There were more obvious points below that infringed this rule, but I
> wanted to point out the first one.

I don't think most native English speakers are likely to interpret the
semantic newline rule as you do because we absorb a different denotation
of "clause" when we're taught elementary formal grammar.

> > It is a typographical best practice.  It is often good typography to
> > keep a line break from occurring between a preposition and its
> > object, or between nouns where one is used as a determiner for the
> > other.  Thaddeus has supplied an example of the former above, and
> > for the latter consider the following[3].
[...]

I goofed up the point I was trying to make here.  I provided a duplicate
example of the case I attributed to Thaddeus.  Let me try that again.

Overflow is guaranteed for a sufficiently large
=2ERI integer\~ n .

> > English style manuals tend to discourage the Lisp effect of nested
> > parentheses[5].
>=20
> Actually, [4].

Hah!  I need a footnote assistance plug-in for Vim.  I'm sure someone
will tell me that Emacs org-mode does this for them.

> I'll go for the brackets in the outer ones, as Maths do, as Thaddeus
> did, and as you pointed out, as man references already use () and
> changing those would be weird at least; printf[3] seems like you're
> pointing to a [3] at the bottom of a page.

Indeed so.  In the next release of groff, ms will bracket footnotes like
this automatically in nroff mode (that is, for terminal output)[2].  I
recently noticed that the me(7) package does not, and I think it should.

> I have trouble myself when reading those expressions, especially when
> mixing that with another negation.  I have to mentally cancel out
> negations first :D

It's a tough problem.  When I was learning Spanish I had trouble
acquiring the practice of reinforcing negatives in sentences ("No
tenemos [no] dios, no tenemos [no] jefes."[??])  How many negatives do I
need?  When do I stop?

Getting back to English, I would be over the moon if my fellow native
speakers would quit misrepresenting the logical negation of "all horses
are animals" as "all horses are not animals".  You see and hear this all
the time, notoriously from journalists.

> I like that reasoning.  I'd like to be able to use .P.  But that would
> mean adding even more inconsistency to the man-pages (of course we
> wouldn't change existing pages to use .P at this point).

Granted.  What I do with groff's man pages is that I tend to queue up
style fixes (mentally if nothing else), applying them when I have a
content fix to make to a page.  Over time, things settle into a new
consistency, but patience is required if churn or flag days are to be
avoided.

> I keep reading that list :)

I'm glad you're still there!

Regards,
Branden

[1] ...except in mixed case since groff 1.23.0 will support this.[3]  :)
[2] https://git.savannah.gnu.org/cgit/groff.git/commit/?id=3Dcaeede07cd2e6e=
10134385cca194c52342f46972
[3] https://git.savannah.gnu.org/cgit/groff.git/commit/?id=3D9503b794e821ef=
1cf6f705b25dc7abbadb920ad2
    https://git.savannah.gnu.org/cgit/groff.git/commit/?id=3D0438b1b905ebe9=
ac5fc678af06db911d25c3a030

--yq6auqkvkwrvebpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmE4M84ACgkQ0Z6cfXEm
bc6/4BAAkQo1xWqkUMDcKWjuB2mHhaxBxtx4GHjqsLecWycfbxzDqA/Qiqv4/VXz
q0QJZMVEk+61RkFx4BedGzX5EVt4HSTYJGwihQhg1WqY/06ecSCDUpQemeTGfB+x
3ZfrhaIThV3sZXCZ4H49KfXYCkMBJu2TXlTNBnHQuXAQCbHIloJlEU0E0S+6aOcM
6lTc7KfODHC2Anwv4c9RpDAe+tQwSGtt9VJwV6NZDqxr1wgtkQKLUWlESOMYpZpj
HoiaZdn0j7x4lKulkKjRGOVSFRGPP5CzmBRNBgWcHTW614VN3Y/0eEMeoUXyTKPd
rDF8vwzD53NaFpO8rrRT/03xZCym97Hzy8Q1xM44890j2h/WekhvE9gt7dN9Wcwt
TGpoTe9usGZGg6NKmTgvF/cmrwTbRIfvlfcX91uV1ZyrqvNHassgFRu3Nl1I/ssl
CXe+4Q4SAnuzJFjz8TBBqcq5QfLPkRPI6ArukOFKC5iCMHAqt3axp89fFUGptd4l
Lm0ZhfaD6idEITZOMLpFEJfdUvm0hta+z7OZEQ+s9JyLu2sm8vU8iP6mjJ8KwgCj
xn2Z73dH7NKGs9HJDA5uTXC/djBDXJ+lkZQ67mt0DC/UfLaEb1+c8+KJFcGN9b5D
0zMgNrvilkw9+XNyxcmbgecTVK4tIOLyZHywh+FQQDrG5+MU+sA=
=fIkk
-----END PGP SIGNATURE-----

--yq6auqkvkwrvebpt--
