Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC756C036
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 20:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbiGHQQd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jul 2022 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiGHQQd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jul 2022 12:16:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1751076EB4;
        Fri,  8 Jul 2022 09:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE655B80189;
        Fri,  8 Jul 2022 16:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA8C341C0;
        Fri,  8 Jul 2022 16:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657296989;
        bh=YlKqOue3jMK+6GSQ63KXsfwr9r5EJDm+PTdC8Y8HnR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9vXjfIVWlYf3U1lgqd7oSDJUKIgDfpSOTVcLOvoa9NqDtRZGo+gnORd04jn7SwRe
         zkMjROuQo2LV7wsaiTCvtEq21UzWCCQeUTfmDNUAb2bkRUujepUzjupHV6Q5DuGdQI
         h6BoMNwe2k8xzYO5VaysU/jENYv8/fVSFnhcNuHUD03OXj79TtEJolOIqLwGAjZyQq
         f1uIgAkovhOCE832OPSBITnzxlozTN8mmR7/QdY++FuZogRNKGGs1C2XlhzeoUgiZQ
         r2iF6gnUiD+0q0lcFSEa3B6oPrYant1c97gLzvEfU7wKP9A19C6krc1O28jdokpCLg
         T5dA55cq2xQ6g==
Date:   Sat, 9 Jul 2022 00:16:24 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: resize fs after resize_inode without e2fsck
Message-ID: <20220708161624.etkxdewnje4nhmhl@zlang-mailbox>
References: <20220708112155.2639551-1-sunke32@huawei.com>
 <20220708112155.2639551-2-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708112155.2639551-2-sunke32@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 08, 2022 at 07:21:54PM +0800, Sun Ke wrote:
> Forget to run requested e2fsck after resize_inode, then resize fs, it
> will trigger off null pointer.
> 
> Regression test for commit b55c3cd102a6 ext4: add reserved GDT blocks
> check.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  tests/ext4/057     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/057.out |  2 ++
>  2 files changed, 46 insertions(+)
>  create mode 100755 tests/ext4/057
>  create mode 100644 tests/ext4/057.out
> 
> diff --git a/tests/ext4/057 b/tests/ext4/057
> new file mode 100755
> index 00000000..125f841a
> --- /dev/null
> +++ b/tests/ext4/057
> @@ -0,0 +1,44 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test 057
> +#
> +# Forget to run requested e2fsck after resize_inode, then resize fs,
> +# it will trigger off null pointer.
> +#
> +# Regression test for commit
> +# b55c3cd102a6 ext4: add reserved GDT blocks check
> +#
> +. ./common/preamble
> +_begin_fstest auto resize quick
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs ext4
> +_fixed_by_kernel_commit b55c3cd102a6 \
> +	"ext4: add reserved GDT blocks check"
> +
> +_require_scratch
> +_require_command "$TUNE2FS_PROG" tune2fs
> +_require_command "$RESIZE2FS_PROG" resize2fs
> +_require_scratch_size $((1024 * 1024)) #kB
> +
> +# set fs size 512M
> +dev_size=$((512 * 1024 * 1024))
> +_scratch_mkfs_sized $dev_size >$seqres.full 2>&1
> +
> +# forget to run requested e2fsck after resize_inode
> +$TUNE2FS_PROG -O ^resize_inode $SCRATCH_DEV >$seqres.full 2>&1

Please use appending write ">>$seqres.full", to avoid seqres.full be
overwritten.

I think we don't need to filter out the error output, we don't expect
there's an error, so if it fails, how about output errors to break
golden image (remind the testers).

> +
> +_scratch_mount
> +
> +# resize fs will trigger NULL pointer in ext4_flex_group_add
> +$RESIZE2FS_PROG $SCRATCH_DEV 1G >$seqres.full 2>&1

Appending write too...

I'm not sure what's the necessary condition to reproduce the bug. Do you
need to resize fs will trigger the bug, but after:

  # tune2fs -O ^resize_inode /dev/sda3

Then resize2fs always get:

  # resize2fs /dev/sda3 3g
  resize2fs 1.45.6 (20-Mar-2020)
  Please run 'e2fsck -f /dev/sda3' first.

Looks like the resizing isn't run actually, is it what you really want?
I've tried to review this patch from fstests side, better to get some
review points from ext4 devel, to help to make sure that.

Thanks,
Zorro

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/057.out b/tests/ext4/057.out
> new file mode 100644
> index 00000000..185023c7
> --- /dev/null
> +++ b/tests/ext4/057.out
> @@ -0,0 +1,2 @@
> +QA output created by 057
> +Silence is golden
> -- 
> 2.13.6
> 
