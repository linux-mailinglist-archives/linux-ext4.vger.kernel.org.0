Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290097B11BD
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 06:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjI1Evd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 00:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjI1Evc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 00:51:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F2F9;
        Wed, 27 Sep 2023 21:51:30 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c453379020so93568875ad.1;
        Wed, 27 Sep 2023 21:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695876690; x=1696481490; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=myreFmYUAC51stxeS7fbe7+oggnl1GIjqnoJwBTGn6k=;
        b=SoS7YUdDmqKafgKREf20VSwG7aSWt/gkX25lA0kW8SEBEXI+RBKAgzHFiEIKBHgwFW
         ArbMSH7OQuMq4hotqYBDb0zkAWCW6GdOCOapeW/jOoVFztrxM9gGd9Kep2mzsPJFwrzz
         ufjT72zoHfnVWQhlAsWZ5TurQwWs630CC9O15Inict5uAUx7SLTqGG8szKxPOZryU4OV
         x50/Gh0QVr0MwWsONxS483XXlGbXlpDQFNVbUVmBHZG9NkOooSwTrI2xqrllefdR9+aA
         5ZB5H/RoaXyF18fM2nrG5uSGcV1lmzFpezA9154rKaUXd1wBnlnI793Z1GkXtM3YvP2n
         5J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876690; x=1696481490;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myreFmYUAC51stxeS7fbe7+oggnl1GIjqnoJwBTGn6k=;
        b=e2I7Rh3+GlD9cg4aL6M7EsJqg0V2qirpB7uHeQh/YHPjV3o279PMq3kCnu8ezo9bie
         sFtkx6guAfxXTkeF0sJVjp0tTPpTPf4ZZ9tYwSJ5SBwz+SVwIqIY4ZUHWBmwcisB7Hea
         p5goBV9EkA5r+1nenmsvy3smS5VAA/YSn4qOTNPnRQbxZlGiipZVgySUEwjWs7fmGRCH
         8e6ST4ehLTOvnw9YioSpahAXL8yuGIfTKDCNYTIfm6KbNY3YJC5cxAO+rvz/xt25Evba
         GR285lwVkKYkcHv+iz5Q9xxdVyZh1JVyL/mv54cKZ0RQnx8ryDPuE1mySkwVrLi8XOuB
         6Y5w==
X-Gm-Message-State: AOJu0YzuUIm9cjY6wb/dkQ88saCMQzp34P5EMD0LAe1EHVWjIsZ0XyCy
        wecREGcsohJt9SNucCI1zE4=
X-Google-Smtp-Source: AGHT+IEcp3oIWE40t0Zf+/YtqRC63IpNNQtMaBTXICa17dscpSyUTozcSu3N+B3/P01vnn1jLpNSXQ==
X-Received: by 2002:a17:903:2305:b0:1c6:e4b:bbeb with SMTP id d5-20020a170903230500b001c60e4bbbebmr78060plh.56.1695876690047;
        Wed, 27 Sep 2023 21:51:30 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001b87bedcc6fsm13979174plh.93.2023.09.27.21.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 21:51:29 -0700 (PDT)
Date:   Thu, 28 Sep 2023 10:21:24 +0530
Message-Id: <87pm22rjcj.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCHv2 2/2] generic: Add integrity tests with synchronous directio
In-Reply-To: <20230928034204.htefxfkdobn3d5e4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Zorro Lang <zlang@redhat.com> writes:

> On Sat, Sep 23, 2023 at 05:30:24PM +0530, Ritesh Harjani (IBM) wrote:
>> This test covers data & metadata integrity check with directio with
>> o_sync flag and checks the file contents & size after sudden fileystem
>> shutdown once the directio write is completed. ext4 directio after iomap
>> conversion was broken in the sense that if the FS crashes after
>> synchronous directio write, it's file size is not properly updated.
>> This test adds a testcase to cover such scenario.
>> 
>> Man page of open says that -
>> O_SYNC provides synchronized I/O file integrity completion, meaning write
>> operations will flush data and all associated metadata to the underlying
>> hardware
>
>
>
>> 
>> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  tests/generic/471     | 50 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/471.out | 22 +++++++++++++++++++
>>  2 files changed, 72 insertions(+)
>>  create mode 100755 tests/generic/471
>>  create mode 100644 tests/generic/471.out
>> 
>> diff --git a/tests/generic/471 b/tests/generic/471
>
> The generic/471 has been taken last week, you can choose another number.
> Or simply use generic/999, then I'll change the 999 to a proper number.
>
>> new file mode 100755
>> index 00000000..218e6676
>> --- /dev/null
>> +++ b/tests/generic/471
>> @@ -0,0 +1,50 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
>> +#
>> +# FS QA Test 471
>> +#
>> +# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick shutdown aio
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>
> Is the bug fix be reviewed and acked now? If it is, please use _fixed_by_kernel_commit
> at here. The commit id can be "xxxxxxxxxxxx" if it's not merged by acked.
>

Hi Zorro,

Yes, the patch is still being worked on. I think we can wait till then
to not spook the distro CI testing to start reporting multiple bug
reports using this testcase :P 


>> +_require_scratch
>> +_require_scratch_shutdown
>> +_require_odirect
>
> Due to you add aio test in v2, so this line should be: _require_aiodio
>

Ok, I guess I can just remove this line "_require_odirect". Because in the
next line I anyway include _require_aiodio.

>> +_require_aiodio aio-dio-write-verify

here ^^

>> +
>> +_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +echo "T-1: Create a 1M file using buff-io & O_SYNC"
>> +$XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
>> +echo "T-1: Shutdown the fs suddenly"
>> +_scratch_shutdown
>> +echo "T-1: Cycle mount"
>> +_scratch_cycle_mount
>> +echo "T-1: File contents after cycle mount"
>> +_hexdump $SCRATCH_MNT/testfile.t1
>> +
>> +echo "T-2: Create a 1M file using O_DIRECT & O_SYNC"
>> +$XFS_IO_PROG -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t2 > /dev/null 2>&1
>> +echo "T-2: Shutdown the fs suddenly"
>> +_scratch_shutdown
>> +echo "T-2: Cycle mount"
>> +_scratch_cycle_mount
>> +echo "T-2: File contents after cycle mount"
>> +_hexdump $SCRATCH_MNT/testfile.t2
>> +
>> +echo "T-3: Create a 1M file using AIO-DIO & O_SYNC"
>> +$AIO_TEST -a size=1048576 -S -N $SCRATCH_MNT/testfile.t3 > /dev/null 2>&1
>
> So you just need aio-dio-write-verify.c to do aio write. Maybe we can have aio
> read and write support in xfs_io in one day:)

Yes, someday maybe :)
But I am not sure what plan Darrick has about it. Was there any
history behind no aio-dio support in xfs_io? Just curious since the
discussion came up.


Thanks for the review!
-ritesh
