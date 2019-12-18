Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7F4123B35
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2019 01:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfLRABL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 19:01:11 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:42441 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRABK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Dec 2019 19:01:10 -0500
Received: by mail-ed1-f53.google.com with SMTP id e10so112018edv.9
        for <linux-ext4@vger.kernel.org>; Tue, 17 Dec 2019 16:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=h2HlcO/HPQ330GiQD75k0DcKbjcqLMnFuhTdEezAlzg=;
        b=tQpy+8Y2Qt489KvQOHEkaQ6YLFpCG6mGM7g7mjKAjDyAA/+Ui457Kh2rZ71Wz0amh5
         rcTxgCoFm2OIcCRrJKFPXDjAua8rT3vphqQdED2iD++jdY0ECqGrSUalrfHU6zw4ZxbS
         DElGlPOIHlGqkTbjlMFeJjSncle+TofZWqT1AfmvAU1BZ9lIS9Iyq9louGrW7tei5jfv
         JBg9XEmbguwnRuR1T3XL/bVIwiH1WrmcvQBkRVDqPDKHuCKdaeIzt7zdp19UMWJ/Eylb
         qrclGRGaN78b777p48ftyJIu/IGGzp2FvVG7b8cbmtD1FPxvt5CbIKyNbrWsP0fgY1LI
         j3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=h2HlcO/HPQ330GiQD75k0DcKbjcqLMnFuhTdEezAlzg=;
        b=bDw717qqam724qgCH1XWdguaSDb5C1U2dgh3lTURFrSy8UGnk1s4lzTqsjwuixv3cI
         VIyJb4S6ZH9H+LgkiUUPndVxRmW4wxRQ3fFLvzT8tXmHQM6ls/4GvYBLBIM5G+9kHb7Y
         7U4lxrNrctRQAMB6zb3AkqQv7oHWD7OrIOBL/Hxx4xVubHey/bBQilxFdgjlSYYkHThE
         +guVUvCdosEWrPAqtjGiGqw1AQPoH6CHmsFLCSA6S2Pv0m2A3fG3aGT+ijIKPo1dENW4
         ozwi5eaRyHceSGZbbO0XD/SrCaNvqovBspzAoC4UFsdvYOR8tafECfzi1O7+ikJhKcp+
         QvNg==
X-Gm-Message-State: APjAAAVwVamyLL4N6YhcbyRh/2iBmwUy61PX37+Ns6qRHItermJ/J1mK
        NhNlBM6Nwv7kA+8sYh49h13EeBz94UGtJdGzHl4ZDKjJhVs=
X-Google-Smtp-Source: APXvYqw8xd/gBW9hOkcDTsOQDReVJjGKg0PFXhLzRFF2heGYTkS2Bd5iHzREn1oXs3QBIH2M8iEfi4Te8xiUbah9iJ0=
X-Received: by 2002:a17:906:b212:: with SMTP id p18mr976166ejz.208.1576627268656;
 Tue, 17 Dec 2019 16:01:08 -0800 (PST)
MIME-Version: 1.0
References: <CADxRZqyeaMuxoT+Rvp--bmX2-WvRs5v1yULcm3E5V4TfV5Qc2A@mail.gmail.com>
In-Reply-To: <CADxRZqyeaMuxoT+Rvp--bmX2-WvRs5v1yULcm3E5V4TfV5Qc2A@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 18 Dec 2019 03:01:03 +0300
Message-ID: <CADxRZqzPDfu36TB5ajhtyxrOx2HdPTe-8YE+ZnKA7DkdutUkGw@mail.gmail.com>
Subject: Re: e2fsprogs.git dumpe2fs / mke2fs sigserv on sparc64
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 17, 2019 at 9:01 PM Anatoly Pugachev <matorola@gmail.com> wrote:
>
> Hello!
>
> Getting current git e2fsprogs of dumpe2fs/mke2fs (and probably others)
> segfaults (via make check) with the following backtrace:

JFYI

checkout of commit db41ae2c3e4716ceffe212a742d3c963e400fa1e makes
dumpe2fs to work correctly (i.e. not to segfault).
Tried to bisect (not sure it was fully correct, since i don't used
make clean between bisect steps),
marking head as bad and db41ae2c as good, leads to this commit :

e2fsprogs.git$ git bisect good
e6069a05daeb8d18289ad7772d7800b09b418bca is the first bad commit
commit e6069a05daeb8d18289ad7772d7800b09b418bca
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue Oct 22 18:42:25 2019 -0400

    Teach ext2fs_open2() to honor the EXT2_FLAG_SUPER_ONLY flag

    Opening the file system with EXT2_FLAG_SUPER_ONLY will leave
    fs->group_desc to be NULL and modify "dumpe2fs -h" and tune2fs when it
    is emulating e2label to use this flag.  This speeds up "dumpe2fs -h"
    and "e2label" when operating on very large file systems.

    To allow other libext2fs functions to work without too many surprises,
    ext2fs_group_desc() will read in the block group descriptors on
    demand.  This allows "dumpe2fs -h" to be able to read the journal
    inode, for example.

    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Cray-bug-id: LUS-5777

 lib/ext2fs/blknum.c | 39 ++++++++++++++++++++++++++++++++++++---
 lib/ext2fs/openfs.c |  4 +++-
 misc/dumpe2fs.c     |  2 ++
 misc/tune2fs.c      |  2 +-
 4 files changed, 42 insertions(+), 5 deletions(-)


So, if you need BE machine to test on, please use 'gcc compile farm'
BE machines (gcc202 debian sparc64, gcc110 centos-7 ppc64 - and git
master segfaults on gcc110 as well)
