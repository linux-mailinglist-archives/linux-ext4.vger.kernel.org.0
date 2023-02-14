Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285EE6962A7
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Feb 2023 12:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBNLsj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Feb 2023 06:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBNLsi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Feb 2023 06:48:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9709F23659
        for <linux-ext4@vger.kernel.org>; Tue, 14 Feb 2023 03:48:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 50D0021B01;
        Tue, 14 Feb 2023 11:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676375316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bg2/Y5HERea7RV0WXY8nvEIN343mHT7k7cMGFBIts9c=;
        b=nqPnqzLqJ0jKFYvRW/2ethuZagVs9tanImTmt0IdwAgAKLk4N0GSWsMJyKvfhTONT+RY2l
        CfbrSCYZPh19hUsOFbM8EJ3xupg3QkPj/b3QJR/k5LU1vxi56uGxi5VycX0OOsYYZgTZU7
        IdCnCqAoCyBto7tSoMUoHol7a2u2Hls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676375316;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bg2/Y5HERea7RV0WXY8nvEIN343mHT7k7cMGFBIts9c=;
        b=IwqqgFszdBPCUDpHT9WVpo05p4IzpHJRw+Zto3HZgcFMCTYxIpMBb4gM7I3s9M+Jz0zro+
        7kf7226b4zrVIdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 438B313A21;
        Tue, 14 Feb 2023 11:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W/F4EBR162MWBwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Feb 2023 11:48:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D1322A06D8; Tue, 14 Feb 2023 12:48:35 +0100 (CET)
Date:   Tue, 14 Feb 2023 12:48:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v4 1/2] ext4: fix inode tree inconsistency caused by
 ENOMEM in ext4_split_extent_at
Message-ID: <20230214114835.hpjr4zgofrcp7hyy@quack3>
References: <20230213040522.3339406-1-zhanchengbin1@huawei.com>
 <20230213040522.3339406-2-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213040522.3339406-2-zhanchengbin1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-02-23 12:05:21, zhanchengbin wrote:
> If ENOMEM fails when the extent is splitting, we need to restore the length
> of the split extent.
> In the call stack of the ext4_split_extent_at function, only in
> ext4_ext_create_new_leaf will it alloc memory and change the shape of the
> extent tree,even if an ENOMEM is returned at this time, the extent tree is
> still self-consistent, Just restore the split extent lens in the function
> ext4_split_extent_at.
> 
> ext4_split_extent_at
>  ext4_ext_insert_extent
>   ext4_ext_create_new_leaf
>    1)ext4_ext_split
>      ext4_find_extent
>    2)ext4_ext_grow_indepth
>      ext4_find_extent
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> ---
>  fs/ext4/extents.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 9de1c9d1a13d..0f95e857089e 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -935,6 +935,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>  
>  		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
>  		if (IS_ERR(bh)) {
> +			EXT4_ERROR_INODE(inode, "IO error reading extent block");

Why have you added this? Usually we don't log any additional errors for IO
errors because the storage layer already reports it... Furthermore this
would potentialy panic the system / remount the fs RO which we also usually
don't do in case of IO errors, only in case of FS corruption.

								Honza

>  			ret = PTR_ERR(bh);
>  			goto err;
>  		}
> @@ -3251,7 +3252,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  		ext4_ext_mark_unwritten(ex2);
>  
>  	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> -	if (err != -ENOSPC && err != -EDQUOT)
> +	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
>  		goto out;
>  
>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
