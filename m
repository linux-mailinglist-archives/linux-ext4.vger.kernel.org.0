Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D15137A76
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Jan 2020 01:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgAKANw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jan 2020 19:13:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39910 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgAKANw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Jan 2020 19:13:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so3193936eds.6
        for <linux-ext4@vger.kernel.org>; Fri, 10 Jan 2020 16:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exvRwaf6Fcg2yDAKT17GRq1b5OtwusPzanX62x0yWMQ=;
        b=KrLbtkAbt3SJh2NH6mDA7Hakx9dIjEXBA0iUniIvRullT3NTaT4WHsDo+rci7xyB0T
         SaQnHop7nHJK7HHaiPLvGgyNC5o79XP8D2DAMaYrJqVycK+uaOnT5IEiCwIDJppJ2Bm7
         LJ/W6jR5TI66l5gDJvFsjqaqyGulrhaiDFLIDi45JviwLJDYgXLoDo8IFr3zU5n4ywZ2
         dbo78VAPFRGedyaGVsn7npUYKDB49K2cVg+jcUjTAduyqi3VvxnOKiJ9XikPdQ7f0ej8
         BXR3DntRPoRLSehvyObosTDH8Lhgyrz7ahzTpMmvoUB1lxTavJSy5F2oxOjkWPNcG8/m
         JJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exvRwaf6Fcg2yDAKT17GRq1b5OtwusPzanX62x0yWMQ=;
        b=Rlq0fiZwUvrE3LPMlRYApne4NA+iDcbMF2R+En8J069XL0p5+a1kGORL37/cj3TP79
         edTUM8hLt5upcF42MQcCz44cIObnRp9M+xqhaq0jGMen69Yyw3P39UyoJX8LX80cSTcN
         O7DhKhtuWHm3kLoPkfHPPgkJ2cuVl4i7iQl3cXFp0ug3EJkGwtvsfxnEUw9wXuzBWFmh
         +NM0qMrNFRUfhgBR9E8fBuQ/8Q2NdG2g3WqwgBJ7wpPpk6y6B+3zEvi/zA1eWOTzKS51
         sjhKzvdQxoGsoRD0pEUD2wTbEWFNzJtxBG2cHioSSVep4eTVSLrhvKBhquVh0LuLwJmY
         7kRg==
X-Gm-Message-State: APjAAAXpo+CADYSlI6eIO42HUGXOGJzhxCPkUO1N/NUX+YQVKinpUEN3
        A1duDdjJuILqCnLh/hE+hINLS108imJDEgw87AFHdtEG
X-Google-Smtp-Source: APXvYqwFiJ+dWB3dtupWsmKTzoRLPgecZxNBPAQiWWbzKm+mTDoLrEppB5llONbTpVspNqO4BJTJbk6Cj1Su2J4/H2c=
X-Received: by 2002:a17:906:1b07:: with SMTP id o7mr5746376ejg.131.1578701630618;
 Fri, 10 Jan 2020 16:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20200110085217.GA7307@yogzotot> <20200110173432.GB304349@mit.edu>
In-Reply-To: <20200110173432.GB304349@mit.edu>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sat, 11 Jan 2020 03:13:43 +0300
Message-ID: <CADxRZqxLWfkKB6dOp5D0C5QETF0vjF_CG1rRLEO0n1p98U+PFQ@mail.gmail.com>
Subject: Re: [PATCH] libext2fs: Extends commit c9a8c53b, with the same fix for
 ext2fs_flush2() and ext2fs_image_super_write() on a Big Endian systems.
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 10, 2020 at 8:34 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Jan 10, 2020 at 11:52:17AM +0300, Anatoly Pugachev wrote:
> >
> > libext2fs: extends commit c9a8c53b, with the same fix for ext2fs_flush2() and
> > ext2fs_image_super_write() on a Big Endian systems.
> >
> > As follow-up to previous discussion 'dumpe2fs / mke2fs sigserv on sparc64'
> >
> > Used find for files which refer to:
> >
> > e2fsprogs.git$ find . -name \*.c | xargs grep -cl 'gdp = ext2fs_group_desc'
> > ./lib/ext2fs/closefs.c
> > ./lib/ext2fs/openfs.c
> > ./lib/ext2fs/imager.c
> >
> > And applied the same check for a null pointer.
> >
> > Tested on a debian linux with sparc64 LDOM and ppc64 LPAR.
> >
> > Fixes sigserv with test suite in "i_bitmaps" test.
>
> As far as I know, the i_bitmaps test is passing on on sparc64 and
> ppc64.  Search for i_bitmaps in:
>
> https://buildd.debian.org/status/fetch.php?pkg=e2fsprogs&arch=sparc64&ver=1.45.5-2&stamp=1578527938&raw=0
>    and
> https://buildd.debian.org/status/fetch.php?pkg=e2fsprogs&arch=ppc64&ver=1.45.5-2&stamp=1578526270&raw=0
>
> The bug in c9a8c53b was caused by SPARSE_SUPER being passed to
> ext2fs_open().  But that doesn't happen in misc/e2image.
>
> I can see optimizing ext2fs_flush() to skip byte-swapping the group
> descriptors if the SUPER_ONLY flag is enabled.  And I can see
> ext2fs_image_super_write() checking to see if the SUPER_ONLY flag is
> set, and returning an error in that case.
>
> But I don't think any of the current e2fsprogs are crashing at the
> moment.  Am I missing something?

Ted,

I'm using "master" branch for my tests, and debian probably using
"debian/master" .
Even test count is differ. In master branch 366 tests and in
"debian/master" 356 tests.

$ git br -vvv
  debian/master 0ba96395 [origin/debian/master] debian/patches: update
for 1.45.5-2 release
* master        32d33132 [origin/master] Merge branch 'maint' into next

Can you please try master branch on any (sparc64 or ppc64) debian
porter boxes? (There's new ppc64 porter box coming soon)
Or on ppc64/sparc64 "gcc compile test" farm machines?

And it's actually up to you, maybe my patch is irrelevant (and sorry
for the noise then), since i don't know internals for e2fsprogs.

Thanks.
