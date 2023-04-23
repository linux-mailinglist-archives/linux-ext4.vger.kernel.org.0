Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491D36EC106
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Apr 2023 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjDWQVe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 12:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDWQVd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 12:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF72E79
        for <linux-ext4@vger.kernel.org>; Sun, 23 Apr 2023 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682266845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wB5eqSaCz8VBK1VuTRwVWDZpYEGkTWsBMz/FZi+lDX4=;
        b=eAVnMKj6bp5RUKeKbP7SDm+sAVYfzuJnhBkqbET4aQnuUvAz7BEBNP0NMED2GImE07Qdqc
        6hkeJyIyuZ0EzuhYbdcFUPAUtGDGypW9KLiARFn6YrSEnHX9DqtSyumLC1fgcIshtJEB+v
        t5cS9FrxzfAEhldWU0sRP7rx8/FZWkI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-v2uCJsIXOQqud0fth-7qKg-1; Sun, 23 Apr 2023 12:20:43 -0400
X-MC-Unique: v2uCJsIXOQqud0fth-7qKg-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1a6a747efb9so39115115ad.2
        for <linux-ext4@vger.kernel.org>; Sun, 23 Apr 2023 09:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682266842; x=1684858842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB5eqSaCz8VBK1VuTRwVWDZpYEGkTWsBMz/FZi+lDX4=;
        b=bu64WJKwvRqXCqRZ5aqI3P3sBzaxjLxIdSceU1t66fchODucJ3tBwOaaa2mMBVmFaI
         8sXqUyFsZDI8a3uco1BsLdRjm8OhigHRWYqf7AenVT+0R8MsPExp1eAXMy3XkpZ37xiB
         mRiqT0vXWh8bmmutl4bp/5FpXESQ5YEqEDEkrZ2l1nezrTTAdXxVPdm/CGePfTuG6Im2
         Y/O0SyzymTTnNSUlieL1MWQhWwNbRFdOM8rm+qMs4J/aWYEeNdcE6GdQQKGSkBgqo3b0
         ndX1cVeRMlBKh8v6B3/dTDSNRqbf+A3zofBbIMpEfeCz9/67wpVRZHuLGt0MYlENu+9Q
         015A==
X-Gm-Message-State: AAQBX9eMSem2W9HPBkJUmlwxQAyTr3+v/bVZgfBA7mxsH5MFh8yLlmTs
        QhAXUpk3EjdSLdsgytiTU9cZ7YfcbfRJg43fxmusGtgjtJYgO2HA0DHk2//gwgEAO+lOzjCajuh
        GuFEmNN8qBwKb6cmfg1/aOcagp8kPmLiyY+s=
X-Received: by 2002:a17:902:d590:b0:1a5:2540:729 with SMTP id k16-20020a170902d59000b001a525400729mr11574769plh.56.1682266842394;
        Sun, 23 Apr 2023 09:20:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350YvD04fFalAuMCpC7d06OQh/mR+x7jjXbdhUX8TgXjgGA8lQoAGom89fcCKMAhlmfl6I0zzcw==
X-Received: by 2002:a17:902:d590:b0:1a5:2540:729 with SMTP id k16-20020a170902d59000b001a525400729mr11574757plh.56.1682266842092;
        Sun, 23 Apr 2023 09:20:42 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001a686578b44sm5263085pld.110.2023.04.23.09.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 09:20:41 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:20:37 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [RFC 2/2] ext4/061: Regression test of jbd2 journal_task race
 against unmount
Message-ID: <20230423162037.6kpvxqsnomvtxsmn@zlang-mailbox>
References: <aa8a633b016114b94d10dd0f9f0b7a355aeb1d62.1682179372.git.ritesh.list@gmail.com>
 <75819a20d2337c154e360c60ec53b7e519ebb97a.1682179372.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75819a20d2337c154e360c60ec53b7e519ebb97a.1682179372.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Apr 22, 2023 at 09:47:34PM +0530, Ritesh Harjani (IBM) wrote:
