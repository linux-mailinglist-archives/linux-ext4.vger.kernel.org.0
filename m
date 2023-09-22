Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8A7AB6D6
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjIVRHS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Sep 2023 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjIVRHS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Sep 2023 13:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0CB192
        for <linux-ext4@vger.kernel.org>; Fri, 22 Sep 2023 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695402385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBvwpRZncWMEu2fOsmmJ3UeKyf9fjcHN+aQjvpZDdsc=;
        b=GMvUNdwdwGmLKWNuKwfv4JFN4l0dCn8Qx0nIP9pejCqR+PFZrd1h2EO/jwmZdMcKtzgMxj
        Gof2pzPDHGdrDyKGxopuelOuctWIzztOdaHBu1p3JL5oQ/WAjzCJNZ3JOvA/VIgqGnhrBD
        4/d0Flj+HdfKNVY4VHjo5HZAkqWFbZQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-PHPbfnmwPq6iz16D9pnPhQ-1; Fri, 22 Sep 2023 13:06:24 -0400
X-MC-Unique: PHPbfnmwPq6iz16D9pnPhQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-274d62ab09bso2109265a91.2
        for <linux-ext4@vger.kernel.org>; Fri, 22 Sep 2023 10:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695402383; x=1696007183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBvwpRZncWMEu2fOsmmJ3UeKyf9fjcHN+aQjvpZDdsc=;
        b=hsj7EM5Q/907gYuDM43Vi1eSPkr9wyhy+Y0NvRGhOXscpWVouwrcId3hixzK5bzOZj
         i01f5XFjIpmDhwne0W9bEc2Z6SKSn78m4eE2P/GCsPOXVqcCEukxbVdP/k4Rtye5zOOh
         BvIlIuGEV4iJALb0/gNajHCcEjuq1Xsq6pGCWDejt4nGbb6rCKMMYonxUOqQRRorplKb
         luQpb07Mh3M5g8ekqjUqmNEJ7e7jBX2bWQoTjxcymSg+yPWvm/YtqkS3wN9juHJDnTxb
         AJrxSVd2pqAAf7iTsFRQkGU2oAPdyTaG1k86vTkjNH2K1BQI7uWiqbnzZQvHOk0IfEG2
         l16w==
X-Gm-Message-State: AOJu0Yz3AzgzwN7j3h/V/PbCR1fiRb6aDgJWTtqRWycOCxFMXI5QqI80
        JH4ptsIrd3BfoZLRvRlThSZdJDZAWhKAQzvNznptCwPOsFpgGkM7MkSnizF5+dFSX2fZuflNqAj
        nK7aIvweLa2KnioUtyNX73A==
X-Received: by 2002:a17:90b:4b41:b0:26b:48e8:cd76 with SMTP id mi1-20020a17090b4b4100b0026b48e8cd76mr276683pjb.37.1695402382836;
        Fri, 22 Sep 2023 10:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjPTMBXJLLU2YC4z3ZHlyKb74NGD84F7EZ5rXS0NITAduQnqyKe6yo93KiLBxEI9gktP8S0A==
X-Received: by 2002:a17:90b:4b41:b0:26b:48e8:cd76 with SMTP id mi1-20020a17090b4b4100b0026b48e8cd76mr276658pjb.37.1695402382473;
        Fri, 22 Sep 2023 10:06:22 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00268b439a0cbsm3811837pji.23.2023.09.22.10.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:06:22 -0700 (PDT)
Date:   Sat, 23 Sep 2023 01:06:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] generic: Add integrity tests with synchronous directio
Message-ID: <20230922170618.7qnyqu7gpntlcpki@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <87y1gy5s9c.fsf@doe.com>
 <434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Thanks for this patch, some review points as below.

Is there a bug ? If there is, please use _fixed_by_kernel_commit to point
out that.

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

This _cleanup looks same ith the default one, so you don't need to do
this "override", just remove this _cleanup and use the default one.

> +
> +# Import common functions.
> +. ./common/filter

If you don't need any filter helpers, feel free to remove this line.

> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
     ^^^
If you'll send a v2, feel free to remove this comment line :)

> +_supported_fs generic
> +_require_scratch
> +_require_scratch_shutdown

_require_odirect ??

Or if you will add aio test in v2, please use _require_aiodio.
Also add "aio" test group (in the _begin_fstest line).

> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +echo "Create a 1M file using O_DIRECT & O_SYNC"
> +xfs_io -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile > /dev/null 2>&1

$XFS_IO_PROG

Thanks,
Zorro

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

