Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530BD598A4A
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Aug 2022 19:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbiHRRYM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Aug 2022 13:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiHRRXj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Aug 2022 13:23:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF1A22B3A;
        Thu, 18 Aug 2022 10:23:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 677EE3F3FD;
        Thu, 18 Aug 2022 17:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660843397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjWNDSRnORbShjMBa9s6R/Heptn3LpK1fy5wT+PfHdI=;
        b=VZWPv19/JaxGGriQcDjOi7IMPosxQlOdCoVC/skrYaburI0Qq6FStemGju+Sx1oXzF0E/V
        Q+y6pMD1k7Ob4DKB3P0dXxIKSRngKkdjacO8Fxhn7CIwRm6zJwsWoLMIFsHu2QTR5+P4dJ
        ZenRyTT4dDVs7Ii/mhCvGrBDJTHTPsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660843397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjWNDSRnORbShjMBa9s6R/Heptn3LpK1fy5wT+PfHdI=;
        b=WF9ZMmWRt0mSoU9njVjSQc/mfYbkNmjSYtwkc3Rl/Sk/z4lVi/Vnn1LqNK9tmQhfQTPGZN
        rq1rVsOj8iovunCA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0F0652C184;
        Thu, 18 Aug 2022 17:23:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 96CCAA066C; Thu, 18 Aug 2022 19:23:16 +0200 (CEST)
Date:   Thu, 18 Aug 2022 19:23:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: add inode table check in __ext4_get_inode_loc
 to aovid possible infinite loop
Message-ID: <20220818172316.jfsjb3efohml3yt3@quack3>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <20220817132701.3015912-3-libaokun1@huawei.com>
 <20220817143138.7krkxzoa3skruiyx@quack3>
 <20220818144353.q6cq3b7huwkopk5b@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818144353.q6cq3b7huwkopk5b@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 18-08-22 20:13:53, Ritesh Harjani (IBM) wrote:
> On 22/08/17 04:31PM, Jan Kara wrote:
> > On Wed 17-08-22 21:27:01, Baokun Li wrote:
> > > In do_writepages, if the value returned by ext4_writepages is "-ENOMEM"
> > > and "wbc->sync_mode == WB_SYNC_ALL", retry until the condition is not met.
> > >
> > > In __ext4_get_inode_loc, if the bh returned by sb_getblk is NULL,
> > > the function returns -ENOMEM.
> > >
> > > In __getblk_slow, if the return value of grow_buffers is less than 0,
> > > the function returns NULL.
> > >
> > > When the three processes are connected in series like the following stack,
> > > an infinite loop may occur:
> > >
> > > do_writepages					<--- keep retrying
> > >  ext4_writepages
> > >   mpage_map_and_submit_extent
> > >    mpage_map_one_extent
> > >     ext4_map_blocks
> > >      ext4_ext_map_blocks
> > >       ext4_ext_handle_unwritten_extents
> > >        ext4_ext_convert_to_initialized
> > >         ext4_split_extent
> > >          ext4_split_extent_at
> > >           __ext4_ext_dirty
> > >            __ext4_mark_inode_dirty
> > >             ext4_reserve_inode_write
> > >              ext4_get_inode_loc
> > >               __ext4_get_inode_loc		<--- return -ENOMEM
> > >                sb_getblk
> > >                 __getblk_gfp
> > >                  __getblk_slow			<--- return NULL
> > >                   grow_buffers
> > >                    grow_dev_page		<--- return -ENXIO
> > >                     ret = (block < end_block) ? 1 : -ENXIO;
> > >
> > > In this issue, bg_inode_table_hi is overwritten as an incorrect value.
> > > As a result, `block < end_block` cannot be met in grow_dev_page.
> > > Therefore, __ext4_get_inode_loc always returns '-ENOMEM' and do_writepages
> > > keeps retrying. As a result, the writeback process is in the D state due
> > > to an infinite loop.
> > >
> > > Add a check on inode table block in the __ext4_get_inode_loc function by
> > > referring to ext4_read_inode_bitmap to avoid this infinite loop.
> > >
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> >
> > Thanks for the fixes. Normally, we check that inode table is fine in
> > ext4_check_descriptors() (and those checks are much stricter) so it seems
> > unnecessary to check it again here. I understand that in your case it was
> > resize that corrupted the group descriptor after the filesystem was mounted
> > which is nasty but there's much more metadata that can be corrupted like
> > this and it's infeasible to check each metadata block before we use it.
> >
> > IMHO a proper fix to this class of issues would be for sb_getblk() to
> > return proper error so that we can distinguish ENOMEM from other errors.
> > But that will be a larger undertaking...
> >
> 
> Hi Jan,
> 
> How about adding a wrapper around sb_getblk() which will do the basic block
> bound checks for ext4. Then we can carefully convert all the callers of
> sb_getblk() in ext4 to call ext4_sb_getblk().
> 
> ext4_sb_getblk() will then return either of below -
> 1. ERR_PTR(-EFSCORRUPTED)
> 2. NULL
> 3. struct buffer_head*
> 
> It's caller can then implement the proper error handling.
> 
> Folding a small patch to implement the simple bound check. Is this the right
> approach?

