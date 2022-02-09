Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41F4B0057
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 23:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiBIWbn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 17:31:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiBIWbm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 17:31:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D619E00ED40;
        Wed,  9 Feb 2022 14:31:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0E9FB8239F;
        Wed,  9 Feb 2022 22:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78738C340E7;
        Wed,  9 Feb 2022 22:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644445900;
        bh=j40slmqUv3sIagsEper22JR9FyT0o6LKQDNVHq7LzHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V74HIrImbz0SCXPJIeQxgGPtU550z3QPK+pMIpUlRZ2/29271omcEDTBPW2SLHjWh
         ZiWwWTCgn8UvRE5yEEYQeTQnXyzAzGM132XKcinnTVDtQ8OPQjZ5o2idjz+AWM9yfP
         qGVj6bUSlIzC5UbCsVxGIIxAM2B3oon398vqcwkyAWE7sXr5v+lq5Uo8/gs4vLjH6g
         YCPtrlVN7S9dsJmXRWkuCLVdsZ88tMPXhiocwWppY9uumwpq84WcVG5Cs77eIvM/nn
         iZWTguBC5ngfSlNlug4EVE+dHLJHh/JHka+jF9tkQEP0BdzKJC8WCwyDB6d+BnvQaA
         lwJq1Ug28e4Eg==
Date:   Wed, 9 Feb 2022 14:31:40 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 3/6] generic/{171,172,173,174}: check
 _scratch_mkfs_sized return code
Message-ID: <20220209223140.GF8313@magnolia>
References: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
 <20220209123305.253038-4-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209123305.253038-4-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 09, 2022 at 09:33:02PM +0900, Shin'ichiro Kawasaki wrote:
> The test cases generic/{171,172,173,174} call _scratch_mkfs before
> _scratch_mkfs_sized, and they do not check return code of
> _scratch_mkfs_sized. Even if _scratch_mkfs_sized failed, _scratch_mount
> after it cannot detect the sized mkfs failure because _scratch_mkfs
> already created a file system on the device. This results in unexpected
> test condition of the test cases.
> 
> To avoid the unexpected test condition, check return code of
> _scratch_mkfs_sized in the test cases.
> 
> Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/171 | 2 +-
>  tests/generic/172 | 2 +-
>  tests/generic/173 | 2 +-
>  tests/generic/174 | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/171 b/tests/generic/171
> index fb2a6f14..f823a454 100755
> --- a/tests/generic/171
> +++ b/tests/generic/171
> @@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
>  if [ $sz_bytes -lt $((32 * 1048576)) ]; then
>  	sz_bytes=$((32 * 1048576))
>  fi
> -_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
> +_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount >> $seqres.full 2>&1
>  rm -rf $testdir
>  mkdir $testdir
> diff --git a/tests/generic/172 b/tests/generic/172
> index ab5122fa..383824b9 100755
> --- a/tests/generic/172
> +++ b/tests/generic/172
> @@ -40,7 +40,7 @@ umount $SCRATCH_MNT
>  
>  file_size=$((768 * 1024 * 1024))
>  fs_size=$((1024 * 1024 * 1024))
> -_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
> +_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount >> $seqres.full 2>&1
>  rm -rf $testdir
>  mkdir $testdir
> diff --git a/tests/generic/173 b/tests/generic/173
> index 0eb313e2..e1493278 100755
> --- a/tests/generic/173
> +++ b/tests/generic/173
> @@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
>  if [ $sz_bytes -lt $((32 * 1048576)) ]; then
>  	sz_bytes=$((32 * 1048576))
>  fi
> -_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
> +_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount >> $seqres.full 2>&1
>  rm -rf $testdir
>  mkdir $testdir
> diff --git a/tests/generic/174 b/tests/generic/174
> index 1505453e..c7a177b8 100755
> --- a/tests/generic/174
> +++ b/tests/generic/174
> @@ -43,7 +43,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
>  if [ $sz_bytes -lt $((32 * 1048576)) ]; then
>  	sz_bytes=$((32 * 1048576))
>  fi
> -_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
> +_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
>  _scratch_mount >> $seqres.full 2>&1
>  rm -rf $testdir
>  mkdir $testdir
> -- 
> 2.34.1
> 
