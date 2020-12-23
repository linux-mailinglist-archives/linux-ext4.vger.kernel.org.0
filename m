Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67722E10DB
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Dec 2020 01:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgLWAsx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 19:48:53 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54578 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLWAsw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 19:48:52 -0500
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3FE6E20B83F2
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 16:48:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FE6E20B83F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608684490;
        bh=v3wvikEi+TCnWKwXVz2SwqZ8WYWaxftiRig40JovFv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lr72FVK2jxltnShil6DAOF7PZpfJ8LCrOuckau7/ltQlnSSkOI951hTAHh7TjeoBX
         85meGHe1Uh6T1GNXxC9bQa4iNq97btASlMc0wc7U0sRqpB7dJ53KVgRI/+QJ0KevAl
         N+rrwIsO94GjWmqCcvZMSgUSrNw28++eXYtlT9zk=
Received: by mail-pl1-f178.google.com with SMTP id b8so8300866plx.0
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 16:48:10 -0800 (PST)
X-Gm-Message-State: AOAM530FGd8++LYOYCiW9wrK3ffL803moQz25yRlYwJbK+sA31Vy7+GD
        THfkPa3f5pTDKbN0INnUtz50J+VJUE1YhSDtxm8=
X-Google-Smtp-Source: ABdhPJx1C6UxcylFirxxKdX5HGAUuJUvlFYHBhi2A6PchIq80SB/O+9il1rC8QtP6HRcSPBBN40R7ZMlAWWtKtJ0cck=
X-Received: by 2002:a17:90a:e551:: with SMTP id ei17mr23745516pjb.187.1608684489661;
 Tue, 22 Dec 2020 16:48:09 -0800 (PST)
MIME-Version: 1.0
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
 <X+AQxkC9MbuxNVRm@mit.edu> <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
 <X+If/kAwiaMdaBtF@mit.edu>
In-Reply-To: <X+If/kAwiaMdaBtF@mit.edu>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Dec 2020 01:47:33 +0100
X-Gmail-Original-Message-ID: <CAFnufp1X1B27Dfr_0DUaBNkKhSGmUjBAvPT+tMoQ8JW6b+q03w@mail.gmail.com>
Message-ID: <CAFnufp1X1B27Dfr_0DUaBNkKhSGmUjBAvPT+tMoQ8JW6b+q03w@mail.gmail.com>
Subject: Re: discard and data=writeback
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 22, 2020 at 5:34 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Dec 22, 2020 at 03:59:29PM +0100, Matteo Croce wrote:
> >
> > I'm issuing sync + sleep(10) after the extraction, so the writes
> > should all be flushed.
> > Also, I repeated the test three times, with very similar results:
>
> So that means the problem is not due to page cache writeback
> interfering with the discards.  So it's most likely that the problem
> is due to how the blocks are allocated and laid out when using
> data=ordered vs data=writeback.
>
> Some experiments to try next.  After extracting the files with
> data=ordered and data=writeback on a freshly formatted file system,
> use "e2freefrag" to see how the free space is fragmented.  This will
> tell us how the file system is doing from a holistic perspective, in
> terms of blocks allocated to the extracted files.  (E2freefrag is
> showing you the blocks *not* allocated, of course, but that's a mirror
> image dual of the blocks that *are* allocated, especially if you start
> from an identical known state; hence the use of a freshly formatted
> file system.)
>

This is with data=ordered:

# e2freefrag /dev/nvme0n1p1
Device: /dev/nvme0n1p1
Blocksize: 4096 bytes
Total blocks: 468843350
Free blocks: 460922366 (98.3%)

Min. free extent: 4 KB
Max. free extent: 2064256 KB
Avg. free extent: 1976084 KB
Num. free extent: 933

# e2freefrag /dev/nvme0n1p1
Device: /dev/nvme0n1p1
Blocksize: 4096 bytes
Total blocks: 468843350
Free blocks: 460922365 (98.3%)

Min. free extent: 4 KB
Max. free extent: 2064256 KB
Avg. free extent: 1976084 KB
Num. free extent: 933

HISTOGRAM OF FREE EXTENT SIZES:
Extent Size Range :  Free extents   Free Blocks  Percent
    4K...    8K-  :             1             1    0.00%
    8K...   16K-  :             2             5    0.00%
   16K...   32K-  :             1             7    0.00%
    2M...    4M-  :             3          2400    0.00%
   32M...   64M-  :             2         16384    0.00%
   64M...  128M-  :            11        267085    0.06%
  128M...  256M-  :            11        650037    0.14%
  256M...  512M-  :             3        314957    0.07%
  512M... 1024M-  :             7       1387580    0.30%
    1G...    2G-  :           892     458283909   99.43%

