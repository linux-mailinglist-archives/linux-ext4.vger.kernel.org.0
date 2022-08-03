Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06839589242
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 20:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbiHCS2z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 14:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiHCS2y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 14:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F60E5A174
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 11:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659551332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p86hTM6P5Di2dTl4u/HxWXCtwGMcyTtc8tLlHscO3fY=;
        b=J84L+2GdLOdE3xff1pO9BdqrKYNZmcvsyZ5Bwx9hq2phwMVsMsLo8kFMc7nRalEj+TWHwE
        FcuM3mp7jKtBF2vOuIvR75a5caohvuMAIpYalqsF9Vs64g7hQKDMA38uZD0xjYlsQYYAzq
        HgGYfkh3Pj/otSh5P0SQki+x3eFya7o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-k20qqvHTNg6ZQfC6HQHAeA-1; Wed, 03 Aug 2022 14:28:51 -0400
X-MC-Unique: k20qqvHTNg6ZQfC6HQHAeA-1
Received: by mail-qt1-f197.google.com with SMTP id bp9-20020a05622a1b8900b0033921a622ccso4055829qtb.23
        for <linux-ext4@vger.kernel.org>; Wed, 03 Aug 2022 11:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p86hTM6P5Di2dTl4u/HxWXCtwGMcyTtc8tLlHscO3fY=;
        b=AM92XkqhPJpnuS8LJB/Yd2UjNGo+ou9Y2XhcxKt58SN4FcZgSTGYYnk2OxbTCY7qsM
         tjbQIZGD7iENQXA1wiWtUDfRKA4yM+y5AYsR/ihZUT+fHDTx+ClDuJT2IzQdX5iIb6tn
         izjh8LPnnIUG9hLaDM3gxXVY9JkQst5NA3NHez/3ubhpPOypqFoAv6r08DcL+OncdP3T
         vpA/J0EXsq//3YJ/Z2VXDRdcXIkn/o420aV7DUUcDGCDvSCaNEYJc31umWzRl0AnZFEB
         3x+ChvnEt19h1gY99s+hqj0U3DWd4mFn0egYxC6cV9RGcSEE8N/kzzUs2//PhQWPuC1T
         G+Ww==
X-Gm-Message-State: AJIora8Goi0CB1/KskoNoJH/+QiVhxZzDIkf5riJKGh9mBrP6Mj0Kt3W
        zgGXL4qHxmCaGMtdRhtwZCPpOKCfL+SMjLbW0zOI99n4WPvduGqbLKv41Jo2YSqrRBcSfDUuPFI
        D9Mk4l+vo7Dr+KblUotiCbg==
X-Received: by 2002:ac8:7d8f:0:b0:31f:cea:9bfd with SMTP id c15-20020ac87d8f000000b0031f0cea9bfdmr22316142qtd.513.1659551330919;
        Wed, 03 Aug 2022 11:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1unQ47sCQ+PZ0Zd8ZKLsNlZlZZdUyETuSQtdVv2kSIodxzxqNUZx5/T6B2nE4cmNQGYWD12TA==
X-Received: by 2002:ac8:7d8f:0:b0:31f:cea:9bfd with SMTP id c15-20020ac87d8f000000b0031f0cea9bfdmr22316125qtd.513.1659551330699;
        Wed, 03 Aug 2022 11:28:50 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q20-20020a37f714000000b006b8d9d53605sm3191781qkj.125.2022.08.03.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:28:50 -0700 (PDT)
Date:   Thu, 4 Aug 2022 02:28:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] common/ext4: provide custom ext4 scratch fs options
Message-ID: <20220803182843.mznuba2z7mbti4co@zlang-mailbox>
References: <165950050051.198922.13423077997881086438.stgit@magnolia>
 <165950051745.198922.6487109955066878945.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165950051745.198922.6487109955066878945.stgit@magnolia>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 02, 2022 at 09:21:57PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a _scratch_options backend for ext* so that we can inject
> pathnames to external log devices into the scratch fs mount options.
> This enables common/dm* to install block device filters, e.g. dm-error
> for stress testing.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/ext4 |   20 ++++++++++++++++++++
>  common/rc   |    3 +++
>  2 files changed, 23 insertions(+)
> 
> 
> diff --git a/common/ext4 b/common/ext4
> index 287705af..819f9786 100644
> --- a/common/ext4
> +++ b/common/ext4
> @@ -154,3 +154,23 @@ _require_scratch_richacl_ext4()
>  		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
>  	_scratch_unmount
>  }
> +
> +_scratch_ext4_options()
> +{
> +    local type=$1
> +    local log_opt=""
> +
> +    case $type in
> +    mkfs)
> +        log_opt="-J device=$SCRATCH_LOGDEV"

In _scratch_mkfs_ext4, it deals with mkfs with SCRATCH_LOGDEV:

  [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
     $mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
     mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"

So is there a conflict or duplication?

> +	;;
> +    mount)
> +	# As of kernel 5.19, the kernel mount option path parser only accepts
> +	# direct paths to block devices--the final path component cannot be a
> +	# symlink.
> +        log_opt="-o journal_path=$(realpath $SCRATCH_LOGDEV)"
> +	;;
> +    esac
> +    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> +	SCRATCH_OPTIONS="$SCRATCH_OPTIONS ${log_opt}"
> +}
> diff --git a/common/rc b/common/rc
> index dc1d65c3..b82bb36b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -178,6 +178,9 @@ _scratch_options()
>      "xfs")
>  	_scratch_xfs_options "$@"
>  	;;
> +    ext2|ext3|ext4|ext4dev)
> +	_scratch_ext4_options "$@"
> +	;;
>      esac
>  }
>  
> 