Yep, looks sensible to me. Maybe I'd just make ext4_sb_getblk() return bh
or ERR_PTR so something like ERR_PTR(-EFSCORRUPTED), ERR_PTR(-ENXIO), or bh
pointer.

								Honza

> 
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> Date: Thu, 18 Aug 2022 07:53:58 -0500
> Subject: [RFC] ext4: Add ext4_sb_getblk() wrapper for block bounds checking
> 
> We might need more bounds checking on the block before calling sb_getblk().
> This helper does that and if it is not valid then returns ERR_PTR(-EFSCORRUPTED)
> Later we will need to carefully convert the callers to use ext4_sb_getblk()
> instead of sb_getblk().
> For e.g. __ext4_get_inode_loc()
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/block_validity.c |  4 +---
>  fs/ext4/ext4.h           | 12 ++++++++++++
>  fs/ext4/super.c          |  9 +++++++++
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 5504f72bbbbe..69347fab7c38 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -301,9 +301,7 @@ int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
>  	struct rb_node *n;
>  	int ret = 1;
> 
> -	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
> -	    (start_blk + count < start_blk) ||
> -	    (start_blk + count > ext4_blocks_count(sbi->s_es)))
> +	if (!ext4_sb_block_valid_fastcheck(sbi->s_es, start_blk, count))
>  		return 0;
> 
>  	/*
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9bca5565547b..79d0e45185d3 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3072,6 +3072,8 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
>  					 sector_t block, blk_opf_t op_flags);
>  extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
>  						   sector_t block);
> +extern struct buffer_head *ext4_sb_getblk(struct super_block *sb,
> +					  sector_t block);
>  extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
>  				bh_end_io_t *end_io);
>  extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
> @@ -3358,6 +3360,16 @@ static inline unsigned int ext4_flex_bg_size(struct ext4_sb_info *sbi)
>  	return 1 << sbi->s_log_groups_per_flex;
>  }
> 
> +static inline bool ext4_sb_block_valid_fastcheck(struct ext4_super_block *es,
> +					sector_t start_blk, unsigned int count)
> +{
> +	if ((start_blk <= le32_to_cpu(es->s_first_data_block)) ||
> +	    (start_blk + count < start_blk) ||
> +	    (start_blk + count > ext4_blocks_count(es)))
> +		return false;
> +	return true;
> +}
> +
>  #define ext4_std_error(sb, errno)				\
>  do {								\
>  	if ((errno))						\
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9a66abcca1a8..5b29272ad9a9 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -269,6 +269,15 @@ void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
>  	}
>  }
> 
> +struct buffer_head *ext4_sb_getblk(struct super_block *sb, sector_t block)
> +{
> +	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> +
> +	if (!ext4_sb_block_valid_fastcheck(es, block, 1))
> +		return ERR_PTR(-EFSCORRUPTED);
> +	return sb_getblk(sb, block);
> +}
> +
>  static int ext4_verify_csum_type(struct super_block *sb,
>  				 struct ext4_super_block *es)
>  {
> --
> 2.25.1
> 
> -ritesh
> 
> 
> 
> > 								Honza
> >
> > > ---
> > >  fs/ext4/inode.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index 601214453c3a..5e171879fa23 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -4466,9 +4466,17 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
> > >  	inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
> > >  	inode_offset = ((ino - 1) %
> > >  			EXT4_INODES_PER_GROUP(sb));
> > > -	block = ext4_inode_table(sb, gdp) + (inode_offset / inodes_per_block);
> > >  	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
> > >
> > > +	block = ext4_inode_table(sb, gdp);
> > > +	if ((block <= le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) ||
> > > +	    (block >= ext4_blocks_count(EXT4_SB(sb)->s_es))) {
> > > +		ext4_error(sb, "Invalid inode table block %llu in "
> > > +			   "block_group %u", block, iloc->block_group);
> > > +		return -EFSCORRUPTED;
> > > +	}
> > > +	block += (inode_offset / inodes_per_block);
> > > +
> > >  	bh = sb_getblk(sb, block);
> > >  	if (unlikely(!bh))
> > >  		return -ENOMEM;
> > > --
> > > 2.31.1
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
