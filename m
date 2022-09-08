Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728265B17D4
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiIHI4d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIHI4c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:56:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF2C6526
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:56:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p18so17162771plr.8
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KejbdQs6+dFJXit6ZeWItn8sywBzSMOGF8pc20q9gjg=;
        b=Je93qBmAAHf69rledy9TBD1UqK929HpiZZu5WUHKfCEC59QgwswqKJg3fNagizWCVA
         FU/IJyqEGqX5Y+PvMQnHUnhrvH3T6pvnYlhRxy/7SUpuxXpH6tSs+CVTc4OCR3g8P+BS
         RF8+SjS5e90MskLt0sIH8bq4LpKmgmGUsJOEbXv5E+TeigX3VtHasfLWlU2MQ7c3ewfm
         t/hknqaJU8GJojdNCVhHUF/7yguwPRAZMy//HPAYiv8Fvt3faac/pnsz8/NER8rx15Pi
         0FAUZH9VjV8stQqDUWr5DI9qKJfp0Q3FzbxmBgwWHG5m+LzGckZpwv/nGgymY4KrJq/3
         F3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KejbdQs6+dFJXit6ZeWItn8sywBzSMOGF8pc20q9gjg=;
        b=gTHLB+UL1+Zd3OpzEtP649rYiQw9wtbOERwXjGtRAerhg0aSylR+0p1rn0JSbjq3tM
         zzoSXGSSrLArvx3ghwmmUav0iT1LaGuyJSPBQ9b2vW8Z04SIhx0x7vcPkts9izyIILWO
         nVyTOadOqhDfDY90StoRgg4jKu3ujmFt5ffIWTntjorJnF7v7GCYAdq4UdAywb7h1UGF
         8T1xHTj/gCZtBZSb5dXhbFPinCz6sa0GyqjWFsRtEyMYxSpFv4mo8kkdMj3JiWKfd77Q
         F3mTZipAZwMGxLZEM3kL+pWomg79ascd4mhvx4AsumFfUw9qGyG85qUAA8gm209b19Zh
         8brw==
X-Gm-Message-State: ACgBeo0TjNu6bi2z4b0peeBgwJktrtOxRgRwqRYpoaJjlnoC4GTFsGbZ
        ZpDwONJDvJkdcauv3mrFxII=
X-Google-Smtp-Source: AA6agR7zFSOK5Pg/BfWlT/tkJP+/pwaDubygRjgtB35zsSifwBO9W7jgi/9olP8g67YJFTmMmzqFbw==
X-Received: by 2002:a17:902:8d8c:b0:172:e237:9a4e with SMTP id v12-20020a1709028d8c00b00172e2379a4emr8236362plo.158.1662627390967;
        Thu, 08 Sep 2022 01:56:30 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id i14-20020a63e90e000000b0042bea8405a3sm5382140pgh.14.2022.09.08.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:56:30 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:26:25 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 07/13] ext4: factor out ext4_encoding_init()
Message-ID: <20220908085625.r3xsfvdgn7ibykt2@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-8-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-8-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/03 11:01AM, Jason Yan wrote:
> Factor out ext4_encoding_init(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 80 +++++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f8806226b796..67972b0218c0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4521,6 +4521,48 @@ static int ext4_inode_info_init(struct super_block *sb,
>  	return 0;
>  }
>  
> +static int ext4_encoding_init(struct super_block *sb, struct ext4_super_block *es)
> +{
> +#if IS_ENABLED(CONFIG_UNICODE)

How about simplying it like below.
		if (!IS_ENABLED(CONFIG_UNICODE))
			return 0;
	
		<...>	

Then we don't need #ifdef CONFIG_UNICODE

-ritesh

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
