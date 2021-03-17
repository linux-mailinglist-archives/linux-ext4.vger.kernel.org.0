Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CC733F54C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Mar 2021 17:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhCQQRV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Mar 2021 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhCQQRJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Mar 2021 12:17:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B20AC06174A
        for <linux-ext4@vger.kernel.org>; Wed, 17 Mar 2021 09:17:09 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u62so26540213oib.6
        for <linux-ext4@vger.kernel.org>; Wed, 17 Mar 2021 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eub6Qa+t0wZaFRuaZ9m0w5UB2wWeCg4kRwZeXes5U20=;
        b=I/KC5FSTuibeBJGHl43AxGwXZ5YsKBSfsPrkU4Kw0FcLsWlu9Z2hgWpZNN4J3/eOTE
         WXkBCEefY6HP/odUHW+8vu6IkVKvvuIbgSiqE2GuaQuEtSwnGdnWo7mydnHNiQk6PVuW
         Btj6K76bA2Llb/CWHYUwldjJoaVaGXScb0nIBOKRmqoZ1TVMwiaoa5YWFp8D1j+sR60k
         lp0esVYkv/j3XUkFth304Oe8JvvS0gIXbuISQ2ME9dphSyCXZmaZCmVBaALlDn/WuHpT
         +sjRPJvtYsBuoajs8YsB149DwTGKBRqbPQ5pESVEiTnzvmn5WOzPBTvFexaOAceEFJCl
         ylNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eub6Qa+t0wZaFRuaZ9m0w5UB2wWeCg4kRwZeXes5U20=;
        b=qgfVwPj4Pg1hn26rYB7YlkFe0r2dCh4f64KLxYnwp+B0eiVmAZMG/X/G71P5eQbZQn
         dH51moydNXzyoENMyx8r7ps6sLpcmrkqdpm9QcD+wbmxrabjspl0V0KzNIT6qKWN8bNe
         2x8vHp19gCLtZTOh4OD/sP0xS0jnGVlC8UZNk2z/vFa3wQHXMivLSqiVQ/PlRQKknbZQ
         55MEf/mhkMX/nnnWaNvJpnC2CdIoz4Yy4EhTIDr/WQq/DLzSw+QdreNwLiwwsM9hz/4H
         FXP5K98ezWIn2XdgjAyQWE3p+rGbolcetfbmTroqcQCaoNdUYCohrtxbMjtwX61Tq024
         bTog==
X-Gm-Message-State: AOAM532rL6nPxvHNnKbMHxIxOBQ3KUbBllYmBVBlZKhEnKqCtsCtQ1DY
        K1KZfLQl6QlJc60fT7t4ALusTMw3wQu6qhVK/yzvnoRkmfY=
X-Google-Smtp-Source: ABdhPJxZxKyCRQiIeXmmL3H1PjMes5mzJzYJcMVNAFchmDtDnCUA35fitpF9QhlvIAsQiDyff1fcWZEmXVf/0G5HLME=
X-Received: by 2002:aca:578b:: with SMTP id l133mr3138412oib.96.1615993267843;
 Wed, 17 Mar 2021 08:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <CADve3d51po2wh6rmgrzM8-k9h=JzE9+mC57Y5V2BxfFkKPFMsw@mail.gmail.com>
 <YEtjuGZCfD+7vCFd@mit.edu> <CADve3d7bioEAMwQ=i8KZ=hjrBDMk7gJK8kTUu2E5Q=W_KbUMPg@mail.gmail.com>
 <YE2FOTpWOaidmT52@mit.edu>
In-Reply-To: <YE2FOTpWOaidmT52@mit.edu>
From:   Shashidhar Patil <shashidhar.patil@gmail.com>
Date:   Wed, 17 Mar 2021 20:30:56 +0530
Message-ID: <CADve3d4h7QmxJUCe8ggHtSb41PbDnvZoj4_m74hHgYD96xjZNw@mail.gmail.com>
Subject: Re: jbd2 task hung in jbd2_journal_commit_transaction
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Theodore,
      Thank you for the details about the journalling layer and
