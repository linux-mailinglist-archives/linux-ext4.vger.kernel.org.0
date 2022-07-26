Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82364580AA5
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 07:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiGZFEi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jul 2022 01:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiGZFEi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Jul 2022 01:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38E3C2616
        for <linux-ext4@vger.kernel.org>; Mon, 25 Jul 2022 22:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658811876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jbFsJ3u7b3EDDKcMh5oNzFJd3D1ohx97XZnBcYktxo=;
        b=PuRdGXj545o9G9NtFvKR7pgUbJUYV40izlsXQbSurxSZQXt2ymrWKHoY3dojaFpGVJFJ1T
        3ZD5w3LbmVxLdAxbri+HY2ASFpfu9Sicawc+olevg/pnzF0D2GCBz9oTHsiw2xcuR19CgN
        ykAL48c2W38Y21/MRR12ToDS38aPrjw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-MkBqTmzxOw61sM4Oz4HNaw-1; Tue, 26 Jul 2022 01:04:34 -0400
X-MC-Unique: MkBqTmzxOw61sM4Oz4HNaw-1
Received: by mail-qk1-f198.google.com with SMTP id x22-20020a05620a259600b006b552a69231so11320406qko.18
        for <linux-ext4@vger.kernel.org>; Mon, 25 Jul 2022 22:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4jbFsJ3u7b3EDDKcMh5oNzFJd3D1ohx97XZnBcYktxo=;
        b=TxZn/lQdeMPA4ICdXo+msjP4Ex8K3Qg7xxCrW7uZ4B2Krii/4lJpLtLkZ2Sbwdy4+w
         7OtRMkp1ynmu2Q1jXVA4H5Oq2TEbdHD+cKM0hc1HiFgXe1tLyUOIEkPrxatU1Qs3+oa1
         5J4N+vQxXaTqFC21q27Yyc/4tNfxuxMrJhULP0Oa/PBPmchrdqm3bKiFNN8zPFSmjKRR
         /yTOI8xQVoXIl3jhK5tYMFrdN4Y9UYtDZAEdiukSYe7kXveyOT1hRdYY/frpvZXFaXkb
         xrkav6CUy+mMliVpUfHkIt0MqCbaMMSzjMhEkoUYNQrteLdtIT61uB1JNP1W0nlSZiY9
         oxZg==
X-Gm-Message-State: AJIora+zXqDKGRY8lSj8BTuYdqI8Ngd/h4ylAmXG4pBHHdUxlYstJ4HO
        Am1OsPqJS1vzFIVaD8S7PSBZaUCa7oK8KgdIOPB7IFZBaslnQTsw5Ybm1+InBd/oYzoJZDBGpXr
        XjJtpqbLD/OqfHMi79H6BMg==
X-Received: by 2002:a05:6214:2308:b0:435:3440:7d3c with SMTP id gc8-20020a056214230800b0043534407d3cmr13494257qvb.65.1658811874011;
        Mon, 25 Jul 2022 22:04:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vXQYbiB7HSbDLNks65TuqQ8Fsz7p+v34ASBzL9falTwWhi3pLz+Lznym+CVZ/U2DP/OXs9Mg==
X-Received: by 2002:a05:6214:2308:b0:435:3440:7d3c with SMTP id gc8-20020a056214230800b0043534407d3cmr13494245qvb.65.1658811873716;
        Mon, 25 Jul 2022 22:04:33 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v33-20020a05622a18a100b0031f0b43629dsm9273741qtc.23.2022.07.25.22.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 22:04:33 -0700 (PDT)
Date:   Tue, 26 Jul 2022 13:04:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4] ext4: resize fs after set reserved GDT blocks equals
 100
Message-ID: <20220726050428.buqfbitoqspaafvg@zlang-mailbox>
References: <20220726032240.3709879-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726032240.3709879-1-sunke32@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 26, 2022 at 11:22:40AM +0800, Sun Ke wrote:
> Set reserved GDT blocks equals 100, then resize fs, will trigger null
> pointer.
> 
> Regression test for commit b55c3cd102a6 ext4: add reserved GDT blocks
> check.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  tests/ext4/057     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/057.out |  2 ++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/ext4/057
>  create mode 100644 tests/ext4/057.out
> 
> diff --git a/tests/ext4/057 b/tests/ext4/057
> new file mode 100755
> index 00000000..f4bbcd32
> --- /dev/null
> +++ b/tests/ext4/057
> @@ -0,0 +1,46 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test 057
> +#
> +# Set reserved GDT blocks equals 100, then resize fs, will trigger null pointer.

The number "100" isn't important, it just hope to get reserved GDT blocks
even if you disable resize_inode feature. So you'd better to reflect these
two conditions, rather than the number "100". E.g:

# A regression test for b55c3cd102a6 ("ext4: add reserved GDT blocks check").
# Make sure there's not kernel crash, if resize an ext4 which resize_inode
# feature is disabled but has reserved GDT blocks.

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
     ^^^^
Remove this useless comment

> +_supported_fs ext4
> +_fixed_by_kernel_commit b55c3cd102a6 \
> +	"ext4: add reserved GDT blocks check"
> +
> +_require_command "$TUNE2FS_PROG" tune2fs

If you don't need this command anymore, remove this line.

> +_require_command "$RESIZE2FS_PROG" resize2fs
> +_require_command "$DEBUGFS_PROG" debugfs
> +_require_scratch_size $((1024 * 1024)) #kB
> +_require_scratch_nocheck

Generally we don't use _require_scratch_size and _require_scratch together,
You can use a simple one line:

  _require_scratch_size_nocheck $((1024 * 1024))

> +
> +# set fs size 512M

If you'd like to have some comments:

# Initalize a 512M ext4 fs with resize_inode feature disabled

> +dev_size=$((512 * 1024 * 1024))
> +MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> +	>>$seqres.full 2>&1 || _fail "mkfs failed"
> +

# Force some reserved GDT blocks to trigger the bug

> +$DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
> +	>>$seqres.full 2>&1
> +
> +$DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
> +	grep "Reserved GDT blocks"
> +
> +_scratch_mount
> +
> +# resize fs will trigger NULL pointer in ext4_flex_group_add

# Expect no crash from this resize operation

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

