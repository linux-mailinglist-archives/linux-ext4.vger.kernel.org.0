Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22076713B60
	for <lists+linux-ext4@lfdr.de>; Sun, 28 May 2023 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjE1RsC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 May 2023 13:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjE1RsB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 May 2023 13:48:01 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF021A0
        for <linux-ext4@vger.kernel.org>; Sun, 28 May 2023 10:47:58 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b0b2eb9ecso160526785a.2
        for <linux-ext4@vger.kernel.org>; Sun, 28 May 2023 10:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685296078; x=1687888078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WGU0RnJplcxfod22NQLzdkQsB3/YMHjtjEu4J1x4cqg=;
        b=NXUHFgc4Pdv0Z4lQnO4Mr2XGSIAkvnlvMxGtU1cZj0UCwHPdRhraoVYTAvB08UP//4
         R/L2sxTMHk0CbjggDB8mwaXWIHKcg418uZSzZJAQTN4QS648qj5q97iRG+fE727UFb8b
         4L65HPkQbTwdQh7xXgWv75RVtVamZ8sW1StTwH6/jWnwPBvcCVXt6EibViqUqSsSMllv
         3mNKfkVi+wACMYSS+lXcxMo7/gqlrV5PuUPv51KmZAe4tcjSAvDbabgiYqM0L6M06MXc
         scjSvHO0WyXUUazv6M4Z4mgVDvoCFKQtEhAB09y5JNZZCKE+HZtSFkvONmrwfa8rx+Hd
         PYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685296078; x=1687888078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGU0RnJplcxfod22NQLzdkQsB3/YMHjtjEu4J1x4cqg=;
        b=hKtd0jr9gXN0DtcypP6zH06/dAEQ6j9CpPy7epQaEHmpJh1FdiZBHE5GpQBVOk5m1l
         6KceWJXjHw10w1uytV9Sx7/TJSAPjKZsTG5DAyVvzLS3t9LhAoJWjXP5U8CGreFA5xZA
         wyTU3O1GpwoLIwwHQGQumw35QzFetBeP4MrYqkxKH2tVtXLPPaZNGDJzRqcSelhFdSo9
         ry/hXztTXJT63w4qKwy80gfUwr4pQIaCHdR4LN5X8UN3c8fPDaMZrEdnViDN5snM3wse
         63TS3gkwwzcx+An+1pfu5B6l/yqqyoI1sfLZeaca/p31TEvX7NV8XPk8eCZhYwMBoiYa
         0+ZQ==
X-Gm-Message-State: AC+VfDwzrGIGmKqxDmRZnHrSVcGCBWinowqGkjCASUT4bNxUjh28/+vV
        1KjKdb6W2LghT5OY3cMPp4w=
X-Google-Smtp-Source: ACHHUZ6VmTVA05h9QkgU9fcGkSw5PTOJGaKf61xIajmZQoOuZM6Jb45OXUaZagKbSwHyPYIv0m5QVw==
X-Received: by 2002:a05:620a:880f:b0:75b:23a1:3f8 with SMTP id qj15-20020a05620a880f00b0075b23a103f8mr5543256qkn.14.1685296077863;
        Sun, 28 May 2023 10:47:57 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id d15-20020a05620a136f00b0075b00e52e3asm2748506qkl.70.2023.05.28.10.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 10:47:57 -0700 (PDT)
Date:   Sun, 28 May 2023 13:47:56 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: enable the lazy init thread when remounting
 read/write
Message-ID: <ZHOTzAzRCwaekt+9@debian-BULLSEYE-live-builder-AMD64>
References: <ZGPDX3pMMa3yg4yg@debian-BULLSEYE-live-builder-AMD64>
 <20230527035729.1001605-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527035729.1001605-1-tytso@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Theodore Ts'o <tytso@mit.edu>:
> In commit a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting
> r/w until quota is re-enabled") we defer clearing tyhe SB_RDONLY flag
> in struct super.  However, we didn't defer when we checked sb_rdonly()
> to determine the lazy itable init thread should be enabled, with the
> next result that the lazy inode table initialization would not be
> properly started.  This can cause generic/231 to fail in ext4's
> nojournal mode.
> 
> Fix this by moving when we decide to start or stop the lazy itable
> init thread to after we clear the SB_RDONLY flag when we are
> remounting the file system read/write.
> 
> Fixes a44be64bbecb ("ext4: don't clear SB_RDONLY when remounting r/w until...")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/super.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9680fe753e59..56a5d1c469fc 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6588,18 +6588,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  		}
>  	}
>  
> -	/*
> -	 * Reinitialize lazy itable initialization thread based on
> -	 * current settings
> -	 */
> -	if (sb_rdonly(sb) || !test_opt(sb, INIT_INODE_TABLE))
> -		ext4_unregister_li_request(sb);
> -	else {
> -		ext4_group_t first_not_zeroed;
> -		first_not_zeroed = ext4_has_uninit_itable(sb);
> -		ext4_register_li_request(sb, first_not_zeroed);
> -	}
> -
>  	/*
>  	 * Handle creation of system zone data early because it can fail.
>  	 * Releasing of existing data is done when we are sure remount will
> @@ -6637,6 +6625,18 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  	if (enable_rw)
>  		sb->s_flags &= ~SB_RDONLY;
>  
> +	/*
> +	 * Reinitialize lazy itable initialization thread based on
> +	 * current settings
> +	 */
> +	if (sb_rdonly(sb) || !test_opt(sb, INIT_INODE_TABLE))
> +		ext4_unregister_li_request(sb);
> +	else {
> +		ext4_group_t first_not_zeroed;
> +		first_not_zeroed = ext4_has_uninit_itable(sb);
> +		ext4_register_li_request(sb, first_not_zeroed);
> +	}
> +
>  	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
>  		ext4_stop_mmpd(sbi);
>  
> -- 
> 2.31.0
>

Hi Ted:

100/100 trials of generic/231 with nojournal passed when I used kvm-xfstests
to run it on a 6.4-rc3 kernel modified with this patch.  A complete run of the
nojournal test case also passed for me without new regressions.

So,
Tested-by: Eric Whitney <enwlinux@gmail.com>

Thanks,
Eric

