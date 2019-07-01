Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A55E5BDA4
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2019 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfGAOIZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Jul 2019 10:08:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34826 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfGAOIZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Jul 2019 10:08:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so13624742otq.2;
        Mon, 01 Jul 2019 07:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7d4aozfprbFNEPiJb3m+1zVikqgEXOkjz3OhZ1mdyOA=;
        b=RIhpRvsatpnn+X/Olov3rn7PvL13zhYG9N9//SY+DrDKLwNULHKorKCODwiwvLdc4t
         WzrJ/afAi+bEJiskEyaRHqhvzrCIPFIi7/qyWk+yV4ARz7i/DeUUhc1aUdXMQjOne10V
         Rm/YOAZs/wIbnJ5MHNQ4ejxbpCyOPS/7ZuIPb7n3x57kCE5pDrtr7Hu/BpX2M5Dwb9wp
         8YpXHo6IyeQo5OMo5WcQNMrUwtdS5XdzWFFFIDx1kvryQhTDbkxIs3FG0Oer2V7y5ZMR
         IsPybMzwxSrUcJ+H6C3KKg3Jr0OKo66nMhfbL5w3gQMk+KtQneeCpChUOvqPpnvBI+0e
         ygJw==
X-Gm-Message-State: APjAAAVXc7bMHiH9Q3NZrfBcFyZpuw0tTJanI+ERFl8hqgbyGcFl8tpK
        l7c4uTN5rd1okxjuZ0P+B0lefftjT8mvoVnZAjM=
X-Google-Smtp-Source: APXvYqywEkY5gIDjlSC+YCgH2xLXFtfJbmo18y30nP9yxPrPoW51cgqOZyEP8PhlLhu4MoQ/juVa8bUSJCfZQDc+tGk=
X-Received: by 2002:a9d:529:: with SMTP id 38mr16744827otw.145.1561990104779;
 Mon, 01 Jul 2019 07:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
 <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com>
 <20190511220659.GB8507@mit.edu> <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net>
 <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net> <17C30FA3-1AB3-4DAD-9B86-9FA9088F11C9@internode.on.net>
 <20190515045717.GB5394@mit.edu> <CAMuHMdV=63MwLdOB2kcX0=23itHg+_q22wXCycTvH3yn4zsfWw@mail.gmail.com>
 <CAMuHMdU-vfWjomDpttYTqgp4YzBu7z__p48r7rq6TSUwx7uFqQ@mail.gmail.com> <20190701135607.GB6549@mit.edu>
In-Reply-To: <20190701135607.GB6549@mit.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Jul 2019 16:08:13 +0200
Message-ID: <CAMuHMdVn9zMsas47CZpWdrFMTu0htn11Dhk459bosFxW7YZv_A@mail.gmail.com>
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Mon, Jul 1, 2019 at 3:56 PM Theodore Ts'o <tytso@mit.edu> wrote:
> On Mon, Jul 01, 2019 at 02:43:14PM +0200, Geert Uytterhoeven wrote:
> > Despite this fix having been applied upstream,  the kernel prints from
> > time to time:
> >
> >     EXT4-fs (sda1): error count since last fsck: 5
> >     EXT4-fs (sda1): initial error at time 1557931133:
> > ext4_get_branch:171: inode 1980: block 27550
> >     EXT4-fs (sda1): last error at time 1558114349:
> > ext4_get_branch:171: inode 1980: block 27550
> >
> > This happens even after a manual run of "e2fsck -f" (while it's mounted
> > RO), which reports a clean file system.
>
> What's happening is this.  When the kernel detects a corruption, newer
> kernels will set these superblock fields:
>
>         __le32  s_error_count;          /* number of fs errors */
>         __le32  s_first_error_time;     /* first time an error happened */
>         __le32  s_first_error_ino;      /* inode involved in first error */
>         __le64  s_first_error_block;    /* block involved of first error */
>         __u8    s_first_error_func[32] __nonstring;     /* function where the error happened */
>         __le32  s_first_error_line;     /* line number where error happened */
>         __le32  s_last_error_time;      /* most recent time of an error */
>         __le32  s_last_error_ino;       /* inode involved in last error */
>         __le32  s_last_error_line;      /* line number where error happened */
>         __le64  s_last_error_block;     /* block involved of last error */
>         __u8    s_last_error_func[32] __nonstring;      /* function where the error happened */
>
> When newer versions of e2fsck *fix* the corruption, it will clear
> these fields.  It's basically a safety check because *way* too many
> ext4 users run with errors=continue (aka, "don't worry, be happy"
> mode), and so this is a poke in the system logs that the file system
> is corrupted, and they, really, *REALLY* should fix it before they
> lose (more) data.

Thanks for the explanation, much appreciated!

> > The inode and block numbers match the numbers printed due to the
> > previous bug.
>
> You can also see when the last file system error was detected via:
>
> % date -d @1558114349
> Fri 17 May 2019 01:32:29 PM EDT

Good. So no new errors detected after the fix.

> > Do you have an idea what's wrong?
> > Note that I run a very old version of e2fsck (from a decade ago).
>
> ... and that's the problem.  If you're going to be using newer
> versions of the kernel, you really should be using newer versions of
> e2fsprogs.
>
> There have been a lot of bug fixes in the last 10 years, and some of
> them can be data corruption bugs....

Yeah, one day I'll have to change the winning horse...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
