Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8BE574F8B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiGNNqx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 09:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiGNNqw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 09:46:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D114F52FD1
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 06:46:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87B4B34982;
        Thu, 14 Jul 2022 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657806409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TJp6zdzOYqptDeclJKKhdIaxyPTzN16LaSy8KJInTQo=;
        b=Ux4ZEBNnfxrFyJyNO72E9M5Q1TZNDbiNhRpYhErtJgKsBILmMGKvb+L5eTJk6svydF3AUZ
        pzxy2QCk/D/qlMJJpOlAdahcMSh8lXKtZSicc9UQq4hFGsPIG2v1BUaZ8RAF4GeAN0sxPM
        W84o20cHRkWEuMCPHPcO+jRMBQM5J0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657806409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TJp6zdzOYqptDeclJKKhdIaxyPTzN16LaSy8KJInTQo=;
        b=ff62T8hf2uY3dHV904xwHu416PUyMwfXKyZZemAqfeSGN0ZOrmQcxBQciOITDjOuYXneSx
        kgH/hEbuEOaEEnAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7591B2C141;
        Thu, 14 Jul 2022 13:46:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0515BA0659; Thu, 14 Jul 2022 15:46:45 +0200 (CEST)
Date:   Thu, 14 Jul 2022 15:46:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Kiselev, Oleg" <okiselev@amazon.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4: reduce computation of overhead during resize
Message-ID: <20220714134645.r4gqax4au5el2pox@quack3>
References: <D03FEE2D-DCAE-44A7-B0D3-0047808426BB@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D03FEE2D-DCAE-44A7-B0D3-0047808426BB@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 30-06-22 02:17:21, Kiselev, Oleg wrote:
> This patch avoids doing an O(n**2)-complexity walk through every flex group.
> Instead, it uses the already computed overhead information for the newly
> allocated space, and simply adds it to the previously calculated
> overhead stored in the superblock.  This drastically reduces the time
> taken to resize very large bigalloc filesystems (from 3+ hours for a
> 64TB fs down to milliseconds).
> 
> Signed-off-by: Oleg Kiselev <okiselev@amazon.com>
> ---
>  fs/ext4/resize.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Overall this looks fine, a few smaller comments below.

> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 8b70a4701293..2acc9fca99ea 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1380,6 +1380,16 @@ static int ext4_setup_new_descs(handle_t *handle, struct super_block *sb,
>  	return err;
>  }
> 
> +static void ext4_set_overhead(struct super_block *sb,
> +                             const ext4_grpblk_t overhead)
> +{

ext4_add_overhead() would be a better name I suppose. Also the 'overhead'
should rather be ext4_fsblk_t to be on the safe side...

> +       struct ext4_sb_info *sbi = EXT4_SB(sb);
> +       struct ext4_super_block *es = sbi->s_es;

Empty line between variable declarations and the code please.

> +       sbi->s_overhead += overhead;
> +       es->s_overhead_clusters = cpu_to_le32((unsigned long) sbi->s_overhead);
						^^^ the typecast looks
bogus here...

> +       smp_wmb();
> +}

The barrier without any comment makes me really wonder why it is here...
But I get ext4_calculate_overhead() has is as well so you're just keeping
it.

> +
>  /*
>   * ext4_update_super() updates the super block so that the newly added
>   * groups can be seen by the filesystem.
> @@ -1482,8 +1492,16 @@ static void ext4_update_super(struct super_block *sb,
> 
>  	/*
>  	 * Update the fs overhead information
> +	 *
> +	 * For bigalloc, if the superblock already has a properly calculated
> +	 * overhead, update it wth a value based on numbers already computed
				^^ with

> +	 * above for the newly allocated capacity.
>  	 */
> -	ext4_calculate_overhead(sb);
> +	if (ext4_has_feature_bigalloc(sb) && (sbi->s_overhead != 0))
> +		ext4_set_overhead(sb,
> +			EXT4_NUM_B2C(sbi, blocks_count - free_blocks));
> +	else
> +		ext4_calculate_overhead(sb);
> 
>  	if (test_opt(sb, DEBUG))
>  		printk(KERN_DEBUG "EXT4-fs: added group %u:"

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
