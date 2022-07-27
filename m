Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8115582617
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiG0MHq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 08:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiG0MHp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 08:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 849651B782
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658923660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EPqkkW3iptkB99T8sdQCA3opbpO1omuXsI7/ALoEDz8=;
        b=ikoFXbOrCEFXK+xueRJYGADSD32fa1JGiXe1ME1Fg+RPRImJhSVbLPndBK1XF6DKECxh1L
        6s3l45hO/Gt1d3lPgHVkf4xtVc7hrNyeYpSvB5zaJvA12pm1+RCu3xXOc/5Y2Qdr6CJgk6
        n756yVtD3txG08eQ2rXODQBWCSb7hl4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-ihTE_LgnM6iA0rI0vI6q-g-1; Wed, 27 Jul 2022 08:07:39 -0400
X-MC-Unique: ihTE_LgnM6iA0rI0vI6q-g-1
Received: by mail-ot1-f69.google.com with SMTP id by5-20020a056830608500b00616c152aefbso8606943otb.6
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 05:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EPqkkW3iptkB99T8sdQCA3opbpO1omuXsI7/ALoEDz8=;
        b=NZo78vNOan0lEVV92rdJGcdnb3v/sbFm3x/Nqw83ecZ997RgCz+AJNtGLfhzJx26E9
         PVBQpRvJmgulhrE/E+hbeqdzmIKSquS65djMFSvGpnJlg0pfi+riti7SwBY0nw6fmMSH
         F0FdMC3XFZEzQLU9iL9ZskyTuzvVnHLKhCz3+dILCAzI9bozZsJ/uNLYXQVQLUb2Swxm
         uccUQ1W8b6Nef8mrL9mSjb43ovDSP1TXIE0AU759nt/Wo9PbmpesPhFPEqF4LxUkgEKF
         f7EJAqPQ1pi7zQG1IP/6mf3kJlGzHIbwdVv2oLaBfHMbLcyLXLtMgdM4WPAwu+BsARKv
         GxHA==
X-Gm-Message-State: AJIora+F15lWQIdiwDxQNj5R1+RZam1Bcnpzkc87dnParMHtqqry3h5b
        L0GUoXsQWYR0ALkQSzUQyRtgVK3aZZsU2FgXEPYuUxOO+V6tVwQJYjUOhIh3lJkr20rEFt8l0Ta
        j1vcfWTChNf10fyIwXjOJ5w==
X-Received: by 2002:a9d:162:0:b0:61c:af45:b49 with SMTP id 89-20020a9d0162000000b0061caf450b49mr7920761otu.34.1658923658686;
        Wed, 27 Jul 2022 05:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uMxVa9TSemyG8bX/wRpTlkADeke+Jg8TuhXUpjBUAuqJvHt/jftXcKghlbrm2bW4fSZMXFxQ==
X-Received: by 2002:a9d:162:0:b0:61c:af45:b49 with SMTP id 89-20020a9d0162000000b0061caf450b49mr7920750otu.34.1658923658392;
        Wed, 27 Jul 2022 05:07:38 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s6-20020a0568080b0600b0033a6939436bsm7089655oij.9.2022.07.27.05.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 05:07:37 -0700 (PDT)
Date:   Wed, 27 Jul 2022 20:07:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5] ext4: resize an ext4 which resize_inode feature is
 disabled but has reserved GDT blocks.
Message-ID: <20220727120732.3645x57voyfozujz@zlang-mailbox>
References: <20220727071140.3886185-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727071140.3886185-1-sunke32@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 27, 2022 at 03:11:40PM +0800, Sun Ke wrote:
> A regression test for b55c3cd102a6 ("ext4: add reserved GDT blocks
> check"). Make sure there's not kernel crash, if resize an ext4 which
> resize_inode feature is disabled but has reserved GDT blocks.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---

This version looks good to me, if no more review points from ext4 list,
I'll merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/057     | 41 +++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/057.out |  2 ++
>  2 files changed, 43 insertions(+)
>  create mode 100755 tests/ext4/057
>  create mode 100644 tests/ext4/057.out
> 
> diff --git a/tests/ext4/057 b/tests/ext4/057
> new file mode 100755
> index 00000000..969da377
> --- /dev/null
> +++ b/tests/ext4/057
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test 057
> +#
> +# A regression test for b55c3cd102a6 ("ext4: add reserved GDT blocks check").
> +# Make sure there's not kernel crash, if resize an ext4 which resize_inode
> +# feature is disabled but has reserved GDT blocks.
> +#
> +. ./common/preamble
> +_begin_fstest auto resize quick
> +
> +# real QA test starts here
> +_supported_fs ext4
> +_fixed_by_kernel_commit b55c3cd102a6 \
> +	"ext4: add reserved GDT blocks check"
> +
> +_require_command "$RESIZE2FS_PROG" resize2fs
> +_require_command "$DEBUGFS_PROG" debugfs
> +_require_scratch_size_nocheck $((1024 * 1024))
> +
> +# Initalize a 512M ext4 fs with resize_inode feature disabled
> +dev_size=$((512 * 1024 * 1024))
> +MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> +	>>$seqres.full 2>&1 || _fail "mkfs failed"
> +
> +# Force some reserved GDT blocks to trigger the bug
> +$DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
> +	>>$seqres.full 2>&1
> +$DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
> +	grep "Reserved GDT blocks"
> +
> +_scratch_mount
> +
> +# Expect no crash from this resize operation
> +$RESIZE2FS_PROG $SCRATCH_DEV 1G >> $seqres.full 2>&1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/057.out b/tests/ext4/057.out
> new file mode 100644
> index 00000000..99423e16
> --- /dev/null
> +++ b/tests/ext4/057.out
> @@ -0,0 +1,2 @@
> +QA output created by 057
> +Reserved GDT blocks:      100
> -- 
> 2.13.6
> 

