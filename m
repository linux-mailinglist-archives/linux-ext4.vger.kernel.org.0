Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949AF52BCDE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbiERNfz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 09:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbiERNfz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 09:35:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F362D7E;
        Wed, 18 May 2022 06:35:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8E23421B1C;
        Wed, 18 May 2022 13:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652880944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LGP99y7W1cFBG0dBgL8R64+Y/eS32761MCmAGvEg25c=;
        b=YmQucZ6RfzQi/DAT820X+vIS7yRGNDgS7DBlHMGF1SnW1VcFm5ef4kGgYSX3DwAJBTFDBx
        KsoyXikf8YgSPSwaClEdQJ15m5Eykv1wONty2I2BSPgq+KPT0uWVkebLKL5W3X4Bq1amP5
        kbFIgirM8WqnX1JvIxWjjWAj0kjqPXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652880944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LGP99y7W1cFBG0dBgL8R64+Y/eS32761MCmAGvEg25c=;
        b=s65dmcFYA4fZHj/kb3FVv7m4CrsKZpsp1kUUdto0XLH8QeoMy2nv97DenbPMSabYqzEckS
        fPVgx01oZcQFAAAQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DD2F12C141;
        Wed, 18 May 2022 13:35:43 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 91D1EA062F; Wed, 18 May 2022 15:35:43 +0200 (CEST)
Date:   Wed, 18 May 2022 15:35:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] ext4: fix bug_on in __es_tree_search
Message-ID: <20220518133543.eewb4zcsw6fs6zpq@quack3.lan>
References: <20220518120816.1541863-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518120816.1541863-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 18-05-22 20:08:16, Baokun Li wrote:
> Hulk Robot reported a BUG_ON:
> ==================================================================
> kernel BUG at fs/ext4/extents_status.c:199!
> [...]
> RIP: 0010:ext4_es_end fs/ext4/extents_status.c:199 [inline]
> RIP: 0010:__es_tree_search+0x1e0/0x260 fs/ext4/extents_status.c:217
> [...]
> Call Trace:
>  ext4_es_cache_extent+0x109/0x340 fs/ext4/extents_status.c:766
>  ext4_cache_extents+0x239/0x2e0 fs/ext4/extents.c:561
>  ext4_find_extent+0x6b7/0xa20 fs/ext4/extents.c:964
>  ext4_ext_map_blocks+0x16b/0x4b70 fs/ext4/extents.c:4384
>  ext4_map_blocks+0xe26/0x19f0 fs/ext4/inode.c:567
>  ext4_getblk+0x320/0x4c0 fs/ext4/inode.c:980
>  ext4_bread+0x2d/0x170 fs/ext4/inode.c:1031
>  ext4_quota_read+0x248/0x320 fs/ext4/super.c:6257
>  v2_read_header+0x78/0x110 fs/quota/quota_v2.c:63
>  v2_check_quota_file+0x76/0x230 fs/quota/quota_v2.c:82
>  vfs_load_quota_inode+0x5d1/0x1530 fs/quota/dquot.c:2368
>  dquot_enable+0x28a/0x330 fs/quota/dquot.c:2490
>  ext4_quota_enable fs/ext4/super.c:6137 [inline]
>  ext4_enable_quotas+0x5d7/0x960 fs/ext4/super.c:6163
>  ext4_fill_super+0xa7c9/0xdc00 fs/ext4/super.c:4754
>  mount_bdev+0x2e9/0x3b0 fs/super.c:1158
>  mount_fs+0x4b/0x1e4 fs/super.c:1261
> [...]
> ==================================================================
> 
> Above issue may happen as follows:
> -------------------------------------
> ext4_fill_super
>  ext4_enable_quotas
>   ext4_quota_enable
>    ext4_iget
>     __ext4_iget
>      ext4_ext_check_inode
>       ext4_ext_check
>        __ext4_ext_check
>         ext4_valid_extent_entries
>          Check for overlapping extents does't take effect
>    dquot_enable
>     vfs_load_quota_inode
>      v2_check_quota_file
>       v2_read_header
>        ext4_quota_read
>         ext4_bread
>          ext4_getblk
>           ext4_map_blocks
>            ext4_ext_map_blocks
>             ext4_find_extent
>              ext4_cache_extents
>               ext4_es_cache_extent
>                ext4_es_cache_extent
>                 __es_tree_search
>                  ext4_es_end
>                   BUG_ON(es->es_lblk + es->es_len < es->es_lblk)
> 
> The error ext4 extents is as follows:
> 0af3 0300 0400 0000 00000000    extent_header
> 00000000 0100 0000 12000000     extent1
> 00000000 0100 0000 18000000     extent2
> 02000000 0400 0000 14000000     extent3
> 
> In the ext4_valid_extent_entries function,
> if prev is 0, no error is returned even if lblock<=prev.
> This was intended to skip the check on the first extent, but
> in the error image above, prev=0+1-1=0 when checking the second extent,
> so even though lblock<=prev, the function does not return an error.
> As a result, bug_ON occurs in __es_tree_search and the system panics.
> 
> To solve this problem, we only need to check that:
> 1. The lblock of the first extent is not less than 0.
> 2. The lblock of the next extent  is not less than
>    the next block of the previous extent.
> The same applies to extent_idx.
> 
> Fixes: 5946d089379a ("ext4: check for overlapping extents in ext4_valid_extent_entries()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/extents.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e473fde6b64b..86ba0db20968 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -372,7 +372,7 @@ static int ext4_valid_extent_entries(struct inode *inode,
>  {
>  	unsigned short entries;
>  	ext4_lblk_t lblock = 0;
> -	ext4_lblk_t prev = 0;
> +	ext4_lblk_t cur = 0;
>  
>  	if (eh->eh_entries == 0)
>  		return 1;
> @@ -396,11 +396,11 @@ static int ext4_valid_extent_entries(struct inode *inode,
>  
>  			/* Check for overlapping extents */
>  			lblock = le32_to_cpu(ext->ee_block);
> -			if ((lblock <= prev) && prev) {
> +			if (lblock < cur) {
>  				*pblk = ext4_ext_pblock(ext);
>  				return 0;
>  			}
> -			prev = lblock + ext4_ext_get_actual_len(ext) - 1;
> +			cur = lblock + ext4_ext_get_actual_len(ext);
>  			ext++;
>  			entries--;
>  		}
> @@ -420,13 +420,13 @@ static int ext4_valid_extent_entries(struct inode *inode,
>  
>  			/* Check for overlapping index extents */
>  			lblock = le32_to_cpu(ext_idx->ei_block);
> -			if ((lblock <= prev) && prev) {
> +			if (lblock < cur) {
>  				*pblk = ext4_idx_pblock(ext_idx);
>  				return 0;
>  			}
>  			ext_idx++;
>  			entries--;
> -			prev = lblock;
> +			cur = lblock + 1;
>  		}
>  	}
>  	return 1;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
