Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC49633FFF9
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Mar 2021 07:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCRG57 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Mar 2021 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCRG5z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Mar 2021 02:57:55 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0E8C06174A
        for <linux-ext4@vger.kernel.org>; Wed, 17 Mar 2021 23:57:55 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w70so621121oie.0
        for <linux-ext4@vger.kernel.org>; Wed, 17 Mar 2021 23:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eiCNyNXWGJ498v+sy6dOJtpGaQS8Wn1e9nIrsk5GdWs=;
        b=nmyCtx7ATFKupVPo3DGIc0HXFiQt6aR3tEZuust2xRZNw2qiMV9NLZBsAYYBQyI9pb
         algYdX3n46rCjYD7CnMEO5frgcfM2MA86kx+HY6Jl2wR3jYe9jdFljw6XuTUsEyYxYi+
         gESrEz+gLIURLJe9iHXEWATr6f+wnBP0lWZfmJV2XFZJYVQu1igvmLCuRCTMlyuo8jqn
         7N81/PrCo3hEe+A7n+xjPGCHSnJrJIUfdmOfDBVKfUldCMVtBs4xjR46UJb2qPA0D6ik
         Ip4Ci26QHRN7Vr5hKn8chxW8vzDQuFm/H1QDBNzPgURjwxY/vW6Ls+CynrcjRzLhgTPV
         s0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eiCNyNXWGJ498v+sy6dOJtpGaQS8Wn1e9nIrsk5GdWs=;
        b=r0BBXw72MIMOCiLJl/Br8Ej0D5UfcPfb9zVfSO73zW716ZV36B5VQHsPjtZo2GPF3I
         8VzFJlgiOsTmrzva8bvPcrzPJAYpQ7zV2OMAa+cC0whsZbo6E94VeAF98he6/ujvkyEF
         6MFyQnEqdafPtmqUpMo3U7J6N3lCWbf5qHjOHbovr4RO6+rvN6Dvi+Uz4FHk9/2v0hIm
         ETonM8cIvws4dTHN3NmTRE0rISbGds2l7PAutsQFWk90gd60cQ/LOcIrNzohigfEzpz6
         NqtWbMklu1RF+p9viMhqOF3oDoMR937ntRtr4N+x9Pls8MGgaG5hstzTgXq+rS4NoZod
         i3HA==
X-Gm-Message-State: AOAM533miYHcFSE2JiosKasymTHnwXgbXCXdJblsXqFt5MYKo1GEu4eK
        bLhi1YANLi2em/thcoM058ilzLbSV47jY5DsAQk=
X-Google-Smtp-Source: ABdhPJwItyi4mgYcDnhNCw1cH+Fj78dSN0MM78bjSSMhy/KknX8kr9XKAE5Bx5600lirRRmUMKp2gZIlK08PZEg8F2A=
X-Received: by 2002:aca:578b:: with SMTP id l133mr2063766oib.96.1616050674591;
 Wed, 17 Mar 2021 23:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <CADve3d51po2wh6rmgrzM8-k9h=JzE9+mC57Y5V2BxfFkKPFMsw@mail.gmail.com>
 <YEtjuGZCfD+7vCFd@mit.edu> <CADve3d7bioEAMwQ=i8KZ=hjrBDMk7gJK8kTUu2E5Q=W_KbUMPg@mail.gmail.com>
 <YE2FOTpWOaidmT52@mit.edu> <CADve3d4h7QmxJUCe8ggHtSb41PbDnvZoj4_m74hHgYD96xjZNw@mail.gmail.com>
 <YFI299oMXylsG9kB@mit.edu>
In-Reply-To: <YFI299oMXylsG9kB@mit.edu>
From:   Shashidhar Patil <shashidhar.patil@gmail.com>
Date:   Thu, 18 Mar 2021 12:27:44 +0530
Message-ID: <CADve3d7gZVP_wzuRFymox9EEU05jbsTGdf=nGOAHeouBuR1jog@mail.gmail.com>
Subject: Re: jbd2 task hung in jbd2_journal_commit_transaction
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Theodore,
    I forgot to include two important  details , the stack trace of
loop0 driver and sar output, which clearly nail  the problem.
The losetup with Ubuntu16.05 does not have O_DIRECT support  and we
were not aware of bypassing of journalling if
O_DIRECT combined with preallocated file scenario.

Using the loop we could track the swap load using sysstat, but
otherwise no other major requirement.
With loop I could reproduce the problem only twice using stress-ng
being run for 20 time for 15 seconds interval.
The problem happens highly random so it may take more number of tries
in some cases.

With direct swap file I tried many times and could not see the issue.
The system continues to function fine after terminating the tests.
The loop is now removed and swap file is activated directly in the
deployed systems where the issue was seen every couple of
weeks. Awaiting for few weeks before concluding about the problem/solution.

Logs below.

backtrace:

6,1725650,1121675639291,-;loop0           D    0  2090      2 0x80000080
4,1725651,1121675639293,-;Call Trace:
4,1725652,1121675639295,-; __schedule+0x3d6/0x8b0
4,1725653,1121675639296,-; schedule+0x36/0x80
4,1725654,1121675639298,-; wait_transaction_locked+0x8a/0xd0
4,1725655,1121675639300,-; ? wait_woken+0x80/0x80
4,1725656,1121675639302,-; add_transaction_credits+0x1cd/0x2b0
4,1725657,1121675639303,-; ? __wake_up_common_lock+0x8e/0xc0
4,1725658,1121675639305,-; start_this_handle+0x103/0x410
4,1725659,1121675639306,-; ? _cond_resched+0x1a/0x50
4,1725660,1121675639310,-; ? kmem_cache_alloc+0x115/0x1c0
4,1725661,1121675639311,-; jbd2__journal_start+0xdb/0x1f0
4,1725662,1121675639314,-; ? ext4_dirty_inode+0x32/0x70
4,1725663,1121675639317,-; __ext4_journal_start_sb+0x6d/0x120
4,1725664,1121675639318,-; ext4_dirty_inode+0x32/0x70
4,1725665,1121675639322,-; __mark_inode_dirty+0x184/0x3b0
4,1725666,1121675639325,-; generic_update_time+0x7b/0xd0
4,1725667,1121675639326,-; ? current_time+0x32/0x70
4,1725668,1121675639328,-; file_update_time+0xbe/0x110
4,1725669,1121675639330,-; __generic_file_write_iter+0x9d/0x1f0
4,1725670,1121675639331,-; ? kmem_cache_free+0x1d1/0x1e0
4,1725671,1121675639333,-; ext4_file_write_iter+0xc4/0x3b0
4,1725672,1121675639336,-; do_iter_readv_writev+0x111/0x180
4,1725673,1121675639337,-; do_iter_write+0x87/0x1a0
4,1725674,1121675639339,-; vfs_iter_write+0x19/0x30
4,1725675,1121675639343,-; lo_write_bvec+0x69/0x110
4,1725676,1121675639344,-; loop_queue_work+0x8ff/0xa60
4,1725677,1121675639346,-; ? __switch_to_asm+0x35/0x70
4,1725678,1121675639347,-; ? __switch_to_asm+0x35/0x70
4,1725679,1121675639348,-; ? __schedule+0x3de/0x8b0
4,1725680,1121675639350,-; kthread_worker_fn+0x85/0x1f0
4,1725681,1121675639351,-; loop_kthread_worker_fn+0x1e/0x20
4,1725682,1121675639352,-; kthread+0x105/0x140
4,1725683,1121675639353,-; ? loop_get_status64+0x90/0x90
4,1725684,1121675639354,-; ? kthread_bind+0x40/0x40
4,1725685,1121675639356,-; ret_from_fork+0x35/0x40

sar output:

root@maglev-master-190:/data/tmp/customers/weber/var/log/sysstat# sar
-d -f sa10 | grep dev7

Linux 4.15.0-117-generic (maglev-master-1)      03/10/21
_x86_64_        (88 CPU)

00:00:01          DEV       tps     rkB/s     wkB/s   areq-sz
aqu-sz     await     svctm     %util
00:05:01       dev7-0      1.74      0.92      6.02      4.00
0.29    184.17     28.01      4.86
00:15:01       dev7-0      4.77      3.35     15.74      4.00
0.53    119.11     14.67      7.00
00:25:01       dev7-0      0.48      1.54      0.37      4.00
0.00      1.31      0.20      0.01
00:35:01       dev7-0      0.48      1.03      0.88      4.00
0.00      4.80      0.25      0.01
00:45:01       dev7-0      0.56      1.43      0.82      4.00
0.00      1.13      0.31      0.02
00:55:01       dev7-0      0.88      2.39      1.13      4.00
0.03     34.22     11.67      1.03
01:05:01       dev7-0      0.88      1.47      2.03      4.00
0.06     75.12     18.69      1.64
01:15:01       dev7-0      1.45      0.08      5.71      4.00
94.30    387.62    605.50     87.62
01:25:01       dev7-0      0.00      0.00      0.00      0.00
128.00      0.00      0.00    100.00
01:35:01       dev7-0      0.00      0.00      0.00      0.00
128.00      0.00      0.00    100.00

On Wed, Mar 17, 2021 at 10:36 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Mar 17, 2021 at 08:30:56PM +0530, Shashidhar Patil wrote:
> > Hi Theodore,
> >       Thank you for the details about the journalling layer and
> > insight into the block device layer.
> >  I think Good luck might have clicked. The swap file in our case is
> > attached to a loop block device before enabling swap using swapon.
> > Since loop driver processes its IO requests by calling
> > vfs_iter_write() the write requests re-enter the ext4
> > filesystem/journalling code.
> > Is that right ? There seems to be a possibility of cylic dependency.
>
> If that hypothesis is correct, you should see an example of that in
> one of your stack traces; do you?  The loop device creates struct file
> where the file is opened using O_DIRECT.  In the O_DIRECT code path,
> assuming the file was fully allocate and initialized, it shouldn't
> involve starting a journal handle.
>
> That being said, why are you using a loop device for a swap device at
> all?  Using a swap file directly is going to be much more efficient,
> and decrease the stack depth and CPU cycles needed to do a swap out if
> nothing else.  If you can reliably reproduce the problem, what happens
> if you use a swap file directly and cut out the loop device as a swap
> device?   Does it make the problem go away?
>
>                                         - Ted
