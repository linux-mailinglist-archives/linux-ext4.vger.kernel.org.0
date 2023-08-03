Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F172D76EB53
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjHCN63 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 09:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbjHCN61 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 09:58:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4541707;
        Thu,  3 Aug 2023 06:58:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20DCA21921;
        Thu,  3 Aug 2023 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691071105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8l+QAiD940oRfagIuqCPBAwWKWqvR6TFA25XDtgoPkE=;
        b=20UDKVqDDoMafg1Mf+6A9zpw7ulljTIIxJkfwahen3RJirthgW3vgD12GcdD6gu84d88SF
        e7OWVwk36aBpGccsIkQq8Z4CG8AMzmmAoeLgIdJMzp/aJpI+fI9/MLdf87ZgszjNxDvgjm
        DTKC91eKkrVbhOsk/s20of3Gjx8/Cro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691071105;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8l+QAiD940oRfagIuqCPBAwWKWqvR6TFA25XDtgoPkE=;
        b=otuL5jz4tvQUbwI2vKkPCD/IWnb+TBrbgd0USU/V8dEBtj/RB/LnMVp2ADEjGawPhz1QpB
        s3Ayb0o8YXSRhOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E9ED1333C;
        Thu,  3 Aug 2023 13:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RVaOA4Gyy2T+fwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 13:58:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8692FA076B; Thu,  3 Aug 2023 15:58:24 +0200 (CEST)
Date:   Thu, 3 Aug 2023 15:58:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/3] ext4: add two helper functions
 extent_logical_end() and pa_logical_end()
Message-ID: <20230803135824.iue2mm53chrxrb2r@quack3>
References: <20230724121059.11834-1-libaokun1@huawei.com>
 <20230724121059.11834-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724121059.11834-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-07-23 20:10:57, Baokun Li wrote:
> When we use lstart + len to calculate the end of free extent or prealloc
> space, it may exceed the maximum value of 4294967295(0xffffffff) supported
> by ext4_lblk_t and cause overflow, which may lead to various problems.
> 
> Therefore, we add two helper functions, extent_logical_end() and
> pa_logical_end(), to limit the type of end to loff_t, and also convert
> lstart to loff_t for calculation to avoid overflow.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c |  9 +++------
>  fs/ext4/mballoc.h | 14 ++++++++++++++
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 21b903fe546e..4cb13b3e41b3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4432,7 +4432,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  
>  	/* first, let's learn actual file size
>  	 * given current request is allocated */
> -	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
> +	size = extent_logical_end(sbi, &ac->ac_o_ex);
>  	size = size << bsbits;
>  	if (size < i_size_read(ac->ac_inode))
>  		size = i_size_read(ac->ac_inode);
> @@ -4766,7 +4766,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_locality_group *lg;
>  	struct ext4_prealloc_space *tmp_pa = NULL, *cpa = NULL;
> -	loff_t tmp_pa_end;
>  	struct rb_node *iter;
>  	ext4_fsblk_t goal_block;
>  
> @@ -4862,9 +4861,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	 * pa can possibly satisfy the request hence check if it overlaps
>  	 * original logical start and stop searching if it doesn't.
>  	 */
> -	tmp_pa_end = (loff_t)tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> -
> -	if (ac->ac_o_ex.fe_logical >= tmp_pa_end) {
> +	if (ac->ac_o_ex.fe_logical >= pa_logical_end(sbi, tmp_pa)) {
>  		spin_unlock(&tmp_pa->pa_lock);
>  		goto try_group_pa;
>  	}
> @@ -5769,7 +5766,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
>  
>  	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
>  	inode_pa_eligible = true;
> -	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
> +	size = extent_logical_end(sbi, &ac->ac_o_ex);
>  	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
>  		>> bsbits;
>  
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index df6b5e7c2274..d7aeb5da7d86 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -233,6 +233,20 @@ static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
>  		(fex->fe_start << EXT4_SB(sb)->s_cluster_bits);
>  }
>  
> +static inline loff_t extent_logical_end(struct ext4_sb_info *sbi,
> +					struct ext4_free_extent *fex)
> +{
> +	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
> +	return (loff_t)fex->fe_logical + EXT4_C2B(sbi, fex->fe_len);
> +}
> +
> +static inline loff_t pa_logical_end(struct ext4_sb_info *sbi,
> +				    struct ext4_prealloc_space *pa)
> +{
> +	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
> +	return (loff_t)pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
> +}
> +
>  typedef int (*ext4_mballoc_query_range_fn)(
>  	struct super_block		*sb,
>  	ext4_group_t			agno,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
