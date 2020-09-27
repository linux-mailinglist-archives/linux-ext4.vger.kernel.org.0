Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7773A27A20D
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Sep 2020 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgI0Riw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Sep 2020 13:38:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51882 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726239AbgI0Riw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 27 Sep 2020 13:38:52 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08RHcYCh003445
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Sep 2020 13:38:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2C63E42003C; Sun, 27 Sep 2020 13:38:34 -0400 (EDT)
Date:   Sun, 27 Sep 2020 13:38:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200927173834.GA23474@mit.edu>
References: <CALvZod5pERERkxWAJcBrZHpcWQH75kXkys2gUg__qM9OL+MmtQ@mail.gmail.com>
 <20200925191902.543953-1-shakeelb@google.com>
 <20200925205604.GA2228989@carbon.dhcp.thefacebook.com>
 <CALvZod5ETbjn7Y0A619Sd+sFO_9QCnUDC-_pBXPgq9AkAK0LRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5ETbjn7Y0A619Sd+sFO_9QCnUDC-_pBXPgq9AkAK0LRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 02:18:48PM -0700, Shakeel Butt wrote:
> 
> Yes, you are right. Let's first get this patch tested and after
> confirmation we can update the commit message.

Thanks Shakeel!  I've tested your patch, as well as reverting the
three commits that Linus had suggested, and both seem to address the
problem for me as well.  I did see a small number of failures
immediately as soon as the VM has booted, when testing with the
"revert the three commits" but this appears to be a different failure,
which I had been seeing periodically during the bisect as well which
was no doubt introducing noise in my testing:

[   28.545018] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [swapper/1:0]
[   28.545018] Modules linked in:
[   28.545018] irq event stamp: 4517759
[   28.545018] hardirqs last  enabled at (4517758): [<ffffffffaa600b9e>] asm_common_interrupt+0x1e/0x40
[   28.545018] hardirqs last disabled at (4517759): [<ffffffffaa5ee55b>] sysvec_apic_timer_interrupt+0xb/0x90
[   28.545018] softirqs last  enabled at (10634): [<ffffffffa9ac00fd>] irq_enter_rcu+0x6d/0x70
[   28.545018] softirqs last disabled at (10635): [<ffffffffaa600f72>] asm_call_on_stack+0x12/0x20
[   28.545018] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc6-xfstests-00007-g3f3cb48a7d90 #1916
[   28.545018] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[   28.545018] RIP: 0010:__do_softirq+0xa3/0x435
[   28.545018] Code: 00 83 80 ac 07 00 00 01 48 89 44 24 08 c7 44 24 1c 0a 00 00 00 65 66 c7 05 a8 ae 9e 55 00 00 e8 d3 92 3b ff fb b8 ff ff ff ff <48> c7 c3 40 51 00 ab 41 0f bc c7 89 c6 83 c6 01 89 74 24 04 75 6a
[   28.545018] RSP: 0000:ffffb89f000e0f98 EFLAGS: 00000202
[   28.545018] RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 000000000000298a
[   28.545018] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffaa80009d
[   28.545018] RBP: ffffb89f000abda0 R08: 0000000000000001 R09: 0000000000000000
[   28.545018] R10: 0000000000000001 R11: 0000000000000046 R12: 0000000000000001
[   28.545018] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000080
[   28.545018] FS:  0000000000000000(0000) GS:ffff998e59200000(0000) knlGS:0000000000000000
[   28.545018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.545018] CR2: 0000000000000000 CR3: 000000023e012001 CR4: 00000000001706e0
[   28.545018] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   28.545018] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   28.545018] Call Trace:
[   28.545018]  <IRQ>
[   28.545018]  asm_call_on_stack+0x12/0x20
[   28.545018]  </IRQ>
[   28.545018]  do_softirq_own_stack+0x4e/0x60
[   28.545018]  irq_exit_rcu+0x9f/0xe0
[   28.545018]  sysvec_call_function_single+0x43/0x90
[   28.545018]  asm_sysvec_call_function_single+0x12/0x20
[   28.545018] RIP: 0010:acpi_idle_do_entry+0x54/0x70
[   28.545018] Code: ed c3 e9 cf fe ff ff 65 48 8b 04 25 00 6e 01 00 48 8b 00 a8 08 75 ea e8 ba c0 5b ff e9 07 00 00 00 0f 00 2d f8 3d 4e 00 fb f4 <9c> 58 fa f6 c4 02 74 cf e9 5f c2 5b ff cc cc cc cc cc cc cc cc cc
[   28.545018] RSP: 0000:ffffb89f000abe88 EFLAGS: 00000202
[   28.545018] RAX: 000000000000293b RBX: ffff998e55640000 RCX: 0000000000001a12
[   28.545018] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffaa5fd2b6
[   28.545018] RBP: ffffffffab163760 R08: 0000000000000001 R09: 00000000000e003c
[   28.545018] R10: ffff998e582e2340 R11: 0000000000000046 R12: 0000000000000001
[   28.545018] R13: 0000000000000001 R14: ffffffffab1637e0 R15: 0000000000000000
[   28.545018]  ? acpi_idle_do_entry+0x46/0x70
[   28.545018]  ? acpi_idle_do_entry+0x46/0x70
[   28.545018]  acpi_idle_enter+0x7d/0xb0
[   28.545018]  cpuidle_enter_state+0x84/0x2c0
[   28.545018]  cpuidle_enter+0x29/0x40
[   28.545018]  cpuidle_idle_call+0x111/0x180
[   28.545018]  do_idle+0x7b/0xd0
[   28.545018]  cpu_startup_entry+0x19/0x20
[   28.545018]  secondary_startup_64+0xb6/0xc0

I think this was an issue relating to acpi_idle that others have
reported, but I thought this was fixed before -rc6 was released?  In
any case, this is post -rc6, so apparently there is something else
going on here, and this is probably unrelated to the regression which
Shakeel's patch is addressing.

					- Ted
