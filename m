Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348E45B1750
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiIHIjs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiIHIjc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:39:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A4764EF
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:39:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u22so17095396plq.12
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FbL6wbQTIIA+Tbn+IEhcdmbXS3h7pNSPA7zhMvPEliY=;
        b=UkA8q9My1o0gUvxofouecCNQyUvkIokIJy2tbzGIAGx5XDFqKrwcFWUQG5rrcAay8h
         S3vV2yzQ1NwUD0xPlrnC5U+PT8KWJOdx2MQNXInL5I5puTP/quwmArjUnKY9vnhGvSnb
         cvadn32jzVljiUYXNSi1Mq1H2iHAp/iSKh7TGtPZ2/WMtkpvfvykfCyKvTAec9SR7Lkz
         8Hji8lNQ5l116YF5c7I69PGsfKyUbFpKwAGfTmtSvjfsq19V4Xx5ShH7tr3FBTTJ0cwy
         e1SEOXhfOy8QOCk8ADG+TmdUfi1rO79S/d71ZzlVLkakOr8jRzrCcbL9MZexjAWWZo//
         h01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FbL6wbQTIIA+Tbn+IEhcdmbXS3h7pNSPA7zhMvPEliY=;
        b=JdZaC7cAianXlgyiK/Wkq9lHu+2FfNImgQbsIn1z2m9ySxEXOQxpEhJoTdxfLeer9i
         IFXpsYwYCnqk54I3nBvkyuk+RR4OvvmfIahTnRl1sWjaxvQyYFP6Zn235Px4Uq/ZjOzE
         QLrZWIOI+5zX90uEpUSP1RaPpH2nknDe1T/EKG/Rl1kMFlPacXgSwmaMEX0T1IK2XyHI
         eR5oX3ZYO/8nFl6rN2nabQRCi0DO13VrVdxOhbqm6Dhv0Dv/8xjcqvrdONZ5rkla4vze
         hP4M8Fd5iejCNzPq0OBOv+ksnlkWqlXTZ/OZ0nTD2OPGugOP+wVlKPJiKcyN2prSkZQI
         GbEw==
X-Gm-Message-State: ACgBeo0vf9Dy4TgkAW+kwGyZIN2pEuYt5oasob0OPK1CLpOOuZr+Ysoh
        3LCkTD4Xkkz66+UAVHKX0eo=
X-Google-Smtp-Source: AA6agR7XXnP0j/aQoxJS3UnCeHHtKWkL8ol2vS82+gWBOtvDXBzIpOA8ZoGn8wDnX2I4RxGeN6oZHw==
X-Received: by 2002:a17:90b:1c11:b0:202:5301:a820 with SMTP id oc17-20020a17090b1c1100b002025301a820mr3095471pjb.193.1662626368311;
        Thu, 08 Sep 2022 01:39:28 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id w24-20020aa79558000000b0053725e331a1sm14019586pfq.82.2022.09.08.01.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:39:27 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:09:22 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 01/13] ext4: goto right label 'failed_mount3a'
Message-ID: <20220908083922.cbwpwp7lmr3wqco3@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-2-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-2-yanaijie@huawei.com>
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
> Before these two branches neither loaded the journal nor created the
> xattr cache. So the right label to goto is 'failed_mount3a'. Although
> this did not cause any issues because the error handler validated if the
> pointer is null. However this still made me confused when reading
> the code. So it's still worth to modify to goto the right label.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

This looks good to me. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9a66abcca1a8..6126da867b26 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5079,30 +5079,30 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		   ext4_has_feature_journal_needs_recovery(sb)) {
>  		ext4_msg(sb, KERN_ERR, "required journal recovery "
>  		       "suppressed and not mounted read-only");
> -		goto failed_mount_wq;
> +		goto failed_mount3a;
>  	} else {
>  		/* Nojournal mode, all journal mount options are illegal */
>  		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "journal_checksum, fs mounted w/o journal");
> -			goto failed_mount_wq;
> +			goto failed_mount3a;
>  		}
>  		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "journal_async_commit, fs mounted w/o journal");
> -			goto failed_mount_wq;
> +			goto failed_mount3a;
>  		}
>  		if (sbi->s_commit_interval != JBD2_DEFAULT_MAX_COMMIT_AGE*HZ) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "commit=%lu, fs mounted w/o journal",
>  				 sbi->s_commit_interval / HZ);
> -			goto failed_mount_wq;
> +			goto failed_mount3a;
>  		}
>  		if (EXT4_MOUNT_DATA_FLAGS &
>  		    (sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
>  			ext4_msg(sb, KERN_ERR, "can't mount with "
>  				 "data=, fs mounted w/o journal");
> -			goto failed_mount_wq;
> +			goto failed_mount3a;
>  		}
>  		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
>  		clear_opt(sb, JOURNAL_CHECKSUM);
> -- 
> 2.31.1
> 
