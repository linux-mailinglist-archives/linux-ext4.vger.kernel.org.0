Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294C2297AF5
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Oct 2020 07:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759660AbgJXFxw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Oct 2020 01:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759650AbgJXFxv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Oct 2020 01:53:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA403C0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 22:53:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a5so3823552ljj.11
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gRtWRnJLTGmKjwzMm2qSH7uQWeKFM7blQ/IQ4eSzr+M=;
        b=f7mq2j1iGFivuER3YlgrExopH89NMdJk0OALk+LhmgtNiv7vwPI9uDcONKc1l1A3Ys
         dCmOaFAAfbrwkX41EcvOXC4wnQiiPIj0XzysHl8+cH7KrO/WXMFQ/ne8UIZNpaHuUshs
         Ly8js049ZyRFJ+NpAOyxwZUN7GibXW/Q2k30sqaRIgVnxrevPzYO6OIq8XIaxbas3Okk
         JDZfkOahnw6qQYSVAaklRYNYhqzoXf6vye6svLwyQSwNODW6x2l3DTgGe/5tRsfU3YtJ
         4zj2H9UDuqUHrHI929gsH4KgtFEuUaQBeMhIN/IWG4+QbrzC59+kEMYyy7ncYs+g8pJA
         woLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gRtWRnJLTGmKjwzMm2qSH7uQWeKFM7blQ/IQ4eSzr+M=;
        b=CX7ln9V28TlYq1onX+kFdbiGUUxcD5qmU4o1k5iQNRgDbFAFIadrZGWsplekBQkT31
         Jp3kf8OJrde7eKSzo9gEn8uyqqibDNM8IL5n9dPAKzqSE/lW31B3ky8ALippv7+zM+sQ
         5vbL28qLjIevub95KBw1AkodFRNybr0cwNZDjtVzTRiOJuKWQkbv0hlysh6+nIPSQPQ8
         8htuzmGop5ujC9ATX/xgWUFB0rHFMYm8GQaX9BL9vXCyL4jnBtxaq2lWuiy1joJf4dNk
         YoSJzVt03IAde1QKwM/JW3D7g78nBiLAXYWD+aCc8Z/ucPfVLHTOWbcTeyN3y2ppvREp
         ZAMQ==
X-Gm-Message-State: AOAM530jREP1Ynl4Qnl+A4HEqgmSShc4nqaDsEbG1fCsph5blQawXuoL
        IWOkqmC2z354BLgybhk6LIRGElKC/CY1ysKbQUkbEw==
X-Google-Smtp-Source: ABdhPJxoB4i1Nx1nNwZkRrPF7huFyJMzQ+OZbgncNLRIimt+pOMcEQFXhAeWVGU7wPnkkY70fkbjli8kj7MG1KXq7XE=
X-Received: by 2002:a05:651c:297:: with SMTP id b23mr2262253ljo.363.1603518827938;
 Fri, 23 Oct 2020 22:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201020073740.29081-1-geert@linux-m68k.org> <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
 <fa84c31f-218f-76be-87de-aa85c3c9b621@infradead.org> <20201021223649.GP181507@mit.edu>
 <CAFd5g44ymt3h6=_h3muHb9A6pPXaTnfhnixYrSny_sEUKGnzzQ@mail.gmail.com> <20201023140744.GS181507@mit.edu>
