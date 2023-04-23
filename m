Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847426EC0DC
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Apr 2023 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDWPrB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 11:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDWPrA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 11:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADB510E9
        for <linux-ext4@vger.kernel.org>; Sun, 23 Apr 2023 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682264772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hx3fghTYGBZimQO6IIzO49njc8vKHoIusnUoZfEyLS0=;
        b=EOntqM2PCRu9jUUMSiy0rjT7mI1mCxdtnkr45piRBQy+0zfx8a3lC4unrUh+44zHtJ9k8j
        7SAbe1fr4kyFRzkk9RwU96UppDvF4EgQV7909za4DChbuzLkY67k1Ono9keM0SGfEHe3A6
        mif3ItLrD6BzLFnTMSwrEEov0yyx1Os=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-_77_6hdlMZG7gxftjMK42w-1; Sun, 23 Apr 2023 11:46:10 -0400
X-MC-Unique: _77_6hdlMZG7gxftjMK42w-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1a69ae5e220so41824185ad.2
        for <linux-ext4@vger.kernel.org>; Sun, 23 Apr 2023 08:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682264769; x=1684856769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx3fghTYGBZimQO6IIzO49njc8vKHoIusnUoZfEyLS0=;
        b=BRoBz34QCIXB5Bw0IQeCltJKpU1QjGGJZdvuVZHlIWTCrjZOXZttByF8bxAI1x0To2
         KM7naLi29KwzLNxJokqBevy9NLYAIBvMtP1gWFRggIzKGFnmnUut5GzlnrXLPrN0MP3w
         7ber88vCOZ2ui595ScMKjPkUnPCKTz1AI4eEA2jwDiF7XMxvwgElqph1MKanEuHOi040
         N+MUNFZGx8IpZnuZg7WaE1A0NqToEzgWrzGH3LIRm8o1NwiO/ZnrEDq2705WdwqR8ViG
         mggOKFCPRZkI4ChLvFOK8ztVvFvTS63yW0Mv+PUNo8slUrJFALI2UfzKoHqFyhVVKEuy
         3hpA==
X-Gm-Message-State: AAQBX9f0Y8elMYGWkFuVEGki7a2M8fAbn20zPAvThHh9aBXtOmXhfS/Q
        qrbq3GgrS94WYjnuMJmVLwGVUNL+5PzwOw98SbZaKoXYRI2+3LpLkgtf2yEyUrGNiMwRY2gmKN5
        54SX8jNYsGrqWiHC7lpK4yA==
X-Received: by 2002:a17:902:ecc8:b0:1a6:ce48:5700 with SMTP id a8-20020a170902ecc800b001a6ce485700mr15001038plh.33.1682264769580;
        Sun, 23 Apr 2023 08:46:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350bPwExPEQlD2dz+F/WRia7qyUBLr8vhI8zdsI0wUMPl30o5NUjguQ10EhpzyK09GNkXitH3PA==
X-Received: by 2002:a17:902:ecc8:b0:1a6:ce48:5700 with SMTP id a8-20020a170902ecc800b001a6ce485700mr15001018plh.33.1682264769211;
        Sun, 23 Apr 2023 08:46:09 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jg11-20020a17090326cb00b001a664e49ebasm4851081plb.304.2023.04.23.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 08:46:08 -0700 (PDT)
Date:   Sun, 23 Apr 2023 23:46:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [RFC 1/2] ext4/060: Regression test against dioread_nolock mount
 option inconsistency
