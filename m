Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2212917D7A7
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 02:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCIBEM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Mar 2020 21:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCIBEM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 8 Mar 2020 21:04:12 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B074320675;
        Mon,  9 Mar 2020 01:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583715851;
        bh=xOZfa+fKIDwwJMXdJdRToMxH2YbKOlmyJ9br5yDPKQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwvOh/oadXZyXrLo2vL9AmDAMw023bIgYrObL6AoQonIgVZq8SUer9V2KTvCM2Uex
         ew/MLJk6Q20LwuZVkACXJ9mdU0jgOlUkNDGPQOkeRGzrM/0TBXbbJAomIO8OQ6WjUV
         AZkFbEnCo8aDUZocP7QFJmoxteNoBtqHLcznt/vc=
Date:   Sun, 8 Mar 2020 18:04:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Message-ID: <20200309010410.GA371527@sol.localdomain>
References: <0000000000000e7156059f751d7b@google.com>
 <20200308043540.1034779-1-ebiggers@kernel.org>
 <20200308230307.GM10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308230307.GM10776@dread.disaster.area>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 09, 2020 at 10:03:07AM +1100, Dave Chinner wrote:
> On Sat, Mar 07, 2020 at 08:35:40PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
> > during do_exit().  That can confuse things.  For example, if BSD process
> > accounting is enabled, then it's possible for do_exit() to end up
> > calling ext4_write_inode().  That triggers the
> > WARN_ON_ONCE(current->flags & PF_MEMALLOC) there, as it assumes
> > (appropriately) that inodes aren't written when allocating memory.
> 
> And just how the hell does and XFS kernel thread end up calling
> ext4_write_inode()? That's kinda a key factor in all this, and
> it's not explained here.
> 
> > This case was reported by syzbot at
> > https://lkml.kernel.org/r/0000000000000e7156059f751d7b@google.com.
> 
> Which doesn't really explain it, either.
> 
> What is the configuration conditions under which this triggers? It
> looks like some weird combination of a no-journal ext4 root
> filesystem and the audit subsystem being configured with O_SYNC
> files?
> 
> People trying to decide if this is something that needs to be
> backported to stable kernels need to be able to unerstand how this
> bug is actually triggered so they can make sane decisions about
> it...

My guess is that syzbot enabled BSD process accounting to a file with FS_SYNC_FL
on an ext4 nojournal fs.  It didn't provide a reproducer itself.  Sure, I'll try
to write a reproducer and include it in the commit message.  I felt it wasn't
quite as important for this one compared to most of the other syzbot bugs, since
BSD process accounting can only be enabled by root, and once we're talking about
do_exit() being able to write an arbitrary file, it's not hard to see why
*something* could get tripped up by PF_MEMALLOC.  There are probably other ways
it could cause problems besides this specific one.  But sure, I'll try.

> 
> I also note that cifs_demultiplex_thread() has the same problem -
> can you please do a complete audit of all the users of PF_MEMALLOC
> and fix all of them?

I already did, that's why at the same time I sent out this patch, I also sent
out one to fix cifs_demultiplex_thread()
(https://lkml.kernel.org/linux-cifs/20200308043645.1034870-1-ebiggers@kernel.org/T/#t).
These were the only two; I didn't find any others that needed to be fixed.

- Eric