In-Reply-To: <20201023140744.GS181507@mit.edu>
From:   David Gow <davidgow@google.com>
Date:   Sat, 24 Oct 2020 13:53:36 +0800
Message-ID: <CABVgOSnVpspcmAUZ+zjmjwgnGJEHPOjXahj8xCHc-ymZAKxeuw@mail.gmail.com>
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of
 selecting it
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 23, 2020 at 10:07 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Oct 22, 2020 at 04:52:52PM -0700, Brendan Higgins wrote:
> > So you, me, Luis, David, and a whole bunch of other people have been
> > thinking about this problem for a while. What if we just put
> > kunitconfig fragments in directories along side the test files they
> > enable?
> >
> > For example, we could add a file to fs/ext4/kunitconfig which contains:
> >
> > CONFIG_EXT4_FS=3Dy
> > CONFIG_EXT4_KUNIT_TESTS=3Dy
> >
> > We could do something similar in fs/jdb2, etc.
> >
> > Obviously some logically separate KUnit tests (different maintainers,
> > different Kconfig symbols, etc) reside in the same directory, for
> > these we could name the kunitconfig file something like
> > lib/list-test.kunitconfig (not a great example because lists are
> > always built into Linux), but you get the idea.
> >
> > Then like Ted suggested, if you call kunit.py run foo/bar, then
> >
> > if bar is a directory, then kunit.py will look for foo/bar/kunitconfig
> >
> > if bar is a file ending with .kunitconfig like foo/bar.kunitconfig,
> > then it will use that kunitconfig
> >
> > if bar is '...' (foo/...) then kunit.py will look for all kunitconfigs
> > underneath foo.
> >
> > Once all the kunitconfigs have been resolved, they will be merged into
> > the .kunitconfig. If they can be successfully merged together, the new
> > .kunitconfig will then continue to function as it currently does.
>
> I was thinking along a similar set of lines this morning.  One thing
> I'd add in addition to your suggestion to that is to change how
> .kunitconfig is interpreted such that
>
> CONFIG_KUNIT=3Dy
>
> is always implied, so it doesn't have to be specified explicitly, and
> that if a line like:
>
> fs/ext4
>
> or
>
> mm
>
> etc. occurs, that will cause a include of the Kunitconfig (I'd using a
> capitalized version of the filename like Kconfig, so that it's easier
> to see in a directory listing) in the named directory.
>
> That way, .kunitconfig is backwards compatible, but it also allows
> people to put a one-liner into .kunitconfig to enable the unit tests
> for that particular directory.
>
> What do folks think?
>

I quite like the idea of supporting includes, as it'd make it easier
to have test hierarchies as well: fs/Kunitconfig could include
ext4/Kunitconfig and fat/Kunitconfig, for instance. If we're adding
something more complicated to the Kunitconfig files than just raw
config entries, there are other things we could do, too (personally,
I'd quite like to be able to list KUnit test modules to be loaded
someday, though that's a bit outside the scope of this discussion).

There are some issues with exactly how we format these that'll need to
be resolved: there are cases where there are multiple distinct "areas"
that need testing which share a subdirectory (something like lib/), so
just using directory paths with one Kunitconfig file per directory has
some limitations. At the same time, it's definitely nicer to be able
to just specify a directory where that works.

Here's what I propose (noting that, realistically, it's unlikely we'll
have time to build the perfect system straight away):

1. We've agreed that 'select' isn't the solution we want, so accept
this patch to get rid of it, and avoid using it elsewhere (I've done
this for the fat test[1]). Do we know if changing this now will
seriously break anyone's workflow (particularly if there's something
automated that'd break?)

2. Add support to kunit.py for loading an arbitrary kunitconfig,
rather than using the default one in the root or build dir. (e.g.,
kunit.py run [path_to_kunitconfig]). This'd let us create
per-subsystem/feature/etc kunitconfigs and use them straight away.
This'd still require people to pass in the kunitconfig path each time
they run the tests, but'd at least give maintainers a single command
they can use and recommend =E2=80=94 they'd just need to have a Kunitconfig
file somewhere in the tree with the tests they want people to run.
Maybe if you pass a directory path, it looks for "Kunitconfig" in that
directory, but otherwise it can be a file like
"lib/data-structres.Kunitconfig" or something which doesn't correspond
to a directory.

3. Add the include support, etc, to kunitconfig, so people working on
multiple subsystems can more easily run groups of tests. This may get
a little complicated if we care about handling things with conflicting
dependencies, so I don't want to hold up the first two on that.

How does that sound?

-- David

[1]: https://lore.kernel.org/linux-kselftest/20201024052047.2526780-1-david=
gow@google.com/
