Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835E07CD270
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 04:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjJRCuS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Oct 2023 22:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJRCuR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Oct 2023 22:50:17 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7837CAB
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 19:50:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 85C403200A12;
        Tue, 17 Oct 2023 22:50:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 22:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1697597412; x=1697683812; bh=z4
        oHDsicD1rLu4S9/g9h5gETwcA1PGj1NpkRk4ugOM0=; b=fuUoZRRKm+XgMDA2XT
        huSFR7PIJUjgIXmT0hCna1UVNf5OB2D9tiK+amsyl3zLLNPXYu0/t6V/8rwok+do
        CjXAQEKom2776T+2jhjfp6d1j21IbypnQ0IfcmiRaRsdiFPrbLq+7MneZ0u3gRVb
        PTpdDsCP2iDE/HewhvkGjSH82JwsJ0viDaF8suaJpRB4k9LO5/JHFQia125UxAfh
        48/4oYSA2wyI7KAUlWMm97orvzvyWiPbCgnM9nbh6XPmvQQ3oAYNGRCpna685A/e
        pq+9hf+EsD6lCm8qbDb9UxIj76Z2xAYIyyabsakPYfez6ooWm32nx+XUyoAZZBYr
        AhGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697597412; x=1697683812; bh=z4oHDsicD1rLu
        4S9/g9h5gETwcA1PGj1NpkRk4ugOM0=; b=aYKCMRYENItiD0nqLypQckdompVuG
        kvZprG75SEGiZS2LRua1nfE4tD/3xB6WklML2qSUCyzqTm2MxLd2q2BCNRqeudpp
        kSe/sMBdHCk3tAP0aszcIsEQZiAIEVOV3MJgfHje/Zi4m51ZRq3xgx/YtULTd1Po
        +2pLiQFaUJj0WplQ4XMxzdMQJlmN3cl3N22VTSueu1RHFJ/zpRFae/ZVzTtXToZx
        2G5cOFjmBx7wg05I2aZNu6mDUqmpN61kz+VQSVJas7XKb8YSpkjPTFEVxwilLKMW
        DWdrg7GtWBSoHfLriqP5k8o7Lgf6kQvoGNl/BFF4pl4kTziGqSViBIFMQ==
X-ME-Sender: <xms:40cvZcBMHyzxjOjGeRj1Hwk7RoKApY8lZdr3YnxMDbLlxtf0aiQRYA>
    <xme:40cvZehJPnFRaaThjm0xQwAnuDuV6uqFoJwM3tqkM_8Pgp5EdoYvBMqJoKhxrl-vq
    Fo5KVD90XIjx_6Jow>
X-ME-Received: <xmr:40cvZfk_LHfUBP_QHoXIxDAy9KAG0GqnfSHFH6qyDr1lqENdgmJNEiFT17IaMC3hGTpG6IQFVQUO5MPXi-0MFEOwa6eWhe3nUZclyEFiDuZ8UgNHTgSOtlCeLzJq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteevudei
    tedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:40cvZSxfwKvZfmDpWE3K_-enm_GpmPaXvYe4yiWER22XcbixRuUSrQ>
    <xmx:40cvZRTSPRfG6JgOzq8632DyYwAsQuG412noINMq4S8zUvtU_WEBAQ>
    <xmx:40cvZdYGZ_MXrElfrK40pZUL5DswDLqq0ajTOAfwjyFolG0tDbZLfg>
    <xmx:5EcvZSQe7qxds4SoU_kUBxlL79HC-bfvqJQKtZxpCTEnRUERHgTNeA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 22:50:11 -0400 (EDT)
Date:   Tue, 17 Oct 2023 19:50:09 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-ext4@vger.kernel.org,
        Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        gustavo.padovan@collabora.com, zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: task hung in ext4_fallocate #2
Message-ID: <20231018025009.ulkykpefwdgpfvzf@awork3.anarazel.de>
References: <20231017033725.r6pfo5a4ayqisct7@awork3.anarazel.de>
 <20231018004335.GA593012@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018004335.GA593012@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On 2023-10-17 20:43:35 -0400, Theodore Ts'o wrote:
