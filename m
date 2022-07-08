Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA35056BD39
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 18:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbiGHPU0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jul 2022 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiGHPUZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jul 2022 11:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7153E1D314
        for <linux-ext4@vger.kernel.org>; Fri,  8 Jul 2022 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657293623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0aso+p9eGYq+v6pFUF5uQ/7lDmfNnHm1Xte8Fgyvtc8=;
        b=XCLF6ctvvasQMQjm0CxZM9ymRG5z4kdy0dSN04kGcGqGyKKY6FCn804C2qixIoCZoGHlI/
        q4qJYveaLONWnY3GuUOoQbgGioJhyJU9rTezWgo3farSIvrc0oA5TxbyBsP8GAiGa6q9rZ
        UBxRfc6BhuB9kKmM7yd5p40/hEhxmgI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-xfRKyfeAO9e_0dtNyWuEyQ-1; Fri, 08 Jul 2022 11:20:22 -0400
X-MC-Unique: xfRKyfeAO9e_0dtNyWuEyQ-1
Received: by mail-qk1-f200.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso21108339qkb.11
        for <linux-ext4@vger.kernel.org>; Fri, 08 Jul 2022 08:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0aso+p9eGYq+v6pFUF5uQ/7lDmfNnHm1Xte8Fgyvtc8=;
        b=oO56lSVOrtUsf8ANJd5Ody/Vd27prhWg9a5SOxvVTn3tLZdZpebYCWlDLuhIJibdrk
         wft1XlHDXsP5AHHI5PDBr6REksxc6TVFj7p+JDKugZQYr+6nCNhWq8K4RukYIme/C3vH
         H7MtsktxuYfED0OFcfThATIDdV7fe/0L3pUG6S7mfyv+q6lwcP1pC20wQ4nC2zgmz+bb
         GPkb6TKSG1BRpNJ9O9IQoSBIG9+NjotzK33EWXP4ng9ZxM99MYZ3CsRab3Z+q45x8e8K
         k74hz2OZa7YyWMZmsQ4lHdofDS0bXG5GzxUzY2HA/vA8oiX0CdadFEsrfNydqTfhIDd5
         EgIQ==
X-Gm-Message-State: AJIora/w8qbwvb3giy8C1qd38G49cqEQzYPNtCGT/y9UvXX3I5M/Ha/g
        VZCcYWcm3sSjhKdlkKv4M39GZKmbrAFlBIPlQuAunUL0uf7rN4SN1Oh2cosDNGb5nl9Up1Au5gQ
        2cltgkAJI+O8IMyGck/m+yQ==
X-Received: by 2002:a05:622a:410:b0:319:4e26:d0bd with SMTP id n16-20020a05622a041000b003194e26d0bdmr3396849qtx.593.1657293621343;
        Fri, 08 Jul 2022 08:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMObtzyqvcRumQ8pV8PwKAmWMleYQXJ9j77N3yQrCpG6LuJL9UPGjEQByjfTJlQdyJMOgjzQ==
X-Received: by 2002:a05:622a:410:b0:319:4e26:d0bd with SMTP id n16-20020a05622a041000b003194e26d0bdmr3396822qtx.593.1657293621009;
        Fri, 08 Jul 2022 08:20:21 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b19-20020ae9eb13000000b006aee672937esm33742276qkg.37.2022.07.08.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 08:20:20 -0700 (PDT)
Date:   Fri, 8 Jul 2022 23:20:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4: set 256 blocks in a block group then apply
 io pressure
Message-ID: <20220708152014.bifm4u2wmdwj3mnf@zlang-mailbox>
References: <20220708112155.2639551-1-sunke32@huawei.com>
 <20220708112155.2639551-3-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708112155.2639551-3-sunke32@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 08, 2022 at 07:21:55PM +0800, Sun Ke wrote:
> Set 256 blocks in a block group, then inject I/O pressure, it will
> trigger off kernel BUG in ext4_mb_mark_diskspace_used.
> 
> Regression test for commit a08f789d2ab5 ext4: fix bug_on
> ext4_mb_use_inode_pa.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  tests/ext4/058     | 33 +++++++++++++++++++++++++++++++++
>  tests/ext4/058.out |  2 ++
>  2 files changed, 35 insertions(+)
>  create mode 100755 tests/ext4/058
>  create mode 100644 tests/ext4/058.out
> 
> diff --git a/tests/ext4/058 b/tests/ext4/058
> new file mode 100755
> index 00000000..b718c1ac
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
> +_begin_fstest auto

quick ?

> +
> +# real QA test starts here
> +
> +_supported_fs ext4
> +_fixed_by_kernel_commit a08f789d2ab5 \
> +	"ext4: fix bug_on ext4_mb_use_inode_pa"
> +_require_scratch
> +
> +# set 256 blocks in a block group
> +_scratch_mkfs -g 256 >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +$FSSTRESS_PROG -d $SCRATCH_MNT/stress -n 1000 >> $seqres.full

Use "2>&1", if you'd like to avoid some fsstress error output break golden image.

BTW, just for make, are you sure this can reproduce that bug? Due to that fix
commit said:
...
    we can easily reproduce this problem with the following commands:
            `fallocate -l100M disk`
            `mkfs.ext4 -b 1024 -g 256 disk`
            `mount disk /mnt`
            `fsstress -d /mnt -l 0 -n 1000 -p 1`
...

It uses "-l 0" to loop run fsstress until hit the bug. You removed the '-l 0',
so are you sure one round `fsstress -n 1000` is enough to reproduce this bug
stably?

Thanks,
Zorro

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

