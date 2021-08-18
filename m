Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89713F02C8
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Aug 2021 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhHRLej (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Aug 2021 07:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235160AbhHRLeh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Aug 2021 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629286442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a90v0LtS50KTvFT1pBbw2/t1m8mtp1xmPUXygGE4Kik=;
        b=LZSLPzaUxDbns9VqSeJfpD93Ahy7jSKUiBQZNm9lFmq78yUCGBSJP5nenlh4DNQ2vtLSkZ
        tdotvFTMU3IhkKdA84yi2Tj3RLMcVh1pPZrM67oWs4VXs2LGriT+GAOJdbuYnNQQzNXNmE
        /8czDKwgbYGzGZWpG7TePVG4xP2L6JM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-uGNcNolmMba1Rk9YcbEV9g-1; Wed, 18 Aug 2021 07:32:39 -0400
X-MC-Unique: uGNcNolmMba1Rk9YcbEV9g-1
Received: by mail-pg1-f200.google.com with SMTP id r35-20020a635d230000b0290239a31e9f24so1259808pgb.9
        for <linux-ext4@vger.kernel.org>; Wed, 18 Aug 2021 04:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=a90v0LtS50KTvFT1pBbw2/t1m8mtp1xmPUXygGE4Kik=;
        b=mG07LZ3fTUYE1nCbb9S2EcIsnntkdF8a6j9OMMEHSKWEwaMHw6sT97D5oyvUxAQQOQ
         GaXiCzKjd4X4VaokKAWQZii2NClJ/sa1C7kuB06ab98EzC2drs3ktwasEqQK/+lqTo35
         PO36/ekTCXNpguiLwbxVfGSnSjQqPCz/AFXMOZhleiSv2ADZGi39oEp+/xtGb3pOoQwJ
         6O8Sa3kA7l9U/GWjttsz2421HsnnJMbf2fxqBT9i0Hy1LAvjEZbcIu1ii0K6hUMErbka
         nCJpvivybLiXWdVNH8vN0eJfXNqtT69O6hFSMMgetJW8G2pKmRT4KkmYymqhwbY8hFOk
         +eFQ==
X-Gm-Message-State: AOAM530Jaw1wukldDSm6KcFeWGEjt/t+FnVnh68d8wYiSPFMs8rwVVMB
        OuDawsQe5nHrJRnhc4ZfLYVuB3Yk4D2FHc2FwhCCfu/gPcPVEn4fYlmpVbbrT8AI6irK5jmciT9
        X39gnZfRBHyIRLZra8/aagA==
X-Received: by 2002:a17:90a:7283:: with SMTP id e3mr9038995pjg.65.1629286357861;
        Wed, 18 Aug 2021 04:32:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymtAvfM+TxenxCGQyyOE7h/xyOk3irlrBNTqkSpFulNm1Ld9DMq1TFvzi7jrG3wXEjNrWTXg==
X-Received: by 2002:a17:90a:7283:: with SMTP id e3mr9038975pjg.65.1629286357607;
        Wed, 18 Aug 2021 04:32:37 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q3sm7511860pgf.18.2021.08.18.04.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 04:32:37 -0700 (PDT)
Date:   Wed, 18 Aug 2021 19:45:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: regression test for "tune2fs -l" after ext4
 shutdown
Message-ID: <20210818114517.kqvfzu2vd45vuhze@fedora>
Mail-Followup-To: bxue@redhat.com, fstests@vger.kernel.org, jack@suse.cz,
        linux-ext4@vger.kernel.org
References: <20210818084126.4167799-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818084126.4167799-1-bxue@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 18, 2021 at 04:40:56PM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 
> Regression test for:
> 
> ext4: Fix tune2fs checksum failure for mounted filesystem

Better to specify the commit id number. I saw Ted has applied that patch:

https://lore.kernel.org/linux-ext4/162895105421.460437.8931255765382647790.b4-ty@mit.edu/

And maybe you can describe *a little* more in commit log.

> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---
> Hi,
> 
> This is a new regression test for the patch
> 
> ```
> ext4: Fix tune2fs checksum failure for mounted filesystem
> 
> Commit 81414b4dd48 ("ext4: remove redundant sb checksum recomputation")
> removed checksum recalculation after updating superblock free space /
> inode counters in ext4_fill_super() based on the fact that we will
> recalculate the checksum on superblock writeout. That is correct
> assumption but until the writeout happens (which can take a long time)
> the checksum is incorrect in the buffer cache and if tune2fs is called
> in that time window it will complain. So return back the checksum
> recalculation and add a comment explaining the tune2fs peculiarity.
> 
> Fixes: 81414b4dd48f ("ext4: remove redundant sb checksum recomputation")
> Reported-by: Boyang Xue <bxue@xxxxxxxxxx>
> Signed-off-by: Jan Kara <jack@xxxxxxx>
> ```
> 
> It's expected to fail on kernels from the kernel-5.11-rc1 to the latest
> version, where tune2fs fails with:
> 
> ```
> tune2fs 1.46.2 (28-Feb-2021)
> tune2fs: Superblock checksum does not match superblock while trying to
> open /dev/loop0
> Couldn't find valid filesystem superblock.
> ```
> 
> Please help review this test, Thanks!
> 
> -Boyang
> 
>  tests/ext4/309     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/309.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/ext4/309
>  create mode 100644 tests/ext4/309.out
> 
> diff --git a/tests/ext4/309 b/tests/ext4/309
> new file mode 100755
> index 00000000..ae335617
> --- /dev/null
> +++ b/tests/ext4/309
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 YOUR NAME HERE.  All Rights Reserved.
                        ^^^^^^^^^^^^^^
                       Write your copyright

> +#
> +# FS QA Test 309
> +#
> +# Test that tune2fs doesn't fail after ext4 shutdown
> +# Regression test for commit:
> +# ext4: Fix tune2fs checksum failure for mounted filesystem
> +#
> +. ./common/preamble
> +_begin_fstest auto rw quick
> +
> +_cleanup()
> +{
> +	_scratch_unmount
> +}

I think the umount isn't necessary, so the specific _cleanup isn't
needed either.

> +
> +# Import common functions.
> +. ./common/filter

Do you use any filter helpers below?

> +
> +# real QA test starts here
> +_supported_fs ext4

I'm wondering if this case can be a generic case, there's nothing
ext4 specified operations, except this line:

"$TUNE2FS_PROG -l $SCRATCH_DEV"

Hmm... if we can change this line to something likes _get_fs_super(),
it might help to make this test to be a generic test.

> +_require_scratch
> +_require_scratch_shutdown
> +_require_command "$TUNE2FS_PROG" tune2fs
> +
> +echo "Silence is golden"
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount
> +echo "ext4/309" > $SCRATCH_MNT/309.tmp

It's sure this case will be "ext4/309", although you use "309" won't
affect anything.

> +_scratch_shutdown
> +_scratch_cycle_mount
> +$TUNE2FS_PROG -l $SCRATCH_DEV >> $seqres.full 2>&1
> +if [ $? -eq 0 ]; then
> +	status=0
> +else
> +	status=1
> +fi

Don't need to change the status value, how about write as:

$TUNE2FS_PROG -l $SCRATCH_DEV >/dev/null

The error output will break the golden image directly.

( cc ext4 mailist, to get more review)

Thanks,
Zorro

> +
> +exit
> diff --git a/tests/ext4/309.out b/tests/ext4/309.out
> new file mode 100644
> index 00000000..56330d65
> --- /dev/null
> +++ b/tests/ext4/309.out
> @@ -0,0 +1,2 @@
> +QA output created by 309
> +Silence is golden
> -- 
> 2.27.0
> 

