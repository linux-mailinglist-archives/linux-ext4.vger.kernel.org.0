Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE553F3E04
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Aug 2021 07:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhHVFST (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Aug 2021 01:18:19 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55233 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229939AbhHVFST (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 22 Aug 2021 01:18:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uksy5lp_1629609454;
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Uksy5lp_1629609454)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 22 Aug 2021 13:17:36 +0800
Date:   Sun, 22 Aug 2021 13:17:34 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] ext4: fix reserved space counter leakage
Message-ID: <YSHd7q7tdzUTSCfV@B-P7TQMD6M-0146>
References: <20210819091351.19297-1-jefflexu@linux.alibaba.com>
 <20210820164556.GA30851@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820164556.GA30851@localhost.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 20, 2021 at 12:45:56PM -0400, Eric Whitney wrote:
> * Jeffle Xu <jefflexu@linux.alibaba.com>:
> > When ext4_es_insert_delayed_block() returns error, e.g., ENOMEM,
> > previously reserved space is not released as the error handling,
> > in which case @s_dirtyclusters_counter is left over. Since this delayed
> > extent failes to be inserted into extent status tree, when inode is
> > written back, the extra @s_dirtyclusters_counter won't be subtracted and
> > remains there forever.
> > 
> > This can leads to /sys/fs/ext4/<dev>/delayed_allocation_blocks remains
> > non-zero even when syncfs is executed on the filesystem.
> > 
> 
> Hi:
> 
> I think the fix below looks fine.  However, this comment doesn't look right
> to me.  Are you really seeing delayed_allocation_blocks values that remain
> incorrectly elevated across last closes (or across file system unmounts and
> remounts)?  s_dirtyclusters_counter isn't written out to stable storage -
> it's an in-memory only variable that's created when a file is first opened
> and destroyed on last close.

hmmm.... Let me explain a bit about this. It can be reproduced easily by fault
injection with the code modified below:

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9a3a8996aacf..29dc0da5960c 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -794,6 +794,9 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
                }
        }

+       if (!(ktime_get_ns() % 3)) {
+               return -ENOMEM;
+       }
        es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
                                  newes->es_pblk);
        if (!es)

and then run a loop
while true; do dd if=/dev/zero of=aaa bs=8192 count=10000; sync; rm -rf aaa; done

After "Cannot allocate memory reported" is shown, s_dirtyclusters_counter
was already leaked. It can cause df and free space counting incorrect in
this mount.

If my understanging is correct, in priciple, we should also check with
"WARN_ON(ei->i_reserved_data_blocks)" in the inode evict path since it
should be considered as 0.

Thanks,
Gao Xiang

> 
> Eric
> 
> > Fixes: 51865fda28e5 ("ext4: let ext4 maintain extent status tree")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > ---
> >  fs/ext4/inode.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 82087657860b..7f15da370281 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -1650,6 +1650,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
> >  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> >  	int ret;
> >  	bool allocated = false;
> > +	bool reserved = false;
> >  
> >  	/*
> >  	 * If the cluster containing lblk is shared with a delayed,
> > @@ -1666,6 +1667,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
> >  		ret = ext4_da_reserve_space(inode);
> >  		if (ret != 0)   /* ENOSPC */
> >  			goto errout;
> > +		reserved = true;
> >  	} else {   /* bigalloc */
> >  		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
> >  			if (!ext4_es_scan_clu(inode,
> > @@ -1678,6 +1680,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
> >  					ret = ext4_da_reserve_space(inode);
> >  					if (ret != 0)   /* ENOSPC */
> >  						goto errout;
> > +					reserved = true;
> >  				} else {
> >  					allocated = true;
> >  				}
> > @@ -1688,6 +1691,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
> >  	}
> >  
> >  	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
> > +	if (ret && reserved)
> > +		ext4_da_release_space(inode, 1);
> >  
> >  errout:
> >  	return ret;
> > -- 
> > 2.27.0
> > 
