Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C02B61F3E7
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 14:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiKGND7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 08:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKGND6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 08:03:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5C91C125;
        Mon,  7 Nov 2022 05:03:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B2ECB1F88D;
        Mon,  7 Nov 2022 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667826235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTn7/SAeZYQ9A1ia+jwBalu/+LDK+Hh32rrdFHW/YY0=;
        b=0CisxmA3TH5wjt/fLy49tHidA+Xs0wytYUEg+N/UQJLKqIla4ScDLQux9ziOklaH0rf0ak
        N4xa7cy4yuh2sRr+htB90Nca+LrBDGU7kHAczn9aYNY5pg97D0uhMx//VwzDYVGcpEuYPk
        ys5Jgu34ado06GYGfumQkER00qGXUMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667826235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTn7/SAeZYQ9A1ia+jwBalu/+LDK+Hh32rrdFHW/YY0=;
        b=UHf76m8PDh0FNfADdCm+sa4BgvpffeaX1s3uxbF+Q2c/yxwz3tFIkkg32x99DoI+8LpI3K
        eo6ck9lrOePpQiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A29A813494;
        Mon,  7 Nov 2022 13:03:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CtyqJzsCaWPOTAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 13:03:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D58AA0704; Mon,  7 Nov 2022 14:03:55 +0100 (CET)
Date:   Mon, 7 Nov 2022 14:03:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix bad checksum after online resize
Message-ID: <20221107130355.hyg4ymvzac4l2plr@quack3>
References: <20221104083553.581928-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104083553.581928-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 04-11-22 16:35:53, Baokun Li wrote:
> When online resizing is performed twice consecutively, the error message
> "Superblock checksum does not match superblock" is displayed for the
> second time. Here's the reproducer:
> 
> 	mkfs.ext4 -F /dev/sdb 100M
> 	mount /dev/sdb /tmp/test
> 	resize2fs /dev/sdb 5G
> 	resize2fs /dev/sdb 6G
> 
> To solve this issue, we moved the update of the checksum after the
> es->s_overhead_clusters is updated.
> 
> Fixes: 026d0d27c488 ("ext4: reduce computation of overhead during resize")
> Fixes: de394a86658f ("ext4: update s_overhead_clusters in the superblock during an on-line resize")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Indeed. Good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/resize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 6dfe9ccae0c5..32fbfc173571 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1471,8 +1471,6 @@ static void ext4_update_super(struct super_block *sb,
>  	 * active. */
>  	ext4_r_blocks_count_set(es, ext4_r_blocks_count(es) +
>  				reserved_blocks);
> -	ext4_superblock_csum_set(sb);
> -	unlock_buffer(sbi->s_sbh);
>  
>  	/* Update the free space counts */
>  	percpu_counter_add(&sbi->s_freeclusters_counter,
> @@ -1508,6 +1506,8 @@ static void ext4_update_super(struct super_block *sb,
>  		ext4_calculate_overhead(sb);
>  	es->s_overhead_clusters = cpu_to_le32(sbi->s_overhead);
>  
> +	ext4_superblock_csum_set(sb);
> +	unlock_buffer(sbi->s_sbh);
>  	if (test_opt(sb, DEBUG))
>  		printk(KERN_DEBUG "EXT4-fs: added group %u:"
>  		       "%llu blocks(%llu free %llu reserved)\n", flex_gd->count,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
