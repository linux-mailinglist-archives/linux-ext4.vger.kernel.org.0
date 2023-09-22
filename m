Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2247AB4AB
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjIVPVY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Sep 2023 11:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjIVPVY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Sep 2023 11:21:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3B2A1;
        Fri, 22 Sep 2023 08:21:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D2DC433C7;
        Fri, 22 Sep 2023 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695396077;
        bh=ij9sQedXywv7LVfCQIvTYStG7bDNfL6PZxTLsZZzB1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9yDc3BjhRr/yu1b3PR4hPIdvru9iP2b+AJPBg0DxSEaKg4IMXinp529XotMQEgpk
         cBcnqjD+v+Z0CY+NLGppouJ/jJ8UjZl7Dqc+dFrspzdyp8QTxyuFT8RM15m+PvKGjx
         dIXt5Fn+CnB2Zr2IDjwAofuhzIjeFsokUMflvuLVM9VkwBbzjmCCuqV2aZIF4O9T0S
         7igJCbPdOy/x4vmm/z79Taenl570xDtWtiAflgysq9toXoWPN8cT7fl0lEFoPwb6GA
         O3gVS+18WZDyPKLhSudxzGY5xLNxNm9+nZgVFNE5xg6tSEVBVrZJ0fZBa0XIwrMAn4
         CLOpjBhEF+fHg==
Date:   Fri, 22 Sep 2023 08:21:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] generic: Add integrity tests with synchronous directio
Message-ID: <20230922152116.GA11380@frogsfrogsfrogs>
References: <87y1gy5s9c.fsf@doe.com>
 <434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 22, 2023 at 05:40:36PM +0530, Ritesh Harjani (IBM) wrote:
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
>  tests/generic/471     | 45 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/471.out |  8 ++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100755 tests/generic/471
>  create mode 100644 tests/generic/471.out
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

$XFS_IO_PROG ?

Otherwise looks good to me...

--D

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
> -- 
> 2.41.0
> 
