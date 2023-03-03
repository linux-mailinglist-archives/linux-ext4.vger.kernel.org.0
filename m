Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13CD6A9492
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Mar 2023 10:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCCJzn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 04:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCCJzk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 04:55:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53BD15C98;
        Fri,  3 Mar 2023 01:55:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49EE0203FA;
        Fri,  3 Mar 2023 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677837337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qrtqDegA0tWUK1DtEqvHurlGCx5n+/cV4BubW106Fb0=;
        b=jPal0subS/FC9zNxqLHjglGSF8Ol+x3nhF5zMMtlsXBtYCkdxw4AZ9Wi9NNAqdZrC/CN+s
        VQ+jbkuy6543vAzeeNyTEqjpC+RLduOP6/vOLGpgGqg8ZVhkwL/NroNg9gZ9pB5Kpgh3mQ
        N39Av/uEBy8GHujj1Yey69RqEsOM/Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677837337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qrtqDegA0tWUK1DtEqvHurlGCx5n+/cV4BubW106Fb0=;
        b=vs0tcujqRktjKppQ84+dvpjEMjUNNYSAtGOw610lf5H0JiL/A7BM+4A6xMQuliFiZtaEhF
        uRzx0a72i02mm3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 309BE1329E;
        Fri,  3 Mar 2023 09:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2FrVCxnEAWRSewAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 03 Mar 2023 09:55:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B6869A06E5; Fri,  3 Mar 2023 10:55:36 +0100 (CET)
Date:   Fri, 3 Mar 2023 10:55:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 1/2] ext4: introduce 'update_only' parameter for
 ext4_find_inline_data_nolock()
Message-ID: <20230303095536.7h7hlpf5v54tjpbj@quack3>
References: <20230303082158.4012809-1-yebin@huaweicloud.com>
 <20230303082158.4012809-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303082158.4012809-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 03-03-23 16:21:57, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Introduce 'update_only' parameter for ext4_find_inline_data_nolock() to
> use this function to update 'inline_off' only.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Now looking at the patch maybe we could do better? The call in
ext4_write_inline_data_end() is there also only to update i_inline_off and
setting EXT4_STATE_MAY_INLINE_DATA from that call is not strictly
problematic (we are just writing new inline data so we cannot be converting
them) but not necessary either. So maybe we should instead move setting of
EXT4_STATE_MAY_INLINE_DATA into ext4_iget_extra_inode() and remove it from 
ext4_find_inline_data_nolock()? Then we won't need the 'update_only'
argument...

								Honza

> ---
>  fs/ext4/ext4.h   | 2 +-
>  fs/ext4/inline.c | 7 ++++---
>  fs/ext4/inode.c  | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 4eeb02d456a9..b073976f4bf2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3545,7 +3545,7 @@ extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
>  
>  /* inline.c */
>  extern int ext4_get_max_inline_size(struct inode *inode);
> -extern int ext4_find_inline_data_nolock(struct inode *inode);
> +extern int ext4_find_inline_data_nolock(struct inode *inode, bool update_only);
>  extern int ext4_init_inline_data(handle_t *handle, struct inode *inode,
>  				 unsigned int len);
>  extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 2b42ececa46d..0fa8f41de3de 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -126,7 +126,7 @@ int ext4_get_max_inline_size(struct inode *inode)
>   * currently only used in a code path coming form ext4_iget, before
>   * the new inode has been unlocked
>   */
> -int ext4_find_inline_data_nolock(struct inode *inode)
> +int ext4_find_inline_data_nolock(struct inode *inode, bool update_only)
>  {
>  	struct ext4_xattr_ibody_find is = {
>  		.s = { .not_found = -ENODATA, },
> @@ -159,7 +159,8 @@ int ext4_find_inline_data_nolock(struct inode *inode)
>  					(void *)ext4_raw_inode(&is.iloc));
>  		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
>  				le32_to_cpu(is.s.here->e_value_size);
> -		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
> +		if (!update_only)
> +			ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  	}
>  out:
>  	brelse(is.iloc.bh);
> @@ -761,7 +762,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>  		 * ext4_write_begin() called
>  		 * ext4_try_to_write_inline_data()
>  		 */
> -		(void) ext4_find_inline_data_nolock(inode);
> +		(void) ext4_find_inline_data_nolock(inode, false);
>  
>  		kaddr = kmap_atomic(page);
>  		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d251d705c276..6ecaa1bef9bb 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4798,7 +4798,7 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
>  	if (EXT4_INODE_HAS_XATTR_SPACE(inode)  &&
>  	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
>  		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
> -		return ext4_find_inline_data_nolock(inode);
> +		return ext4_find_inline_data_nolock(inode, false);
>  	} else
>  		EXT4_I(inode)->i_inline_off = 0;
>  	return 0;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
