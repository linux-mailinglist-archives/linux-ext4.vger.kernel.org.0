Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D31ED6C2
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 02:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfKDBCh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Nov 2019 20:02:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33164 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfKDBCh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Nov 2019 20:02:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id 6so12903076wmf.0
        for <linux-ext4@vger.kernel.org>; Sun, 03 Nov 2019 17:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AWyR+bGTGMFD8+HQUddI08vKKSkkr0/MKUO4tpvfVAc=;
        b=maSU1c1Nfqp+mxagU+8zJu/nL3aQft8VFDawau8r18GnnN5ulj7Ge6kDMFkVANtHaY
         vGOVUxutk/Selbn1FCyCCbYLuD10+Qj5cGI+zJMcbFYwjyIakMeDAY3PQtMEmB997Cnc
         zveWeRHJUqP8TPeLTTtbwxck2tbuqPpKH+qRJDnupDZCwnxaf9lHxkAiZvakxg+QAWc/
         I0vAQQ3Vaa0vW4A+rxb8v3dX0cQl0cZWiyk3s99QowCZhqrFqup4t9tRDiJTrqsRJk7h
         K9wFR+7CShxORAtte/YIZcbqUCDHztZgUhvnfJHQi/CnuUlToxMqsUgNr4EIQ5CCqSbi
         5Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AWyR+bGTGMFD8+HQUddI08vKKSkkr0/MKUO4tpvfVAc=;
        b=hibxrimzntTjIkXbEJHy2Qn/FFW1kJTiv2rw1XXpmOBWyj9iP8jo70wYMLYniXmFgo
         HOHeUsr5GL3iv/VNpEWsKYhZXX7//d8mFBdOJY/UYMY90Y8LaBeTHSoi6ZnOYUCQU+6u
         JayKste2OSPjCvTgBeIs4OppKuU6anjrB1c6T532SnSTM72OMrFst/tep+ZTBHAy+kSd
         859vihh05m8arpd+fHbcgxrGQTWVliuMJsDcc7iF2oQYY54IyIx/tflnovyOcMhz1v68
         XCz8O1IHaq586/vjNxmCR5zfJUlVO5NiNGzImSgaasTF9uDv/C/xuW85Ahxy3KOiRJDo
         2BWw==
X-Gm-Message-State: APjAAAVtaVw5Vc7dkRB+ZfNozGlXOuG2r13OuYRJy3+R3SyzsyaAxN3K
        dYCv+vJ12Sf1+7LAfKfONiUx0Lvg331Zom+nYdZTTw==
X-Google-Smtp-Source: APXvYqwZXStdNTmX78tlTg6EfvfrB9rtzfnauybC+1E/kFaLejF9Ll3aOQc0YZvrhSevh64Uf4rap4YGCt5z7Q6lDL4=
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr20993335wmf.10.1572829352893;
 Sun, 03 Nov 2019 17:02:32 -0800 (PST)
MIME-Version: 1.0
References: <1571900042725.99617@xiaomi.com> <20191024201800.GE1124@mit.edu>
 <1572349386604.43878@xiaomi.com> <20191029213553.GD4404@mit.edu>
 <1572409673853.43507@xiaomi.com> <20191030142628.GA16197@mit.edu>
In-Reply-To: <20191030142628.GA16197@mit.edu>
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Mon, 4 Nov 2019 09:01:28 +0800
Message-ID: <CAAJeciVYOAWzsjAtL7SNmpFQH60z0MB53OPE3hZ==_oBB0N3dQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCB2MyAwOS8xM10gZXh0NA==?=
        =?UTF-8?B?OiBmYXN0LWNvbW1pdCBjb21taXQgcGF0aCBjaGFuZ2Vz?=
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     =?UTF-8?B?WGlhb2h1aTEgTGkg5p2O5pmT6L6J?= <lixiaohui1@xiaomi.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

another way which i think can fix this fsync time cost problem may be
that changing ext4 data mode from order to writeback.

when in writeback mode, inode' data has not to be waited in jbd2
thread, so the fsync time cost is also reduced.
meawhile, writeback mode also can guarantee filesystem consistency in
os crash-reboot conditions,
with only one drawback is that it will cause security problems such as
stale data will be seen.

but in android system with file encryption enabled, there is no
security problem as files are all encryped.
but user will see wrong file data in system crash-reboot conditions
with writeback mode enabled.

