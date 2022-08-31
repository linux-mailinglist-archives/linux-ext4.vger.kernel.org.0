Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3EE5A7C76
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiHaLu0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHaLuZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:50:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFAC3CBF7
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:50:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 06E212218E;
        Wed, 31 Aug 2022 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661946623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jK+gpX1tkQb/+g64yDyNpxSmzjZp3VSR687XuTU6ll0=;
        b=E1tij3qpmO2kJjMYvZ+NIc976EnKGhP12uFJjO/5d9kwg+qdKhxBkFcIznyMV4JW4JnNPf
        3QKLHWKurRKCkG4e1ioVboIko0Fg3+ekje4+idrMcFO4R+ch8MRfLR9nqKxwE8ro3VkSOY
        O6dcXTWhs23oNtwWiYP+mvu9f1UX8GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661946623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jK+gpX1tkQb/+g64yDyNpxSmzjZp3VSR687XuTU6ll0=;
        b=PtobloW+7GBZrXvd+vBUUAn6xoE/i31+49cUte2bzNTZgiW0W00hUFJdoFgcPTfo3h1C0d
        0rqCaJNLU6m/5vAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8926F1332D;
        Wed, 31 Aug 2022 11:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jzF4If5KD2M7CQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:50:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 94E61A067B; Wed, 31 Aug 2022 13:50:21 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:50:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 07/13] ext4: factor out ext4_encoding_init()
Message-ID: <20220831115021.3xrmazefuefhzq3z@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-8-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-8-yanaijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:05, Jason Yan wrote:
> Factor out ext4_encoding_init(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 80 +++++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 458d146149b2..9ee27472b802 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4521,6 +4521,48 @@ static int ext4_inode_info_init(struct super_block *sb,
>  	return 0;
>  }
>  
> +static int ext4_encoding_init(struct super_block *sb, struct ext4_super_block *es)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)
> +	const struct ext4_sb_encodings *encoding_info;
> +	struct unicode_map *encoding;
> +	__u16 encoding_flags = le16_to_cpu(es->s_encoding_flags);
> +
> +	if (!ext4_has_feature_casefold(sb) || sb->s_encoding)
> +		return 0;
> +
> +	encoding_info = ext4_sb_read_encoding(es);
> +	if (!encoding_info) {
> +		ext4_msg(sb, KERN_ERR,
> +			"Encoding requested by superblock is unknown");
> +		return -EINVAL;
> +	}
> +
> +	encoding = utf8_load(encoding_info->version);
> +	if (IS_ERR(encoding)) {
> +		ext4_msg(sb, KERN_ERR,
> +			"can't mount with superblock charset: %s-%u.%u.%u "
> +			"not supported by the kernel. flags: 0x%x.",
> +			encoding_info->name,
> +			unicode_major(encoding_info->version),
> +			unicode_minor(encoding_info->version),
> +			unicode_rev(encoding_info->version),
> +			encoding_flags);
> +		return -EINVAL;
> +	}
> +	ext4_msg(sb, KERN_INFO,"Using encoding defined by superblock: "
> +		"%s-%u.%u.%u with flags 0x%hx", encoding_info->name,
> +		unicode_major(encoding_info->version),
> +		unicode_minor(encoding_info->version),
> +		unicode_rev(encoding_info->version),
> +		encoding_flags);
> +
> +	sb->s_encoding = encoding;
> +	sb->s_encoding_flags = encoding_flags;
> +#endif
> +	return 0;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh, **group_desc;
> @@ -4678,42 +4720,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	ext4_apply_options(fc, sb);
>  
> -#if IS_ENABLED(CONFIG_UNICODE)
> -	if (ext4_has_feature_casefold(sb) && !sb->s_encoding) {
> -		const struct ext4_sb_encodings *encoding_info;
> -		struct unicode_map *encoding;
> -		__u16 encoding_flags = le16_to_cpu(es->s_encoding_flags);
> -
> -		encoding_info = ext4_sb_read_encoding(es);
> -		if (!encoding_info) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "Encoding requested by superblock is unknown");
> -			goto failed_mount;
> -		}
> -
> -		encoding = utf8_load(encoding_info->version);
> -		if (IS_ERR(encoding)) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "can't mount with superblock charset: %s-%u.%u.%u "
> -				 "not supported by the kernel. flags: 0x%x.",
> -				 encoding_info->name,
> -				 unicode_major(encoding_info->version),
> -				 unicode_minor(encoding_info->version),
> -				 unicode_rev(encoding_info->version),
> -				 encoding_flags);
> -			goto failed_mount;
> -		}
> -		ext4_msg(sb, KERN_INFO,"Using encoding defined by superblock: "
> -			 "%s-%u.%u.%u with flags 0x%hx", encoding_info->name,
> -			 unicode_major(encoding_info->version),
> -			 unicode_minor(encoding_info->version),
> -			 unicode_rev(encoding_info->version),
> -			 encoding_flags);
> -
> -		sb->s_encoding = encoding;
> -		sb->s_encoding_flags = encoding_flags;
> -	}
> -#endif
> +	if (ext4_encoding_init(sb, es))
> +		goto failed_mount;
>  
>  	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
>  		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!\n");
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
