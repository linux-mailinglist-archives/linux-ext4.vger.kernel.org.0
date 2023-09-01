Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA078F78B
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Sep 2023 05:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbjIADvp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 23:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjIADvo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 23:51:44 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB73F18C;
        Thu, 31 Aug 2023 20:51:41 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bd045336c6so1196218a34.2;
        Thu, 31 Aug 2023 20:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693540300; x=1694145100; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM3JKX7Dav71VnKYpce9CXueqnYfgS+zkQbBLMQsBhI=;
        b=cTEmN+ic5EAzdrBZU5GwTHT/OpwpE4Ka+/04aKWoVBRxRy/khsqJ0Q+uuISBPWnzwq
         7ymukAlP3FFiX8MUHUpjpdJis+3g0FgXrpJg0zmZxlCeqnKi0yLXSIzc9mZW7zilulul
         y7IymCe7NeH/4cemcTdMM2o2H8x5j87bjQrR23FPZ46+/3gyox9pYlllwr5IxFUuM8CQ
         Py6OLrlvzq3dFRYx4SsmpRIiKZYVpoAEG9XyN+S+dchDW3/CMiUngtLQHVgET+wuesBD
         8ydAW3/MDyhslgwFUydfgEX1wzgVlcVWKKjTrlXF2Lo8adlu30rlxqSc0SGvmmZz/x78
         KFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693540300; x=1694145100;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JM3JKX7Dav71VnKYpce9CXueqnYfgS+zkQbBLMQsBhI=;
        b=ZrZo49kbkwv0XCrY1SUvaF4SRluTH3KOFkOM9RS2z54bf3EiSJA23fOQLZocmzK5so
         Ao9bB8+txbvDFkzAAcb3Rn1SfsvbXhpt82XuQaxg8amU+2gUIBHy2WoKw+mJj85+b13z
         yeCrOQEOGVJzpXHxIgUa44qzPi8mTX/BDKMJp3CWGM5aAnamtVoEsdMShdd6w005V4cE
         6PhwD8hqj7ARTYo8++/qh6vI2vFHVKFEIj+jhO63GyKtTVapU2LRcei9TNjsFmlN+gWK
         uTyT9PW8KndKLFbncE5m4eWoy2PvEclc6ksUVkNp61P63OJWXacY8vMzIV4jn+Y6qacL
         COPQ==
X-Gm-Message-State: AOJu0YzS+XSHoKhod0AV+4W69N0KoOnt9qa0g4qwsVgh3FQOyar3XCB/
        HHajNblzQTSMp+zUBwtc3soBHjMYd+A=
X-Google-Smtp-Source: AGHT+IE2Xme2k3sHrFKZMsIT1gwPX2mU/eeqMeA2GVWOzt2fCljglWWqPepRP66sGJ8BjissGkGZmg==
X-Received: by 2002:a05:6870:c0cc:b0:1bb:8b8a:2b1b with SMTP id e12-20020a056870c0cc00b001bb8b8a2b1bmr1541000oad.54.1693540300563;
        Thu, 31 Aug 2023 20:51:40 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090ae61700b00268238583acsm3637468pjy.32.2023.08.31.20.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 20:51:39 -0700 (PDT)
Date:   Fri, 01 Sep 2023 09:21:36 +0530
Message-Id: <87bkem8saf.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/11] ext4: call ext4_mb_mark_context in ext4_mb_mark_diskspace_used
In-Reply-To: <20230826155028.4019470-5-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> call ext4_mb_mark_context in ext4_mb_mark_diskspace_used to:
> 1. remove repeat code to normally update bitmap and group descriptor
> on disk.
> 2. call ext4_mb_mark_context instead of only setting bits in block bitmap
> to fix the bitmap. Function ext4_mb_mark_context will also update
> checksum of bitmap and other counter along with the bit change to keep
> the cosistent with bit change or block bitmap will be marked corrupted as
> checksum of bitmap is in inconsistent state.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/mballoc.c | 86 +++++++++++------------------------------------
>  1 file changed, 20 insertions(+), 66 deletions(-)

I was wondering whether checking for !ext4_inode_block_valid() can also
be part of ext4_mb_mark_context() by passing EXT4_MB_METABLOCKS_VALID_CHECK
flag.

But as for this patch. It looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh

