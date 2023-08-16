Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353E677D872
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 04:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjHPC3S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 22:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbjHPC3D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 22:29:03 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ECF1BE6
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 19:29:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G2SqM3021107
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 22:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692152934; bh=Tqzc6H21Z5tRhTJIgrgKqSfa8TiyK0F3Ud9NCiMZK/A=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=aLdMHT7WV2jz7+Y3WXrBLdjFizcOCRkXODCFec6ifdZG037N42OPLao+xQbCeOc2h
         hFFAzO4iqdsybeFmN93kkPU7Zl98s/7lRqY1YjUB9WCuXtcoGa5YJ8Y6+xp2tS/kxp
         uG7uCuLURWt61hzPFEhwRLpIRCzBmShaar7To9/zj1T5el3TUVQ6se2Ku0zKb+UYhC
         bP5qhw9q3zBGGicCd9GV5QEK8dj5a74kl4TMVFaPQ/ip2hQU9PH0Sh1o4YAfaG8bOk
         Jf3BYBJHXBKVUtn5gKYKRMdxW8oU2DuQJEozI4m7I3HbTgIJg0nxifm/o+IbFfyPe4
         V/Vnt7CJVKfVg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E70D915C0292; Tue, 15 Aug 2023 22:28:51 -0400 (EDT)
Date:   Tue, 15 Aug 2023 22:28:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Park, SeongJae" <sjpark@amazon.com>
Subject: Re: Tasks stuck jbd2 for a long time
Message-ID: <20230816022851.GH2247938@mit.edu>
References: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It would be helpful if you can translate address in the stack trace to
line numbers.  See [1] and the script in
./scripts/decode_stacktrace.sh in the kernel sources.  (It is
referenced in the web page at [1].)

[1] https://docs.kernel.org/admin-guide/bug-hunting.html

Of course, in order to interpret the line numbers, we'll need a
pointer to the git repo of your kernel sources and the git commit ID
you were using that presumably corresponds to 5.10.184-175.731.amzn2.x86_64.

The stack trace for which I am particularly interested is the one for
the jbd2/md0-8 task, e.g.:

>       Not tainted 5.10.184-175.731.amzn2.x86_64 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:jbd2/md0-8      state:D stack:    0 pid: 8068 ppid:     2
> flags:0x00004080
> Call Trace:
> __schedule+0x1f9/0x660
>  schedule+0x46/0xb0
>  jbd2_journal_commit_transaction+0x35d/0x1880 [jbd2]  <--------- line #?
>  ? update_load_avg+0x7a/0x5d0
>  ? add_wait_queue_exclusive+0x70/0x70
>  ? lock_timer_base+0x61/0x80
>  ? kjournald2+0xcf/0x360 [jbd2]
>  kjournald2+0xcf/0x360 [jbd2]

Most of the other stack traces you refenced are tasks that are waiting
for the transaction commit to complete so they can proceed with some
file system operation.  The stack traces which have
start_this_handle() in them are examples of this going on.  Stack
traces of tasks that do *not* have start_this_handle() would be
specially interesting.

The question is why is the commit thread blocking, and on what.  It
could be blocking on some I/O; or some memory allocation; or waiting
for some process with an open transation handle to close it.  The line
number of the jbd2 thread in fs/jbd2/commit.c will give us at least a
partial answer to that question.  Of course, then we'll need to answer
the next question --- why is the I/O blocked?  Or why is the memory
allocation not completing?   etc.

I could make some speculation (such as perhaps some memory allocation
is being made without GFP_NOFS, and this is causing a deadlock between
the memory allocation code which is trying to initiate writeback, but
that is blocked on the transaction commit completing), but without
understanding what the jbd2_journal_commit_transaction() is blocking
at  jbd2_journal_commit_transaction+0x35d/0x1880, that would be justa
guess - pure speculation --- without knowing more.

Cheers,

						- Ted
