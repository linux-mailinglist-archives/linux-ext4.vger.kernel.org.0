Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9417D6F0
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgCHXDN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Mar 2020 19:03:13 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39855 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgCHXDN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Mar 2020 19:03:13 -0400
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C32917E9739;
        Mon,  9 Mar 2020 10:03:09 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jB4wt-0004sr-3Z; Mon, 09 Mar 2020 10:03:07 +1100
Date:   Mon, 9 Mar 2020 10:03:07 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Message-ID: <20200308230307.GM10776@dread.disaster.area>
References: <0000000000000e7156059f751d7b@google.com>
 <20200308043540.1034779-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308043540.1034779-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=eJfxgxciAAAA:8 a=hSkVLCK3AAAA:8
        a=7-415B0cAAAA:8 a=dLdYvm8lChJJgMaHoBcA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=xM9caqqi1sUkTy8OJ5Uh:22
        a=cQPPKAXgyycSBL8etih5:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 07, 2020 at 08:35:40PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
> during do_exit().  That can confuse things.  For example, if BSD process
> accounting is enabled, then it's possible for do_exit() to end up
> calling ext4_write_inode().  That triggers the
> WARN_ON_ONCE(current->flags & PF_MEMALLOC) there, as it assumes
> (appropriately) that inodes aren't written when allocating memory.

And just how the hell does and XFS kernel thread end up calling
ext4_write_inode()? That's kinda a key factor in all this, and
it's not explained here.

> This case was reported by syzbot at
> https://lkml.kernel.org/r/0000000000000e7156059f751d7b@google.com.

Which doesn't really explain it, either.

What is the configuration conditions under which this triggers? It
looks like some weird combination of a no-journal ext4 root
filesystem and the audit subsystem being configured with O_SYNC
files?

People trying to decide if this is something that needs to be
backported to stable kernels need to be able to unerstand how this
bug is actually triggered so they can make sane decisions about
it...

/me tracks the PF_MEMALLOC flag back to commit 43ff2122e649 ("xfs:
on-stack delayed write buffer lists") where is was inherited here
from the buffer flush daemon that xfsaild took over from. Which also
never cleared the PF_MEMALLOC flag. That goes back to 2002:

commit d676c94914eb97d72061aff69c99406df4f395e9
Author: Steve Lord <lord@sgi.com>
Date:   Fri Jan 11 23:31:51 2002 +0000

    Merge pagebuf module into XFS

So this issue of calling do_exit() with PF_MEMALLOC set has been
around for 18+ years without anyone noticing it.

I also note that cifs_demultiplex_thread() has the same problem -
can you please do a complete audit of all the users of PF_MEMALLOC
and fix all of them?

> Fix this in xfsaild() by using the helper functions to save and restore
> PF_MEMALLOC.
> 
> Reported-by: syzbot+1f9dc49e8de2582d90c2@syzkaller.appspotmail.com
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/xfs/xfs_trans_ail.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 00cc5b8734be..3bc570c90ad9 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -529,8 +529,9 @@ xfsaild(
>  {
>  	struct xfs_ail	*ailp = data;
>  	long		tout = 0;	/* milliseconds */
> +	unsigned int	noreclaim_flag;
>  
> -	current->flags |= PF_MEMALLOC;
> +	noreclaim_flag = memalloc_noreclaim_save();
>  	set_freezable();
>  
>  	while (1) {
> @@ -601,6 +602,7 @@ xfsaild(
>  		tout = xfsaild_push(ailp);
>  	}
>  
> +	memalloc_noreclaim_restore(noreclaim_flag);
>  	return 0;
>  }

The code looks fine - I considered doing this a couple of weeks ago
just for cleaniness reasons - but the commit message needs work to
explain the context of the bug...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
