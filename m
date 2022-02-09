Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4E84AE616
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 01:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiBIAf4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Feb 2022 19:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbiBIAfw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Feb 2022 19:35:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A793DC06157B;
        Tue,  8 Feb 2022 16:35:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69C87B8175F;
        Wed,  9 Feb 2022 00:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D701C004E1;
        Wed,  9 Feb 2022 00:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644366949;
        bh=SINN8rvGIdWaD570mnD1Dd9uhTxoVudJ59to5rkpYww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+NMD5X/+nPUTxTAHv/VqupB5mmHiUU2Owh5ztqO8Zr/7WGaEPDwBwfwT36astLLe
         qEjrMQW6gCtUDwZFNo6nbM4WwstfbZEPHe28xmTFQbQaOcGfDN8v2azP2LZO82wXNf
         xvGWIxrZ32NNLBvIxV3sL5L+0dY3pdCwpOnZ5ixj4YvBzzxOggb35SgpJ4WZgAuGUU
         B7YM38guhBeK4DbPgql7Th4Y1GcnQhEr0dPm3+i/JQ1+oLt03aztDf1YWSikw0TMCf
         MjtASBYZzvxjO+MiYTgqyz55b/o9JMgCu5LcjFSr6TlPJw3PxyP5XxjvJiInW0tP96
         cyyp6UCGYpEQA==
Date:   Tue, 8 Feb 2022 16:35:48 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 2/7] generic/{171,172,173,174,204}: check
 _scratch_mkfs_sized return code
Message-ID: <20220209003548.GC8288@magnolia>
References: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
 <20220207065541.232685-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207065541.232685-3-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 07, 2022 at 03:55:36PM +0900, Shin'ichiro Kawasaki wrote:
> The test cases generic/{171,172,173,174,204} call _scratch_mkfs before
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

Hm.  I wonder, are there other tests that employ this _scratch_mkfs ->
scratch_mkfs_sized sequence and need patching?

$ git grep -l _scratch_mkfs_sized | while read f; do grep -q
'_scratch_mkfs[[:space:]]' $f && echo $f; done
common/encrypt
common/rc
tests/ext4/021
tests/generic/171
tests/generic/172
tests/generic/173
tests/generic/174
tests/generic/204
tests/generic/520
tests/generic/525
tests/xfs/015

generic/520 is a false positive, and you patched the rest.  OK, good.

I wonder if the maintainer will ask for the _scratch_mkfs_sized in the
failure output, but as far as I'm concerned:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/171 | 2 +-
>  tests/generic/172 | 2 +-
>  tests/generic/173 | 2 +-
>  tests/generic/174 | 2 +-
>  tests/generic/204 | 3 ++-
>  5 files changed, 6 insertions(+), 5 deletions(-)
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
> diff --git a/tests/generic/204 b/tests/generic/204
> index a3dabb71..b5deb443 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -35,7 +35,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
>  
>  SIZE=`expr 115 \* 1024 \* 1024`
> -_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
> +_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
> +	|| _fail "mkfs failed"
>  cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  _scratch_mount
>  
> -- 
> 2.34.1
> 