>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b066ee018cdb..e650eac22237 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4084,46 +4084,28 @@ static noinline_for_stack int
>  ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  				handle_t *handle, unsigned int reserv_clstrs)
>  {
> -	struct buffer_head *bitmap_bh = NULL;
> +	struct ext4_mark_context mc;
>  	struct ext4_group_desc *gdp;
> -	struct buffer_head *gdp_bh;
>  	struct ext4_sb_info *sbi;
>  	struct super_block *sb;
>  	ext4_fsblk_t block;
>  	int err, len;
> +	int flags = 0;
>  
>  	BUG_ON(ac->ac_status != AC_STATUS_FOUND);
>  	BUG_ON(ac->ac_b_ex.fe_len <= 0);
>  
>  	sb = ac->ac_sb;
>  	sbi = EXT4_SB(sb);
> +	ext4_mb_prepare_mark_context(&mc, handle, sb, 1);
>  
> -	bitmap_bh = ext4_read_block_bitmap(sb, ac->ac_b_ex.fe_group);
> -	if (IS_ERR(bitmap_bh)) {
> -		return PTR_ERR(bitmap_bh);
> -	}
> -
> -	BUFFER_TRACE(bitmap_bh, "getting write access");
> -	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
> -					    EXT4_JTR_NONE);
> -	if (err)
> -		goto out_err;
> -
> -	err = -EIO;
> -	gdp = ext4_get_group_desc(sb, ac->ac_b_ex.fe_group, &gdp_bh);
> +	gdp = ext4_get_group_desc(sb, ac->ac_b_ex.fe_group, NULL);
>  	if (!gdp)
> -		goto out_err;
> -
> +		return -EIO;
>  	ext4_debug("using block group %u(%d)\n", ac->ac_b_ex.fe_group,
>  			ext4_free_group_clusters(sb, gdp));
>  
> -	BUFFER_TRACE(gdp_bh, "get_write_access");
> -	err = ext4_journal_get_write_access(handle, sb, gdp_bh, EXT4_JTR_NONE);
> -	if (err)
> -		goto out_err;
> -
>  	block = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
> -
>  	len = EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>  	if (!ext4_inode_block_valid(ac->ac_inode, block, len)) {
>  		ext4_error(sb, "Allocating blocks %llu-%llu which overlap "
> @@ -4132,41 +4114,28 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  		 * Fix the bitmap and return EFSCORRUPTED
>  		 * We leak some of the blocks here.
>  		 */
> -		ext4_lock_group(sb, ac->ac_b_ex.fe_group);
> -		mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
> -			      ac->ac_b_ex.fe_len);
> -		ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
> -		err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
> +		err = ext4_mb_mark_context(&mc, ac->ac_b_ex.fe_group,
> +					   ac->ac_b_ex.fe_start,
> +					   ac->ac_b_ex.fe_len,
> +					   0);
>  		if (!err)
>  			err = -EFSCORRUPTED;
> -		goto out_err;
> +		return err;
>  	}
>  
> -	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
>  #ifdef AGGRESSIVE_CHECK
> -	{
> -		int i;
> -		for (i = 0; i < ac->ac_b_ex.fe_len; i++) {
> -			BUG_ON(mb_test_bit(ac->ac_b_ex.fe_start + i,
> -						bitmap_bh->b_data));
> -		}
> -	}
> +	flags |= EXT4_MB_BITMAP_MARKED_CHECK;
>  #endif
> -	mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
> -		      ac->ac_b_ex.fe_len);
> -	if (ext4_has_group_desc_csum(sb) &&
> -	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> -		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> -		ext4_free_group_clusters_set(sb, gdp,
> -					     ext4_free_clusters_after_init(sb,
> -						ac->ac_b_ex.fe_group, gdp));
> -	}
> -	len = ext4_free_group_clusters(sb, gdp) - ac->ac_b_ex.fe_len;
> -	ext4_free_group_clusters_set(sb, gdp, len);
> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> -	ext4_group_desc_csum_set(sb, ac->ac_b_ex.fe_group, gdp);
> +	err = ext4_mb_mark_context(&mc, ac->ac_b_ex.fe_group,
> +				   ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
> +				   flags);
> +
> +	if (err && mc.changed == 0)
> +		return err;
>  
> -	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
> +#ifdef AGGRESSIVE_CHECK
> +	BUG_ON(mc.changed != ac->ac_b_ex.fe_len);
> +#endif
>  	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
>  	/*
>  	 * Now reduce the dirty block count also. Should not go negative
> @@ -4176,21 +4145,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  		percpu_counter_sub(&sbi->s_dirtyclusters_counter,
>  				   reserv_clstrs);
>  
> -	if (sbi->s_log_groups_per_flex) {
> -		ext4_group_t flex_group = ext4_flex_group(sbi,
> -							  ac->ac_b_ex.fe_group);
> -		atomic64_sub(ac->ac_b_ex.fe_len,
> -			     &sbi_array_rcu_deref(sbi, s_flex_groups,
> -						  flex_group)->free_clusters);
> -	}
> -
> -	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
> -	if (err)
> -		goto out_err;
> -	err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
> -
> -out_err:
> -	brelse(bitmap_bh);
>  	return err;
>  }
>  
> -- 
> 2.30.0
