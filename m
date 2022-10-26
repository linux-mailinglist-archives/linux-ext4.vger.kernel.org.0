Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF0760DE59
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiJZJlv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiJZJlu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 05:41:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328BF5071F;
        Wed, 26 Oct 2022 02:41:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E61EC1F74A;
        Wed, 26 Oct 2022 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666777307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvGGmhT+mb54m/Ckk59OpGjeeAhbrk4I5c2+MnDwZWg=;
        b=XmA0pkXIS8rsBBbbiB2tx6W2pECUxZE4PFxaPFUCdHuTjR3rYaqmfQXc7OYc4e4nXSY5lK
        v9nrZ/YukMF/AULVImpWPfE3L3Z+k0jD7w+0R08DjS4dwf0/eOxRVvyxFBOdScN2CnUoN5
        da8Lw7UXv2gwE6gLH8qLpb5LF4fj3UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666777307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvGGmhT+mb54m/Ckk59OpGjeeAhbrk4I5c2+MnDwZWg=;
        b=VnGgJPbC8H2jSSi0oAZZ2Map/uj44FZMY8jbIQfJMI7supcLEFxu7XoGVhhE/11oNVv7AW
        bsSTjprbi6GI38Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3F0E13A6E;
        Wed, 26 Oct 2022 09:41:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7Wj0M9sAWWMhaAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 26 Oct 2022 09:41:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 574A8A06F9; Wed, 26 Oct 2022 11:41:47 +0200 (CEST)
Date:   Wed, 26 Oct 2022 11:41:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 3/4] ext4: add EXT4_IGET_BAD flag to prevent
 unexpected bad inode
Message-ID: <20221026094147.n3hv6bk6meafc73y@quack3>
References: <20221026042310.3839669-1-libaokun1@huawei.com>
 <20221026042310.3839669-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026042310.3839669-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 26-10-22 12:23:09, Baokun Li wrote:
> There are many places that will get unhappy (and crash) when ext4_iget()
> returns a bad inode. However, if iget the boot loader inode, allows a bad
> inode to be returned, because the inode may not be initialized. This
> mechanism can be used to bypass some checks and cause panic. To solve this
> problem, we add a special iget flag EXT4_IGET_BAD. Only with this flag
> we'd be returning bad inode from ext4_iget(), otherwise we always return
> the error code if the inode is bad inode.(suggested by Jan Kara)
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  | 3 ++-
>  fs/ext4/inode.c | 8 +++++++-
>  fs/ext4/ioctl.c | 3 ++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8d5453852f98..2b574b143bde 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2964,7 +2964,8 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  typedef enum {
>  	EXT4_IGET_NORMAL =	0,
>  	EXT4_IGET_SPECIAL =	0x0001, /* OK to iget a system inode */
> -	EXT4_IGET_HANDLE = 	0x0002	/* Inode # is from a handle */
> +	EXT4_IGET_HANDLE = 	0x0002,	/* Inode # is from a handle */
> +	EXT4_IGET_BAD =		0x0004  /* Allow to iget a bad inode */
>  } ext4_iget_flags;
>  
>  extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ae3a836dd9d7..f767340229fd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5043,8 +5043,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
>  		ext4_error_inode(inode, function, line, 0,
>  				 "casefold flag without casefold feature");
> -	brelse(iloc.bh);
> +	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
> +		ext4_error_inode(inode, function, line, 0,
> +				 "bad inode without EXT4_IGET_BAD flag");
> +		ret = -EUCLEAN;
> +		goto bad_inode;
> +	}
>  
> +	brelse(iloc.bh);
>  	unlock_new_inode(inode);
>  	return inode;
>  
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index ded535535b27..e0be8026c996 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -375,7 +375,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
>  	blkcnt_t blocks;
>  	unsigned short bytes;
>  
> -	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO, EXT4_IGET_SPECIAL);
> +	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO,
> +			EXT4_IGET_SPECIAL | EXT4_IGET_BAD);
>  	if (IS_ERR(inode_bl))
>  		return PTR_ERR(inode_bl);
>  	ei_bl = EXT4_I(inode_bl);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
