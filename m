Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7107AC06D
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Sep 2023 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjIWKZf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 Sep 2023 06:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjIWKZe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 Sep 2023 06:25:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51019E;
        Sat, 23 Sep 2023 03:25:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c47309a8ccso35743185ad.1;
        Sat, 23 Sep 2023 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695464728; x=1696069528; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UmJSE52TWCxPu3kdwbSjvuRVkR5Be4GmoiLFIIzHsZc=;
        b=DW+TUHs58NjajbZoVWOyiWMDHRQr8kVJJxmJbozwsEfb5spKM7JorIU+SANiW3VOfQ
         liDBwIUtLhSbvt7B9jq//FpXqLgPaOSVdKv22rf4RWfF2VAAOIikij2qy2Bq7PyLlpyC
         x1fFNR/2yH8ccq3Sda4yum/FYvxiX5ax/b/tfDSivcaZ9raiknJ5YJEYVfYbUTl6d/1p
         PmgsmcUdK54LsvFxNy6NlNNykCR6eg78msrVCDmTHLuHJXJq4bKP9frgByC0LIEe63DO
         o/BQssXgyZUed2v3pcn1AiAWXFT3VL7QuzkJSZANRTmQRLwNxsnLuKqd4QWv5ed6AMFS
         g1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695464728; x=1696069528;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmJSE52TWCxPu3kdwbSjvuRVkR5Be4GmoiLFIIzHsZc=;
        b=hDuT66tRnxehP3bPWESSuUxbPDIx+VxM/AJLAm7xqIuFl39pg846qsCNQjjnmvqdw9
         RkJFeHn+n64kzXmx7t9t8fhPfjcMzIEas1CVg6sMHU9ByTyQj0Z4184seGiBUiNYoUEi
         hS3xFMWzkT5IQS1RSVR5zEDWkrqdVXxdgB5SAQhi+LppnV/+24+/NkvuVzZB8bh+qTP7
         9MecfTL1mVX8oLcwRUlS3gJ6+46F5xTQUC5GXNXgYe4NxR293oYb6TLR/F6Ysh/j4MR8
         +B+b6cC/KyYqG8rM7vbSRKLVhTrEy3apyO3ScVwhZAehl1B+BbCpYPiehsNqNrgFrbAG
         molg==
X-Gm-Message-State: AOJu0YzKPa4m/NZmfv3hFd+iCSr4kSxqUBjfszRwWKheL2MHIcZcrOxM
        w9y0ELSL7PtsPQLJxVCdeIPRz3nyl+w=
X-Google-Smtp-Source: AGHT+IFbRlkGIrakAA4H+YpBcdL2SLyw+f4sTrSunz4Kk5SOjROgJdGQOUuTZiPZSfumWzl4B7KrHg==
X-Received: by 2002:a17:902:f814:b0:1c6:362:3553 with SMTP id ix20-20020a170902f81400b001c603623553mr646116plb.31.1695464727986;
        Sat, 23 Sep 2023 03:25:27 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b001c444106bcasm5037779plf.46.2023.09.23.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 03:25:27 -0700 (PDT)
Date:   Sat, 23 Sep 2023 15:55:23 +0530
Message-Id: <87pm295gq4.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] generic: Add integrity tests with synchronous directio
In-Reply-To: <20230922170618.7qnyqu7gpntlcpki@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Zorro Lang <zlang@redhat.com> writes:

> On Fri, Sep 22, 2023 at 05:40:36PM +0530, Ritesh Harjani (IBM) wrote:
>> This test covers data & metadata integrity check with directio with
>> o_sync flag and checks the file contents & size after sudden fileystem
>> shutdown once the directio write is completed. ext4 directio after iomap
>> conversion was broken in the sense that if the FS crashes after
>> synchronous directio write, it's file size is not properly updated.
>> This test adds a testcase to cover such scenario.
>
> Thanks for this patch, some review points as below.
>
> Is there a bug ? If there is, please use _fixed_by_kernel_commit to point
> out that.
>

It's still under discussion. So I am fine if you would like to wait
until the official fix is ready.

>> 
>> Man page of open says that -
>> O_SYNC provides synchronized I/O file integrity completion, meaning write
>> operations will flush data and all associated metadata to the underlying
>> hardware
>> 
>> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  tests/generic/471     | 45 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/471.out |  8 ++++++++
>>  2 files changed, 53 insertions(+)
>>  create mode 100755 tests/generic/471
>>  create mode 100644 tests/generic/471.out
>> 
>> diff --git a/tests/generic/471 b/tests/generic/471
>> new file mode 100755
>> index 00000000..6c31cff8
>> --- /dev/null
>> +++ b/tests/generic/471
>> @@ -0,0 +1,45 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
>> +#
>> +# FS QA Test 471
>> +#
>> +# Integrity test with DIRECT_IO & O_SYNC with sudden shutdown
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick shutdown
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>
> This _cleanup looks same ith the default one, so you don't need to do
> this "override", just remove this _cleanup and use the default one.
>

Ok, IIUC, we don't need to define _cleanup function, since
". ./common/preamble" does it for us.

>> +
>> +# Import common functions.
>> +. ./common/filter
>
> If you don't need any filter helpers, feel free to remove this line.
>

will remove it.

>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>      ^^^
> If you'll send a v2, feel free to remove this comment line :)
>

Will remove.


>> +_supported_fs generic
>> +_require_scratch
>> +_require_scratch_shutdown
>
> _require_odirect ??
>
> Or if you will add aio test in v2, please use _require_aiodio.
> Also add "aio" test group (in the _begin_fstest line).
>

Sure. Thanks for pointing out.

>> +
>> +_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +echo "Create a 1M file using O_DIRECT & O_SYNC"
>> +xfs_io -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile > /dev/null 2>&1
>
> $XFS_IO_PROG

done.
>
> Thanks,
> Zorro
>

Thanks for the review!
-ritesh
