Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158D07AB5A4
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjIVQNX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Sep 2023 12:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjIVQNW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Sep 2023 12:13:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6BA100;
        Fri, 22 Sep 2023 09:13:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdf4752c3cso18667925ad.2;
        Fri, 22 Sep 2023 09:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695399195; x=1696003995; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Tjf5r00Lqmhy/M6RVpzSsAVMaDILHAuySZ81BrNfgM=;
        b=V/GnEe3BvuRtCNWZcFYYeE+r3ZLvSJWgghqAZtq86XdoX7gxlQQY0mdUu9RXTnbjLB
         zoldjABnYzaPSbK7HwA83DKmIoNhB+/i6ccA7JT+8JV4Of22zu4QhiwriUtCXiJmvjgd
         1bV5I84jg43I+hcxlvHqV3GXm0p5CcAFSfx6njNXUQIqurzi2VyYNp+CjpWXuqhjJjNp
         L0x22nFnO0/yRD/PQ5HJANyyi58v0keS2VBIVek9Nj285LUek2kR0hqAOr+DB06Pi68+
         SgdLu5cBQL9MH38nkyMbz+uChwPb5dW1KZqKbhp4arFR/ktxJuY/4tm/JMY2BqKPMsE6
         rzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695399195; x=1696003995;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Tjf5r00Lqmhy/M6RVpzSsAVMaDILHAuySZ81BrNfgM=;
        b=A1HIMeCbgOAF+r1gSgwv1Ip70SVca9sPjYB0H7ToO7G1gNVRGiapWhQVjInOkcwpxK
         Xmft0j973Ge3+PmcngkfqCPQGfQCYvpVSbqgZZVMEFLsv89YJr8aIxdKFCuuqBAJ0omN
         +euRBqSIWAWvVpr6lNFgXS7TdivXpJXXM5bWWaQ2AlZrAlRXIFfurq/FuwMm4UHbPhHI
         qXgUDgiVsi2qRHBcxjOL1VOswJCkSHzFMzOqgBvRleW8x0rJG/bSM/4ZuNj1DsPkeLGr
         tPVSHBxqf3ufitenXNYwtSL6f+t2z48Fuy+16Dj5KGc05DZbRYsFNQbHJM9SO4RR0Rls
         vRXQ==
X-Gm-Message-State: AOJu0Yyotx1F91Ji9jTHobhahQ5dJyZ+IYN5y4qWFgtl40vpbkE4RtMm
        CRWnBsBX0/mAo7A1FZWl1Zc=
X-Google-Smtp-Source: AGHT+IFTfXgpinPIJVlgEQMUcNLnWvvdFV3mnmMdcg8sHyRwWU+fnPHPwKGDHL9Ck5chxeCoLpXdrA==
X-Received: by 2002:a17:902:d2cd:b0:1bd:fa80:103d with SMTP id n13-20020a170902d2cd00b001bdfa80103dmr9470542plc.25.1695399195555;
        Fri, 22 Sep 2023 09:13:15 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id jk12-20020a170903330c00b001bc930d4517sm3673317plb.42.2023.09.22.09.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:13:14 -0700 (PDT)
Date:   Fri, 22 Sep 2023 21:43:11 +0530
Message-Id: <87sf765gq0.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] generic: Add integrity tests with synchronous directio
In-Reply-To: <20230922152116.GA11380@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, Sep 22, 2023 at 05:40:36PM +0530, Ritesh Harjani (IBM) wrote:
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
> $XFS_IO_PROG ?

Thanks for pointing out. Will fix it in next rev.

>
> Otherwise looks good to me...

Thanks. I am planning to enhance this integrity test to also cover
synchronous dio (already added), buff-io and aiodio writes as well
in the next revision.

-ritesh
