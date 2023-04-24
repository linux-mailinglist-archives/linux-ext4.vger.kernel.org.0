Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1186ED264
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjDXQZl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Apr 2023 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjDXQZk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Apr 2023 12:25:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3DD2702;
        Mon, 24 Apr 2023 09:25:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2B78218D6;
        Mon, 24 Apr 2023 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682353537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDnzHHJLtk40MWayxtSf+dzh53e9g56MVO1vqf4UNN0=;
        b=V9SJ5QLA+9awksYj6lUK96HEi0B73RO0E9E70nJTMig7n0x4+KPxzBYipj3x1E9ztqLd5o
        Sm4abzI/D+5cDF+Dzr1RGm/7JjKvDvMep/WjVxg68pSJyixGxWY9f5UwG2tk7OoBno2WhY
        6WkTZ4d618EwCLy0NYlZS8oMMngjr6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682353537;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDnzHHJLtk40MWayxtSf+dzh53e9g56MVO1vqf4UNN0=;
        b=sUUcd+FWpB4njlgGrlN2KwDdm18sy7WLV2+E/smnhYas3uMRYS0UOv8EMRybw0KcJ+z/Cs
        grogBrftiS7eU0Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2D831390E;
        Mon, 24 Apr 2023 16:25:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1i6oK4GtRmQPCQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Apr 2023 16:25:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 303D2A0729; Mon, 24 Apr 2023 18:25:37 +0200 (CEST)
Date:   Mon, 24 Apr 2023 18:25:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, yanaijie@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix unused iterator variable warnings
Message-ID: <20230424162537.3mptpz3syqfn5u4y@quack3>
References: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420-ext4-unused-variables-super-c-v1-1-138b6db6c21c@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 20-04-23 09:51:24, Nathan Chancellor wrote:
> When CONFIG_QUOTA is disabled, there are warnings around unused iterator
> variables:
> 
>   fs/ext4/super.c: In function 'ext4_put_super':
>   fs/ext4/super.c:1262:13: error: unused variable 'i' [-Werror=unused-variable]
>    1262 |         int i, err;
>         |             ^
>   fs/ext4/super.c: In function '__ext4_fill_super':
>   fs/ext4/super.c:5200:22: error: unused variable 'i' [-Werror=unused-variable]
>    5200 |         unsigned int i;
>         |                      ^
>   cc1: all warnings being treated as errors
> 
> The kernel has updated to gnu11, allowing the variables to be declared
> within the for loop. Do so to clear up the warnings.
> 
> Fixes: dcbf87589d90 ("ext4: factor out ext4_flex_groups_free()")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 403cc0e6cd65..f16492b8c98d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1259,7 +1259,7 @@ static void ext4_put_super(struct super_block *sb)
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct ext4_super_block *es = sbi->s_es;
>  	int aborted = 0;
> -	int i, err;
> +	int err;
>  
>  	/*
>  	 * Unregister sysfs before destroying jbd2 journal.
> @@ -1311,7 +1311,7 @@ static void ext4_put_super(struct super_block *sb)
>  	ext4_flex_groups_free(sbi);
>  	ext4_percpu_param_destroy(sbi);
>  #ifdef CONFIG_QUOTA
> -	for (i = 0; i < EXT4_MAXQUOTAS; i++)
> +	for (int i = 0; i < EXT4_MAXQUOTAS; i++)
>  		kfree(get_qf_name(sb, sbi, i));
>  #endif
>  
> @@ -5197,7 +5197,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	ext4_fsblk_t logical_sb_block;
>  	struct inode *root;
>  	int ret = -ENOMEM;
> -	unsigned int i;
>  	int needs_recovery;
>  	int err = 0;
>  	ext4_group_t first_not_zeroed;
> @@ -5628,7 +5627,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  #endif
>  
>  #ifdef CONFIG_QUOTA
> -	for (i = 0; i < EXT4_MAXQUOTAS; i++)
> +	for (unsigned int i = 0; i < EXT4_MAXQUOTAS; i++)
>  		kfree(get_qf_name(sb, sbi, i));
>  #endif
>  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
> 
> ---
> base-commit: 519fe1bae7e20fc4e7f179d50b6102b49980e85d
> change-id: 20230420-ext4-unused-variables-super-c-cabda558d931
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
