Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3413E5BC9D7
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 12:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiISKtV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 06:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiISKsq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 06:48:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4029B24082
        for <linux-ext4@vger.kernel.org>; Mon, 19 Sep 2022 03:40:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E530922163;
        Mon, 19 Sep 2022 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663584031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7UMMPYj2GAY8SfZ8R6PT6d87NL+zc8yS5Ilh9QzO/Xo=;
        b=Gfy3e8OQbFFCxI+WariemdXU9TcDMSkXwW4G6c8MD2V9xKDKA8uyzjLmEBGVkn9hT7pXPT
        IJcmz3MUZQHpYuFw2V36Nvagp5ttI1PMMf4LELTYIgnRujRz1caU0pP8Vb0nGrWC3ZsUji
        VTvgWsI9YWZYFVduw+rS5HzRMxFhSEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663584031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7UMMPYj2GAY8SfZ8R6PT6d87NL+zc8yS5Ilh9QzO/Xo=;
        b=4OMHUIEOiDU4XHctKRECQ588TrObxjwFSWSuq0P4u5/Rp4aRtIPDnIJOPOFh7xa1TFdzyN
        4t5s6XiQ34ziMgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D741813A96;
        Mon, 19 Sep 2022 10:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FhqLNB9HKGNGdgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Sep 2022 10:40:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6873BA0682; Mon, 19 Sep 2022 12:40:31 +0200 (CEST)
Date:   Mon, 19 Sep 2022 12:40:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 16/16] ext4: move DIOREAD_NOLOCK setting to
 ext4_set_def_opts()
Message-ID: <20220919104031.kvtf6ks2hkxp65ej@quack3>
References: <20220916141527.1012715-1-yanaijie@huawei.com>
 <20220916141527.1012715-17-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916141527.1012715-17-yanaijie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 16-09-22 22:15:27, Jason Yan wrote:
> Now since all preparations is done, we can move the DIOREAD_NOLOCK
> setting to ext4_set_def_opts().
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 25813758a53c..8624cc30c18b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4364,6 +4364,9 @@ static void ext4_set_def_opts(struct super_block *sb,
>  	if (!IS_EXT3_SB(sb) && !IS_EXT2_SB(sb) &&
>  	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
>  		set_opt(sb, DELALLOC);
> +
> +	if (sb->s_blocksize == PAGE_SIZE)
> +		set_opt(sb, DIOREAD_NOLOCK);
>  }
>  
>  static int ext4_handle_clustersize(struct super_block *sb)
> @@ -5109,9 +5112,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	 */
>  	sbi->s_li_wait_mult = EXT4_DEF_LI_WAIT_MULT;
>  
> -	if (sb->s_blocksize == PAGE_SIZE)
> -		set_opt(sb, DIOREAD_NOLOCK);
> -
>  	if (ext4_inode_info_init(sb, es))
>  		goto failed_mount;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
