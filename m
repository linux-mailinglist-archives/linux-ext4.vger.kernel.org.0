Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBEC3DCC91
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Aug 2021 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhHAQDx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Aug 2021 12:03:53 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:50424 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhHAQDx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Aug 2021 12:03:53 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1568787|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0485666-0.0247587-0.926675;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.KtsttxN_1627833823;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KtsttxN_1627833823)
          by smtp.aliyun-inc.com(10.147.43.95);
          Mon, 02 Aug 2021 00:03:43 +0800
Date:   Mon, 2 Aug 2021 00:03:43 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCHv2 7/9] generic/620: Use _mkfs_dev_blocksized to use 4k bs
Message-ID: <YQbF38FWSLX+eUm6@desktop>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
 <a7d863771ec7187a1d89e0e33aa36bb6aaa5a2a7.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d863771ec7187a1d89e0e33aa36bb6aaa5a2a7.1626844259.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 21, 2021 at 10:58:00AM +0530, Ritesh Harjani wrote:
> ext4 with 64k blocksize (passed by user config) fails with below error for
> this given test which requires dmhugedisk. Since this test anyways only
> requires 4k bs, so use _mkfs_dev_blocksized() to fix this.
> 
> <error log with 64k bs>
> mkfs.ext4: Input/output error while writing out and closing file system
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  tests/generic/620 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/620 b/tests/generic/620
> index b052376f..444e682d 100755
> --- a/tests/generic/620
> +++ b/tests/generic/620
> @@ -42,7 +42,9 @@ sectors=$((2*1024*1024*1024*17))
>  chunk_size=128
>  
>  _dmhugedisk_init $sectors $chunk_size
> -_mkfs_dev $DMHUGEDISK_DEV
> +
> +# Use 4k blocksize.
> +_mkfs_dev_blocksized 4096 $DMHUGEDISK_DEV

We run the test by forcing 4k blocksize, which could be tested in 4k
blocksize setup. Maybe it's another case that should _notrun in 64k
blocksize setup.

Thanks,
Eryu

>  _mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
>  testfile=$SCRATCH_MNT/testfile-$seq
>  
> -- 
> 2.31.1
