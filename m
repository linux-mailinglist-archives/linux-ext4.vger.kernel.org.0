Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FCD7CF692
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 13:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345337AbjJSLVs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 07:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345340AbjJSLVr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 07:21:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE94A13E;
        Thu, 19 Oct 2023 04:21:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE4161F88B;
        Thu, 19 Oct 2023 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697714502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anqeIkMaMdr1xsMDaKBggc57N5EfU/q3Lzp4OguOtUk=;
        b=d+Cb9QMI2Z/5dRjQq5wj0SkrU8n32aJbZdqwYSsrIRfgKNGk1q0vB8w7xmjGDMAmmPfi7K
        nSwWSpDXFliO3UzTVpF0kznOZ+XXKhM2DfiCQ9KVidmiVWcrWhDnjynNsmji/Wsubc5OLX
        uHPbrz8la/0wY0bczCCPz4EwlwOftI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697714502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anqeIkMaMdr1xsMDaKBggc57N5EfU/q3Lzp4OguOtUk=;
        b=2/015+ZsjJjOYpcMOPSLGERB1S65E1vCbO1EcHGnNLio/MQF9yIGhQB0OZ+Dz2YDarzg9M
        eAZTRZG2SGUJluBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DDFA3139C2;
        Thu, 19 Oct 2023 11:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id duQbNkYRMWWzGAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 11:21:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 519BDA06B0; Thu, 19 Oct 2023 13:21:42 +0200 (CEST)
Date:   Thu, 19 Oct 2023 13:21:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 1/4] ext4: unify the type of flexbg_size to unsigned int
Message-ID: <20231019112142.4s6jebebztqaunnt@quack3>
References: <20231018114221.441526-1-libaokun1@huawei.com>
 <20231018114221.441526-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018114221.441526-2-libaokun1@huawei.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.00
X-Spamd-Result: default: False [-1.00 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_SPAM(5.10)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 18-10-23 19:42:18, Baokun Li wrote:
> The maximum value of flexbg_size is 2^31, but the maximum value of int
> is (2^31 - 1), so overflow may occur when the type of flexbg_size is
> declared as int.
> 
> For example, when uninit_mask is initialized in ext4_alloc_group_tables(),
> if flexbg_size == 2^31, the initialized uninit_mask is incorrect, and this
> may causes set_flexbg_block_bitmap() to trigger a BUG_ON().
> 
> Therefore, the flexbg_size type is declared as unsigned int to avoid
> overflow and memory waste.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/resize.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 4fe061edefdd..c6d4539d4c1f 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -228,7 +228,7 @@ struct ext4_new_flex_group_data {
>   *
>   * Returns NULL on failure otherwise address of the allocated structure.
>   */
> -static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned long flexbg_size)
> +static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
>  {
>  	struct ext4_new_flex_group_data *flex_gd;
>  
> @@ -283,7 +283,7 @@ static void free_flex_gd(struct ext4_new_flex_group_data *flex_gd)
>   */
>  static int ext4_alloc_group_tables(struct super_block *sb,
>  				struct ext4_new_flex_group_data *flex_gd,
> -				int flexbg_size)
> +				unsigned int flexbg_size)
>  {
>  	struct ext4_new_group_data *group_data = flex_gd->groups;
>  	ext4_fsblk_t start_blk;
> @@ -384,12 +384,12 @@ static int ext4_alloc_group_tables(struct super_block *sb,
>  		group = group_data[0].group;
>  
>  		printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
> -		       "%d groups, flexbg size is %d:\n", flex_gd->count,
> +		       "%u groups, flexbg size is %u:\n", flex_gd->count,
>  		       flexbg_size);
>  
>  		for (i = 0; i < flex_gd->count; i++) {
>  			ext4_debug(
> -			       "adding %s group %u: %u blocks (%d free, %d mdata blocks)\n",
> +			       "adding %s group %u: %u blocks (%u free, %u mdata blocks)\n",
>  			       ext4_bg_has_super(sb, group + i) ? "normal" :
>  			       "no-super", group + i,
>  			       group_data[i].blocks_count,
> @@ -1606,7 +1606,7 @@ static int ext4_flex_group_add(struct super_block *sb,
>  static int ext4_setup_next_flex_gd(struct super_block *sb,
>  				    struct ext4_new_flex_group_data *flex_gd,
>  				    ext4_fsblk_t n_blocks_count,
> -				    unsigned long flexbg_size)
> +				    unsigned int flexbg_size)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct ext4_super_block *es = sbi->s_es;
> @@ -1990,8 +1990,9 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
>  	ext4_fsblk_t o_blocks_count;
>  	ext4_fsblk_t n_blocks_count_retry = 0;
>  	unsigned long last_update_time = 0;
> -	int err = 0, flexbg_size = 1 << sbi->s_log_groups_per_flex;
> +	int err = 0;
>  	int meta_bg;
> +	unsigned int flexbg_size = ext4_flex_bg_size(sbi);
>  
>  	/* See if the device is actually as big as what was requested */
>  	bh = ext4_sb_bread(sb, n_blocks_count - 1, 0);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
