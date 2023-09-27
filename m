Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12787AFEEE
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 10:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjI0ItZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjI0ItY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 04:49:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FD7A3;
        Wed, 27 Sep 2023 01:49:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c3bd829b86so83289205ad.0;
        Wed, 27 Sep 2023 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695804562; x=1696409362; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rt/Yw43hYQHNo06Frt+fQ33LFBmtCQhUztnPZ1yyNbI=;
        b=OznP9QddYD/P6SLu1IihEPpKDHVvJJZCKkNpl/GsiaSwPis2NgEXljT2DBH9R9w/bi
         WtnciHWgRRm+sZ9WLhrB98dewHCAx5gBKMNVXBsbDxqhJJPvwMjYWk06wZnJlBt7mPIE
         gy1msnawdL5Q+8Dxdh4jDlHKc67EOgm5hGDYPf0nL3mIDLqyQEGxqh978g9um0mYT9Bj
         hoz3FOt2oiKjNdSsP1IJ9idvDfGABNyNBRh+tk+m7SYyNH2mB3lXbwBTuWc1+KXAN49q
         QZ4ZpEIx0/0fomoTAStWoyrZdFp1/PaiO9SjrySgjMCCkdHEmbOmN//mCVzincuUAib+
         px4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804562; x=1696409362;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rt/Yw43hYQHNo06Frt+fQ33LFBmtCQhUztnPZ1yyNbI=;
        b=DOJgs8p31UaZ0jd4cYZ64NYIYn4fmAjn6ct8Avyvl8DJWWYX4TEKUjTIFyu5qBZluJ
         vVY3VmA1OF8jeXCKlYpNvXx05BbfHDBqNHzXozU2MLW3Ck0qXFwIXPsYeqMmIQKmMi3g
         E7QFjvoeLVLytF7EDJgECJ9SPceKPqYgpEgIywGii47JuQ20h4dTwNQs4Hp2WsiMQwG5
         EpcBBwcoa2UGhsbVC2QpHNFih7pBSMiA2dZgg6aQzYZR56CYGD+Wq8k2oPjzuNm+j8U2
         gk38q7FF4t6w9mXPPqcTADam3EcAghiXdlzElxzdRc+P0HW2fLMUhiSA3MXpZe2+7Hfe
         BNew==
X-Gm-Message-State: AOJu0Yz/cEPuzLIW7T4Q4es9V+8uMxnz6tYsfrLGfQV5s3xzJGRSHt0F
        8s+ukaPykQTgij/Qgrcug9fYyitDr3k=
X-Google-Smtp-Source: AGHT+IHOIvlC0VTTSD1TDqihjByVlmint/jkmEcXp1TPBsQlERqjLLSm7j2rCoIykA/lAs6dVQsmxQ==
X-Received: by 2002:a17:902:da8c:b0:1c5:a60c:4ee with SMTP id j12-20020a170902da8c00b001c5a60c04eemr1257482plx.47.1695804562075;
        Wed, 27 Sep 2023 01:49:22 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001bb99e188fcsm12495621plx.194.2023.09.27.01.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 01:49:21 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:19:17 +0530
Message-Id: <87zg18f1bm.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/12] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
In-Reply-To: <20230919201532.310085-3-shikemeng@huaweicloud.com>
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

> There are several reasons to add a general function ext4_mb_mark_context
> to update block bitmap and group descriptor on disk:
> 1. pair behavior of alloc/free bits. For example,
> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
> 2. remove repeat code to read from disk, update and write back to disk.
> 3. reduce future unit test mocks to catch real IO to update structure
> on disk.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 147 ++++++++++++++++++++++++----------------------
>  1 file changed, 77 insertions(+), 70 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index cf09adfbaf11..e1320eea46e9 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3953,6 +3953,80 @@ void ext4_exit_mballoc(void)
>  	ext4_groupinfo_destroy_slabs();
>  }
>  
> +static int
> +ext4_mb_mark_context(struct super_block *sb, bool state, ext4_group_t group,
> +		     ext4_grpblk_t blkoff, ext4_grpblk_t len)


ext4_grpblk_t is defined as int.
    /* data type for block offset of block group */
    typedef int ext4_grpblk_t;

I think len should be unsigned int (u32) here. 

> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct buffer_head *bitmap_bh = NULL;
> +	struct ext4_group_desc *gdp;
> +	struct buffer_head *gdp_bh;
> +	int err;
> +	unsigned int i, already, changed;
> +
> +	bitmap_bh = ext4_read_block_bitmap(sb, group);
> +	if (IS_ERR(bitmap_bh))
> +		return PTR_ERR(bitmap_bh);
> +
> +	err = -EIO;
> +	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> +	if (!gdp)
> +		goto out_err;
> +
> +	ext4_lock_group(sb, group);
> +	if (ext4_has_group_desc_csum(sb) &&
> +	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
> +		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> +		ext4_free_group_clusters_set(sb, gdp,
> +			ext4_free_clusters_after_init(sb, group, gdp));
> +	}
> +
> +	already = 0;
> +	for (i = 0; i < len; i++)
> +		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
> +				state)
> +			already++;
> +	changed = len - already;
> +
> +	if (state) {
> +		mb_set_bits(bitmap_bh->b_data, blkoff, len);
> +		ext4_free_group_clusters_set(sb, gdp,
> +			ext4_free_group_clusters(sb, gdp) - changed);
> +	} else {
> +		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
> +		ext4_free_group_clusters_set(sb, gdp,
> +			ext4_free_group_clusters(sb, gdp) + changed);
> +	}
> +
> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> +	ext4_group_desc_csum_set(sb, group, gdp);
> +	ext4_unlock_group(sb, group);
> +
> +	if (sbi->s_log_groups_per_flex) {
> +		ext4_group_t flex_group = ext4_flex_group(sbi, group);
> +		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
> +					   s_flex_groups, flex_group);
> +
> +		if (state)
> +			atomic64_sub(changed, &fg->free_clusters);
> +		else
> +			atomic64_add(changed, &fg->free_clusters);
> +	}
> +
> +	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> +	if (err)
> +		goto out_err;
> +	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> +	if (err)
> +		goto out_err;
> +
> +	sync_dirty_buffer(bitmap_bh);
> +	sync_dirty_buffer(gdp_bh);
> +
> +out_err:
> +	brelse(bitmap_bh);
> +	return err;
> +}
>  
>  /*
>   * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
> @@ -4079,15 +4153,11 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  		     int len, bool state)

Even ext4_mb_mark_bb should take len as unsigned int IMO.
For e.g. ext4_fc_replay_add_range() passes map.m_len which is also
unsigned int.


Otherwise the patch looks good to me. Feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh
