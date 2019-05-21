Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42B24CAA
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2019 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfEUK2a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 May 2019 06:28:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42926 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUK2a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 May 2019 06:28:30 -0400
Received: by mail-lf1-f66.google.com with SMTP id y13so12632087lfh.9
        for <linux-ext4@vger.kernel.org>; Tue, 21 May 2019 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypEC6tDgKAfHuEBHsi8HF1SX5FcgwInmJVlMmX/EfCU=;
        b=ZkSCYeAzMi0thhRrnIvfYIQJ8rn7TLQ8Z7DxodHlKXwnrL5Ijd3ZlHAyRC04x3+LW+
         riiRoAflqyMdLnpDjaG6FeZZtAQC/7FXkkvYZfLCPPOEps0Ua+Ue21OpyP0xdXeh75j1
         GFnLnUbWZztTc00PaJDSiatCDXDAYlnxzb12xdE2fCNQH2fWnWFtcvvT+QH4d53sMlPp
         jlzjJ9gI+RgEq2/mL5DCdHtFfbXQhzy7OY/jgZ+gkrnICsONpZ5v95a7YYdq0rxXccxa
         7LkcMaelW0RyOzZYZ2n4V6k2/8dTgP46LKHKpDKhKTt6+s1Y3B4DivFCD7jBUrW6PS9x
         yxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypEC6tDgKAfHuEBHsi8HF1SX5FcgwInmJVlMmX/EfCU=;
        b=ca6lpIaRdKQO+QJDEcPFrWSx8+Oq3hZYbPHp49Cz4VbJ/bP3lU8+36iwMBfVZOXvzQ
         6t/vtyJRKURmuu/6EAvqQbWS6EK1ixlYJmKP5rJWE7RAWspY8fC71iAEyESDYrwQRP/Y
         q+gp1/uVf/guss7ROBezH3Bpv+jIDttaZy7NVA70iWIKracId9RP5i64il0f22K+thmN
         fGKJVsdkxPKWgePOZxFVB/CR0h4kEqbDrW8R7wsR0bR71+omZ5XM63YezRejVbEjiaBz
         1rtBJxYZpP87HDM2pKIfvSuRPPNFf228IBy9ehev+ThDqf48Fay9ASSN8f4k2YdrCwZE
         Xg1A==
X-Gm-Message-State: APjAAAU0Owraq+m6ISafAK6izObTpDgsvXet+X/L1EPSRdVp1Qa3ydL8
        NqaDYxMpK6qFNWgv1uPXKuZYEQN9f/O5Gs+DyXerZA==
X-Google-Smtp-Source: APXvYqxaPoajSLqDQ5wespjdeGowGUfBiNAuDTnpRIMI85N/n48zuFdCpcv8LtcEdpCbkRjFqW/KclwazMexHAvBwM8=
X-Received: by 2002:ac2:429a:: with SMTP id m26mr1408107lfh.152.1558434507185;
 Tue, 21 May 2019 03:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190520115247.060821231@linuxfoundation.org> <20190520222342.wtsjx227c6qbkuua@xps.therub.org>
 <20190521085956.GC31445@kroah.com> <CA+G9fYvHmUimtwszwo=9fDQLn+MNh8Vq3UGPaPUdhH=dEKzqxg@mail.gmail.com>
 <20190521093849.GA9806@kroah.com>
In-Reply-To: <20190521093849.GA9806@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 May 2019 15:58:15 +0530
Message-ID: <CA+G9fYveeg_FMsL31aunJ2A9XLYk908Y1nSFw4kwkFk3h3uEiA@mail.gmail.com>
Subject: Re: ext4 regression (was Re: [PATCH 4.19 000/105] 4.19.45-stable review)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 21 May 2019 at 15:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 21, 2019 at 02:58:58PM +0530, Naresh Kamboju wrote:
> > On Tue, 21 May 2019 at 14:30, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, May 20, 2019 at 05:23:42PM -0500, Dan Rue wrote:
> > > > On Mon, May 20, 2019 at 02:13:06PM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.19.45 release.
> > > > > There are 105 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Wed 22 May 2019 11:50:49 AM UTC.
> > > > > Anything received after that time might be too late.
> > > >
> > > > We're seeing an ext4 issue previously reported at
> > > > https://lore.kernel.org/lkml/20190514092054.GA6949@osiris.
> > > >
> > > > [ 1916.032087] EXT4-fs error (device sda): ext4_find_extent:909: inode #8: comm jbd2/sda-8: pblk 121667583 bad header/extent: invalid extent entries - magic f30a, entries 8, max 340(340), depth 0(0)
> > > > [ 1916.073840] jbd2_journal_bmap: journal block not found at offset 4455 on sda-8
> > > > [ 1916.081071] Aborting journal on device sda-8.
> > > > [ 1916.348652] EXT4-fs error (device sda): ext4_journal_check_start:61: Detected aborted journal
> > > > [ 1916.357222] EXT4-fs (sda): Remounting filesystem read-only
> > > >
> > > > This is seen on 4.19-rc, 5.0-rc, mainline, and next. We don't have data
> > > > for 5.1-rc yet, which is presumably also affected in this RC round.
> > > >
> > > > We only see this on x86_64 and i386 devices - though our hardware setups
> > > > vary so it could be coincidence.
> > > >
> > > > I have to run out now, but I'll come back and work on a reproducer and
> > > > bisection later tonight and tomorrow.
> > > >
> > > > Here is an example test run; link goes to the spot in the ltp syscalls
> > > > test where the disk goes into read-only mode.
> > > > https://lkft.validation.linaro.org/scheduler/job/735468#L8081
> > >
> > > Odd, I keep hearing rumors of ext4 issues right now, but nothing
> > > actually solid that I can point to.  Any help you can provide here would
> > > be great.
> > >
> >
> > git bisect helped me to land on this commit,
> >
> > # git bisect bad
> > e8fd3c9a5415f9199e3fc5279e0f1dfcc0a80ab2 is the first bad commit
> > commit e8fd3c9a5415f9199e3fc5279e0f1dfcc0a80ab2
> > Author: Theodore Ts'o <tytso@mit.edu>
> > Date:   Tue Apr 9 23:37:08 2019 -0400
> >
> >     ext4: protect journal inode's blocks using block_validity
> >
> >     commit 345c0dbf3a30872d9b204db96b5857cd00808cae upstream.
> >
> >     Add the blocks which belong to the journal inode to block_validity's
> >     system zone so attempts to deallocate or overwrite the journal due a
> >     corrupted file system where the journal blocks are also claimed by
> >     another inode.
> >
> >     Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202879
> >     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> >     Cc: stable@kernel.org
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > :040000 040000 b8b6ce2577d60c65021e5cc1c3a38b32e0cbb2ff
> > 747c67b159b33e4e1da414b1d33567a5da9ae125 M fs
>
> Ah, many thanks for this bisection.
>
> Ted, any ideas here?  Should I drop this from the stable trees, and you
> revert it from Linus's?  Or something else?
>
> Note, I do also have 170417c8c7bb ("ext4: fix block validity checks for
> journal inodes using indirect blocks") in the trees, which was supposed
> to fix the problem with this patch, am I missing another one as well?

FYI,
I have applied fix patch 170417c8c7bb ("ext4: fix block validity checks for
 journal inodes using indirect blocks") but did not fix this problem.

>
> (side note, it was mean not to mark 170417c8c7bb for stable, when the
> patch it was fixing was marked for stable, I'm lucky I caught it...)
>

This problem occurring on stable rc 4.19, 5.0, 5.1 branches
and master branch of mainline and -next trees also.


- Naresh
