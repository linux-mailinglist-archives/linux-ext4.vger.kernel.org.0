Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54F2E1164
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Dec 2020 02:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgLWB0i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 20:26:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33634 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLWB0i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 20:26:38 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by linux.microsoft.com (Postfix) with ESMTPSA id EC7E820B83F6
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 17:25:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC7E820B83F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608686756;
        bh=Fjnwr1BONf/IzhstAFwwplZCeQyAR1juu3N7QMvoCrg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nyTC04kZtRes9wOYulzH27XuIWaZ8CFQWWQ6qjfZfV8spm32eof6kB51TP6d3QlV2
         gmqSrWukIPFvzkTtEBY5wLz6FwAHIhsYRl+R2xmWkINpxps+Xk+QIA54JFxCO/1l0U
         KTQHWEPpiWU/wlFzM8FU1eJq9v06DcfPzL79yOYc=
Received: by mail-pf1-f173.google.com with SMTP id m6so9441458pfm.6
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 17:25:55 -0800 (PST)
X-Gm-Message-State: AOAM533EiieneU2BbPSv3xhb7Wrah53vNRMCsAKAeib8b0sjoSg2fBBm
        y0pijOgrfs9AV5kiYSNuyG8LGvRg3BNWEsVL52Y=
X-Google-Smtp-Source: ABdhPJyw7GVQQuGfCKABEoo6YOa2iRCGGXmroEOxm0GEjvSsTXSMH2MZjI8U33IvrO51a5J++xn1bMzjxCzZnmCUVDk=
X-Received: by 2002:a63:752:: with SMTP id 79mr21864498pgh.272.1608686755096;
 Tue, 22 Dec 2020 17:25:55 -0800 (PST)
MIME-Version: 1.0
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
 <X+AQxkC9MbuxNVRm@mit.edu> <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
 <X+If/kAwiaMdaBtF@mit.edu> <EA4612BD-D992-4549-9D54-E2A54F9FB939@dilger.ca>
