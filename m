Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BC155933B
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jun 2022 08:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiFXGRK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jun 2022 02:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiFXGRI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jun 2022 02:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C0614EA04
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 23:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656051426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zS3IsB2SxaWn7FKVotEVa/GMXmNG8HC49Y5sW0xw7I=;
        b=C08ejQauOKKxRxkdYLXwiDTj36hanX9b7PhX3MWjRA+9uhZr8oplFtXRji/i/7+uOtC8it
        GL1TTHYhLiGgEmMI+p48eWhzHk+hir2WQqazHmW+0oyr3OTcR2RGEPNpGIRyuu1v9MgLC6
        qCepvOsULh6dYh7MElOcHi4YrvBV1QI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-8oo67iV-O_yUXLNNFuEBHQ-1; Fri, 24 Jun 2022 02:17:04 -0400
X-MC-Unique: 8oo67iV-O_yUXLNNFuEBHQ-1
Received: by mail-qv1-f71.google.com with SMTP id ls8-20020a0562145f8800b0047078180732so1725066qvb.2
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 23:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8zS3IsB2SxaWn7FKVotEVa/GMXmNG8HC49Y5sW0xw7I=;
        b=Y45o7aN+SwRMVB/au7DPmTJ00ZS2gEwsWOHquTQ2QUFTMZD9Lbg/eRWFjMCuC0F0i+
         P/KDxMJr/mmUTr7fgAzx1M/e6y4IPu74UdROTDCEtqBgzsZjaSz34BcDUsh0aryttaa2
         jS+mpZXasPntxddC42hczJj539zLBHznpbwaF28Pm9Hke7ijnMT5LGSvMKb8eOr2TwzP
         cbXcuc0kDlEs7tgjvH6A3WkECd2aPChGo9MMXdSn1dMw34HvhRJi7UMvsZJwg0tc1f7k
         RGbakwKAzskZ/cHFSBY0r5tmluB2k43mqgtCcZXSKwFwPetKIaPURR+N+PA41tGM9jmT
         eFBA==
X-Gm-Message-State: AJIora+H/quUJu2uw/DK2jJtiM9O5U2ZtSyufR4nEXF93PIJ/mM89nsY
        CXy+NKOqV4jLaK1IjwGvM2ip7M0oASfdFW94dQpRqYHl0GoVXa0PpERhNpd7qPY6AwLPHk5hKwm
        xCrlAnUqUjcnXn54bJ8CJ+w==
X-Received: by 2002:ac8:5b50:0:b0:305:3275:b9bf with SMTP id n16-20020ac85b50000000b003053275b9bfmr11444075qtw.498.1656051423560;
        Thu, 23 Jun 2022 23:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vefrm2rq70JDwELgpQV2bt8QlwdFwZFZWBDiPit9fA/NxGoF8Ny8SVccrw7v0NjT1quM+67A==
X-Received: by 2002:ac8:5b50:0:b0:305:3275:b9bf with SMTP id n16-20020ac85b50000000b003053275b9bfmr11444063qtw.498.1656051423326;
        Thu, 23 Jun 2022 23:17:03 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a69d7f390csm1232878qkp.103.2022.06.23.23.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:17:02 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:16:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: Re: [xfstests PATCH v2] ext4/053: test changing
 test_dummy_encryption on remount
Message-ID: <20220624061657.snbyeebcpepwv5em@zlang-mailbox>
References: <20220623184113.330183-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623184113.330183-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 23, 2022 at 11:41:13AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The test_dummy_encryption mount option isn't supposed to be settable or
> changeable via a remount, so add test cases for this.  This is a
> regression test for a bug that was introduced in Linux v5.17 and fixed
> in v5.19-rc3 by commit 85456054e10b ("ext4: fix up test_dummy_encryption
> handling for new mount API").
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

Thanks for reminding that, I'll merge this patch this week.

> 
> v2: added info about fixing commit, and added a Reviewed-by tag
> 
>  tests/ext4/053 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 23e553c5..555e474e 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -685,6 +685,9 @@ for fstype in ext2 ext3 ext4; do
>  		mnt test_dummy_encryption=v2
>  		not_mnt test_dummy_encryption=bad
>  		not_mnt test_dummy_encryption=
> +		# Can't be set or changed on remount.
> +		mnt_then_not_remount defaults test_dummy_encryption
> +		mnt_then_not_remount test_dummy_encryption=v1 test_dummy_encryption=v2
>  		do_mkfs -O ^encrypt $SCRATCH_DEV ${SIZE}k
>  	fi
>  	not_mnt test_dummy_encryption
> 
> base-commit: 0882b0913eae6fd6d2010323da1dde0ff96bf7d4
> -- 
> 2.36.1
> 

