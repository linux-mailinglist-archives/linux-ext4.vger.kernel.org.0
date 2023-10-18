Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799147CD16D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 02:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjJRAoD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Oct 2023 20:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjJRAoD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Oct 2023 20:44:03 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EDAF7
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 17:44:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39I0hZXS011900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 20:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1697589818; bh=P9/9YNXWwQxn0dILxlsrcPkLVXG8uSZ/9sAG6wchdLs=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=gWpxmVvLJ1ex0TOrGNOUOEHmqFE20WTcXwWrLrd0cmIAaWsZfGa6nauLkjSZubAnc
         oegqAzfReC3nIwHDmoaSzNgZHtmplOXJt59nM+dTydZUGpnvSAPuCz6gM0Qp5CNlWc
         uki7a6lT6Qweog3YKDJLcCShn2ygd4QrUIT5FT/Mgju4fh8mBlGQNTC/Hw8axHUzBX
         M4d51sAeF1W7HK3gPbpAjdmd6Y4ScICF9U6zQf1A2o0qzd1yyOO+igPZTWKxTG0g6J
         8TtH9jtgL2vcYBy+9rWIdei1WwBzAUXZv07peMOEIJCVSp82XMc8FdLTukB3Jox9AL
         POGIP/lP8WmHQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8868A15C0243; Tue, 17 Oct 2023 20:43:35 -0400 (EDT)
Date:   Tue, 17 Oct 2023 20:43:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andres Freund <andres@anarazel.de>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-ext4@vger.kernel.org,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, gustavo.padovan@collabora.com,
        zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: task hung in ext4_fallocate #2
Message-ID: <20231018004335.GA593012@mit.edu>
References: <20231017033725.r6pfo5a4ayqisct7@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017033725.r6pfo5a4ayqisct7@awork3.anarazel.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 16, 2023 at 08:37:25PM -0700, Andres Freund wrote:
> I just was able to reproduce the issue, after upgrading to 6.6-rc6 - this time
> it took ~55min of high load (io_uring using branch of postgres, running a
> write heavy transactional workload concurrently with concurrent bulk data
> load) to trigger the issue.
> 
> For now I have left the system running, in case there's something you would
> like me to check while the system is hung.
> 
> The first hanging task that I observed:
> 
> cat /proc/57606/stack
> [<0>] inode_dio_wait+0xd5/0x100
> [<0>] ext4_fallocate+0x12f/0x1040
> [<0>] vfs_fallocate+0x135/0x360
> [<0>] __x64_sys_fallocate+0x42/0x70
> [<0>] do_syscall_64+0x38/0x80
> [<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

This stack trace is from some process (presumably postgres) trying to
do a fallocate() system call:

	/* Wait all existing dio workers, newcomers will block on i_rwsem */
	inode_dio_wait(inode);

The reason for this is that we can't manipulate the extent tree until
any data block I/Os comlplete.  This will block until
iomap_dio_complete() in fs/iomap/direct-io.c calls inode_dio_end().

> [ 3194.579297] INFO: task iou-wrk-58004:58874 blocked for more than 122 seconds.
> [ 3194.579304]       Not tainted 6.6.0-rc6-andres-00001-g01edcfe38260 #77
> [ 3194.579310] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 3194.579314] task:iou-wrk-58004   state:D stack:0     pid:58874 ppid:52606  flags:0x00004000
> [ 3194.579325] Call Trace:
> [ 3194.579329]  <TASK>
> [ 3194.579334]  __schedule+0x388/0x13e0
> [ 3194.579349]  schedule+0x5f/0xe0
> [ 3194.579361]  schedule_preempt_disabled+0x15/0x20
> [ 3194.579374]  rwsem_down_read_slowpath+0x26e/0x4c0
> [ 3194.579385]  down_read+0x44/0xa0
> [ 3194.579393]  ext4_file_write_iter+0x432/0xa80
> [ 3194.579407]  io_write+0x129/0x420

This could potentially be a interesting stack trace; but this is where
we really need to map the stack address to line numbers.  Is that
something you could do?

> Once I hear that you don't want me to test something out on the running
> system, I think a sensible next step could be to compile with lockdep and see
> if that finds a problem?

That's certainly a possibiity.  But also please make sure that you can
compile with with debugging information enabled so that we can get
reliable line numbers.  I use:

CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
CONFIG_DEBUG_INFO_REDUCED=y

Cheers,

						- Ted