> On Mon, Oct 16, 2023 at 08:37:25PM -0700, Andres Freund wrote:
> > I just was able to reproduce the issue, after upgrading to 6.6-rc6 - this time
> > it took ~55min of high load (io_uring using branch of postgres, running a
> > write heavy transactional workload concurrently with concurrent bulk data
> > load) to trigger the issue.
> >
> > For now I have left the system running, in case there's something you would
> > like me to check while the system is hung.
> >
> > The first hanging task that I observed:
> >
> > cat /proc/57606/stack
> > [<0>] inode_dio_wait+0xd5/0x100
> > [<0>] ext4_fallocate+0x12f/0x1040
> > [<0>] vfs_fallocate+0x135/0x360
> > [<0>] __x64_sys_fallocate+0x42/0x70
> > [<0>] do_syscall_64+0x38/0x80
> > [<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> This stack trace is from some process (presumably postgres) trying to
> do a fallocate() system call:

Yes, it's indeed postgres.


> > [ 3194.579297] INFO: task iou-wrk-58004:58874 blocked for more than 122 seconds.
> > [ 3194.579304]       Not tainted 6.6.0-rc6-andres-00001-g01edcfe38260 #77
> > [ 3194.579310] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [ 3194.579314] task:iou-wrk-58004   state:D stack:0     pid:58874 ppid:52606  flags:0x00004000
> > [ 3194.579325] Call Trace:
> > [ 3194.579329]  <TASK>
> > [ 3194.579334]  __schedule+0x388/0x13e0
> > [ 3194.579349]  schedule+0x5f/0xe0
> > [ 3194.579361]  schedule_preempt_disabled+0x15/0x20
> > [ 3194.579374]  rwsem_down_read_slowpath+0x26e/0x4c0
> > [ 3194.579385]  down_read+0x44/0xa0
> > [ 3194.579393]  ext4_file_write_iter+0x432/0xa80
> > [ 3194.579407]  io_write+0x129/0x420
>
> This could potentially be a interesting stack trace; but this is where
> we really need to map the stack address to line numbers.  Is that
> something you could do?

Converting the above with scripts/decode_stacktrace.sh yields:

__schedule (kernel/sched/core.c:5382 kernel/sched/core.c:6695)
schedule (./arch/x86/include/asm/preempt.h:85 (discriminator 13) kernel/sched/core.c:6772 (discriminator 13))
schedule_preempt_disabled (./arch/x86/include/asm/preempt.h:80 (discriminator 10) kernel/sched/core.c:6831 (discriminator 10))
rwsem_down_read_slowpath (kernel/locking/rwsem.c:1073 (discriminator 4))
down_read (./arch/x86/include/asm/preempt.h:95 kernel/locking/rwsem.c:1257 kernel/locking/rwsem.c:1263 kernel/locking/rwsem.c:1522)
ext4_file_write_iter (./include/linux/fs.h:1073 fs/ext4/file.c:57 fs/ext4/file.c:564 fs/ext4/file.c:715)
io_write (./include/linux/fs.h:1956 io_uring/rw.c:926)

But I'm not sure that that stacktrace is quite right (e.g. what's
./include/linux/fs.h:1073 doing in this stacktrace?). But with an optimized
build it's a bit hard to tell what's an optimization artifact and what's an
off stack trace...


I had the idea to look at the stacks (via /proc/$pid/stack) for all postgres
processes and the associated io-uring threads, and then to deduplicate them.

22x:
ext4_file_write_iter (./include/linux/fs.h:1073 fs/ext4/file.c:57 fs/ext4/file.c:564 fs/ext4/file.c:715)
io_write (./include/linux/fs.h:1956 io_uring/rw.c:926)
io_issue_sqe (io_uring/io_uring.c:1878)
io_wq_submit_work (io_uring/io_uring.c:1960)
io_worker_handle_work (io_uring/io-wq.c:596)
io_wq_worker (io_uring/io-wq.c:258 io_uring/io-wq.c:648)
ret_from_fork (arch/x86/kernel/process.c:147)
ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

8x:
__do_sys_io_uring_enter (io_uring/io_uring.c:2553 (discriminator 1) io_uring/io_uring.c:2622 (discriminator 1) io_uring/io_uring.c:3706 (discriminator 1))
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

2x:
io_wq_worker (./arch/x86/include/asm/current.h:41 (discriminator 5) io_uring/io-wq.c:668 (discriminator 5))
ret_from_fork (arch/x86/kernel/process.c:147)
ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

2x:
futex_wait_queue (./arch/x86/include/asm/current.h:41 (discriminator 5) kernel/futex/waitwake.c:357 (discriminator 5))
futex_wait (kernel/futex/waitwake.c:660)
do_futex (kernel/futex/syscalls.c:106 (discriminator 1))
__x64_sys_futex (kernel/futex/syscalls.c:183 kernel/futex/syscalls.c:164 kernel/futex/syscalls.c:164)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

1x:
do_epoll_wait (fs/eventpoll.c:1921 (discriminator 1) fs/eventpoll.c:2318 (discriminator 1))
__x64_sys_epoll_wait (fs/eventpoll.c:2325)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

1x:
inode_dio_wait (./arch/x86/include/asm/atomic.h:23 ./include/linux/atomic/atomic-arch-fallback.h:444 ./include/linux/atomic/atomic-instrumented.h:33 fs/inode.c:2429 fs/inode.c:2446)
ext4_fallocate (fs/ext4/extents.c:4752)
vfs_fallocate (fs/open.c:324)
__x64_sys_fallocate (./include/linux/file.h:45 fs/open.c:348 fs/open.c:355 fs/open.c:353 fs/open.c:353)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)




> > Once I hear that you don't want me to test something out on the running
> > system, I think a sensible next step could be to compile with lockdep and see
> > if that finds a problem?
>
> That's certainly a possibiity.  But also please make sure that you can
> compile with with debugging information enabled so that we can get
> reliable line numbers.  I use:
>
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> CONFIG_DEBUG_INFO_REDUCED=y

The kernel from above had debug info enabled, albeit forced to dwarf4 (IIRC I
ran into issues with pahole not understanding all of dwarf5):

$ zgrep DEBUG_INFO /proc/config.gz
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_COMPRESSED_ZSTD is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y

I switched it to CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y and am rebuilding
with lockdep enabled. Curious to see how long it'll take to trigger the
problem with it enabled...

Greetings,

Andres Freund
