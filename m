Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712F845407B
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Nov 2021 06:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhKQF4O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Nov 2021 00:56:14 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:49075 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233348AbhKQF4O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 17 Nov 2021 00:56:14 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id EC51AA46A9;
        Wed, 17 Nov 2021 16:53:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mnDsd-009nSO-AO; Wed, 17 Nov 2021 16:53:11 +1100
Date:   Wed, 17 Nov 2021 16:53:11 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: introduce memalloc_retry_wait()
Message-ID: <20211117055311.GS449541@dread.disaster.area>
References: <163712329077.13692.12796971766360881401@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163712329077.13692.12796971766360881401@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=619498ca
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=WAyi4Cf-4lf-hVXyuRgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 17, 2021 at 03:28:10PM +1100, NeilBrown wrote:
> 
> Various places in the kernel - largely in filesystems - respond to a
> memory allocation failure by looping around and re-trying.
.....
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index aca874d33fe6..f2f2a5b28808 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -214,6 +214,27 @@ static inline void fs_reclaim_acquire(gfp_t gfp_mask) { }
>  static inline void fs_reclaim_release(gfp_t gfp_mask) { }
>  #endif
>  
> +/* Any memory-allocation retry loop should use
> + * memalloc_retry_wait(), and pass the flags for the most
> + * constrained allocation attempt that might have failed.
> + * This provides useful documentation of where loops are,
> + * and a central place to fine tune the waiting as the MM
> + * implementation changes.
> + */
> +static inline void memalloc_retry_wait(gfp_t gfp_flags)
> +{
> +	gfp_flags = current_gfp_context(gfp_flags);
> +	if ((gfp_flags & __GFP_DIRECT_RECLAIM) &&
> +	    !(gfp_flags & __GFP_NORETRY))
> +		/* Probably waited already, no need for much more */
> +		schedule_timeout_uninterruptible(1);
> +	else
> +		/* Probably didn't wait, and has now released a lock,
> +		 * so now is a good time to wait
> +		 */
> +		schedule_timeout_uninterruptible(HZ/50);
> +}

The existing congestion_wait() calls io_schedule_timeout() under
TASK_UNINTERRUPTIBLE conditions.

Does changing all these calls just to a plain
schedule_timeout_uninterruptible() make any difference to behaviour?
At least process accounting will appear different (uninterruptible
sleep instead of IO wait), and I suspect that the block plug
flushing in io_schedule() might be a good idea to retain for all the
filesystems that call this function from IO-related routines.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
