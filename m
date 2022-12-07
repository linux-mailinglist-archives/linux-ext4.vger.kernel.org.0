Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0FC64633A
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 22:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLGV0L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 16:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLGV0L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 16:26:11 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470781DBE;
        Wed,  7 Dec 2022 13:26:09 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id fz10so17259734qtb.3;
        Wed, 07 Dec 2022 13:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3iVn5Pq2ve6gBz9rsR6+/e6l3RP2MHL3O878IJfOVfI=;
        b=QvblP0StWIys6WeKh/O1w1NGcZNvMa5ED4V4ajXq4SqT7fofTIqhHUkLSvI/M1WNVY
         E1P32rYuly5goAoWiHb/lvsk0zUKuZJxZlPsqNv1x2EBpalFur8kWNUwC1OrIOFHeOJe
         geWsIF1Rm7M6JAk14VEpAiPsftyBK9VZ6gF0QsqDMwsXtiLiLeDK0N+7qn1bMezRFwhf
         4wi6PSjNh6zTWTQAKeYzoBy9+9UcT/9BVE6s5yHvIt3XS3kdLgITl8QGc7L5rKLKvbVN
         PAGqW3cG8jWC4ljxDhUvSUgRACmJJ4Igk7wl6/LEHKK8W3k0DrIyM23W9B5mPdTqAAip
         fWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iVn5Pq2ve6gBz9rsR6+/e6l3RP2MHL3O878IJfOVfI=;
        b=CFvcZUwO9nNINgqsTky+/z1EMN0DaJ/NCKctFkSAX9aboG0UeUfcSN5VJCIuO6JUtb
         YyV32dJDK5Q19nlwIr+Cq+5sPTvQhXZMdKFdFrEOJqfBLzRfn3U8tj6UlAbxuddaiEL7
         WNdALJZEQUj5M0NvYdUf0DBqr3+WQiZLDclQx1qOPeiR0clsGHEdZDM0zzDFFDB6Ct7l
         8llegq0OVln+KVg+vdReVWdnfUvG4Z0ApwctKP5++2q2IYUz8b1fLQo5T8yriPm60PwV
         FJ17ibXWjKmAna9Kpxfj8C9j/O3QxGSSGp7XwvoJUiQMok35fujj+V6f3pT2NrDE6Cus
         un7A==
X-Gm-Message-State: ANoB5pmLg3x5Zw3m4hgAnbkmlpSfQTFwMOI/X7tJqu3MFrby5lY6GrxF
        hbdlFGzI5W2VLFCZ52HcDX4=
X-Google-Smtp-Source: AA0mqf6yo5wCH9D0TexETyqio3e7qF0SO2QPUuN/6AMixl3W+j3K3sD3U2N0okFXjuZMB8ra3WDpGQ==
X-Received: by 2002:a05:622a:1b89:b0:3a5:63ef:1d48 with SMTP id bp9-20020a05622a1b8900b003a563ef1d48mr84609685qtb.6.1670448368854;
        Wed, 07 Dec 2022 13:26:08 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id k26-20020ac8605a000000b0035d08c1da35sm13843485qtm.45.2022.12.07.13.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 13:26:08 -0800 (PST)
Date:   Wed, 7 Dec 2022 16:26:06 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 2/3] ext4: record error when detect abnormal
 'i_reserved_data_blocks'
Message-ID: <Y5EE7gm66eDNe9Us@debian-BULLSEYE-live-builder-AMD64>
References: <20221203025941.2661302-1-yebin@huaweicloud.com>
 <20221203025941.2661302-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203025941.2661302-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Ye Bin <yebin@huaweicloud.com>:
> From: Ye Bin <yebin10@huawei.com>
> 
> If 'i_reserved_data_blocks' is not cleared which mean something wrong with
> code, free space accounting is likely wrong, according to Jan Kara's advice
> use ext4_error() to record this abnormal let fsck to repair and also we can
> capture this issue.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 840e0a614959..41413338c05b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1387,10 +1387,10 @@ static void ext4_destroy_inode(struct inode *inode)
>  	}
>  
>  	if (EXT4_I(inode)->i_reserved_data_blocks)
> -		ext4_msg(inode->i_sb, KERN_ERR,
> -			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
> -			 inode->i_ino, EXT4_I(inode),
> -			 EXT4_I(inode)->i_reserved_data_blocks);
> +		ext4_error(inode->i_sb,
> +			"Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
> +			inode->i_ino, EXT4_I(inode),
> +			EXT4_I(inode)->i_reserved_data_blocks);

It would be better if the arguments to ext4_error after the first were aligned
under "inode->i_sb", as you had in your first version.  That's typical ext4
practice as seen earlier in this function, though this does pass checkpatch.
Otherwise, looks good.

That said, feel free to add:

Reviewed-by: Eric Whitney <enwlinux@gmail.com>


>  }
>  
>  static void init_once(void *foo)
> -- 
> 2.31.1
> 