Message-ID: <20230423154604.p65lfge3ari3jgeu@zlang-mailbox>
References: <aa8a633b016114b94d10dd0f9f0b7a355aeb1d62.1682179372.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8a633b016114b94d10dd0f9f0b7a355aeb1d62.1682179372.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Apr 22, 2023 at 09:47:33PM +0530, Ritesh Harjani (IBM) wrote:
> During ext4_writepages, ext4 queries dioread_nolock mount option twice
> and if someone remount the filesystem in between with ^dioread_nolock,
> then this can cause an inconsistency causing WARN_ON() to be triggered.
> 
> This fix describes the problem in more detail -
> 
> https://lore.kernel.org/linux-ext4/20230328090534.662l7yxj2e425j7w@quack3/T/#md19c34646e8b4a816498532c298a66ecf2ae77d4
> 
> This test reproduces below warning for me w/o the fix.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 26 at fs/ext4/page-io.c:231 ext4_put_io_end_defer+0xfb/0x140
> Modules linked in:
> CPU: 2 PID: 26 Comm: ksoftirqd/2 Not tainted 6.3.0-rc6-xfstests-00044-ga5c68786f1b1 #23
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ext4_put_io_end_defer+0xfb/0x140
> Code: 5d 41 5e 41 5f e9 a5 73 d0 00 5b 48 89 ef 5d 41 5c 41 5d 41 5e 41 5f e9 d3 fa ff ff 49 83 be a8 03 00 00 00 0f 84 7b ff fd
> <...>
> Call Trace:
>  <TASK>
>  blk_update_request+0x116/0x4c0
>  ? finish_task_switch.isra.0+0xfb/0x320
>  blk_mq_end_request+0x1e/0x40
>  blk_complete_reqs+0x40/0x50
>  __do_softirq+0xd8/0x3e1
>  ? smpboot_thread_fn+0x30/0x280
>  run_ksoftirqd+0x3a/0x60
>  smpboot_thread_fn+0x1d8/0x280
>  ? __pfx_smpboot_thread_fn+0x10/0x10
>  kthread+0xf6/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2c/0x50
>  </TASK>
> [
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tests/ext4/060     | 88 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/060.out |  2 ++
>  2 files changed, 90 insertions(+)
>  create mode 100755 tests/ext4/060
>  create mode 100644 tests/ext4/060.out
> 
> diff --git a/tests/ext4/060 b/tests/ext4/060
> new file mode 100755
> index 00000000..d9fe1a99
> --- /dev/null
> +++ b/tests/ext4/060
> @@ -0,0 +1,88 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 060
> +#
> +# This is to test a ext4 regression against inconsistent values of

Great, a new regression test case!

> +# dioread_nolock mount option while in ext4_writepages path.
> +# See - https://lore.kernel.org/linux-ext4/20230328090534.662l7yxj2e425j7w@quack3/T/#md19c34646e8b4a816498532c298a66ecf2ae77d4

You can use the commit id and subject to replace the link.

> +#
> +. ./common/preamble
> +_begin_fstest auto quick

also add mount/remount tag?

> +
> +PID1=""
> +PIDS=""
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +# Override the default cleanup function.
> + _cleanup()
> +{
> +	{
> +		kill -SIGKILL $PID1 $PIDS
> +		wait $PID1 $PIDS
> +	} > /dev/null 2>&1

I think the curly braces "{ }" is not necessary. Refer to generic/390 to deal
with the background processes.

[ -n "$PIDS" ] && kill -9 $PIDS
wait $PIDS

> +
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> + . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.

Remove this comment.

> +_supported_fs ext4

_fixed_by_kernel_commit ?

> +_require_scratch
> +
> +_scratch_mkfs_ext4 >> $seqres.full 2>&1
> +_scratch_mount
> +_scratch_remount "dioread_nolock" >> $seqres.full 2>&1
> +ret=$?

If the "$ret" is only used once as below...

> +if [ $ret -ne 0 ]; then

... then we can use "$?" directly.

> +	_notrun "dioread_nolock mount option not supported"

When ext4 start to support dioread_nolock/dioread_lock ?

If it's old enough, we don't need to check this option. Or we can have a new
helper (e.g. require_scratch_ext4_mount_option()). You can refer to
_require_scratch_ext4_feature(), or maybe we can change it to support mount
option test.

> +fi
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +function run_buff_io_loop()
> +{
> +	# add buffered io case here
> +	while [ 1 ]; do
> +		xfs_io -fc "truncate 0" -c "pwrite 0 200M" -c "fsync" "$testfile.$1" > /dev/null 2>&1

I only find the $testfile is used at here once, if so you can make it as
a local variable of this function.

> +		sleep 2;
> +	done
> +}
> +
> +function run_remount_loop()
> +{
> +	# add remount loop case here
> +	while [ 1 ]; do
> +		_scratch_remount "dioread_nolock" >> $seqres.full 2>&1
> +		sleep 1
> +		_scratch_remount "dioread_lock" >> $seqres.full 2>&1
> +		sleep 1
> +	done
> +}
> +
> +run_remount_loop &
> +PID1=$!

If you don't need to kill these processes in a specific order, I think
you can:

PIDS=$!

> +for i in $(seq 1 20); do
> +	run_buff_io_loop $i &
> +	PID=$!
> +	PIDS="${PIDS} ${PID}"

PIDS="$PIDS $!"

> +done
> +
> +sleep 10

$((10 * TIME_FACTOR)) ?

> +
> +{
> +	kill -SIGKILL $PID1 $PIDS
> +	wait $PID1 $PIDS
> +} > /dev/null 2>&1

kill -9 $$PIDS
wait $PIDS
unset PIDS

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/060.out b/tests/ext4/060.out
> new file mode 100644
> index 00000000..8ffce4de
> --- /dev/null
> +++ b/tests/ext4/060.out
> @@ -0,0 +1,2 @@
> +QA output created by 060
> +Silence is golden
> --
> 2.39.2
> 

