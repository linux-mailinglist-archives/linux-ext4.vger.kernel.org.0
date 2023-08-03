Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B6176EB59
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 15:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjHCN65 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 09:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjHCN64 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 09:58:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A52170D;
        Thu,  3 Aug 2023 06:58:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6661621980;
        Thu,  3 Aug 2023 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691071133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTJxvWqtu7HdvmCpxlA8gxx5nXWxZFSZ+fc8SOhAj9s=;
        b=ttLo30NEZEAkZo+GKcUUBPX+disFG6lUUkR0EYZYYa8hYqnuRPq6sLr2SU4uoKfmROp5Ev
        EWT2MrQ44nOyQbVt1lyUN88DW9p2dyf8QbjsoL7yNMFIxSHZ9OfVNilRe+0d8yfkTwce2g
        s9L6Jonw9+JxUJDFDr8a3W3Ma4VRe2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691071133;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DTJxvWqtu7HdvmCpxlA8gxx5nXWxZFSZ+fc8SOhAj9s=;
        b=aowPEysjLXHqI0SvQT+3OCldkwdMtF9HPEooMKE1Q9JfGO4jSqr+/6aAQzv4N1OgExSdjN
        O9Ao9qJhusJ5pIDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5756F1333C;
        Thu,  3 Aug 2023 13:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tdRSFZ2yy2RjAQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 13:58:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EEF92A076B; Thu,  3 Aug 2023 15:58:52 +0200 (CEST)
Date:   Thu, 3 Aug 2023 15:58:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 3/3] ext4: avoid overlapping preallocations due to
 overflow
Message-ID: <20230803135852.w7rfvw6veyi2abxy@quack3>
References: <20230724121059.11834-1-libaokun1@huawei.com>
 <20230724121059.11834-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724121059.11834-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-07-23 20:10:59, Baokun Li wrote:
> Let's say we want to allocate 2 blocks starting from 4294966386, after
> predicting the file size, start is aligned to 4294965248, len is changed
> to 2048, then end = start + size = 0x100000000. Since end is of
> type ext4_lblk_t, i.e. uint, end is truncated to 0.
> 
> This causes (pa->pa_lstart >= end) to always hold when checking if the
> current extent to be allocated crosses already preallocated blocks, so the
> resulting ac_g_ex may cross already preallocated blocks. Hence we convert
> the end type to loff_t and use pa_logical_end() to avoid overflow.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 86bce870dc5a..78a4a24e2f57 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4222,12 +4222,13 @@ ext4_mb_pa_rb_next_iter(ext4_lblk_t new_start, ext4_lblk_t cur_start, struct rb_
>  
>  static inline void
>  ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
> -			  ext4_lblk_t start, ext4_lblk_t end)
> +			  ext4_lblk_t start, loff_t end)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_prealloc_space *tmp_pa;
> -	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +	ext4_lblk_t tmp_pa_start;
> +	loff_t tmp_pa_end;
>  	struct rb_node *iter;
>  
>  	read_lock(&ei->i_prealloc_lock);
> @@ -4236,7 +4237,7 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>  		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
>  				  pa_node.inode_node);
>  		tmp_pa_start = tmp_pa->pa_lstart;
> -		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +		tmp_pa_end = pa_logical_end(sbi, tmp_pa);
>  
>  		spin_lock(&tmp_pa->pa_lock);
>  		if (tmp_pa->pa_deleted == 0)
> @@ -4258,14 +4259,14 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>   */
>  static inline void
>  ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
> -			  ext4_lblk_t *start, ext4_lblk_t *end)
> +			  ext4_lblk_t *start, loff_t *end)
>  {
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_prealloc_space *tmp_pa = NULL, *left_pa = NULL, *right_pa = NULL;
>  	struct rb_node *iter;
> -	ext4_lblk_t new_start, new_end;
> -	ext4_lblk_t tmp_pa_start, tmp_pa_end, left_pa_end = -1, right_pa_start = -1;
> +	ext4_lblk_t new_start, tmp_pa_start, right_pa_start = -1;
> +	loff_t new_end, tmp_pa_end, left_pa_end = -1;
>  
>  	new_start = *start;
>  	new_end = *end;
> @@ -4284,7 +4285,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
>  				  pa_node.inode_node);
>  		tmp_pa_start = tmp_pa->pa_lstart;
> -		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +		tmp_pa_end = pa_logical_end(sbi, tmp_pa);
>  
>  		/* PA must not overlap original request */
>  		spin_lock(&tmp_pa->pa_lock);
> @@ -4364,8 +4365,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  	}
>  
>  	if (left_pa) {
> -		left_pa_end =
> -			left_pa->pa_lstart + EXT4_C2B(sbi, left_pa->pa_len);
> +		left_pa_end = pa_logical_end(sbi, left_pa);
>  		BUG_ON(left_pa_end > ac->ac_o_ex.fe_logical);
>  	}
>  
> @@ -4404,8 +4404,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_super_block *es = sbi->s_es;
>  	int bsbits, max;
> -	ext4_lblk_t end;
> -	loff_t size, start_off;
> +	loff_t size, start_off, end;
>  	loff_t orig_size __maybe_unused;
>  	ext4_lblk_t start;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
