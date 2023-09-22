Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A67AB594
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjIVQJg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Sep 2023 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjIVQJf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Sep 2023 12:09:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8248B100;
        Fri, 22 Sep 2023 09:09:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2095966b3a.0;
        Fri, 22 Sep 2023 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695398969; x=1696003769; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1wTX+TB06MEAjRMyvPhzSgFLCY3xJKUxyUe+GNOqMn8=;
        b=It+e+ehkW3xrSAx0dZpoYwt0tJyXRpcC+9YdLeFqq0Yb+t1QvZoSNIndoS3r+JOxGO
         GcwMP9wCCUO/lsicRjkS0LCnw9mD+tvdm3VHVmcR/r8iKJxoP2SzPBRS0znTtXKoVGGf
         47tQnHTU8GuKs9/6Gbci9m1UUgniri8KMfk1AHMMVs91rwW6kfO+/33W9tiM5942UmAh
         ZL80hS9JKbmvMjHCTTvO5vanK45bjOzybsB5dQ7TNT/EP1gQf/JJnAyDLseXEMqZEkDS
         7xgYunsk2vyGBw/4RACy/yHJ9rZk+9KdUdu08gjgNeDdIepkc7HFfyX8xh6noe2aYmxA
         87ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695398969; x=1696003769;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wTX+TB06MEAjRMyvPhzSgFLCY3xJKUxyUe+GNOqMn8=;
        b=kR8A0Vn3xCygBT6UMooZsNxYyzchfZwe3rGIdV3PBFT70qdDVjsSWgDJ5OY19O6/Ho
         bnadiZ9B1mHoS+sv796yP4Dyre+zytaVfdwFptoIu+xQcxXLK6DdGTCntVCnMrQOyxXC
         D1ceyIwmmosumI540RO3UhKVASQGXc+V25x2uquCVEM9kfjuirSiVs3R0+UUZsMiae2H
         tMXJG9l6zGPyf6FubMmeYLW9POCBk4Rd9IvQYtP1d6CNtx5U5Vly89rBgQqRCvjf3iHl
         vXprUokk9EQIg6u/efi9/ou/0u8YBYdUKs2uy0vhZKfXK3decBRHsEmks1AtRBrbtViZ
         Wf5A==
X-Gm-Message-State: AOJu0YwYcgm5TxUDo+7JxDiszsYDm0GphiD5fnZmcF/STWiorBLW1CdE
        TbkymoU/fXUcOwnpc8B1c7iIO239bp0=
X-Google-Smtp-Source: AGHT+IEBmJQBe2iqnQhB+X6YhSKtLmctzD6gBM1lF0kNv5FQnFTEnq8GNbdltVyvBvRctQuN+5EAaA==
X-Received: by 2002:a05:6a20:a10e:b0:14c:e8d4:fb3e with SMTP id q14-20020a056a20a10e00b0014ce8d4fb3emr10450685pzk.43.1695398968800;
        Fri, 22 Sep 2023 09:09:28 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id t19-20020a17090b019300b00274922d4b38sm3470104pjs.27.2023.09.22.09.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:09:28 -0700 (PDT)
Date:   Fri, 22 Sep 2023 21:39:24 +0530
Message-Id: <87v8c25gwb.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>, fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] generic: Add integrity tests with synchronous directio
In-Reply-To: <7ce321e3-3250-5627-18f8-230249fbf78f@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Gao Xiang <hsiangkao@linux.alibaba.com> writes:

> Hi Ritesh,
>
> On 2023/9/22 20:10, Ritesh Harjani (IBM) wrote:
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
>> 
>> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   tests/generic/471     | 45 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/471.out |  8 ++++++++
>>   2 files changed, 53 insertions(+)
>>   create mode 100755 tests/generic/471
>>   create mode 100644 tests/generic/471.out
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
>> +
>> +# Import common functions.
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_require_scratch
>> +_require_scratch_shutdown
>> +
>> +_scratch_mkfs > $seqres.full 2>&1
>> +_scratch_mount
>> +
>> +echo "Create a 1M file using O_DIRECT & O_SYNC"
>> +xfs_io -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile > /dev/null 2>&1
>
> Thanks for the time on this.
>
> I'm fine with this as it's the exact regression test to
> my report.
>
> Although the original issue from our guest real workload
> is actually aio + O_SYNC, but that doesn't matter for
> ext4 since it will serialize the whole process of DIO
> write beyond i_size with inode lock.

Yes, even if we do AIO but since it is an extending write we will pass
IOMAP_DIO_FORCE_WAIT to iomap which means it will wait for the
completion anyway.

But on second thoughts, we can still add both synchronous direct-io
writes and buffered-io writes to this test. The man page of "open" tells
about O_SYNC flag, so the test should make sure that "data" and
"metadata" gets written to disk for both buffered-io and direct-io.
I will enhance that in second revision to cover buffered-io case as well.

>
> Yet if my understanding is correct, some other fses (e.g.
> XFS) seem to be more relaxed than this, see
> xfs_file_dio_write_aligned() and xfs_file_write_checks(),
> so I'm not sure if we need to cover AIO cases as well,
> anyway.

It's O_SYNC flag of open which mandates both data and metadata
integrity after "write" (or similar) completion. 
So, I think it will be better to cover AIO case as well.

There are a bunch of AIO tests present. I will see if either of it can
be enhanced to do basic aiodio writes. If not, I will add a basic
integrity test.

Thanks
-ritesh

>
> Thanks,
> Gao Xiang
>
>> +
>> +echo "Shutdown the fs suddenly"
>> +_scratch_shutdown
>> +
>> +echo "Cycle mount"
>> +_scratch_cycle_mount
>> +
>> +echo "File contents after cycle mount"
>> +_hexdump $SCRATCH_MNT/testfile
>> +
>> +status=0
>> +exit
>> diff --git a/tests/generic/471.out b/tests/generic/471.out
>> new file mode 100644
>> index 00000000..ae279b79
>> --- /dev/null
>> +++ b/tests/generic/471.out
>> @@ -0,0 +1,8 @@
>> +QA output created by 471
>> +Create a 1M file using O_DIRECT & O_SYNC
>> +Shutdown the fs suddenly
>> +Cycle mount
>> +File contents after cycle mount
>> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
>> +*
>> +100000
