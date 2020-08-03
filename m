Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29723AE32
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Aug 2020 22:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHCUeC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Aug 2020 16:34:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:55310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgHCUeC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 3 Aug 2020 16:34:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E5023B5B2;
        Mon,  3 Aug 2020 20:34:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3B5F91E12CB; Mon,  3 Aug 2020 22:34:00 +0200 (CEST)
Date:   Mon, 3 Aug 2020 22:34:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH 2/2] ext4: mballoc - limit scanning of uninitialized
 groups
Message-ID: <20200803203400.GB1214@quack2.suse.cz>
References: <48DC3E7A-AA4E-494D-A520-3D301FBC573B@whamcloud.com>
 <20200521070432.AE06852051@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521070432.AE06852051@d06av21.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 21-05-20 12:34:29, Ritesh Harjani wrote:
> 
> 
> On 5/20/20 3:15 PM, Alex Zhuravlev wrote:
> > cr=0 is supposed to be an optimization to save CPU cycles, but if
> > buddy data (in memory) is not initialized then all this makes no
> > sense as we have to do sync IO taking a lot of cycles.
> > also, at cr=0 mballoc doesn't store any available chunk. cr=1 also
> > skips groups using heuristic based on avg. fragment size. it's more
> > useful to skip such groups and switch to cr=2 where groups will be
> > scanned for available chunks.
> > 
> > The goal group is not skipped to prevent allocations in foreign groups,
> > which can happen after mount while buddy data is still being populated.
> > 
> > using sparse image and dm-slow virtual device of 120TB was simulated.
> > then the image was formatted and filled using debugfs to mark ~85% of
> > available space as busy. the very first allocation w/o the patch could
> > not complete in half an hour (according to vmstat it would take ~10-1
> > hours). with the patch applied the allocation took ~20 seconds.
> > 
> > Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
> > Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
> 
> This looks even better to me. Feel free to add:
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Going through some old email... Ted, why wasn't this patch merged?

								Honza

> >   fs/ext4/mballoc.c | 30 +++++++++++++++++++++++++++++-
> >   1 file changed, 29 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 30d5d97548c4..f719714862b5 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -1877,6 +1877,21 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
> >   	return 0;
> >   }
> > +static inline int ext4_mb_uninit_on_disk(struct super_block *sb,
> > +				    ext4_group_t group)
> > +{
> > +	struct ext4_group_desc *desc;
> > +
> > +	if (!ext4_has_group_desc_csum(sb))
> > +		return 0;
> > +
> > +	desc = ext4_get_group_desc(sb, group, NULL);
> > +	if (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> >   /*
> >    * The routine scans buddy structures (not bitmap!) from given order
> >    * to max order and tries to find big enough chunk to satisfy the req
> > @@ -2060,7 +2075,20 @@ static int ext4_mb_good_group(struct ext4_allocation_context *ac,
> >   	/* We only do this if the grp has never been initialized */
> >   	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
> > -		int ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> > +		int ret;
> > +
> > +		/* cr=0/1 is a very optimistic search to find large
> > +		 * good chunks almost for free. if buddy data is
> > +		 * not ready, then this optimization makes no sense.
> > +		 * instead it leads to loading (synchronously) lots
> > +		 * of groups and very slow allocations.
> > +		 * but don't skip the goal group to keep blocks in
> > +		 * the inode's group. */
> > +
> > +		if (cr < 2 && !ext4_mb_uninit_on_disk(ac->ac_sb, group) &&
> > +		    ac->ac_g_ex.fe_group != group)
> > +			return 0;
> > +		ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> >   		if (ret)
> >   			return ret;
> >   	}
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