In-Reply-To: <EA4612BD-D992-4549-9D54-E2A54F9FB939@dilger.ca>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Dec 2020 02:25:19 +0100
X-Gmail-Original-Message-ID: <CAFnufp2Yu3+Mz6yxjEHtN_4Mjf+hCjbJLedWfLWT=3A3zt8PBQ@mail.gmail.com>
Message-ID: <CAFnufp2Yu3+Mz6yxjEHtN_4Mjf+hCjbJLedWfLWT=3A3zt8PBQ@mail.gmail.com>
Subject: Re: discard and data=writeback
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 <linux-ext4@vger.kernel.org>, Wang Shilong <wshilong@ddn.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 22, 2020 at 11:53 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Dec 22, 2020, at 9:34 AM, Theodore Y. Ts'o <tytso@MIT.EDU> wrote:
> >
> > On Tue, Dec 22, 2020 at 03:59:29PM +0100, Matteo Croce wrote:
> >>
> >> I'm issuing sync + sleep(10) after the extraction, so the writes
> >> should all be flushed.
> >> Also, I repeated the test three times, with very similar results:
> >
> > So that means the problem is not due to page cache writeback
> > interfering with the discards.  So it's most likely that the problem
> > is due to how the blocks are allocated and laid out when using
> > data=ordered vs data=writeback.
> >
> > Some experiments to try next.  After extracting the files with
> > data=ordered and data=writeback on a freshly formatted file system,
> > use "e2freefrag" to see how the free space is fragmented.  This will
> > tell us how the file system is doing from a holistic perspective, in
> > terms of blocks allocated to the extracted files.  (E2freefrag is
> > showing you the blocks *not* allocated, of course, but that's a mirror
> > image dual of the blocks that *are* allocated, especially if you start
> > from an identical known state; hence the use of a freshly formatted
> > file system.)
> >
> > Next, we can see how individual files look like with respect to
> > fragmentation.  This can be done via using filefrag on all of the
> > files, e.g:
> >
> >       find . -type f -print0  | xargs -0 filefrag
> >
> > Another way to get similar (although not identical) information is via
> > running "e2fsck -E fragcheck" on a file system.  How they differ is
> > especially more of a big deal on ext3 file systems without extents and
> > flex_bg, since filefrag tries to take into account metadata blocks
> > such as indirect blocks and extent tree blocks, and e2fsck -E
> > fragcheck does not; but it's good enough for getting a good gestalt
> > for the files' overall fragmentation --- and note that as long as the
> > average fragment size is at least a megabyte or two, some
> > fragmentation really isn't that much of a problem from a real-world
> > performance perspective.  People can get way too invested in trying to
> > get to perfection with 100% fragmentation-free files.  The problem
> > with doing this at the expense of all else is that you can end up
> > making the overall free space fragmentation worse as the file system
> > ages, at which point the file system performance really dives through
> > the floor as the file system approaches 100%, or even 80-90% full,
> > especially on HDD's.  For SSD's fragmentation doesn't matter quite so
> > much, unless the average fragment size is *really* small, and when you
> > are discarded freed blocks.
> >
> > Even if the files are showing no substantial difference in
> > fragmentation, and the free space is equally A-OK with respect to
> > fragmentation, the other possibility is the *layout* of the blocks are
> > such that the order in which they are deleted using rm -rf ends up
> > being less friendly from a discard perspective.  This can happen if
> > the directory hierarchy is big enough, and/or the journal size is
> > small enough, that the rm -rf requires multiple journal transactions
> > to complete.  That's because with mount -o discard, we do the discards
> > after each transaction commit, and it might be that even though the
> > used blocks are perfectly contiguous, because of the order in which
> > the files end up getting deleted, we end up needing to discard them in
> > smaller chunks.
> >
> > For example, one could imagine a case where you have a million 4k
> > files, and they are allocated contiguously, but if you get
> > super-unlucky, such that in the first transaction you delete all of
> > the odd-numbered files, and in second transaction you delete all of
> > the even-numbered files, you might need to do a million 4k discards
> > --- but if all of the deletes could fit into a single transaction, you
> > would only need to do a single million block discard operation.
> >
> > Finally, you may want to consider whether or not mount -o discard
> > really makes sense or not.  For most SSD's, especially high-end SSD's,
> > it probably doesn't make that much difference.  That's because when
> > you overwrite a sector, the SSD knows (or should know; this might not
> > be some really cheap, crappy low-end flash devices; but on those
> > devices, discard might not be making uch of a difference anyway), that
> > the old contents of the sector is no longer needed.  Hence an
> > overwrite effectively is an "implied discard".  So long as there is a
> > sufficient number of free erase blocks, the SSD might be able to keep
> > up doing the GC for those "implied discards", and so accelerating the
> > process by sending explicit discards after every journal transaction
> > might not be necessary.  Or, maybe it's sufficient to run "fstrim"
> > every week at Sunday 3am local time; or maybe even fstrim once a night
> > or fstrim once a month --- your mileage may vary.
> >
> > It's going to vary from SSD to SSD and from workload to workload, but
> > you might find that mount -o discard isn't buying you all that much
> > --- if you run a random write workload, and you don't notice any
> > performance degradation, and you don't notice an increase in the SSD's
> > write amplification numbers (if they are provided by your SSD), then
> > you might very well find that it's not worth it to use mount -o
> > discard.
> >
> > I personally don't bother using mount -o discard, and instead
> > periodically run fstrim, on my personal machines.  Part of that is
> > because I'm mostly just reading and replying to emails, building
> > kernels and editing text files, and that is not nearly as stressful on
> > the FTL as a full-blown random write workload (for example, if you
> > were running a database supporting a transaction processing workload).
>
> The problem (IMHO) with "-o discard" is that if it is only trimming
> *blocks* that were deleted, these may be too small to effectively be
> processed by the underlying device (e.g. the "super-unlucky" example
> above where interleaved 4KB file deletes result in 1M separate 4KB
> trim requests to the device, even when the *space* that is freed by
> the unlinks could be handled with far fewer large trim requests.
>
> There was a discussion previously ("introduce EXT4_BG_WAS_TRIMMED ...")
>
> https://patchwork.ozlabs.org/project/linux-ext4/patch/1592831677-13945-1-git-send-email-wangshilong1991@gmail.com/
>
> about leveraging the persistent EXT4_BG_WAS_TRIMMED flag in the group
> descriptors, and having "-o discard" only track trim on a per-group
> basis rather than its current mode of doing trim on a per-block basis,
> and then use the same code internally as fstrim to do a trim of free
> blocks in that block group.
>
> Using EXT4_BG_WAS_TRIMMED and tracking *groups* to be trimmed would be
> a bit more lazy than the current "-o discard" implementation, but would
> be more memory efficient, and also more efficient for the device (fewer,
> larger trim requests submitted).  It would only need to track groups
> that have at least a reasonable amount of free space to be trimmed.  If
> the group doesn't have enough free blocks to trim now, it will be checked
> again in the future when more blocks are freed.
>

Hi,

I gave it a quick run refreshing it for 5.10, but it doesn't seem to help.
Are there actions needed other than the patch itself?

Regards,
-- 
per aspera ad upstream