for example:
-------------
file A has allocate 50 new blocks, and already dirtys page cache
corresponding to these 50 blocks,
and after the medata represent new 50 blocks of this file have been
flushed to journal area, the system crash.
file A's data according to above 50 new blocks has not been to flushed to d=
isk.
after system reboot and finish file system recovery work, file A's
size has bee enlarged with new 50 blocks added.
but data in this file's new 50 blocks is not correct. so it will cheat
user if it is difficult to see this data-not-correct problem.
-------------

and this problem can't fixed by e2fsck full check ,it is not belong to
file system consistency,
so we will insist on using order mode ,not writeback mode.

i will also share my view about that ijournal paper in my next time.

On Wed, Oct 30, 2019 at 10:26 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Oct 30, 2019 at 04:28:42AM +0000, Xiaohui1 Li =E6=9D=8E=E6=99=93=
=E8=BE=89 wrote:
> > the problem of file' data wating in jbd2 order mode is also a
> > serious problem which case a long-latency fsync call.
>
> Yes, this is a separate problem, although note that if the file with a
> large amount of data is the file which is being fsync'ed, you have to
> write it out at fsync time no matter what.
>
> You could try to write out dirty data earlier (e.g., by decreasing the
> 30 second writeback window), but there are tradeoffs.  For one thing,
> if the file ends up being deleted anyway, it's better not to write out
> the data at all.  For another, if we know how big the file is at the
> time when we do the writeout, we can do a better job allocating space
> for the file, and it improves the file layout by making it more likely
> it will be contiguous, or at least mostly contiguous.
>
> Also, files that tend to be fsync'ed a lot tend to be database files
> (e.g., SQLite files), and they tend to write small amounts of data and
> then fsync them.  So the problem described below happens when there
> are unrelated files that happen to be downloaded in parallel.  An
> example of this in the Android case mgiht be when the user is
> downloading a large video file, such as a movie, to be watched offline
> later (such as when they are on a plane).
>
> > as pointed out in this iJournaling paper, when three conditions turn up=
 at the same time,
> > 1: order mode must be applied, not the writeback mode.
> > 2: The delayed block allocation technique of ext4 must be  applied.
> > 3: backgroud buffer writes are too many.
>
> (1) and (2) are the default.  (3) may or may not be a frequent
> occurrence, depending on the workload.  In practice though, users
> aren't downloading large files all *that* often.
>
> > we have no choice as the order mode need to do this work, so the
> > waiting inode-data-flushed-disk time is too long in some extreme
> > conditions.  so it cause the appearance of long-latency fsync call.
> >
> > thank you for your reply, i will try to fix this problem in my free tim=
e.
>
> So there is a solution; it's just a bit tricky to do, and it's not
> been a huge enough deal that anyone has allocated time to fix it.
>
> The idea is to allocate space, but not actually update the metadata
> blocks at the time when the data blocks are allocated.  Instead, we
> reserve them so they won't get allocated for use by another file, and
> we note where they are in the extent status cache.  We then issue the
> writes of the data block, and only after they are complete, only
> *then* do we update the metadata blocks (which then gets updated via
> the journal, using either a commit or a fast commit).
>
> This is similar to the dioread_nolock case, where we update the
> metadata blocks first, but mark them as unwritten, then we let the
> data blocks get written, and only finally do we update the metadata
> blocks so they are marked as written (e.g., initialized).  This avoids
> the stale data problem as well, but we end up modifying the metadata
> blocks twice, and it has resulted other performance problems since in
> increases overhead on the i_data_sem lock.  See for example some of
> the posts by Liu Bo from Alibaba last year:
>
> If we can allocate space, write the data blocks, and only *then*
> update the extent tree metadata blocks, it solves a lot of problems.
> We can get rid of the dioread_nolock option; we can get rid of the
> data=3Dordered vs data=3Dwriteback distinction; and we can avoid the need
> to force data blocks to be written out at commit time.  So it improves
> performance, and it will reduce code complexity, making it a win-win
> approach.
>
> The problem is that this means significantly changing how we do block
> allocation and block reservation, so it's a fairly large and invasive
> set of changes.  But it's the right long-term direction, and we'll get
> there eventually.
>
> Cheers,
>
>                                                 - Ted
