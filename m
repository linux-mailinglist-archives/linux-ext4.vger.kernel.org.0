Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5CE7CF741
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjJSLoo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjJSLoo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 07:44:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C823A12F;
        Thu, 19 Oct 2023 04:44:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE88C1F38C;
        Thu, 19 Oct 2023 11:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697715879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efj53zL1rdLnd7W+qZoipaW+aReVa2FuAUE+fELztug=;
        b=h881vF6RySHtKPG75Fdo4HrIUgPdtPtnjzwnPiBQDnxmjTPDnWXpqc3bEryndNmbMhitPO
        Iat5z7AilaYNNUpt0/U7tulr2pq9gWDPXZrG3w6XUphfZVJ9JXFVo6OXVuV96QCg1fioqc
        lQKxIy0azBpF1WBs8MyqHL2aVBoVStk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697715879;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efj53zL1rdLnd7W+qZoipaW+aReVa2FuAUE+fELztug=;
        b=PiQowyEwE3OUAsgFC2SfBPGsGMJwgGg9lcpgAI4D1WlRq+p5yraFTooohj4whugNcKxhmS
        yOyFJae/lCMppqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADE27139C2;
        Thu, 19 Oct 2023 11:44:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TGiEKqcWMWVtJgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 11:44:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 23A21A06B0; Thu, 19 Oct 2023 13:44:39 +0200 (CEST)
Date:   Thu, 19 Oct 2023 13:44:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 3/4] ext4: avoid online resizing failures due to
 oversized flex bg
Message-ID: <20231019114439.45ytcripaettgpsg@quack3>
References: <20231018114221.441526-1-libaokun1@huawei.com>
 <20231018114221.441526-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018114221.441526-4-libaokun1@huawei.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.10
X-Spamd-Result: default: False [-5.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 18-10-23 19:42:20, Baokun Li wrote:
> When we online resize an ext4 filesystem with a oversized flexbg_size,
> 
>      mkfs.ext4 -F -G 67108864 $dev -b 4096 100M
>      mount $dev $dir
>      resize2fs $dev 16G
> 
> the following WARN_ON is triggered:
> ==================================================================
> WARNING: CPU: 0 PID: 427 at mm/page_alloc.c:4402 __alloc_pages+0x411/0x550
> Modules linked in: sg(E)
> CPU: 0 PID: 427 Comm: resize2fs Tainted: G  E  6.6.0-rc5+ #314
> RIP: 0010:__alloc_pages+0x411/0x550
> Call Trace:
>  <TASK>
>  __kmalloc_large_node+0xa2/0x200
>  __kmalloc+0x16e/0x290
>  ext4_resize_fs+0x481/0xd80
>  __ext4_ioctl+0x1616/0x1d90
>  ext4_ioctl+0x12/0x20
>  __x64_sys_ioctl+0xf0/0x150
>  do_syscall_64+0x3b/0x90
> ==================================================================
> 
> This is because flexbg_size is too large and the size of the new_group_data
> array to be allocated exceeds MAX_ORDER. Currently, the minimum value of
> MAX_ORDER is 8, the minimum value of PAGE_SIZE is 4096, the corresponding
> maximum number of groups that can be allocated is:
> 
>  (PAGE_SIZE << MAX_ORDER) / sizeof(struct ext4_new_group_data) ≈ 21845
> 
> And the value that is down-aligned to the power of 2 is 16384. Therefore,
> this value is defined as MAX_RESIZE_BG, and the number of groups added
> each time does not exceed this value during resizing, and is added multiple
> times to complete the online resizing. The difference is that the metadata
> in a flex_bg may be more dispersed.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/resize.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 0a57b199883c..e168a9f59600 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -218,10 +218,17 @@ struct ext4_new_flex_group_data {
>  						   in the flex group */
>  	__u16 *bg_flags;			/* block group flags of groups
>  						   in @groups */
> +	ext4_group_t resize_bg;			/* number of allocated
> +						   new_group_data */
>  	ext4_group_t count;			/* number of groups in @groups
>  						 */
>  };
>  
> +/*
> + * Avoiding memory allocation failures due to too many groups added each time.
> + */
> +#define MAX_RESIZE_BG				16384
> +
>  /*
>   * alloc_flex_gd() allocates a ext4_new_flex_group_data with size of
>   * @flexbg_size.
> @@ -236,14 +243,18 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
>  	if (flex_gd == NULL)
>  		goto out3;
>  
> -	flex_gd->count = flexbg_size;
> -	flex_gd->groups = kmalloc_array(flexbg_size,
> +	if (unlikely(flexbg_size > MAX_RESIZE_BG))
> +		flex_gd->resize_bg = MAX_RESIZE_BG;
> +	else
> +		flex_gd->resize_bg = flexbg_size;
> +
> +	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
>  					sizeof(struct ext4_new_group_data),
>  					GFP_NOFS);
>  	if (flex_gd->groups == NULL)
>  		goto out2;
>  
> -	flex_gd->bg_flags = kmalloc_array(flexbg_size, sizeof(__u16),
> +	flex_gd->bg_flags = kmalloc_array(flex_gd->resize_bg, sizeof(__u16),
>  					  GFP_NOFS);
>  	if (flex_gd->bg_flags == NULL)
>  		goto out1;
> @@ -1602,8 +1613,7 @@ static int ext4_flex_group_add(struct super_block *sb,
>  
>  static int ext4_setup_next_flex_gd(struct super_block *sb,
>  				    struct ext4_new_flex_group_data *flex_gd,
> -				    ext4_fsblk_t n_blocks_count,
> -				    unsigned int flexbg_size)
> +				    ext4_fsblk_t n_blocks_count)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct ext4_super_block *es = sbi->s_es;
> @@ -1627,7 +1637,7 @@ static int ext4_setup_next_flex_gd(struct super_block *sb,
>  	BUG_ON(last);
>  	ext4_get_group_no_and_offset(sb, n_blocks_count - 1, &n_group, &last);
>  
> -	last_group = group | (flexbg_size - 1);
> +	last_group = group | (flex_gd->resize_bg - 1);
>  	if (last_group > n_group)
>  		last_group = n_group;
>  
> @@ -2130,8 +2140,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
>  	/* Add flex groups. Note that a regular group is a
>  	 * flex group with 1 group.
>  	 */
> -	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count,
> -					      flexbg_size)) {
> +	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count)) {
>  		if (time_is_before_jiffies(last_update_time + HZ * 10)) {
>  			if (last_update_time)
>  				ext4_msg(sb, KERN_INFO,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
