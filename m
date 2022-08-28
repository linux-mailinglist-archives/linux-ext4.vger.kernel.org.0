Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA55A3B18
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Aug 2022 04:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiH1CtN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Aug 2022 22:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiH1CtM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Aug 2022 22:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8399C2ED51
        for <linux-ext4@vger.kernel.org>; Sat, 27 Aug 2022 19:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661654950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=68X0zg3NEM88zYos+dzftqhh6Zlx3yOU3jN3Id6tzdQ=;
        b=i1pPmL1SnqVfLmUcfD6NjbVw6INVBlY2YY8RdpbMb1ARZbxKssvbBlAnJdtiIj+EeQ1hM/
        m/85DZjd4dlqmsJgWYAKCGmNDqZQK/UYt18Z8Ucaz3KxyK0B+WNfcSWBgSFSgQuqX0XwRI
        lowu/n8SXorMenXYuWajB3xIs6bnyWo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-321-QhKmARwJM4KXGMCwexggwg-1; Sat, 27 Aug 2022 22:49:07 -0400
X-MC-Unique: QhKmARwJM4KXGMCwexggwg-1
Received: by mail-qk1-f197.google.com with SMTP id w22-20020a05620a445600b006bb7f43d1cfso4106538qkp.16
        for <linux-ext4@vger.kernel.org>; Sat, 27 Aug 2022 19:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=68X0zg3NEM88zYos+dzftqhh6Zlx3yOU3jN3Id6tzdQ=;
        b=sAOfWDxITG2zde1MRBhggRkcRQmL+FsCfvRcrU4p/nPWyedmi2/WTkvjFQQUrL97ky
         OMHwtMyP4wonGaY+nXgrKJjUeIKSLVinQL3p1UkotlJIOWRrmOCIzQkJvynUisvT4hWC
         6qXBO3sDLxlyDf3ymwlk7pcQput85QB/4GkixaZgxvOpROPjIzNqqtJmIZRuS6QoQjUy
         0SFXBsPnxe2y9Oc2fsNZfiFYxyRzpyJ+FhRbRmyJVIwZtsoGWgXCL5hhSOocoGtXqyWF
         XWfx9cuZf41lCancf2nFOltlsGoOHpV8t6FYBy4WrTMPYjGz1KN4jnDWhkTZv5Fdr7Zz
         0J0w==
X-Gm-Message-State: ACgBeo3tkvnKLLwCJ0oxvQFWwRWHePPJrfEpKYBA3TEwKyXVJu2wX15E
        uewSvDwKYSx9GsdTxCpteGZxgwdf34hdzXz++xng/Cnp3Kp26VU+x3umOM51RPAl7DA+GZ7p6GD
        iijBv2RDUNheC8F1uUZdufA==
X-Received: by 2002:a05:6214:c44:b0:497:1321:b7a7 with SMTP id r4-20020a0562140c4400b004971321b7a7mr5659503qvj.16.1661654946626;
        Sat, 27 Aug 2022 19:49:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4l0x25JtgDBZhxzAsWMWgLDcUeKwiIG/3i5Z4Fb7nKFdXAJPKH9MCTErDsDpJP+sXfPb96Zw==
X-Received: by 2002:a05:6214:c44:b0:497:1321:b7a7 with SMTP id r4-20020a0562140c4400b004971321b7a7mr5659496qvj.16.1661654946364;
        Sat, 27 Aug 2022 19:49:06 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z20-20020ac87f94000000b003051ea4e7f6sm2816172qtj.48.2022.08.27.19.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 19:49:05 -0700 (PDT)
Date:   Sun, 28 Aug 2022 10:48:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org, jack@suse.cz, oliver.sang@intel.com,
        lkp@intel.com, linux-ext4@vger.kernel.org, tytso@mit.edu,
        lczerner@redhat.com
Subject: Re: [PATCH] ext4/053: Remove nouser_xattr test
Message-ID: <20220828024858.cf5awn2uksbpchb3@zlang-mailbox>
References: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 17, 2022 at 11:10:23AM +0800, Yang Xu wrote:
> Plan to remove noacl and nouser_xattr mount option in kernel because they
> are deprecated[1]. So remove nouser_xattr test in here.

What's the [1]?

We'd better to be careful when we want to remove a testing coverage. I'm not
sure if they've decided to removed this mount option, the ext4/053 is an
important test case for ext4, so I'd like to hear their opinion.

Thanks,
Zorro

> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/ext4/053 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 555e474e..5d2c478a 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -439,7 +439,6 @@ for fstype in ext2 ext3 ext4; do
>  	mnt oldalloc removed
>  	mnt orlov removed
>  	mnt -t user_xattr
> -	mnt nouser_xattr
>  
>  	if _has_kernel_config CONFIG_EXT4_FS_POSIX_ACL; then
>  		mnt -t acl
> -- 
> 2.27.0
> 

