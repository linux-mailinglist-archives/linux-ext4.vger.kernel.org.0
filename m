Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311AD5A7CE5
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 14:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiHaMG7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 08:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiHaMG6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 08:06:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B879D2B3C
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 05:06:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0F421F9EA;
        Wed, 31 Aug 2022 12:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661947612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sb0H8DxMXD7MyPLypHxfJKEFscJpyzPksQ7Qn9V+6bc=;
        b=KtTVwfRf4/f+5k7Rk/VA18I7c4rLc5oXTlgRhTX/DMUwimUd/+QRH08KQ655fU2zIjE4AK
        ONVJLbgYeVk5j+ypXM9f0X5xef/QhmCNI2o3u/quSe/emTxsKmXpMK82kLWHDEQAPraO05
        v2taifH209mqVJk3p86ZMvroc0FkFPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661947612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sb0H8DxMXD7MyPLypHxfJKEFscJpyzPksQ7Qn9V+6bc=;
        b=3NUbIRDmdzAxf0GBef9zpMe9pyBCnEhaPfKsSkvmSKRAz3ux5ibH1pdxS3fhW5vjzCqU0u
        bvHtHR24D/HCzSCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE4221332D;
        Wed, 31 Aug 2022 12:06:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u21jLtxOD2MREQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 12:06:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 52172A067B; Wed, 31 Aug 2022 14:06:52 +0200 (CEST)
Date:   Wed, 31 Aug 2022 14:06:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 13/13] ext4: factor out ext4_journal_data_check()
Message-ID: <20220831120652.rovamxbtt4ibutar@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-14-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-14-yanaijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:11, Jason Yan wrote:
> Factor out ext4_journal_data_check(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  fs/ext4/super.c | 60 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 95e70f0316db..c070d4f5ecc4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4910,6 +4910,39 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>  	return err;
>  }
>  
> +static int ext4_journal_data_check(struct super_block *sb)

Perhaps name this ext4_journal_data_mode_check()? Otherwise feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> +{
> +	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
> +		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with "
> +			    "data=journal disables delayed allocation, "
> +			    "dioread_nolock, O_DIRECT and fast_commit support!\n");
> +		/* can't mount with both data=journal and dioread_nolock. */
> +		clear_opt(sb, DIOREAD_NOLOCK);
> +		clear_opt2(sb, JOURNAL_FAST_COMMIT);
> +		if (test_opt2(sb, EXPLICIT_DELALLOC)) {
> +			ext4_msg(sb, KERN_ERR, "can't mount with "
> +				 "both data=journal and delalloc");
> +			return -EINVAL;
> +		}
> +		if (test_opt(sb, DAX_ALWAYS)) {
> +			ext4_msg(sb, KERN_ERR, "can't mount with "
> +				 "both data=journal and dax");
> +			return -EINVAL;
> +		}
> +		if (ext4_has_feature_encrypt(sb)) {
> +			ext4_msg(sb, KERN_WARNING,
> +				 "encrypted files will use data=ordered "
> +				 "instead of data journaling mode");
> +		}
> +		if (test_opt(sb, DELALLOC))
> +			clear_opt(sb, DELALLOC);
> +	} else {
> +		sb->s_iflags |= SB_I_CGROUPWB;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh;
> @@ -5033,31 +5066,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	if (ext4_encoding_init(sb, es))
>  		goto failed_mount;
>  
> -	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
> -		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!\n");
> -		/* can't mount with both data=journal and dioread_nolock. */
> -		clear_opt(sb, DIOREAD_NOLOCK);
> -		clear_opt2(sb, JOURNAL_FAST_COMMIT);
> -		if (test_opt2(sb, EXPLICIT_DELALLOC)) {
> -			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				 "both data=journal and delalloc");
> -			goto failed_mount;
> -		}
> -		if (test_opt(sb, DAX_ALWAYS)) {
> -			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				 "both data=journal and dax");
> -			goto failed_mount;
> -		}
> -		if (ext4_has_feature_encrypt(sb)) {
> -			ext4_msg(sb, KERN_WARNING,
> -				 "encrypted files will use data=ordered "
> -				 "instead of data journaling mode");
> -		}
> -		if (test_opt(sb, DELALLOC))
> -			clear_opt(sb, DELALLOC);
> -	} else {
> -		sb->s_iflags |= SB_I_CGROUPWB;
> -	}
> +	if (ext4_journal_data_check(sb))
> +		goto failed_mount;
>  
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
