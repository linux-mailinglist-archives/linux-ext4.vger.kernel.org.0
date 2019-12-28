Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF512BE38
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Dec 2019 19:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfL1SCg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Dec 2019 13:02:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43466 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfL1SCg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Dec 2019 13:02:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so28255841edb.10
        for <linux-ext4@vger.kernel.org>; Sat, 28 Dec 2019 10:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3CQATDTn/2B/4Fbc8AVpzxc8HKMdQRew1XHudv3St0=;
        b=SaercPp2o1l3Kz5sxUw1sFfSxfAmTWeFhURS8Vwj6k8R4UX3YgLm78JmjVSio2FWBM
         e5B/ON2OEOgLPxP5aiPN3GM6WqreZT0ezIFDgkr87xMPTrJ7N4R4oeZS+2dNVwHjIhlm
         F3OPnfvLNvzWHjq+qdvGcxKFgDuLaFa5K5xWLyoRzU9K0uFQUo+5QANTpWImounWqCJn
         XGrMkmva9hLGhulLfvZQXoEQ/V+YEdqOU8OE5P1gGdLqk08dUXklJBRP4Ytro8vD4bnR
         Ybh+23djyZe4zaKGWJpEhwuKJ+kE80UHUO2sbadf7HtZE1VnLFSGCXHYQ92I5uFRzjGS
         6d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3CQATDTn/2B/4Fbc8AVpzxc8HKMdQRew1XHudv3St0=;
        b=NmK5qas1mNAukswXpVQjd+UoBFiijobHbRrCgIHhqCFM7vn6aO0wVwJjR4RD4t5TId
         xt+0bedQMGkjuqR5Q2WFqFQC6stTGH53yohWsCkDqj/7eAssglgCqT/ZS+hCHbFuECcf
         L09weRj04HlG0EWKmTzOh/qEBCAkKyDQOx4UAKAteKfe8xf6JgWVN55Hz4DsyBUPD3/F
         Q1kPbbsGPTf0kNx/ilqfixcve4pHtmLi0PYIJLVEiOW46563DZytnpWKcvRDhoD5i2I3
         PbQJX5DE1hnzz1AsQ3a4sqhsvDm7+6R14rz7bjl6IAzLI1OlNi4IcdQwsWjK1minLQDX
         cwTQ==
X-Gm-Message-State: APjAAAWIsXdOlgZNFcKwhGlXXPe7a9q9hEbKo2joB/OFtVKlFL7Jxxyw
        oSgiKxKJO3yc4Oct8VmQwq+Um3GggXOjUMvuh24rhu9P
X-Google-Smtp-Source: APXvYqwg/tzbtkEKOIJoI6xQk4Sy3eLLTd7MdrV7SB2rV04Lwh6qr/hYq470u/HkBl6ghxwTIPU4Eojk44tz03N6XtU=
X-Received: by 2002:a17:906:14d5:: with SMTP id y21mr41631399ejc.212.1577556154667;
 Sat, 28 Dec 2019 10:02:34 -0800 (PST)
MIME-Version: 1.0
References: <CADxRZqyeaMuxoT+Rvp--bmX2-WvRs5v1yULcm3E5V4TfV5Qc2A@mail.gmail.com>
 <CADxRZqzPDfu36TB5ajhtyxrOx2HdPTe-8YE+ZnKA7DkdutUkGw@mail.gmail.com>
 <20191227044936.GB70060@mit.edu> <CADxRZqx4MKB4g0uWaraB48YEjUVo_4Nu58Ne7x2C62YMt07DYg@mail.gmail.com>
In-Reply-To: <CADxRZqx4MKB4g0uWaraB48YEjUVo_4Nu58Ne7x2C62YMt07DYg@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Sat, 28 Dec 2019 21:02:23 +0300
Message-ID: <CADxRZqyyM6cUGQhwWrOObFJRAT+-SafYP32ZzBt8mcnixrMc6A@mail.gmail.com>
Subject: Re: e2fsprogs.git dumpe2fs / mke2fs sigserv on sparc64
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 28, 2019 at 8:17 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> On Fri, Dec 27, 2019 at 7:49 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Wed, Dec 18, 2019 at 03:01:03AM +0300, Anatoly Pugachev wrote:
> > > On Tue, Dec 17, 2019 at 9:01 PM Anatoly Pugachev <matorola@gmail.com> wrote:
> > > >
> > > > Getting current git e2fsprogs of dumpe2fs/mke2fs (and probably others)
> > > > segfaults (via make check) with the following backtrace...
> >
> > Hi,
> >
> > Thanks for reporting this bug.  It should be fixed with this commit:
> >
> > commit c9a8c53b17ccc4543509d55ff3b343ddbfe805e5
>
> Theodore, thanks.
> This patch fixes issue with all e2fsprogs test suite.
>
> PS: there's another one which is failed:
> 366 tests succeeded     1 tests failed
>
> i_bitmaps: e2image bitmap read/write test: failed
>
>
> e2fsprogs.git$ git desc
> v1.45.4-57-g523219f2
>
> $ cd e2fsprogs.git/tests/i_bitmaps
>
> e2fsprogs.git/tests/i_bitmaps$ ulimit -c unlimited
>
> e2fsprogs.git/tests/i_bitmaps$ ../../misc/e2image /tmp/image  /tmp/image.e2i
> e2image 1.46-WIP (09-Oct-2019)
> Segmentation fault (core dumped)
>
> e2fsprogs.git/tests/i_bitmaps$ gdb -q ../../misc/e2image
> Reading symbols from ../../misc/e2image...
> (gdb) set args /tmp/image /tmp/image.e2i
> (gdb) run
> Starting program: e2fsprogs.git/misc/e2image /tmp/image /tmp/image.e2i
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/sparc64-linux-gnu/libthread_db.so.1".
> e2image 1.46-WIP (09-Oct-2019)
>
> Program received signal SIGSEGV, Segmentation fault.
> ext2fs_swap_group_desc2 (fs=0x10000148a90, gdp=0x0) at swapfs.c:145
> 145             gdp->bg_block_bitmap = ext2fs_swab32(gdp->bg_block_bitmap);
> (gdb) br
> Breakpoint 1 at 0x1000001bb10: file swapfs.c, line 145.

this was meant to be bt (backtrace), not br (brakepoint):

Program received signal SIGSEGV, Segmentation fault.
ext2fs_swap_group_desc2 (fs=0x10000148a90, gdp=0x0) at swapfs.c:145
145             gdp->bg_block_bitmap = ext2fs_swab32(gdp->bg_block_bitmap);
(gdb) bt
#0  ext2fs_swap_group_desc2 (fs=0x10000148a90, gdp=0x0) at swapfs.c:145
#1  0x00000100000080fc in ext2fs_image_super_write (fs=0x10000148a90,
fd=<optimized out>, flags=<optimized out>) at imager.c:248
#2  0x0000010000004cc8 in write_image_file (fd=<optimized out>,
fs=<optimized out>) at e2image.c:245
#3  main (argc=<optimized out>, argv=<optimized out>) at e2image.c:1717
(gdb)