insight into the block device layer.
 I think Good luck might have clicked. The swap file in our case is
attached to a loop block device before enabling swap using swapon.
Since loop driver processes its IO requests by calling
vfs_iter_write() the write requests re-enter the ext4
filesystem/journalling code.
Is that right ? There seems to be a possibility of cylic dependency.

Thanks
-Shashidhar
On Sun, Mar 14, 2021 at 9:08 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Sat, Mar 13, 2021 at 01:29:43PM +0530, Shashidhar Patil wrote:
> > > From what I can tell zswap is using writepage(), and since the swap
> > > file should be *completely* preallocated and initialized, we should
> > > never be trying to start a handle from zswap.  This should prevent the
> > > deadlock from happening.  If zswap is doing something which is causing
> > > ext4 to start a handle when it tries to writeout a swap page, then
> > > that would certainly be a problem.  But that really shouldn't be the
> > > case.
> >
> > Yes. But the the first sys_write() called by the application did
> > allocate an journal handle as required and since
> > this specific request now is waiting for IO to complete the handle is
> > not closed. Elsewhere in jbd2 task the commit_transaction is
> > blocked since there is one or more open journalling handles. Is my
> > understanding correct ?
>
> Yes, that's correct.  When we start a transaction commit, either
> because the 5 second commit interval has been reached, or there isn't
> enough room in the journal for a particular handle to start (when we
> start a file system mutation, we estimate the worst case number of
> blocks that might need to be modified, and hence require space in the
> journal), we first (a) stop any new handles from being started, and
> then (b) wait for all currently running handles to complete.
>
> If one handle takes a lot longer to complete than all the others,
> while we are waiting for that last handle to finish, the commit can
> not make forward progress, and no other file system operation which
> requires modifying metadata can proceed.  As a result, we try to keep
> the time between starting a handle and stopping a handle as short as
> possible.  For example, if possible, we will try to read a block that
> might be needed by a mutation operation *before* we start the handle.
> That's not always possible, but we try to do that whenever possible,
> and there are various tracepoints and other debugging facilities so we
> can see which types of file system mutations require holding handles
> longest, so we can try to optimize them.
>
> > 4,1737846,1121675697013,-; schedule+0x36/0x80
> > 4,1737847,1121675697015,-; io_schedule+0x16/0x40
> > 4,1737848,1121675697016,-; blk_mq_get_tag+0x161/0x250
> > 4,1737849,1121675697018,-; ? wait_woken+0x80/0x80
> > 4,1737850,1121675697020,-; blk_mq_get_request+0xdc/0x3b0
> > 4,1737851,1121675697021,-; blk_mq_make_request+0x128/0x5b0
> > 4,1737852,1121675697023,-; generic_make_request+0x122/0x2f0
> > 4,1737853,1121675697024,-; ? bio_alloc_bioset+0xd2/0x1e0
> > 4,1737854,1121675697026,-; submit_bio+0x73/0x140
> > .....
> > So all those IO requests are waiting for response from the raid port,
> > is that right ?
> >
> > But the megaraid_sas driver( the system has LSI MEGARAID port) in most
> > cases handles the unresponsive behavior
> > by resetting the device. IN this case the reset did not happen, maybe
> > there is some other bug in the megaraid driver.
>
> Yes, it's not necessarily a problem with the storage device or the
> host bus adapter; it could also be some kind of bug in the device
> driver --- or even the block layer, although that's much, much less
> likely (mostly because a lot of people would be complaining if that
> were the case).
>
> If you have access to a SCSI/SATA bus snooper which can be inserted in
> between the storage device (HDD/SSD) and the LSI Megaraid, that might
> be helpful in terms of trying to figure out what is going on.  Failing
> that, you'll probably find some way to add/use debugging
> hooks/tracepoints in the driver.
>
> Good luck,
>
>                                         - Ted
