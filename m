Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1257525B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiGNQC0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 12:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiGNQCZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 12:02:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9649D41D29;
        Thu, 14 Jul 2022 09:02:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 342F461FD3;
        Thu, 14 Jul 2022 16:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA73DC34114;
        Thu, 14 Jul 2022 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657814543;
        bh=oWSvBAESFqN6whrCnoaeHu7ZW1P80ycyDyLO1rQ02zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bsIkNkE3Tfd3WOO2PAUrt0Hlt0RNkABhDJbiL+oX8u77LLfmKCtiElMw+CqgSOCzX
         nEj0V8o0HMkhPqjE29QUle+li9O3Nnsdno8hFA4VB89k0x0/s4EOY7Vb7Mkwk3yZZq
         yfyXZBmE0YSKLZ7eUQFs74D4W9k56xeuJ1VxCfkzhW/QIb5yUrR3Zd2v8EfkM/jCJC
         IN4jQqyLPChxePAVzn0tR7UmOoTZDvREv/SMxJzNbuwxVbVP+0kydqgejzZqCPX13c
         lpR7UVHhYTox+LQunXnnJBv5sidsA+q86gOD9QJmGPK+kFR7gHHDuY5AHJ2gfW/wBt
         E83n957zOtUEQ==
Date:   Fri, 15 Jul 2022 00:02:18 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ext4: set 256 blocks in a block group then apply
 io pressure
Message-ID: <20220714160218.6thhgyv654jlqxld@zlang-mailbox>
References: <20220713092859.3881376-1-sunke32@huawei.com>
 <20220713092859.3881376-3-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713092859.3881376-3-sunke32@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 13, 2022 at 05:28:59PM +0800, Sun Ke wrote:
> Set 256 blocks in a block group, then inject I/O pressure, it will
> trigger off kernel BUG in ext4_mb_mark_diskspace_used.
> 
> Regression test for commit a08f789d2ab5 ext4: fix bug_on
> ext4_mb_use_inode_pa.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---

This version looks good to me. I'll merge it if there's not objection
from ext4 folks.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  tests/ext4/058     | 33 +++++++++++++++++++++++++++++++++
>  tests/ext4/058.out |  2 ++
>  2 files changed, 35 insertions(+)
>  create mode 100755 tests/ext4/058
>  create mode 100644 tests/ext4/058.out
> 
> diff --git a/tests/ext4/058 b/tests/ext4/058
> new file mode 100755
> index 00000000..ddc96f30
> --- /dev/null
> +++ b/tests/ext4/058
> @@ -0,0 +1,33 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test 058
> +#
> +# Set 256 blocks in a block group, then inject I/O pressure,
> +# it will trigger off kernel BUG in ext4_mb_mark_diskspace_used
> +#
> +# Regression test for commit
> +# a08f789d2ab5 ext4: fix bug_on ext4_mb_use_inode_pa 
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# real QA test starts here
> +
> +_supported_fs ext4
> +_fixed_by_kernel_commit a08f789d2ab5 \
> +	"ext4: fix bug_on ext4_mb_use_inode_pa"
> +_require_scratch
> +
> +# set 256 blocks in a block group
> +_scratch_mkfs -g 256 >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +$FSSTRESS_PROG -d $SCRATCH_MNT/stress -n 1000 >> $seqres.full 2>&1
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/058.out b/tests/ext4/058.out
> new file mode 100644
> index 00000000..fb5ca60b
> --- /dev/null
> +++ b/tests/ext4/058.out
> @@ -0,0 +1,2 @@
> +QA output created by 058
> +Silence is golden
> -- 
> 2.13.6
> 
