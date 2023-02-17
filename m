Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4269AE33
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 15:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBQOk2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Feb 2023 09:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQOkX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Feb 2023 09:40:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819316D276;
        Fri, 17 Feb 2023 06:40:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 404811FDEA;
        Fri, 17 Feb 2023 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676644821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7xAoDoMi5FqPCVAZPesq05qEVXx9VGNR69gSXe/fSk=;
        b=zyYkQjS9kEijhkpEwPyWTYoLlASkqwyHvdPedIsjGdEaZYO9pNqmPNtOdvUxWkQ2RKjTa9
        lme/Ct6Ni6mdOwmgdXfZddzRJ5Qbq8pDP8jr8J5s5fDkYSIYQwAgEG0iVib78KPwAFEb+Q
        pwcP9peuCk8sx5YIVtCO2vEU1mLL3SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676644821;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v7xAoDoMi5FqPCVAZPesq05qEVXx9VGNR69gSXe/fSk=;
        b=POUlIDYcBKEVYQX84qcHBErlW/zd9udg8uhHQgAJQ261LSQvFbglAmgfBNB7MdGZKUL9YN
        RnF9LAZwWDNG7pCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3410713274;
        Fri, 17 Feb 2023 14:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jeOuDNWR72O9IwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Feb 2023 14:40:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A34CAA06E1; Fri, 17 Feb 2023 15:40:20 +0100 (CET)
Date:   Fri, 17 Feb 2023 15:40:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: extents: Modify the return value variable type and
 initialize the assignment
Message-ID: <20230217144020.pteb7wx5a7dphcvx@quack3>
References: <20230208193443.3055-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208193443.3055-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 09-02-23 03:34:43, Li kunyu wrote:
> Modify the return value variable to be consistent with the return value
> type of the function, and modify the initialization assignment. Under
> certain circumstances, the constant return value is not required.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

Hum, I don't think this really improves anything. All the functions seem to
return 0 or error code (and ext4_fallocate()) as well so the size of return
value does not really matter and we usually just use int in this case.

								Honza

> ---
>  fs/ext4/extents.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 9de1c9d1a13d..debeb2e7a162 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4676,7 +4676,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	struct inode *inode = file_inode(file);
>  	loff_t new_size = 0;
>  	unsigned int max_blocks;
> -	int ret = 0;
> +	long ret = -EOPNOTSUPP;
>  	int flags;
>  	ext4_lblk_t lblk;
>  	unsigned int blkbits = inode->i_blkbits;
> @@ -4689,13 +4689,13 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	 */
>  	if (IS_ENCRYPTED(inode) &&
>  	    (mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
> -		return -EOPNOTSUPP;
> +		return ret;
>  
>  	/* Return error if mode is not supported */
>  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
>  		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
>  		     FALLOC_FL_INSERT_RANGE))
> -		return -EOPNOTSUPP;
> +		return ret;
>  
>  	inode_lock(inode);
>  	ret = ext4_convert_inline_data(inode);
> -- 
> 2.18.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
