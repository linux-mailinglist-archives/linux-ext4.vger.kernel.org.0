Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A776565D091
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 11:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjADKYv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 05:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjADKYt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 05:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F50519C2B
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 02:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672827843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NiO3SgefuF+bosWf/8bcuMQPzTbDxN7nPMXJv8avx24=;
        b=HZOTwKovSS29VA6QlVErQDYgn3+SsAEK3Pbc1jx5LJmOqY41LOYrZrblX1/Sx+qNN14ZTY
        tI75DaNN8Nf/LC5HFneTQ6VgXzyrva7YVfJhdFvhB0O/5ixlQZR7wPKDZ7xwWJaehFMo6x
        kzi1Xm83NcIu17vYEJl0HjYLa9+B0nY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-DilR7bcyN4mMy82Kwe5yIg-1; Wed, 04 Jan 2023 05:24:02 -0500
X-MC-Unique: DilR7bcyN4mMy82Kwe5yIg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCCCE1C08979;
        Wed,  4 Jan 2023 10:24:01 +0000 (UTC)
Received: from fedora (ovpn-192-227.brq.redhat.com [10.40.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DB0B492D8B;
        Wed,  4 Jan 2023 10:24:01 +0000 (UTC)
Date:   Wed, 4 Jan 2023 11:23:59 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] libsupport: clean up definition of flags_array
Message-ID: <20230104102359.4bfndqhuddmkqymq@fedora>
References: <20230104090323.276063-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104090323.276063-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 01:03:23AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add braces to address the following compiler warning with gcc -Wall:
> 
> print_fs_flags.c:24:42: warning: missing braces around initializer [-Wmissing-braces]
>    24 | static struct flags_name flags_array[] = {
>       |                                          ^
> 
> Also add 'const', and add an explicit NULL in the last entry.

Looks good, thanks.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/support/print_fs_flags.c | 60 ++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/lib/support/print_fs_flags.c b/lib/support/print_fs_flags.c
> index e54acc04..f47cd665 100644
> --- a/lib/support/print_fs_flags.c
> +++ b/lib/support/print_fs_flags.c
> @@ -21,40 +21,40 @@ struct flags_name {
>  	const char	*name;
>  };
>  
> -static struct flags_name flags_array[] = {
> -	EXT2_FLAG_RW, "EXT2_FLAG_RW",
> -	EXT2_FLAG_CHANGED, "EXT2_FLAG_CHANGED",
> -	EXT2_FLAG_DIRTY, "EXT2_FLAG_DIRTY",
> -	EXT2_FLAG_VALID, "EXT2_FLAG_VALID",
> -	EXT2_FLAG_IB_DIRTY, "EXT2_FLAG_IB_DIRTY",
> -	EXT2_FLAG_BB_DIRTY, "EXT2_FLAG_BB_DIRTY",
> -	EXT2_FLAG_SWAP_BYTES, "EXT2_FLAG_SWAP_BYTES",
> -	EXT2_FLAG_SWAP_BYTES_READ, "EXT2_FLAG_SWAP_BYTES_READ",
> -	EXT2_FLAG_SWAP_BYTES_WRITE, "EXT2_FLAG_SWAP_BYTES_WRITE",
> -	EXT2_FLAG_MASTER_SB_ONLY, "EXT2_FLAG_MASTER_SB_ONLY",
> -	EXT2_FLAG_FORCE, "EXT2_FLAG_FORCE",
> -	EXT2_FLAG_SUPER_ONLY, "EXT2_FLAG_SUPER_ONLY",
> -	EXT2_FLAG_JOURNAL_DEV_OK, "EXT2_FLAG_JOURNAL_DEV_OK",
> -	EXT2_FLAG_IMAGE_FILE, "EXT2_FLAG_IMAGE_FILE",
> -	EXT2_FLAG_EXCLUSIVE, "EXT2_FLAG_EXCLUSIVE",
> -	EXT2_FLAG_SOFTSUPP_FEATURES, "EXT2_FLAG_SOFTSUPP_FEATURES",
> -	EXT2_FLAG_NOFREE_ON_ERROR, "EXT2_FLAG_NOFREE_ON_ERROR",
> -	EXT2_FLAG_64BITS, "EXT2_FLAG_64BITS",
> -	EXT2_FLAG_PRINT_PROGRESS, "EXT2_FLAG_PRINT_PROGRESS",
> -	EXT2_FLAG_DIRECT_IO, "EXT2_FLAG_DIRECT_IO",
> -	EXT2_FLAG_SKIP_MMP, "EXT2_FLAG_SKIP_MMP",
> -	EXT2_FLAG_IGNORE_CSUM_ERRORS, "EXT2_FLAG_IGNORE_CSUM_ERRORS",
> -	EXT2_FLAG_SHARE_DUP, "EXT2_FLAG_SHARE_DUP",
> -	EXT2_FLAG_IGNORE_SB_ERRORS, "EXT2_FLAG_IGNORE_SB_ERRORS",
> -	EXT2_FLAG_BBITMAP_TAIL_PROBLEM, "EXT2_FLAG_BBITMAP_TAIL_PROBLEM",
> -	EXT2_FLAG_IBITMAP_TAIL_PROBLEM, "EXT2_FLAG_IBITMAP_TAIL_PROBLEM",
> -	EXT2_FLAG_THREADS, "EXT2_FLAG_THREADS",
> -	0
> +static const struct flags_name flags_array[] = {
> +	{ EXT2_FLAG_RW, "EXT2_FLAG_RW" },
> +	{ EXT2_FLAG_CHANGED, "EXT2_FLAG_CHANGED" },
> +	{ EXT2_FLAG_DIRTY, "EXT2_FLAG_DIRTY" },
> +	{ EXT2_FLAG_VALID, "EXT2_FLAG_VALID" },
> +	{ EXT2_FLAG_IB_DIRTY, "EXT2_FLAG_IB_DIRTY" },
> +	{ EXT2_FLAG_BB_DIRTY, "EXT2_FLAG_BB_DIRTY" },
> +	{ EXT2_FLAG_SWAP_BYTES, "EXT2_FLAG_SWAP_BYTES" },
> +	{ EXT2_FLAG_SWAP_BYTES_READ, "EXT2_FLAG_SWAP_BYTES_READ" },
> +	{ EXT2_FLAG_SWAP_BYTES_WRITE, "EXT2_FLAG_SWAP_BYTES_WRITE" },
> +	{ EXT2_FLAG_MASTER_SB_ONLY, "EXT2_FLAG_MASTER_SB_ONLY" },
> +	{ EXT2_FLAG_FORCE, "EXT2_FLAG_FORCE" },
> +	{ EXT2_FLAG_SUPER_ONLY, "EXT2_FLAG_SUPER_ONLY" },
> +	{ EXT2_FLAG_JOURNAL_DEV_OK, "EXT2_FLAG_JOURNAL_DEV_OK" },
> +	{ EXT2_FLAG_IMAGE_FILE, "EXT2_FLAG_IMAGE_FILE" },
> +	{ EXT2_FLAG_EXCLUSIVE, "EXT2_FLAG_EXCLUSIVE" },
> +	{ EXT2_FLAG_SOFTSUPP_FEATURES, "EXT2_FLAG_SOFTSUPP_FEATURES" },
> +	{ EXT2_FLAG_NOFREE_ON_ERROR, "EXT2_FLAG_NOFREE_ON_ERROR" },
> +	{ EXT2_FLAG_64BITS, "EXT2_FLAG_64BITS" },
> +	{ EXT2_FLAG_PRINT_PROGRESS, "EXT2_FLAG_PRINT_PROGRESS" },
> +	{ EXT2_FLAG_DIRECT_IO, "EXT2_FLAG_DIRECT_IO" },
> +	{ EXT2_FLAG_SKIP_MMP, "EXT2_FLAG_SKIP_MMP" },
> +	{ EXT2_FLAG_IGNORE_CSUM_ERRORS, "EXT2_FLAG_IGNORE_CSUM_ERRORS" },
> +	{ EXT2_FLAG_SHARE_DUP, "EXT2_FLAG_SHARE_DUP" },
> +	{ EXT2_FLAG_IGNORE_SB_ERRORS, "EXT2_FLAG_IGNORE_SB_ERRORS" },
> +	{ EXT2_FLAG_BBITMAP_TAIL_PROBLEM, "EXT2_FLAG_BBITMAP_TAIL_PROBLEM" },
> +	{ EXT2_FLAG_IBITMAP_TAIL_PROBLEM, "EXT2_FLAG_IBITMAP_TAIL_PROBLEM" },
> +	{ EXT2_FLAG_THREADS, "EXT2_FLAG_THREADS" },
> +	{ 0, NULL },
>  };
>  
>  void print_fs_flags(FILE * f, unsigned long flags)
>  {
> -	struct flags_name *fp;
> +	const struct flags_name *fp;
>  	int	first = 1, pos = 16;
>  
>  	for (fp = flags_array; fp->flag != 0; fp++) {
> -- 
> 2.39.0
> 

