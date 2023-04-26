Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7556EEFD2
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Apr 2023 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbjDZIFN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbjDZIFL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 04:05:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F26D3598;
        Wed, 26 Apr 2023 01:05:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so5649922b3a.2;
        Wed, 26 Apr 2023 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682496300; x=1685088300;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SciRdqcR7n21lYLAgquNl0PXOwkcT56LabDCcxsO+B4=;
        b=laxYLyoOPi9siIBETnLx+RgMNtgV3ecmPqfQ9jFfoPU/leADggHD8PkFpOSEl0MPtd
         Z1edhd9VP/beJZ4fPImPTEEUihSTWu/GII6obgNL4D7OzxcCw7QAqVUzzLgtq8Yu9Yhm
         3wRzP3USxg+PIpi4yYtTatqhb8AjsWhjffT5D+oM+Vhrrn5rMjz+dYuWZ4qDU+q50aTH
         XwL3kHXO7S/zAN9rMuPBo2neL5OVPT83y3u6debfA8tqYg5oYJPWQnp433ySnufzP3wX
         8wsoZXQ2HVls1ke+wWAy/VX6+UmszkjDyYSmkOsd/GSHAMqNLzDMTnvm/3SOiP0sl4N0
         /6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682496300; x=1685088300;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SciRdqcR7n21lYLAgquNl0PXOwkcT56LabDCcxsO+B4=;
        b=jPPYzbqdSWrj6lF22jfBl7s5rTAqXU+cuoABKUtC4d5UWtJFNA988upUNCOkJeFzCS
         8+IB2hfgQgiijXrzVYGBXAj6ez5lQUecXcTEHLVb3LuKtcQes2wz8JoVoyzfTtfIvsph
         78UIYHh034jvQ0KS/xL0rZrRxTwOlLbi/ILOfXtN7+d4W9YLHIP4bXwgmSMq05HFndTa
         /Tguai6AEjq7ACgfnQ+RJltUL0vJohK1w4ErgeHhhkU3PqpkZ3ptXDJMf5C3/OmS6h/x
         ujUSUcRC6kYP/zOmsWZExG3hkLw5QZLM4Yiwxnbud44TdQr8d3fS4bWYovhT3VEU26mz
         K6lA==
X-Gm-Message-State: AAQBX9f1HmgMX8PjFYZHkAA7waEHKkWUNQRJDQIygDNUFZ91r40yaqlA
        Ohb5jsPUm/rBpMBfZmaqGwk=
X-Google-Smtp-Source: AKy350a7jb5A+lCqt7RWiq/FGahhrNGJnTB8y+yy+MqyA941BNPTheauFAluUHjEZScPvZitCB2RRw==
X-Received: by 2002:a05:6a00:1250:b0:63d:3d08:4792 with SMTP id u16-20020a056a00125000b0063d3d084792mr25859150pfi.32.1682496300449;
        Wed, 26 Apr 2023 01:05:00 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:80ba:df67:5773:54c8:514f])
        by smtp.gmail.com with ESMTPSA id s23-20020a62e717000000b005aa60d8545esm10642634pfh.61.2023.04.26.01.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 01:04:59 -0700 (PDT)
Date:   Wed, 26 Apr 2023 13:34:35 +0530
Message-Id: <87pm7rgjcc.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [RFC 1/2] ext4/060: Regression test against dioread_nolock mount option inconsistency
In-Reply-To: <20230423154604.p65lfge3ari3jgeu@zlang-mailbox>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Zorro Lang <zlang@redhat.com> writes:

> On Sat, Apr 22, 2023 at 09:47:33PM +0530, Ritesh Harjani (IBM) wrote:
>> During ext4_writepages, ext4 queries dioread_nolock mount option twice
>> and if someone remount the filesystem in between with ^dioread_nolock,
>> then this can cause an inconsistency causing WARN_ON() to be triggered.
>>
>> This fix describes the problem in more detail -
>>
>> https://lore.kernel.org/linux-ext4/20230328090534.662l7yxj2e425j7w@quack3/T/#md19c34646e8b4a816498532c298a66ecf2ae77d4
>>
>> This test reproduces below warning for me w/o the fix.
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 2 PID: 26 at fs/ext4/page-io.c:231 ext4_put_io_end_defer+0xfb/0x140
>> Modules linked in:
>> CPU: 2 PID: 26 Comm: ksoftirqd/2 Not tainted 6.3.0-rc6-xfstests-00044-ga5c68786f1b1 #23
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:ext4_put_io_end_defer+0xfb/0x140
>> Code: 5d 41 5e 41 5f e9 a5 73 d0 00 5b 48 89 ef 5d 41 5c 41 5d 41 5e 41 5f e9 d3 fa ff ff 49 83 be a8 03 00 00 00 0f 84 7b ff fd
>> <...>
>> Call Trace:
>>  <TASK>
>>  blk_update_request+0x116/0x4c0
>>  ? finish_task_switch.isra.0+0xfb/0x320
>>  blk_mq_end_request+0x1e/0x40
>>  blk_complete_reqs+0x40/0x50
>>  __do_softirq+0xd8/0x3e1
>>  ? smpboot_thread_fn+0x30/0x280
>>  run_ksoftirqd+0x3a/0x60
>>  smpboot_thread_fn+0x1d8/0x280
>>  ? __pfx_smpboot_thread_fn+0x10/0x10
>>  kthread+0xf6/0x120
>>  ? __pfx_kthread+0x10/0x10
>>  ret_from_fork+0x2c/0x50
>>  </TASK>
>> [
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  tests/ext4/060     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/ext4/060.out |  2 ++
>>  2 files changed, 90 insertions(+)
>>  create mode 100755 tests/ext4/060
>>  create mode 100644 tests/ext4/060.out
>>
>> diff --git a/tests/ext4/060 b/tests/ext4/060
>> new file mode 100755
>> index 00000000..d9fe1a99
>> --- /dev/null
>> +++ b/tests/ext4/060
>> @@ -0,0 +1,88 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
>> +#
>> +# FS QA Test 060
>> +#
>> +# This is to test a ext4 regression against inconsistent values of
>
> Great, a new regression test case!
>
>> +# dioread_nolock mount option while in ext4_writepages path.
>> +# See - https://lore.kernel.org/linux-ext4/20230328090534.662l7yxj2e425j7w@quack3/T/#md19c34646e8b4a816498532c298a66ecf2ae77d4
>
> You can use the commit id and subject to replace the link.
>
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>
> also add mount/remount tag?
>

Yes.

>> +
>> +PID1=""
>> +PIDS=""
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +# Override the default cleanup function.
>> + _cleanup()
>> +{
>> +	{
>> +		kill -SIGKILL $PID1 $PIDS
>> +		wait $PID1 $PIDS
>> +	} > /dev/null 2>&1
>
> I think the curly braces "{ }" is not necessary. Refer to generic/390 to deal
> with the background processes.

Ok, will check that.

>
> [ -n "$PIDS" ] && kill -9 $PIDS
> wait $PIDS
>

Sure.

>> +
>> +	cd /
>> +	rm -r -f $tmp.*
>> +}
>> +
>> +# Import common functions.
>> + . ./common/filter
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>
> Remove this comment.
>
>> +_supported_fs ext4
>
> _fixed_by_kernel_commit ?
>

Yes, I will check the commit-id and will update it.

>> +_require_scratch
>> +
>> +_scratch_mkfs_ext4 >> $seqres.full 2>&1
>> +_scratch_mount
>> +_scratch_remount "dioread_nolock" >> $seqres.full 2>&1
>> +ret=$?
>
> If the "$ret" is only used once as below...
>
>> +if [ $ret -ne 0 ]; then
>
> ... then we can use "$?" directly.
>
>> +	_notrun "dioread_nolock mount option not supported"
>
> When ext4 start to support dioread_nolock/dioread_lock ?

Ok. yes looks like dioread_nolock is quiet old. Will drop the check.

>
> If it's old enough, we don't need to check this option. Or we can have a new
> helper (e.g. require_scratch_ext4_mount_option()). You can refer to
> _require_scratch_ext4_feature(), or maybe we can change it to support mount
> option test.
>
>> +fi
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +function run_buff_io_loop()
>> +{
>> +	# add buffered io case here
>> +	while [ 1 ]; do
>> +		xfs_io -fc "truncate 0" -c "pwrite 0 200M" -c "fsync" "$testfile.$1" > /dev/null 2>&1
>
> I only find the $testfile is used at here once, if so you can make it as
> a local variable of this function.
>
>> +		sleep 2;
>> +	done
>> +}
>> +
>> +function run_remount_loop()
>> +{
>> +	# add remount loop case here
>> +	while [ 1 ]; do
>> +		_scratch_remount "dioread_nolock" >> $seqres.full 2>&1
>> +		sleep 1
>> +		_scratch_remount "dioread_lock" >> $seqres.full 2>&1
>> +		sleep 1
>> +	done
>> +}
>> +
>> +run_remount_loop &
>> +PID1=$!
>
> If you don't need to kill these processes in a specific order, I think
> you can:
>
> PIDS=$!
>

ok.

>> +for i in $(seq 1 20); do
>> +	run_buff_io_loop $i &
>> +	PID=$!
>> +	PIDS="${PIDS} ${PID}"
>
> PIDS="$PIDS $!"
>
>> +done
>> +
>> +sleep 10
>
> $((10 * TIME_FACTOR)) ?
>

Sure. will check more on TIME_FACTOR.

>> +
>> +{
>> +	kill -SIGKILL $PID1 $PIDS
>> +	wait $PID1 $PIDS
>> +} > /dev/null 2>&1
>
> kill -9 $$PIDS
> wait $PIDS
> unset PIDS
>

Thanks Zorro for the quick review. Agree with all of your comments.
I will work on these and will send out v2 addressing your review
comments.

-ritesh
