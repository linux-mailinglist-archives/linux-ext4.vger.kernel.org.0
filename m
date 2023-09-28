Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359EC7B114C
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 05:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjI1DnB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 23:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjI1Dm7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 23:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A75121
        for <linux-ext4@vger.kernel.org>; Wed, 27 Sep 2023 20:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695872531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmTiX+0/+aFN8cFt5h57GNILP7gRG2Ts9XjKchIAyGk=;
        b=Lb6HPhvoNr2ylhDzCvG8lW9cSAwGTz1HVjiLfm1V4iQ2jzCHM5fwSS3H0FYZ1exzMxqap1
        nA61tZIpkGf/Az/Eu2UfYFIuRI+37YMrVqu/xZ0jknvn0GlhI7kQCsoBuw96WPqfWhJR8z
        9icGUSLA9fPg2Mr0BsnqPHQiCCljYrU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-iVLDWo93PpGD8HdyZeW_IQ-1; Wed, 27 Sep 2023 23:42:09 -0400
X-MC-Unique: iVLDWo93PpGD8HdyZeW_IQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5789f2f13fcso12410967a12.3
        for <linux-ext4@vger.kernel.org>; Wed, 27 Sep 2023 20:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695872528; x=1696477328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmTiX+0/+aFN8cFt5h57GNILP7gRG2Ts9XjKchIAyGk=;
        b=HYae/aGRmOvAf8SvsnkC+2JwegojP8gDewr+8OyWspoFhbUGXujmzlReXWdCxR/LC4
         o0tP5V+rKe06Wy86UGa5PQsiv6IouUgkFyMqgegzn1pOmeDZwM6s9M0/ZkSjTU/jHAAP
         FoqwV/2/Ib6toULs3jFfsXASZb/FTdWMp/HPCcFJVE8lJ09PL/ArwnIZvq7PPTZ2ogGa
         dNhbPJFFUxdzNyMefBFxtbtsDiho2TyLNPq3Y2OC0b/wobdGP+jxiBGbgcIlgVrF+tO3
         4OCdAmuxEZanjCH4d9eWM69m0NAxwBifi8qhEf0Aw5gykfi3NIbAM5CyRPj/ohbc3F5y
         mmcg==
X-Gm-Message-State: AOJu0YywDXRFZZm5qh7z+oJfAseobLkUNJ1rczLAxXxocq+uocNqY9l5
        HmiW2Bl+ZUtt9pAtzzBd4tqYcOeSAay7c1/G9zYF7JGb1WkuRlcRDA66CYV7rAJ4puZLp+HOW37
        xuT8jBylKoDo6aL9ZKV54j7tgHhLQS4U+QxU=
X-Received: by 2002:a17:90b:908:b0:268:7be6:29a5 with SMTP id bo8-20020a17090b090800b002687be629a5mr69055pjb.9.1695872528163;
        Wed, 27 Sep 2023 20:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVWjmUi3fcWivC4xa1ZTR1pwE/OGC4EbBW67iSreLcD3ERXyUWgKaBVIDMc2Rj1qphXnuRxg==
X-Received: by 2002:a17:90b:908:b0:268:7be6:29a5 with SMTP id bo8-20020a17090b090800b002687be629a5mr69046pjb.9.1695872527818;
        Wed, 27 Sep 2023 20:42:07 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a414600b00274a9f8e82asm2821466pjg.51.2023.09.27.20.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 20:42:07 -0700 (PDT)
Date:   Thu, 28 Sep 2023 11:42:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCHv2 2/2] generic: Add integrity tests with synchronous
 directio
Message-ID: <20230928034204.htefxfkdobn3d5e4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <3b86ab1f1447f0b6db88d4dfafe304fd04ae2b11.1695469920.git.ritesh.list@gmail.com>
 <3c21207848460ffe8aab734b32c1c2464049296c.1695469920.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c21207848460ffe8aab734b32c1c2464049296c.1695469920.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 23, 2023 at 05:30:24PM +0530, Ritesh Harjani (IBM) wrote:
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
>  tests/generic/471     | 50 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/471.out | 22 +++++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100755 tests/generic/471
>  create mode 100644 tests/generic/471.out
> 
> diff --git a/tests/generic/471 b/tests/generic/471

The generic/471 has been taken last week, you can choose another number.
Or simply use generic/999, then I'll change the 999 to a proper number.

> new file mode 100755
> index 00000000..218e6676
> --- /dev/null
> +++ b/tests/generic/471
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 471
> +#
> +# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown
> +#
> +. ./common/preamble
> +_begin_fstest auto quick shutdown aio
> +
> +# real QA test starts here
> +_supported_fs generic

Is the bug fix be reviewed and acked now? If it is, please use _fixed_by_kernel_commit
at here. The commit id can be "xxxxxxxxxxxx" if it's not merged by acked.

> +_require_scratch
> +_require_scratch_shutdown
> +_require_odirect

Due to you add aio test in v2, so this line should be: _require_aiodio

> +_require_aiodio aio-dio-write-verify
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +echo "T-1: Create a 1M file using buff-io & O_SYNC"
> +$XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
> +echo "T-1: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-1: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-1: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t1
> +
> +echo "T-2: Create a 1M file using O_DIRECT & O_SYNC"
> +$XFS_IO_PROG -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t2 > /dev/null 2>&1
> +echo "T-2: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-2: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-2: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t2
> +
> +echo "T-3: Create a 1M file using AIO-DIO & O_SYNC"
> +$AIO_TEST -a size=1048576 -S -N $SCRATCH_MNT/testfile.t3 > /dev/null 2>&1

So you just need aio-dio-write-verify.c to do aio write. Maybe we can have aio
read and write support in xfs_io in one day:)

Thanks,
Zorro


> +echo "T-3: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-3: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-3: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t3
> +
> +status=0
> +exit
> diff --git a/tests/generic/471.out b/tests/generic/471.out
> new file mode 100644
> index 00000000..2bfb033d
> --- /dev/null
> +++ b/tests/generic/471.out
> @@ -0,0 +1,22 @@
> +QA output created by 471
> +T-1: Create a 1M file using buff-io & O_SYNC
> +T-1: Shutdown the fs suddenly
> +T-1: Cycle mount
> +T-1: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-2: Create a 1M file using O_DIRECT & O_SYNC
> +T-2: Shutdown the fs suddenly
> +T-2: Cycle mount
> +T-2: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-3: Create a 1M file using AIO-DIO & O_SYNC
> +T-3: Shutdown the fs suddenly
> +T-3: Cycle mount
> +T-3: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> -- 
> 2.41.0
> 

