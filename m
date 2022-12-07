Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A36645855
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 11:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLGK6X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 05:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLGK6V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 05:58:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A6A63B8;
        Wed,  7 Dec 2022 02:58:20 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BD9121C52;
        Wed,  7 Dec 2022 10:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670410699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HOjgmp+ii/hThRxPLSbxgbWqIaU3NHdpUYrGBC2XzBw=;
        b=gUYJ7SFrmbROV1WH3iqb+Hzpyrq4mX6WbwBvLKyJKF+vgi5MdUMENF5OpUsCIut/Jy8mQ9
        gX+5uGamRNFy8HcO/8AtzqcZBZLi6jXp3Cvnia3mXPIsQfx9jlsT7uCAMkAz0ZeWTCBY/N
        DQlVrj3brmNDdKOc+e3iifJRwPaLi+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670410699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HOjgmp+ii/hThRxPLSbxgbWqIaU3NHdpUYrGBC2XzBw=;
        b=ENtuD9DoIWud3lp0szeesqKr4gSRgDrxi9zPBEKx7/nkUBQ+tMPE16+fbLDdP98sQeDgcK
        wzA1YUwj5WCeMZBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8D508134CD;
        Wed,  7 Dec 2022 10:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id U3J2IstxkGMJHQAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 10:58:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1DFF4A0725; Wed,  7 Dec 2022 11:58:19 +0100 (CET)
Date:   Wed, 7 Dec 2022 11:58:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 4/6] ext4: allocate extended attribute value in
 vmalloc area
Message-ID: <20221207105819.jmirjhh6ygknsbcm@quack3>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-5-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207074043.1286731-5-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 07-12-22 15:40:41, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, extended attribute value maxium length is 64K. The memory requested here
> does not need continuous physical addresses, so it is appropriate to use
> kvmalloc to request memory. At the same time, it can also cope with the
> situation that the extended attribute will become longer in the future.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!

								Honza

> ---
>  fs/ext4/xattr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 75287422c36c..efa623658c12 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2579,7 +2579,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>  
>  	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
>  	bs = kzalloc(sizeof(struct ext4_xattr_block_find), GFP_NOFS);
> -	buffer = kmalloc(value_size, GFP_NOFS);
> +	buffer = kvmalloc(value_size, GFP_NOFS);
>  	b_entry_name = kmalloc(entry->e_name_len + 1, GFP_NOFS);
>  	if (!is || !bs || !buffer || !b_entry_name) {
>  		error = -ENOMEM;
> @@ -2631,7 +2631,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>  	error = 0;
>  out:
>  	kfree(b_entry_name);
> -	kfree(buffer);
> +	kvfree(buffer);
>  	if (is)
>  		brelse(is->iloc.bh);
>  	if (bs)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
