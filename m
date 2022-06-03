Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD053C442
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jun 2022 07:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiFCFb4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Jun 2022 01:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiFCFby (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Jun 2022 01:31:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1DC105;
        Thu,  2 Jun 2022 22:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B1D5B82153;
        Fri,  3 Jun 2022 05:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165ACC385A9;
        Fri,  3 Jun 2022 05:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654234309;
        bh=8YyKCZHbzxEnqZHzlExnBfqd010jKWg9faUnMg77rp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q74aZMr2Kej9Yw10UVIC1hk2z5sZbTv5WA2VI2kr+29+CMvJQwyJX2RtZkrjtF22F
         TtGiD/yLAkZ59IWRKG3o0DbYsW5oyYKQAS5SpnSYl81oZNZ7GFhoYBy+eCPYddKtcu
         mhPB4u786CP0WQkyBcOeTtIhWj/2icmfUCflA2pqvYhwOGoKLpXeWbYNS/9KxTf2HO
         aH1GMLlztt6EbS9M+WgeZZ0dyr/IegQZvtFEHml81lqPRhcC1OqrFQpRY1lCzlb23q
         FtvQuo7/6FmJJIgfPAnULKzZQHHLf70kCkReJDh/l3WmEZuUZBDIlOk9/nmSg8uXT5
         y5mwXsfSY0E7Q==
Date:   Fri, 3 Jun 2022 13:31:43 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4/053: update the test_dummy_encryption tests
Message-ID: <20220603053143.ud42tcsxrdkr3mj2@zlang-mailbox>
References: <20220530173044.156375-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530173044.156375-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 30, 2022 at 10:30:44AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Kernel commit 5f41fdaea63d ("ext4: only allow test_dummy_encryption when
> supported") tightened the requirements on when the test_dummy_encryption
> mount option is accepted.  Update ext4/053 accordingly.
> 
> Move the test cases to later in the file to group them with the other
> test cases that use do_mkfs to add custom mkfs options instead of using
> the "default" filesystem that the test creates at the beginning.
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: mention the commit ID now that it is merged, and add a Reviewed-by

Hi Eric,

If I don't remember wrong, it was a patchset with 2 patches. Now you only
send this patch out, do you hope to merge this one only, or merge both?

Thanks,
Zorro

> 
>  tests/ext4/053 | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/tests/ext4/053 b/tests/ext4/053
> index 187a2515..23e553c5 100755
> --- a/tests/ext4/053
> +++ b/tests/ext4/053
> @@ -511,20 +511,6 @@ for fstype in ext2 ext3 ext4; do
>  	mnt noinit_itable
>  	mnt max_dir_size_kb=4096
>  
> -	if _has_kernel_config CONFIG_FS_ENCRYPTION; then
> -		mnt test_dummy_encryption
> -		mnt test_dummy_encryption=v1
> -		mnt test_dummy_encryption=v2
> -		not_mnt test_dummy_encryption=v3
> -		not_mnt test_dummy_encryption=
> -	else
> -		mnt test_dummy_encryption ^test_dummy_encryption
> -		mnt test_dummy_encryption=v1 ^test_dummy_encryption=v1
> -		mnt test_dummy_encryption=v2 ^test_dummy_encryption=v2
> -		mnt test_dummy_encryption=v3 ^test_dummy_encryption=v3
> -		not_mnt test_dummy_encryption=
> -	fi
> -
>  	if _has_kernel_config CONFIG_FS_ENCRYPTION_INLINE_CRYPT; then
>  		mnt inlinecrypt
>  	else
> @@ -686,6 +672,27 @@ for fstype in ext2 ext3 ext4; do
>  	mnt_then_not_remount defaults jqfmt=vfsv1
>  	remount defaults grpjquota=,usrjquota= ignored
>  
> +	echo "== Testing the test_dummy_encryption option" >> $seqres.full
> +	# Since kernel commit 5f41fdaea63d ("ext4: only allow
> +	# test_dummy_encryption when supported"), the test_dummy_encryption
> +	# option is only allowed when the filesystem has the encrypt feature and
> +	# the kernel has CONFIG_FS_ENCRYPTION.  The encrypt feature requirement
> +	# implies that this option is never allowed on ext2 or ext3 mounts.
> +	if [[ $fstype == ext4 ]] && _has_kernel_config CONFIG_FS_ENCRYPTION; then
> +		do_mkfs -O encrypt $SCRATCH_DEV ${SIZE}k
> +		mnt test_dummy_encryption
> +		mnt test_dummy_encryption=v1
> +		mnt test_dummy_encryption=v2
> +		not_mnt test_dummy_encryption=bad
> +		not_mnt test_dummy_encryption=
> +		do_mkfs -O ^encrypt $SCRATCH_DEV ${SIZE}k
> +	fi
> +	not_mnt test_dummy_encryption
> +	not_mnt test_dummy_encryption=v1
> +	not_mnt test_dummy_encryption=v2
> +	not_mnt test_dummy_encryption=bad
> +	not_mnt test_dummy_encryption=
> +
>  done #for fstype in ext2 ext3 ext4; do
>  
>  $UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> 
> base-commit: d3cc66012a287b6db81aad408b6970a4a96a67da
> -- 
> 2.36.1
> 