> This test adds a testcase to catch race condition against
> reading of journal_task and parallel unmount.
> This patch in kernel fixes this [1]
> 
>     ext4_put_super()                cat /sys/fs/ext4/loop2/journal_task
>             |                               ext4_attr_show();
>     ext4_jbd2_journal_destroy();                    |
>             |                                journal_task_show()
>             |                                       |
>             |                               task_pid_vnr(NULL);
>     sbi->s_journal = NULL;
> 
> RIP: 0010:__task_pid_nr_ns+0x4d/0xe0
> <...>
> Call Trace:
>  <TASK>
>  ext4_attr_show+0x1bd/0x3e0
>  sysfs_kf_seq_show+0x8e/0x110
>  seq_read_iter+0x11b/0x4d0
>  vfs_read+0x216/0x2e0
>  ksys_read+0x69/0xf0
>  do_syscall_64+0x3f/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [
> 
> [1]: https://lore.kernel.org/all/20200318061301.4320-1-riteshh@linux.ibm.com/
> Commit: ext4: Unregister sysfs path before destroying jbd2 journal
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tests/ext4/061     | 82 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/061.out |  2 ++
>  2 files changed, 84 insertions(+)
>  create mode 100755 tests/ext4/061
>  create mode 100644 tests/ext4/061.out
> 
> diff --git a/tests/ext4/061 b/tests/ext4/061
> new file mode 100755
> index 00000000..88bf138a
> --- /dev/null
> +++ b/tests/ext4/061
> @@ -0,0 +1,82 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 061
> +#
> +# Regression test for https://lore.kernel.org/all/20200318061301.4320-1-riteshh@linux.ibm.com/
> +# ext4: Unregister sysfs path before destroying jbd2 journal

The link isn't needed, if you points out the commit id and subject.

> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +pid_mloop=""
> +pids_jloop=""
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	{
> +		kill -SIGKILL $pid_mloop $pids_jloop
> +		wait $pid_mloop $pids_jloop
> +	} > /dev/null 2>&1

[ -n "$pids_jloop" ] && kill -9 $pids_jloop
[ -n "$pid_mloop" ] && kill -9 $pid_mloop
wait

> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs ext4
> +_fixed_by_kernel_commit 5e47868fb94b63c \
> +	"ext4: unregister sysfs path before destroying jbd2 journal"
> +_require_scratch
> +_require_fs_sysfs journal_task
> +
> +_scratch_mkfs_ext4 >> $seqres.full 2>&1
> +# mount filesystem
> +_scratch_mount >> $seqres.full 2>&1
> +scratch_dev=$(_short_dev $SCRATCH_DEV)

The $scratch_dev is only used in read_journal_task_loop() ...

> +
> +function mount_loop()
> +{
> +	while [ 1 ]; do
> +		_scratch_unmount >> $seqres.full 2>&1
> +		sleep 1;
> +		_scratch_mount >> $seqres.full 2>&1

Do you hope to fail the test directly if the mount fails? Or you hope
to use _try_scratch_mount ?

> +		sleep 1;
> +	done
> +}
> +
> +function read_journal_task_loop()
> +{
> +	while [ 1 ]; do
> +		cat /sys/fs/ext4/$scratch_dev/journal_task > /dev/null 2>&1

... so I think you can write this line as:

cat /sys/fs/ext4/$(_short_dev $SCRATCH_DEV)/journal_task ...


BTW, I'm wondering if you need to check the journal_task is supported?

> +		sleep 1;
> +	done
> +}
> +
> +mount_loop &
> +pid_mloop=$!
> +
> +for i in $(seq 1 100); do
> +	read_journal_task_loop &
> +	pid=$!
> +	pids_jloop="${pids_jloop} ${pid}"

pids_jloop="${pids_jloop} $!"

> +done
> +
> +sleep 20

20 * TIME_FACTOR ?

> +{
> +	kill -SIGKILL $pid_mloop $pids_jloop
> +	wait $pid_mloop $pids_jloop
> +} > /dev/null 2>&1

kill -9 $pid_mloop $pids_jloop
wait $pid_mloop $pids_jloop
unset pid_mloop pids_jloop

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/061.out b/tests/ext4/061.out
> new file mode 100644
> index 00000000..273be9e0
> --- /dev/null
> +++ b/tests/ext4/061.out
> @@ -0,0 +1,2 @@
> +QA output created by 061
> +Silence is golden
> --
> 2.39.2
> 

