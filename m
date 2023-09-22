Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015C7AB2B5
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 15:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjIVNa1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Sep 2023 09:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbjIVNaL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Sep 2023 09:30:11 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0231A8;
        Fri, 22 Sep 2023 06:30:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vsdceue_1695389400;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vsdceue_1695389400)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 21:30:01 +0800
Message-ID: <7ce321e3-3250-5627-18f8-230249fbf78f@linux.alibaba.com>
Date:   Fri, 22 Sep 2023 21:29:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] generic: Add integrity tests with synchronous directio
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>
References: <87y1gy5s9c.fsf@doe.com>
 <434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ritesh,

On 2023/9/22 20:10, Ritesh Harjani (IBM) wrote:
> This test covers data & metadata integrity check with directio with
> o_sync flag and checks the file contents & size after sudden fileystem
> shutdown once the directio write is completed. ext4 directio after iomap
> conversion was broken in the sense that if the FS crashes after
> synchronous directio write, it's file size is not properly updated.
> This test adds a testcase to cover such scenario.
> 
> Man page of open says that -
> O_SYNC provides synchronized I/O file integrity completion, meaning write
> operations will flush data and all associated metadata to the underlying
> hardware
> 
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   tests/generic/471     | 45 +++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/471.out |  8 ++++++++
>   2 files changed, 53 insertions(+)
>   create mode 100755 tests/generic/471
>   create mode 100644 tests/generic/471.out
> 
> diff --git a/tests/generic/471 b/tests/generic/471
> new file mode 100755
> index 00000000..6c31cff8
> --- /dev/null
> +++ b/tests/generic/471
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 471
> +#
> +# Integrity test with DIRECT_IO & O_SYNC with sudden shutdown
> +#
> +. ./common/preamble
> +_begin_fstest auto quick shutdown
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_scratch
> +_require_scratch_shutdown
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +echo "Create a 1M file using O_DIRECT & O_SYNC"
> +xfs_io -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile > /dev/null 2>&1

Thanks for the time on this.

I'm fine with this as it's the exact regression test to
my report.

Although the original issue from our guest real workload
is actually aio + O_SYNC, but that doesn't matter for
ext4 since it will serialize the whole process of DIO
write beyond i_size with inode lock.

Yet if my understanding is correct, some other fses (e.g.
XFS) seem to be more relaxed than this, see
xfs_file_dio_write_aligned() and xfs_file_write_checks(),
so I'm not sure if we need to cover AIO cases as well,
anyway.

Thanks,
Gao Xiang

> +
> +echo "Shutdown the fs suddenly"
> +_scratch_shutdown
> +
> +echo "Cycle mount"
> +_scratch_cycle_mount
> +
> +echo "File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile
> +
> +status=0
> +exit
> diff --git a/tests/generic/471.out b/tests/generic/471.out
> new file mode 100644
> index 00000000..ae279b79
> --- /dev/null
> +++ b/tests/generic/471.out
> @@ -0,0 +1,8 @@
> +QA output created by 471
> +Create a 1M file using O_DIRECT & O_SYNC
> +Shutdown the fs suddenly
> +Cycle mount
> +File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
