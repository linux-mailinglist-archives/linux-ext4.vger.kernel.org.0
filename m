Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65D33DCC8A
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Aug 2021 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhHAQAh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Aug 2021 12:00:37 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:43470 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhHAQAZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Aug 2021 12:00:25 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07865121|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.427253-0.00360999-0.569137;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Ktt9fTh_1627833615;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Ktt9fTh_1627833615)
          by smtp.aliyun-inc.com(10.147.41.143);
          Mon, 02 Aug 2021 00:00:15 +0800
Date:   Mon, 2 Aug 2021 00:00:14 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCHv2 5/9] generic/031: Fix the test case for 64k blocksize
 config
Message-ID: <YQbFDtq9aDA7Ql1j@desktop>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
 <c37a4cfb8a50d2df68369d66ef6e1ebf6533e3ea.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37a4cfb8a50d2df68369d66ef6e1ebf6533e3ea.1626844259.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 21, 2021 at 10:57:58AM +0530, Ritesh Harjani wrote:
> This test fails with blocksize 64k since the test assumes 4k blocksize
> in fcollapse param. This patch fixes that and also tests for 64k
> blocksize.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/generic/031     | 14 +++++++++-----
>  tests/generic/031.out | 16 ++++++++--------
>  2 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/generic/031 b/tests/generic/031
> index 313ce9ff..11961c54 100755
> --- a/tests/generic/031
> +++ b/tests/generic/031
> @@ -26,11 +26,16 @@ testfile=$SCRATCH_MNT/testfile
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  
> +# fcollapse need offset and len to be multiple of blocksize for filesystems
> +# So let's make the offsets and len required for fcollapse multiples of 64K
> +# so that it works for all configurations (including on dax on 64K page size
> +# systems)
> +fact=$((65536/4096))
>  $XFS_IO_PROG -f \
> -	-c "pwrite 185332 55756" \
> -	-c "fcollapse 28672 40960" \
> -	-c "pwrite 133228 63394" \
> -	-c "fcollapse 0 4096" \
> +	-c "pwrite $((185332*fact + 12)) $((55756*fact + 12))" \

Where does this 12 come from? And I'm wondering if this still reproduces
the original bug.

And looks like that the original test setups came from a specific
fsstress or fsx run, and aimed to the specific bug, perhaps we could
require the test with <= 4k block size, and _notrun in 64k case.

Thanks,
Eryu

> +	-c "fcollapse $((28672 * fact)) $((40960 * fact))" \
> +	-c "pwrite $((133228 * fact + 12)) $((63394 * fact + 12))" \
> +	-c "fcollapse 0 $((4096 * fact))" \
>  $testfile | _filter_xfs_io
>  
>  echo "==== Pre-Remount ==="
> @@ -41,4 +46,3 @@ hexdump -C $testfile
>  
>  status=0
>  exit
> -
> diff --git a/tests/generic/031.out b/tests/generic/031.out
> index 194bfa45..7dfcfe41 100644
> --- a/tests/generic/031.out
> +++ b/tests/generic/031.out
> @@ -1,19 +1,19 @@
>  QA output created by 031
> -wrote 55756/55756 bytes at offset 185332
> +wrote 892108/892108 bytes at offset 2965324
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 63394/63394 bytes at offset 133228
> +wrote 1014316/1014316 bytes at offset 2131660
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  ==== Pre-Remount ===
>  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>  *
> -0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> -0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> +001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> +001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
>  *
> -0002fdc0
> +002fdc18
>  ==== Post-Remount ==
>  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>  *
> -0001f860  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> -0001f870  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
> +001f86c0  00 00 00 00 00 00 00 00  00 00 00 00 cd cd cd cd  |................|
> +001f86d0  cd cd cd cd cd cd cd cd  cd cd cd cd cd cd cd cd  |................|
>  *
> -0002fdc0
> +002fdc18
> -- 
> 2.31.1