and this data=writeback:

# e2freefrag /dev/nvme0n1p1
Device: /dev/nvme0n1p1
Blocksize: 4096 bytes
Total blocks: 468843350
Free blocks: 460922366 (98.3%)

Min. free extent: 4 KB
Max. free extent: 2064256 KB
Avg. free extent: 1976084 KB
Num. free extent: 933

HISTOGRAM OF FREE EXTENT SIZES:
Extent Size Range :  Free extents   Free Blocks  Percent
    4K...    8K-  :             1             1    0.00%
    8K...   16K-  :             2             5    0.00%
   16K...   32K-  :             1             7    0.00%
    2M...    4M-  :             3          2400    0.00%
   32M...   64M-  :             2         16384    0.00%
   64M...  128M-  :            11        267085    0.06%
  128M...  256M-  :            11        650038    0.14%
  256M...  512M-  :             3        314957    0.07%
  512M... 1024M-  :             7       1387580    0.30%
    1G...    2G-  :           892     458283909   99.43%

> Next, we can see how individual files look like with respect to
> fragmentation.  This can be done via using filefrag on all of the
> files, e.g:
>
>        find . -type f -print0  | xargs -0 filefrag
>

data=ordered:

# find /media -type f -print0 | xargs -0 filefrag |awk -F: '{print$2}'
|sort |uniq -c
     32  0 extents found
  70570  1 extent found

data=writeback:

# find /media -type f -print0 | xargs -0 filefrag |awk -F: '{print$2}'
|sort |uniq -c
     32  0 extents found
  70570  1 extent found

> Another way to get similar (although not identical) information is via
> running "e2fsck -E fragcheck" on a file system.  How they differ is
> especially more of a big deal on ext3 file systems without extents and
> flex_bg, since filefrag tries to take into account metadata blocks
> such as indirect blocks and extent tree blocks, and e2fsck -E
> fragcheck does not; but it's good enough for getting a good gestalt
> for the files' overall fragmentation
>

data=ordered:

# e2fsck -fE fragcheck /dev/nvme0n1p1
e2fsck 1.45.6 (20-Mar-2020)
Pass 1: Checking inodes, blocks, and sizes
69341844(d): expecting 277356746 actual extent phys 277356748 log 1 len 2
69342337(d): expecting 277356766 actual extent phys 277356768 log 1 len 2
69346374(d): expecting 277357037 actual extent phys 277357094 log 1 len 2
69469890(d): expecting 277880969 actual extent phys 277880975 log 1 len 2
69473971(d): expecting 277881215 actual extent phys 277881219 log 1 len 2
69606373(d): expecting 278405580 actual extent phys 278405581 log 1 len 2
69732356(d): expecting 278929541 actual extent phys 278929543 log 1 len 2
69868308(d): expecting 279454129 actual extent phys 279454245 log 1 len 2
69999150(d): expecting 279978430 actual extent phys 279978439 log 1 len 2
69999150(d): expecting 279978441 actual extent phys 279978457 log 3 len 1
69999150(d): expecting 279978458 actual extent phys 279978459 log 4 len 1
69999150(d): expecting 279978460 actual extent phys 279978502 log 5 len 1
69999150(d): expecting 279978503 actual extent phys 279978511 log 6 len 2
69999150(d): expecting 279978513 actual extent phys 279978517 log 8 len 1
70000685(d): expecting 279978520 actual extent phys 279978523 log 1 len 2
70124788(d): expecting 280502371 actual extent phys 280502381 log 1 len 2
70124788(d): expecting 280502383 actual extent phys 280502394 log 3 len 1
70124788(d): expecting 280502395 actual extent phys 280502399 log 4 len 1
70126301(d): expecting 280502445 actual extent phys 280502459 log 1 len 2
70127963(d): expecting 280502526 actual extent phys 280502528 log 1 len 2
70256678(d): expecting 281026905 actual extent phys 281026913 log 1 len 2
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p1: 75365/117211136 files (0.0% non-contiguous),
7920985/468843350 blocks

data=writeback:

