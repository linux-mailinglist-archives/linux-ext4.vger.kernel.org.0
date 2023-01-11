Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706AB6658FA
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 11:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjAKK0L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 05:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjAKK0K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 05:26:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617AFF35
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 02:26:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E3AE1173B2;
        Wed, 11 Jan 2023 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673432761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqpyc7p31idPZXlUJxRUkjnz/Qv/YNB1YeWrgc8aABk=;
        b=EzeK6AMDpDKLsaQXSTyR+it1te2CerkRULYiapJZyRug3o986MNYL8Hz3Pmlc91pJ6ReCc
        bxN7YQmHv8ZJWLoqjQRHGzLuJnEzVzmPKI6AWgs++3reFmZ7gxVad/+rYpB46Htob0bnJt
        LUwBwXnGOwJ6xXkwdg8gwSGaf/kYEU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673432761;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rqpyc7p31idPZXlUJxRUkjnz/Qv/YNB1YeWrgc8aABk=;
        b=BUY2v4yn3dadsQ4FZLottO8ohPCwRmEazvMBrW+k+x3uGnmOvt54atYFne+ir1BXh8VA+o
        UFO9VwND5OwfbRDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D726513591;
        Wed, 11 Jan 2023 10:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dLh4NLmOvmMrBQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Jan 2023 10:26:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6C958A0744; Wed, 11 Jan 2023 11:26:01 +0100 (CET)
Date:   Wed, 11 Jan 2023 11:26:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH 2/2] ext4: call ext4_handle_error when read extent failed
 in ext4_ext_insert_extent
Message-ID: <20230111102601.igx6act3cxofml53@quack3>
References: <20230110133407.994711-1-zhanchengbin1@huawei.com>
 <20230110133407.994711-3-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230110133407.994711-3-zhanchengbin1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-01-23 21:34:07, zhanchengbin wrote:
> In addition to ext4_find_extent reading extent block return
> -EIO, ext4_handle_error will be called when there is a problem that
> may cause file system inconsistency in the ext4_ext_insert_extent
> function.
> So call the ext4_handle_error function when the ext4_find_extent
> read fails，and make the filesystem read-only when mount for
> `errors=remount-ro`, and Check whether the journal is aborted in
> the ext4_split_extent_at function.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for the patch! Some comments below.

> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3559ea6b0781..3798b2a8e550 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -935,6 +935,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>  
>  		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
>  		if (IS_ERR(bh)) {
> +			EXT4_ERROR_INODE(inode, "IO error reading extent block");

So this is fine...

>  			ret = PTR_ERR(bh);
>  			goto err;
>  		}
> @@ -3251,7 +3252,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  		ext4_ext_mark_unwritten(ex2);
>  
>  	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
> -	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> +	if (err && is_handle_aborted(handle))
>  		goto out;

But this doesn't look right. Firstly, if err == 0, it will wrongly go to
the zero-out part although we should exit. Secondly, is_handle_aborted() is
not going to work for nojournal mode. So I don't think we can simplify the
condition like this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
