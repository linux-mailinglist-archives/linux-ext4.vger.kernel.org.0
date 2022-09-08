Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC5B5B176C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiIHIog (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiIHIod (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:44:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83600165A6
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:44:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d12so17142880plr.6
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=R1C7fa/ZFpUF9QCzNHKqUFciwjaIJ/cnmZnTXgVvbb8=;
        b=pR6gtQ31coM9+/y+Q7ArgFVcJfX2K+Ht1QjZ1msJECs4Wfjf0K45SicRJKbQSq9SUT
         QQ3mZo+3QpRqnM0I2Hvoy8SY82VPBwxBXQfZna3pT5JBsFV9WyBymvXWVIeVX4dQhcq1
         LX2bMh82VP5qjzjJjg4mjGb8pOqFn5FbZgB1BgRwaFlxV6BUZ9GT/mZlYQ18eYZsvWYX
         Yb3TdYh3gwlLNKn8v9h/tT911v3EthmmuG5pok1Lfwq83JZjZ8nIyf2AOf6em6sYLzOq
         z+JsxUXkdfKEQlFppAvvO5/tqzcMpg/AJOFSG+NwshXI2LRwzZO4Tw18qi1V28OcFCvw
         dBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=R1C7fa/ZFpUF9QCzNHKqUFciwjaIJ/cnmZnTXgVvbb8=;
        b=4s4oHxxhDIetXJoCd16Z6mk7RyjtsOo7gA7ui4l8zYjrlhim4DuaBOQfOgewXi75n9
         T45eBb4H+kBwTZs43h9nAYrGzuCwryyk6bVorgXK97OPDODf2hwbo+yVgK7QbKqxr6C8
         HTBmPU4/eXfDOeSJ9IXsTt+nAOSSPA/4scs+lMuCtklaeZl35iIKGoPUm4/3klKnOGx/
         9iKGbBsHeU354NLe5o95oB32+qQWNvAxNSy36J/dxEmvG15YV9E8P05yj8YwA/2Wm5cs
         4ZwILBBRF75N87Hfs3025bCspXTduJKgI5iCgbTbsfyEmHjsp0qVbIVH3kIFvpk/HT//
         74kA==
X-Gm-Message-State: ACgBeo1kWT9AXLB+nQENeuRVSGd/nuMYtb8YIuEuQO5C19cFYWsB6ROk
        OzQgTXRVZV9RYqwSVo7ID9CooiIlrds=
X-Google-Smtp-Source: AA6agR6P37Y7f8qZhuUiI8i28NUutVXMvIUIxPFLM6hXzM/tjkQwQjGyjVxMn6seoIeoJHX2l9giFA==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr3093337pjb.143.1662626672037;
        Thu, 08 Sep 2022 01:44:32 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id i71-20020a639d4a000000b0041b667a1b69sm12187306pgd.36.2022.09.08.01.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:44:31 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:14:26 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 03/13] ext4: factor out ext4_set_def_opts()
Message-ID: <20220908084426.w4ltd7cotudoykyw@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-4-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-4-yanaijie@huawei.com>
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
> Factor out ext4_set_def_opts(). No functional change.

       if (blocksize == PAGE_SIZE)
               set_opt(sb, DIOREAD_NOLOCK);
The patch looks good however, even this ^^ could be moved in
ext4_set_def_opts() via some refactoring.

If required you could even submit a seperate change for above. 

Otherwise this change looks good to me. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 105 ++++++++++++++++++++++++++----------------------
>  1 file changed, 56 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6fced457ba3f..7cc499a221ff 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4311,6 +4311,61 @@ static struct ext4_sb_info *ext4_alloc_sbi(struct super_block *sb)
>  	return NULL;
>  }
>  
> +static void ext4_set_def_opts(struct super_block *sb,
> +			      struct ext4_super_block *es)
> +{
> +	unsigned long def_mount_opts;
> +
> +	/* Set defaults before we parse the mount options */
> +	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
> +	set_opt(sb, INIT_INODE_TABLE);
> +	if (def_mount_opts & EXT4_DEFM_DEBUG)
> +		set_opt(sb, DEBUG);
> +	if (def_mount_opts & EXT4_DEFM_BSDGROUPS)
> +		set_opt(sb, GRPID);
> +	if (def_mount_opts & EXT4_DEFM_UID16)
> +		set_opt(sb, NO_UID32);
> +	/* xattr user namespace & acls are now defaulted on */
> +	set_opt(sb, XATTR_USER);
> +#ifdef CONFIG_EXT4_FS_POSIX_ACL
> +	set_opt(sb, POSIX_ACL);
> +#endif
> +	if (ext4_has_feature_fast_commit(sb))
> +		set_opt2(sb, JOURNAL_FAST_COMMIT);
> +	/* don't forget to enable journal_csum when metadata_csum is enabled. */
> +	if (ext4_has_metadata_csum(sb))
> +		set_opt(sb, JOURNAL_CHECKSUM);
> +
> +	if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_DATA)
> +		set_opt(sb, JOURNAL_DATA);
> +	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_ORDERED)
> +		set_opt(sb, ORDERED_DATA);
> +	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_WBACK)
> +		set_opt(sb, WRITEBACK_DATA);
> +
> +	if (le16_to_cpu(es->s_errors) == EXT4_ERRORS_PANIC)
> +		set_opt(sb, ERRORS_PANIC);
> +	else if (le16_to_cpu(es->s_errors) == EXT4_ERRORS_CONTINUE)
> +		set_opt(sb, ERRORS_CONT);
> +	else
> +		set_opt(sb, ERRORS_RO);
> +	/* block_validity enabled by default; disable with noblock_validity */
> +	set_opt(sb, BLOCK_VALIDITY);
> +	if (def_mount_opts & EXT4_DEFM_DISCARD)
> +		set_opt(sb, DISCARD);
> +
> +	if ((def_mount_opts & EXT4_DEFM_NOBARRIER) == 0)
> +		set_opt(sb, BARRIER);
> +
> +	/*
> +	 * enable delayed allocation by default
> +	 * Use -o nodelalloc to turn it off
> +	 */
> +	if (!IS_EXT3_SB(sb) && !IS_EXT2_SB(sb) &&
> +	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
> +		set_opt(sb, DELALLOC);
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh, **group_desc;
> @@ -4320,7 +4375,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	ext4_fsblk_t block;
>  	ext4_fsblk_t logical_sb_block;
>  	unsigned long offset = 0;
> -	unsigned long def_mount_opts;
>  	struct inode *root;
>  	int ret = -ENOMEM;
>  	int blocksize, clustersize;
> @@ -4420,43 +4474,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		sbi->s_csum_seed = ext4_chksum(sbi, ~0, es->s_uuid,
>  					       sizeof(es->s_uuid));
>  
> -	/* Set defaults before we parse the mount options */
> -	def_mount_opts = le32_to_cpu(es->s_default_mount_opts);
> -	set_opt(sb, INIT_INODE_TABLE);
> -	if (def_mount_opts & EXT4_DEFM_DEBUG)
> -		set_opt(sb, DEBUG);
> -	if (def_mount_opts & EXT4_DEFM_BSDGROUPS)
> -		set_opt(sb, GRPID);
> -	if (def_mount_opts & EXT4_DEFM_UID16)
> -		set_opt(sb, NO_UID32);
> -	/* xattr user namespace & acls are now defaulted on */
> -	set_opt(sb, XATTR_USER);
> -#ifdef CONFIG_EXT4_FS_POSIX_ACL
> -	set_opt(sb, POSIX_ACL);
> -#endif
> -	if (ext4_has_feature_fast_commit(sb))
> -		set_opt2(sb, JOURNAL_FAST_COMMIT);
> -	/* don't forget to enable journal_csum when metadata_csum is enabled. */
> -	if (ext4_has_metadata_csum(sb))
> -		set_opt(sb, JOURNAL_CHECKSUM);
> -
> -	if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_DATA)
> -		set_opt(sb, JOURNAL_DATA);
> -	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_ORDERED)
> -		set_opt(sb, ORDERED_DATA);
> -	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_WBACK)
> -		set_opt(sb, WRITEBACK_DATA);
> -
> -	if (le16_to_cpu(sbi->s_es->s_errors) == EXT4_ERRORS_PANIC)
> -		set_opt(sb, ERRORS_PANIC);
> -	else if (le16_to_cpu(sbi->s_es->s_errors) == EXT4_ERRORS_CONTINUE)
> -		set_opt(sb, ERRORS_CONT);
> -	else
> -		set_opt(sb, ERRORS_RO);
> -	/* block_validity enabled by default; disable with noblock_validity */
> -	set_opt(sb, BLOCK_VALIDITY);
> -	if (def_mount_opts & EXT4_DEFM_DISCARD)
> -		set_opt(sb, DISCARD);
> +	ext4_set_def_opts(sb, es);
>  
>  	sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
>  	sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
> @@ -4464,17 +4482,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
>  	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
>  
> -	if ((def_mount_opts & EXT4_DEFM_NOBARRIER) == 0)
> -		set_opt(sb, BARRIER);
> -
> -	/*
> -	 * enable delayed allocation by default
> -	 * Use -o nodelalloc to turn it off
> -	 */
> -	if (!IS_EXT3_SB(sb) && !IS_EXT2_SB(sb) &&
> -	    ((def_mount_opts & EXT4_DEFM_NODELALLOC) == 0))
> -		set_opt(sb, DELALLOC);
> -
>  	/*
>  	 * set default s_li_wait_mult for lazyinit, for the case there is
>  	 * no mount option specified.
> -- 
> 2.31.1
> 
