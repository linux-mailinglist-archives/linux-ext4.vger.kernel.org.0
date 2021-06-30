Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761083B8682
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhF3Pwb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 11:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235726AbhF3Pwa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 11:52:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ADD9613D9;
        Wed, 30 Jun 2021 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625068201;
        bh=5Yzjf8CLoyjvsGOm15lA+iMIUx1+ykzNUDuGH7t93nU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRyP3/Cqq9HRCUeOvLZDY6IbX554ZswmHPl5Mu6cX0emYc+NB3z8CeBAXkxomc0Cb
         OAHA5f/O+SAij2py/Pjx8ITmuTtGmq0MIN2GNQEEqTZ7ZLaG3oRA5oHVs0g377HAln
         ZUl96pgUQFKZ7YejOKFlBgVRtC7IjT1xfX2u/oDCW2bBo9mQ89Z/z2DSQUpAg1tf4N
         PsaAvvKkyPwQHInrqW7UXaj/BtC++REuUt9a+glXWVjBPbga7YRd6LLKAYohTL06v2
         rxwT+AQTm70SbQQwPG5RMaM3qjA64Ao+MtCzarWUdqbJ29y9mMoxl3+w4/NFzr8IUp
         ag/HdjRW6U1dQ==
Date:   Wed, 30 Jun 2021 08:50:01 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/9] generic/031: Fix the test case for 64k blocksize
 config
Message-ID: <20210630155001.GA13743@locust>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <efd1594eeec7b893c47865ce5a94c25dc94dac28.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd1594eeec7b893c47865ce5a94c25dc94dac28.1623651783.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 14, 2021 at 11:58:09AM +0530, Ritesh Harjani wrote:
> This test fails with blocksize 64k since the test assumes 4k blocksize
> in fcollapse param. This patch fixes that and also tests for 64k
> blocksize.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/generic/031                          | 37 ++++++++++++++++++----
>  tests/generic/031.out.64k                  | 19 +++++++++++
>  tests/generic/{031.out => 031.out.default} |  0
>  3 files changed, 49 insertions(+), 7 deletions(-)
>  create mode 100644 tests/generic/031.out.64k
>  rename tests/generic/{031.out => 031.out.default} (100%)
> 
> diff --git a/tests/generic/031 b/tests/generic/031
> index db84031b..40cb23af 100755
> --- a/tests/generic/031
> +++ b/tests/generic/031
> @@ -8,6 +8,7 @@
>  # correctly written and aren't left behind causing invalidation or data
>  # corruption issues.
>  #
> +seqfull=$0
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
>  echo "QA output created by $seq"
> @@ -39,12 +40,35 @@ testfile=$SCRATCH_MNT/testfile
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  
> -$XFS_IO_PROG -f \
> -	-c "pwrite 185332 55756" \
> -	-c "fcollapse 28672 40960" \
> -	-c "pwrite 133228 63394" \
> -	-c "fcollapse 0 4096" \
> -$testfile | _filter_xfs_io
> +# fcollapse need offset and len to be multiple of blocksize for filesystems
> +# hence make this test work with 64k blocksize as well.
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +
> +rm -f $seqfull.out
> +if [ "$blksz" -eq 65536 ]; then
> +	ln -s $seq.out.64k $seqfull.out
> +else
> +	ln -s $seq.out.default $seqfull.out
> +fi
> +
> +if [[ $blksz -le 4096 ]]; then
> +	$XFS_IO_PROG -f \
> +		-c "pwrite 185332 55756" \
> +		-c "fcollapse 28672 40960" \
> +		-c "pwrite 133228 63394" \
> +		-c "fcollapse 0 4096" \
> +	$testfile | _filter_xfs_io
> +elif [[ $blksz -eq 65536 ]]; then
> +	fact=$blksz/4096

What if the blocksize is 32k?

--D

> +	$XFS_IO_PROG -f \
> +		-c "pwrite $((185332*fact + 12)) $((55756*fact + 12))" \
> +		-c "fcollapse $((28672 * fact)) $((40960 * fact))" \
> +		-c "pwrite $((133228 * fact + 12)) $((63394 * fact + 12))" \
> +		-c "fcollapse 0 $((4096 * fact))" \
> +	$testfile | _filter_xfs_io
> +else
> +	_notrun "blocksize not supported"
> +fi
>  
>  echo "==== Pre-Remount ==="
>  hexdump -C $testfile
> @@ -54,4 +78,3 @@ hexdump -C $testfile
>  
>  status=0
>  exit
> -
> diff --git a/tests/generic/031.out.64k b/tests/generic/031.out.64k
> new file mode 100644
> index 00000000..7dfcfe41
> --- /dev/null
> +++ b/tests/generic/031.out.64k
> @@ -0,0 +1,19 @@
> +QA output created by 031
> +wrote 892108/892108 bytes at offset 2965324
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1014316/1014316 bytes at offset 2131660
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +==== Pre-Remount ===
> +00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +*
> +001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> +001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> +*
> +002fdc18
> +==== Post-Remount ==
> +00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> +*
> +001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> +001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> +*
> +002fdc18
> diff --git a/tests/generic/031.out b/tests/generic/031.out.default
> similarity index 100%
> rename from tests/generic/031.out
> rename to tests/generic/031.out.default
> -- 
> 2.31.1
> 
