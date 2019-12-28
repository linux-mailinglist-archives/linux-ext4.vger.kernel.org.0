Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F012BE22
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Dec 2019 18:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfL1RRT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Dec 2019 12:17:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35081 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfL1RRS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Dec 2019 12:17:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so28209533edv.2
        for <linux-ext4@vger.kernel.org>; Sat, 28 Dec 2019 09:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/X447ruVmnNzSxKFpt4jWkujfjeT5ORU22XUMwlDayc=;
        b=U5Xsc89wbTJPuHoSEai07RT02WAWl9VTr/NHDuhn7GzFT7FPorqo2FdQFUfJ2hImAx
         AYhPJIiewhwsbMmcvjxRd8IXS55W5cakrJNxMz74WXuLAogLGwzGfUCW8wZtZHDbJgD9
         W2xUWI+W3QfcO9oEB2CA34X5iLanvci8ZYgxhCvU1Mjv/TSfBdq2MwGuwN6TL6lB0EpN
         hGjYJqcnHGPMAyFvsI62QztGnMbSiEesOmmhPeDYPjxN4Tcl02vwFR/QsTli2S9ktKKl
         uCgLZVsLCUBv2iyPTVEG/qOq1XxQQclrBucs/hsN3Anvx7uwe41u0s1D5kLjwoE4HweI
         /TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/X447ruVmnNzSxKFpt4jWkujfjeT5ORU22XUMwlDayc=;
        b=TjZfVNQ1k61jAUGvB61hKmKFUnGiPEIFKVfcZVbJ+adByCeDSqaeZOadsK77RrVLU+
         dusY8FB8x2e0krFKj1PU5ont5weJqc+4Ii4spHuUIuQlNlkeoAm3Riy1VGtOPDfBasfb
         HydfUWlGryPZdVwtPebLyduK4ANw7T01wrWTu6A0A4HOjpwTL6vymcUX4KOQSea6B1V2
         Z1Qtui6Kj7wPfKnpvUASfeuSt3byYeuGuhstDFpDsqQgM130r0RY2hWwYTnV/Dbrdamm
         wkEAHwS0Al6xpUL7QZl0kkfF/jH2IhSvVkSw8hFa+m3S0hG59SkpDtB9UvUBvPLVLPaE
         t4Ew==
X-Gm-Message-State: APjAAAUPS4un/ve1b0VFXlcqOQzuT/gc77Yemi3cTw0ohGXODlXR0qDp
        gloE8iqlBd8YAcAIEPHfXy1UeNofDKoXWJa0d7fcI1Ay
X-Google-Smtp-Source: APXvYqy367iIqqr+Yu8o8/wGfsfg7754sRcIpHTOQ6mx2OY4gEdl3sOf03H2ozUOTrmL9bHiUtHD0r15jnU3ZmP7cwg=
X-Received: by 2002:a05:6402:28d:: with SMTP id l13mr59540098edv.236.1577553437001;
 Sat, 28 Dec 2019 09:17:17 -0800 (PST)
MIME-Version: 1.0
References: <CADxRZqyeaMuxoT+Rvp--bmX2-WvRs5v1yULcm3E5V4TfV5Qc2A@mail.gmail.com>
 <CADxRZqzPDfu36TB5ajhtyxrOx2HdPTe-8YE+ZnKA7DkdutUkGw@mail.gmail.com> <20191227044936.GB70060@mit.edu>
In-Reply-To: <20191227044936.GB70060@mit.edu>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sat, 28 Dec 2019 20:17:06 +0300
Message-ID: <CADxRZqx4MKB4g0uWaraB48YEjUVo_4Nu58Ne7x2C62YMt07DYg@mail.gmail.com>
Subject: Re: e2fsprogs.git dumpe2fs / mke2fs sigserv on sparc64
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 27, 2019 at 7:49 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Dec 18, 2019 at 03:01:03AM +0300, Anatoly Pugachev wrote:
> > On Tue, Dec 17, 2019 at 9:01 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> > >
> > > Getting current git e2fsprogs of dumpe2fs/mke2fs (and probably others)
> > > segfaults (via make check) with the following backtrace...
>
> Hi,
>
> Thanks for reporting this bug.  It should be fixed with this commit:
>
> commit c9a8c53b17ccc4543509d55ff3b343ddbfe805e5

Theodore, thanks.
This patch fixes issue with all e2fsprogs test suite.

PS: there's another one which is failed:
366 tests succeeded     1 tests failed

i_bitmaps: e2image bitmap read/write test: failed


e2fsprogs.git$ git desc
v1.45.4-57-g523219f2

$ cd e2fsprogs.git/tests/i_bitmaps

e2fsprogs.git/tests/i_bitmaps$ ulimit -c unlimited

e2fsprogs.git/tests/i_bitmaps$ ../../misc/e2image /tmp/image  /tmp/image.e2i
e2image 1.46-WIP (09-Oct-2019)
Segmentation fault (core dumped)

e2fsprogs.git/tests/i_bitmaps$ gdb -q ../../misc/e2image
Reading symbols from ../../misc/e2image...
(gdb) set args /tmp/image /tmp/image.e2i
(gdb) run
Starting program: e2fsprogs.git/misc/e2image /tmp/image /tmp/image.e2i
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/sparc64-linux-gnu/libthread_db.so.1".
e2image 1.46-WIP (09-Oct-2019)

Program received signal SIGSEGV, Segmentation fault.
ext2fs_swap_group_desc2 (fs=0x10000148a90, gdp=0x0) at swapfs.c:145
145             gdp->bg_block_bitmap = ext2fs_swab32(gdp->bg_block_bitmap);
(gdb) br
Breakpoint 1 at 0x1000001bb10: file swapfs.c, line 145.
(gdb) p gdp
$1 = (struct ext2_group_desc *) 0x0
(gdb)