# e2fsck -fE fragcheck /dev/nvme0n1p1
e2fsck 1.45.6 (20-Mar-2020)
Pass 1: Checking inodes, blocks, and sizes
91755156(d): expecting 367009992 actual extent phys 367009994 log 1 len 2
91755649(d): expecting 367010012 actual extent phys 367010014 log 1 len 2
91759686(d): expecting 367010283 actual extent phys 367010340 log 1 len 2
91883202(d): expecting 367534217 actual extent phys 367534223 log 1 len 2
91887283(d): expecting 367534463 actual extent phys 367534467 log 1 len 2
92019685(d): expecting 368058828 actual extent phys 368058829 log 1 len 2
92145668(d): expecting 368582789 actual extent phys 368582791 log 1 len 2
92281620(d): expecting 369107377 actual extent phys 369107493 log 1 len 2
92412462(d): expecting 369631678 actual extent phys 369631687 log 1 len 2
92412462(d): expecting 369631689 actual extent phys 369631705 log 3 len 1
92412462(d): expecting 369631706 actual extent phys 369631707 log 4 len 1
92412462(d): expecting 369631708 actual extent phys 369631757 log 5 len 1
92412462(d): expecting 369631758 actual extent phys 369631759 log 6 len 2
92412462(d): expecting 369631761 actual extent phys 369631766 log 8 len 1
92413997(d): expecting 369631768 actual extent phys 369631771 log 1 len 2
92538100(d): expecting 370155619 actual extent phys 370155629 log 1 len 2
92538100(d): expecting 370155631 actual extent phys 370155642 log 3 len 1
92538100(d): expecting 370155643 actual extent phys 370155647 log 4 len 1
92539613(d): expecting 370155693 actual extent phys 370155707 log 1 len 2
92541275(d): expecting 370155774 actual extent phys 370155776 log 1 len 2
92669990(d): expecting 370680153 actual extent phys 370680161 log 1 len 2
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p1: 75365/117211136 files (0.0% non-contiguous),
7920984/468843350 blocks

As an extra test I extracted the archive with data=ordered, remounted
with data=writeback and timed the rm -rf and viceversa.
The mount option is the one that counts, the one using during
extraction doesn't matter.

As extra extra test I also tried data=journal, which is as fast as ordered.

> Even if the files are showing no substantial difference in
> fragmentation, and the free space is equally A-OK with respect to
> fragmentation, the other possibility is the *layout* of the blocks are
> such that the order in which they are deleted using rm -rf ends up
> being less friendly from a discard perspective.  This can happen if
> the directory hierarchy is big enough, and/or the journal size is
> small enough, that the rm -rf requires multiple journal transactions
> to complete.  That's because with mount -o discard, we do the discards
> after each transaction commit, and it might be that even though the
> used blocks are perfectly contiguous, because of the order in which
> the files end up getting deleted, we end up needing to discard them in
> smaller chunks.
>
> For example, one could imagine a case where you have a million 4k
> files, and they are allocated contiguously, but if you get
> super-unlucky, such that in the first transaction you delete all of
> the odd-numbered files, and in second transaction you delete all of
> the even-numbered files, you might need to do a million 4k discards
> --- but if all of the deletes could fit into a single transaction, you
> would only need to do a single million block discard operation.
>
> Finally, you may want to consider whether or not mount -o discard
> really makes sense or not.  For most SSD's, especially high-end SSD's,
> it probably doesn't make that much difference.  That's because when
> you overwrite a sector, the SSD knows (or should know; this might not
> be some really cheap, crappy low-end flash devices; but on those
> devices, discard might not be making uch of a difference anyway), that
> the old contents of the sector is no longer needed.  Hence an
> overwrite effectively is an "implied discard".  So long as there is a
> sufficient number of free erase blocks, the SSD might be able to keep
> up doing the GC for those "implied discards", and so accelerating the
> process by sending explicit discards after every journal transaction
> might not be necessary.  Or, maybe it's sufficient to run "fstrim"
> every week at Sunday 3am local time; or maybe even fstrim once a night
> or fstrim once a month --- your mileage may vary.
>
> It's going to vary from SSD to SSD and from workload to workload, but
> you might find that mount -o discard isn't buying you all that much
> --- if you run a random write workload, and you don't notice any
> performance degradation, and you don't notice an increase in the SSD's
> write amplification numbers (if they are provided by your SSD), then
> you might very well find that it's not worth it to use mount -o
> discard.
>
> I personally don't bother using mount -o discard, and instead
> periodically run fstrim, on my personal machines.  Part of that is
> because I'm mostly just reading and replying to emails, building
> kernels and editing text files, and that is not nearly as stressful on
> the FTL as a full-blown random write workload (for example, if you
> were running a database supporting a transaction processing workload).
>

That's what I'm doing locally, I issue a fstrim from time to time.
But I found discard useful in QEMU guests because latest virtio-blk
will punch holes in the host and save space.

Cheers,
-- 
per aspera ad upstream
