Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A00668DA90
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Feb 2023 15:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjBGOYB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Feb 2023 09:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjBGOYA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Feb 2023 09:24:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA52EC66
        for <linux-ext4@vger.kernel.org>; Tue,  7 Feb 2023 06:23:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5D9920685;
        Tue,  7 Feb 2023 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675779837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dqFLgAah+b/bJ1/bJd0kGyaplgnwIMLPj4Alb94lf4c=;
        b=WGy4zue20xBJE/xneNINHzB7UAMlD6B5lYeBtcFL4PPNuSiql7KEp6ZXZgv1REItdDSt98
        apQXGdUY6xhJyOisLFoy29WTieeR1Ea1Kotyvo7MHUPQHkQEsGf9v7y/GHBAkd4gguFRcM
        titnMTZqeH0Ik2oPKT1DkSnBlqkvYjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675779837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dqFLgAah+b/bJ1/bJd0kGyaplgnwIMLPj4Alb94lf4c=;
        b=qld5sn3ZGXR81sZ2BdywtdEZyFlL9ocnHOL9VuGKDOIzAmYrE3w6jsoqUFmpVP/n+Ag1X6
        J/CX9MyXN81lNLDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B715F139ED;
        Tue,  7 Feb 2023 14:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lt2pLP1e4mOyDAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Feb 2023 14:23:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A5BADA06D5; Tue,  7 Feb 2023 15:23:56 +0100 (CET)
Date:   Tue, 7 Feb 2023 15:23:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v3 2/2] ext4: restore len when ext4_ext_insert_extent
 failed
Message-ID: <20230207142356.frf4zzpqlh7mlwft@quack3>
References: <20230207070931.2189663-1-zhanchengbin1@huawei.com>
 <20230207070931.2189663-3-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207070931.2189663-3-zhanchengbin1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 07-02-23 15:09:31, zhanchengbin wrote:
> Inside the ext4_ext_insert_extent function, every error returned will
> not destroy the consistency of the tree. Even if it fails after changing
> half of the tree, can also ensure that the tree is self-consistent, like
> function ext4_ext_create_new_leaf.

Hum, but e.g. if ext4_ext_correct_indexes() fails, we *will* end up with
corrupted extent tree pretty much without a chance for recovery, won't we?

								Honza

> After ext4_ext_insert_extent fails, update extent status tree depends on
> the incoming split_flag. So restore the len of extent to be split when
> ext4_ext_insert_extent return failed in ext4_split_extent_at.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/extents.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3559ea6b0781..b926fef73de4 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -935,6 +935,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>  
>  		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
>  		if (IS_ERR(bh)) {
> +			EXT4_ERROR_INODE(inode, "IO error reading extent block");
>  			ret = PTR_ERR(bh);
>  			goto err;
>  		}
> @@ -3251,7 +3252,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  		ext4_ext_mark_unwritten(ex2);
>  
>  	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> -	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> +	if (!err)
>  		goto out;
>  
>  	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
