Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB77802FE
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 03:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350591AbjHRBUJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 21:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356852AbjHRBTv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 21:19:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70A3A99
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 18:19:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I1JbFP031025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 21:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692321579; bh=N9xq8ez1R4EYiLuS925H02h8PtkhiCpRuEH5JezPpjU=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Vy6XAfC2pLW4p2NCVrbi/0ffp54RIr9cx+fikDdMnSuYQvNZeBRUc2Qd8LyaauyW9
         4RCk8nv1E5bvO2fdPmkcBo+y9CdTN9o8R0S1s7wz9rSYIF/JhuysZfY2w4LEAtrDpW
         NvBG73U+BclKH3L4jzKhits/7loHmPpuviMemy0T98LSHj7saR1gp1yc0yFMJJUn9O
         62A9i8Cnzqo6VS3opXexP4s5MzdepxuwPjZv9Iob8uNk0Pao7zqcw826jawT9RZpcf
         9oamIZefUq10n9TzAO/HXoI6RYr99Uh6HAjzrCetyVRwuMF8D2YgYF8BNT1S8+qbCU
         q9KPIhO17yg7A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 22C4515C0501; Thu, 17 Aug 2023 21:19:37 -0400 (EDT)
Date:   Thu, 17 Aug 2023 21:19:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Park, SeongJae" <sjpark@amazon.com>
Subject: Re: Tasks stuck jbd2 for a long time
Message-ID: <20230818011937.GA3464136@mit.edu>
References: <153d081d-e738-b916-4f72-364b2c1cc36a@amazon.com>
 <20230816022851.GH2247938@mit.edu>
 <17b6398c-859e-4ce7-b751-8688a7288b47@amazon.com>
 <20230816145310.giogco2nbzedgak2@quack3>
 <e716473e-7251-7a81-fa5e-6bf6ba34e49f@amazon.com>
 <20230816215227.jlvmqasfbc73asi4@quack3>
 <7f687907-8982-3be6-54ee-f55aae2f4692@amazon.com>
 <20230817104917.bs46doo6duo7utlm@quack3>
 <f8b8e655-7485-ef11-e151-7118b1531f16@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8b8e655-7485-ef11-e151-7118b1531f16@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 17, 2023 at 11:59:03AM -0700, Bhatnagar, Rishabh wrote:
> 
> I think I found the thread that is holding the transaction handle. It seems
> to be in runnable state though.

This looks like it's case of livelock...

> It has the journal_info set to the journal handle that has the matching
> transaction as the journal's running transaction.
> Here is the associated stack trace. It is converting unwritten extents to
> extents.
> 
> PID: 287    TASK: ffff976801890000  CPU: 20  COMMAND: "kworker/u96:35"
>  #0 [ffffbd6c40b3f498] __schedule+617 at ffffffffbb912df9
>  #1 [ffffbd6c40b3f530] _cond_resched+38 at ffffffffbb9133e6
>  #2 [ffffbd6c40b3f538] shrink_lruvec+670 at ffffffffbb244d1e
>  #3 [ffffbd6c40b3f640] _cond_resched+21 at ffffffffbb9133d5
>  #4 [ffffbd6c40b3f648] shrink_node+552 at ffffffffbb2452a8
>  #5 [ffffbd6c40b3f6c8] do_try_to_free_pages+201 at ffffffffbb245829
>  #6 [ffffbd6c40b3f718] try_to_free_pages+239 at ffffffffbb246c0f
>  #7 [ffffbd6c40b3f7b0] __alloc_pages_slowpath.constprop.114+913 at
> ffffffffbb28d741
>  #8 [ffffbd6c40b3f890] __alloc_pages_nodemask+679 at ffffffffbb28e2e7
>  #9 [ffffbd6c40b3f900] allocate_slab+726 at ffffffffbb2b0886
> #10 [ffffbd6c40b3f958] ___slab_alloc+1173 at ffffffffbb2b3ff5
> #11 [ffffbd6c40b3f988] insert_revoke_hash+37 at ffffffffc016f435 [jbd2] 
> (/home/ec2-user/linux/fs/jbd2/revoke.c:146)

