Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C729276C288
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 03:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjHBB5N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 21:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjHBB5M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 21:57:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67425212A;
        Tue,  1 Aug 2023 18:57:11 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bb84194bf3so39473965ad.3;
        Tue, 01 Aug 2023 18:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690941431; x=1691546231;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lh/FkjR6lchSJbXFoRIJssgs9hs8H+Ud4pBRt1B6DUE=;
        b=BusafkPr036Qc9TCdzYpEW0rFYns+257Z1qzEVOdcjR9gGep0+whZxA2tQZ5L9UeO+
         Q5vcS13wVk5fda9loL2By1VnSoSuWKI5C93XRvP6iqXspoiVUYZ3/iq7jE0Bc4cjSR7F
         oJmimsc+0TV+LaHJilvyLbLYdxknSjVyTuicr05Fi21yjZnJ5asGY6Cb2uoFBG57/gsg
         n1PL9smX3MHIfB97SskDW3yyJLxuiagRSbQkn1C1QVGcn5dOGRNrBsa45CJOrALtl0sj
         mUWVVuMf7NakjMPLQlGmNsGSRJpW4T+8Bq7J6VYDJmyd5vt43YBf4hoaVqpBP+grFGmH
         isKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690941431; x=1691546231;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lh/FkjR6lchSJbXFoRIJssgs9hs8H+Ud4pBRt1B6DUE=;
        b=HTp+B4Nt77JvJleKflUcI8vj8Lp/O8EfPIJQYAkKiIEsGjEa4huUOlZ6sevICNEMfU
         /nqlKMMRbi3WX3rY8zYijE9lRX0zPIL5ErLFl63rEPOMnwfMgu5fw4NRR+0R8MrjhxgK
         ib1kI5L+0+51BtsHWVwtOo47udHYdF2ySdInBKugJMH7kEYmmrkUDiLKWFnI3e6auWqX
         xL8QdokNLRawldcm69FvUo3GR1p1wpQWGMKynU+Tu1Obl0jqFU9NkH7nt6fmpDD2mNOT
         /8hwOOhF675oSn/yM5f1Y7zrl+VwpENEvxze0HuxVLoWBUwxXbb8kWq6u7KjJNgT1NBA
         v58Q==
X-Gm-Message-State: ABy/qLbCVePs77+dqh+ZcBOMdtfDNVmQ6uRZ2Mz0rZwKYlKhq/cfbkTh
        0z32qcX7VQe+4Hoya7hglf4=
X-Google-Smtp-Source: APBJJlHkmvPzkkJZHSnZs53q1v3L+MCypundzGX6iL8Tcc0smthpk1B6PYYMNfzZojtySf7teIop+w==
X-Received: by 2002:a17:902:788e:b0:1bb:98a0:b78a with SMTP id q14-20020a170902788e00b001bb98a0b78amr11540766pll.18.1690941430739;
        Tue, 01 Aug 2023 18:57:10 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b001b03b7f8adfsm11115379plh.246.2023.08.01.18.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 18:57:09 -0700 (PDT)
Date:   Wed, 02 Aug 2023 07:27:06 +0530
Message-Id: <87pm46w6j1.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH v2] ext4: Replace CR_FAST macro with inline function for readability
In-Reply-To: <20230630085927.140137-1-ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> Replace CR_FAST with ext4_mb_cr_expensive() inline function for better
> readability. This function returns true if the criteria is one of the
> expensive/slower ones where lots of disk IO/prefetching is acceptable.
>
> No functional changes are intended in this patch.
>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>
> Changes since v1 [1] 
>
> * reworded an if condition in ext_mb_good_group_nolock
>   and added a comment to better describe the intent of the 
> 	condition
> * Picked up RVB from Jan.
>
> [1]
> https://lore.kernel.org/linux-ext4/ZJ2YIr5EVbz4ezIc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/T/#ma9428de15c4084937274f4d66dcd4d53f505d32a
>
>  fs/ext4/ext4.h    |  7 ++++---
>  fs/ext4/mballoc.c | 13 +++++++++----
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 45a531446ea2..e404169a2858 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -176,9 +176,6 @@ enum criteria {
>  	EXT4_MB_NUM_CRS
>  };
>  
> -/* criteria below which we use fast block scanning and avoid unnecessary IO */
> -#define CR_FAST CR_GOAL_LEN_SLOW
> -
>  /*
>   * Flags used in mballoc's allocation_context flags field.
>   *
> @@ -2924,6 +2921,10 @@ extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
>  extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
>  extern void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  		       int len, int state);
> +static inline bool ext4_mb_cr_expensive(enum criteria cr)
> +{
> +	return cr >= CR_GOAL_LEN_SLOW;
> +}
>  
>  /* inode.c */
>  void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a2475b8c9fb5..542577f621c6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2446,7 +2446,7 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
>  			break;
>  		}
>  
> -		if (ac->ac_criteria < CR_FAST) {
> +		if (!ext4_mb_cr_expensive(ac->ac_criteria)) {
>  			/*
>  			 * In CR_GOAL_LEN_FAST and CR_BEST_AVAIL_LEN, we are
>  			 * sure that this group will have a large enough
> @@ -2630,7 +2630,12 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>  	free = grp->bb_free;
>  	if (free == 0)
>  		goto out;
> -	if (cr <= CR_FAST && free < ac->ac_g_ex.fe_len)
> +	/*
> +	 * In all criterias except CR_ANY_FREE we try to avoid groups that
> +	 * can't possibly satisfy the full goal request due to insufficient
> +	 * free blocks.
> +	 */
> +	if (cr < CR_ANY_FREE && free < ac->ac_g_ex.fe_len)
>  		goto out;

cr CR_BEST_AVAIL_LEN, is the one where we can allocate something smaller
than the original goal length. But in that we alter the goal length
itself while selecting the criteria.
So checking free < ac->ac_g_ex.fe_len should work here. 


Looks good to me. Feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



>  	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
>  		goto out;
> @@ -2654,7 +2659,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>  		 * sure we locate metadata blocks in the first block group in
>  		 * the flex_bg if possible.
>  		 */
> -		if (cr < CR_FAST &&
> +		if (!ext4_mb_cr_expensive(cr) &&
>  		    (!sbi->s_log_groups_per_flex ||
>  		     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) != 0)) &&
>  		    !(ext4_has_group_desc_csum(sb) &&
> @@ -2848,7 +2853,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  			 * spend a lot of time loading imperfect groups
>  			 */
>  			if ((prefetch_grp == group) &&
> -			    (cr >= CR_FAST ||
> +			    (ext4_mb_cr_expensive(cr) ||
>  			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
>  				nr = sbi->s_mb_prefetch;
>  				if (ext4_has_feature_flex_bg(sb)) {
> -- 
> 2.31.1

-ritesh
