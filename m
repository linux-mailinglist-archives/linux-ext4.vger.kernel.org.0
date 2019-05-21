Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2024B81
	for <lists+linux-ext4@lfdr.de>; Tue, 21 May 2019 11:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEUJ3M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 May 2019 05:29:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44305 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEUJ3M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 May 2019 05:29:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id n134so12483530lfn.11
        for <linux-ext4@vger.kernel.org>; Tue, 21 May 2019 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bDhuqyWQOugAB2J2IW4o9KvvRVuCaOEFqCaZHsR2lo=;
        b=qrm95ot6Cg+5UvFW4o/vicOnL7utM3Fk1hl2VAQvbAcWY3DaDiHAbMJUfNbSbmBGKP
         bS+/eAmBn2Et6qNt9R0c4JmZdZuovSkHdtbqsGegevZ6aVtUp0qINvXQ5PnmDY/nhmTH
         l5LX9UNjoleeXiVDFmA2axbTca9t8BWSiLqgy7cuq3gaWopo36mV8A307+JirXMj8jPg
         WxH2v7bc3wY6rXn+7OCF2ZKUfg2AKczNbALEwWYCGEQThrITWHaYLr27FVPDnVj7Gjea
         tMTgi94jYOvtWGlfvS+olWwnozp47LjfG7GEpdw9iE8g/7jlCe69c5+Gc+0U3fayOTGQ
         pJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bDhuqyWQOugAB2J2IW4o9KvvRVuCaOEFqCaZHsR2lo=;
        b=U1XbQtodQEJ7wVdtLMU7ywqBYH3xIfiG5RKe6kceUAxQlN0tfwQO4bVBWo6If+j0s/
         5d9pgfam/4lYRjSWvGKQqZMxXtYc1oD9Twgfvb/QbJ7bjT4HPzJLOPf1NTsMMhOkwdKK
         Wa9g9IC9C8VD0SYjgJxxYyqf0FsRoGvG25V+PPKOKPLJxjsOOfEf5m8nF5IAiT4Ez3Cj
         nYgQVh2CgN3BdZQTRDIhdRPGtvS3uRyqX+qt8O4RCfJ338fxUTs7v9wlObpeO7r8WBDl
         ANmGkBEHdekOG44SGJ9LrRX8L20Q95TGWQyTIeZTdtdtvR3d/39LB6eaEEHQRvaAFbNb
         c8Mw==
X-Gm-Message-State: APjAAAUy7Jr0z0yc9ynhBtPWZTGHaptI+m2vk6YfsNQGdYf3VcQkBRVU
        lX4TspJoMooUzqweciUaRYk85vR6pX1SE5c3AJi1Bg==
X-Google-Smtp-Source: APXvYqx+IN2EjSUfvaaTz/kgVZcP6y31/EIWrDgZcpvYvTh3XkDT9atG8F4bORoEemzmNXf/5z4b0FkkJySERKhSUZo=
X-Received: by 2002:a19:ee0a:: with SMTP id g10mr3722695lfb.127.1558430950013;
 Tue, 21 May 2019 02:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190520115247.060821231@linuxfoundation.org> <20190520222342.wtsjx227c6qbkuua@xps.therub.org>
 <20190521085956.GC31445@kroah.com>
In-Reply-To: <20190521085956.GC31445@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 May 2019 14:58:58 +0530
Message-ID: <CA+G9fYvHmUimtwszwo=9fDQLn+MNh8Vq3UGPaPUdhH=dEKzqxg@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/105] 4.19.45-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 21 May 2019 at 14:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 20, 2019 at 05:23:42PM -0500, Dan Rue wrote:
> > On Mon, May 20, 2019 at 02:13:06PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.19.45 release.
> > > There are 105 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed 22 May 2019 11:50:49 AM UTC.
> > > Anything received after that time might be too late.
> >
> > We're seeing an ext4 issue previously reported at
> > https://lore.kernel.org/lkml/20190514092054.GA6949@osiris.
> >
> > [ 1916.032087] EXT4-fs error (device sda): ext4_find_extent:909: inode #8: comm jbd2/sda-8: pblk 121667583 bad header/extent: invalid extent entries - magic f30a, entries 8, max 340(340), depth 0(0)
> > [ 1916.073840] jbd2_journal_bmap: journal block not found at offset 4455 on sda-8
> > [ 1916.081071] Aborting journal on device sda-8.
> > [ 1916.348652] EXT4-fs error (device sda): ext4_journal_check_start:61: Detected aborted journal
> > [ 1916.357222] EXT4-fs (sda): Remounting filesystem read-only
> >
> > This is seen on 4.19-rc, 5.0-rc, mainline, and next. We don't have data
> > for 5.1-rc yet, which is presumably also affected in this RC round.
> >
> > We only see this on x86_64 and i386 devices - though our hardware setups
> > vary so it could be coincidence.
> >
> > I have to run out now, but I'll come back and work on a reproducer and
> > bisection later tonight and tomorrow.
> >
> > Here is an example test run; link goes to the spot in the ltp syscalls
> > test where the disk goes into read-only mode.
> > https://lkft.validation.linaro.org/scheduler/job/735468#L8081
>
> Odd, I keep hearing rumors of ext4 issues right now, but nothing
> actually solid that I can point to.  Any help you can provide here would
> be great.
>

git bisect helped me to land on this commit,

# git bisect bad
e8fd3c9a5415f9199e3fc5279e0f1dfcc0a80ab2 is the first bad commit
commit e8fd3c9a5415f9199e3fc5279e0f1dfcc0a80ab2
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue Apr 9 23:37:08 2019 -0400

    ext4: protect journal inode's blocks using block_validity

    commit 345c0dbf3a30872d9b204db96b5857cd00808cae upstream.

    Add the blocks which belong to the journal inode to block_validity's
    system zone so attempts to deallocate or overwrite the journal due a
    corrupted file system where the journal blocks are also claimed by
    another inode.

    Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202879
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Cc: stable@kernel.org
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:040000 040000 b8b6ce2577d60c65021e5cc1c3a38b32e0cbb2ff
747c67b159b33e4e1da414b1d33567a5da9ae125 M fs

- Naresh

> thanks,
>
> greg k-h