insert_revoke_hash is trying to do a memory allocation of a 48 byte
structure using kmem_cache_alloc() with the __GFP_NOFAIL bit set.  (We
use GFP_NOFAIL because if the memory allocation fails, the only
recourse we can have is to shut down the journal and force the file
system to be read-only --- or crash the system, of course.)

Since we have set __GFP_NOFAIL, the memory allocator is apparently not
able to find even a single free page for the slab allocator, and so
it's apparently trying and trying to free memory --- and failing
miserably.

Hmm... something that might be worth trying is to see if running the
job in a memcg, since how the kernel handles OOM, and how it will
handle OOM kills will differ depending whether is getting constrained
by container memory or by completely running out of memory.

I wonder why this version of the 5.10 kernel isn't solving the problem
performing an OOM kill to free memory.  We're running a 5.10 based
kernel in our data centers at $WORK, and normally the OOM killer is
quite free to make memory available by killing as necessasry deal with
these situations.  (As Spock once said, "The needs of the many
outweighs the needs of the few --- or the one."  And sometimes the
best way to keep the system running is to sacrifice one of the
userspace processes.)  Do you by any chance have all or most of the
user processes exempted from the OOM killer?

> #16 [ffffbd6c40b3faa0] __ext4_forget+338 at ffffffffc02efb32 [ext4] 
> (/home/ec2-user/linux/fs/ext4/ext4_jbd2.c:298)
> #17 [ffffbd6c40b3fae0] ext4_free_blocks+2437 at ffffffffc031fd55 [ext4]
> (/home/ec2-user/linux/fs/ext4/mballoc.c:5709 (discriminator 2))
> #18 [ffffbd6c40b3fbb0] ext4_ext_handle_unwritten_extents+596 at
> ffffffffc02f56a4 [ext4] ((inlined by) ext4_ext_handle_unwritten_extents at
> /home/ec2-user/linux/fs/ext4/extents.c:3892)

This part of the stack trace is weird.  I don't see what callees of
ext4_ext_handle_unwritten_extents() would result in ext4_free_blocks()
getting called.  Unfortunately, the code is very heavily inlined, and
we only see the first level of inlining.  My best guess is that it was
in some error handling code, such as this:

	if (err) {
		/* free all allocated blocks in error case */
		for (i = 0; i < depth; i++) {
			if (!ablocks[i])
				continue;
			ext4_free_blocks(handle, inode, NULL, ablocks[i], 1,
					 EXT4_FREE_BLOCKS_METADATA);
		}
	}

... and this call to ext4_free_blocks() resulted in the call to
__ext4_forget, which in turn tried to create a journal revoke record.

And the cause of the error may very well have been caused by some
other memory allocation, if the system was so desperately low on
memory.


Anyway, the big question is why the system allowed the system to get
so low in memory in the first place.  In addition to OOM killing
processes, one of the things that Linux is supposed to do is "write
throttling", where if a process is dirtying too many pages, to put the
guilty processes to sleep so that page cleaning can have a chance to
catch up.

Quoting from section 14.1.5 (Writeback) from [1]:

    As applications write to files, the pagecache becomes dirty and
    the buffercache may become dirty. When the amount of dirty memory
    reaches a specified number of pages in bytes
    (vm.dirty_background_bytes), or when the amount of dirty memory
    reaches a specific ratio to total memory
    (vm.dirty_background_ratio), or when the pages have been dirty for
    longer than a specified amount of time
    (vm.dirty_expire_centisecs), the kernel begins writeback of pages
    starting with files that had the pages dirtied first. The
    background bytes and ratios are mutually exclusive and setting one
    will overwrite the other. Flusher threads perform writeback in the
    background and allow applications to continue running. If the I/O
    cannot keep up with applications dirtying pagecache, and dirty
    data reaches a critical setting (vm.dirty_bytes or
    vm.dirty_ratio), then applications begin to be throttled to
    prevent dirty data exceeding this threshold.

[1] https://documentation.suse.com/sles/15-SP3/html/SLES-all/cha-tuning-memory.html

So it might be worth looking at if your system has non-default values
for /proc/sys/vm/{dirty_bytes,dirty_ratio,dirty_background_bytes,etc.}.

Cheers,

					- Ted
