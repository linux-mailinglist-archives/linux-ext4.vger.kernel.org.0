Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C15C99F0
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 10:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJCIc6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 04:32:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:33028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfJCIc6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 04:32:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B08FB125;
        Thu,  3 Oct 2019 08:32:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7E15C1E4810; Thu,  3 Oct 2019 10:33:16 +0200 (CEST)
Date:   Thu, 3 Oct 2019 10:33:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 17/19] jbd2: Rename h_buffer_credits to h_total_credits
Message-ID: <20191003083316.GA17911@quack2.suse.cz>
References: <20190930104339.24919-17-jack@suse.cz>
 <201909302058.uxNSY0q3%lkp@intel.com>
 <20190930150553.GB4001@mit.edu>
 <20190930162536.GB13973@quack2.suse.cz>
 <20190930212145.GC4001@mit.edu>
 <20191001075908.GB25062@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001075908.GB25062@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 01-10-19 09:59:08, Jan Kara wrote:
> On Mon 30-09-19 17:21:45, Theodore Y. Ts'o wrote:
> > On Mon, Sep 30, 2019 at 06:25:36PM +0200, Jan Kara wrote:
> > > The problem was that my patches were based on a kernel that didn't have
> > > this code yet. I've rebased now on current Linus' tree and fixed this up in
> > > my local tree (along with couple documentation warnings). But I don't think
> > > it's worth resending just for this.
> > 
> > Oh, agreed, it's not worth resending for this; it was a quick fixup.
> > 
> > How much testing have you given this patch series?  I did a quick
> > xfstests run, and I found the following new failures when this was
> > applied on top of the dev branch on ext4.git (e.g., what got sent to
> > Linus as a pull request). 
> 
> I did run e.g. ext4/4k, ext4/1k, ext4/nojournal, ext4/datajournal. But
> my setup does not run ext4/026 (too old e2fsprogs it seems - I need to
> update those). I have cathegorized generic/233 as preexisting failure but I
> might be wrong and it definitely failed differently for me. Anyway, thanks
> for running these tests, I'll check more what's going on.

OK, so I've fixed ext4/026 and generic/233 failures - those were really
bugs I've introduced. The failure I've seen with generic/233 was different
than what you've shown so I'm not 100% sure the problem will be really
fixed for you. We'll see.

The ext4/301 in nojournal mode is a preexisting failure for me. I'm getting
EBUSY from ext4_move_extents() because page buffers cannot be occasionally
invalidated. Looking at the code that indeed looks possible given the
workload (pages can be written out while ext4_move_extents() runs).

I'm not yet sure about some failures in ext4/adv and ext4/bigalloc configs.
Where can I find what mkfs & mount options do you use for these? I've
looked at xfstests-bld but I didn't find the configs there... Thanks!

								Honza

> > ext4/4k: 
> >   Failures: ext4/026 generic/233
> > ext4/1k: 
> >   Failures: ext4/026
> > ext4/ext3: 
> >   Failures: ext4/026 generic/233
> > ext4/encrypt: 
> >   Failures: generic/083
> > ext4/nojournal:
> >   Failures: ext4/301
> > ext4/adv: 
> >   Failures: ext4/026 generic/233 generic/269 generic/270 generic/476
> > ext4/dioread_nolock: 
> >   Failures: ext4/026 generic/233
> > ext4/data_journal: 
> >   Failures: generic/233
> > ext4/bigalloc: 
> >   Failures: generic/013 generic/014 generic/051 generic/083
> >     generic/232 generic/233 generic/269 generic/270 generic/299
> >     generic/429 generic/475 generic/476
> > ext4/bigalloc_1k: 
> >   Failures: ext4/026 generic/013 generic/014 generic/032 generic/051
> >     generic/068 generic/083 generic/232 generic/233 generic/269
> >     generic/270 generic/320 generic/475 generic/476
> > 
> > I haven't trianged them all yet, but here are the details for the two
> > biggies: ext4/026 and generic/233.
> > 
> > 					- Ted
> > 
> > ext4/026		[14:11:43][   14.287850] run fstests ext4/026 at 2019-09-30 14:11:43
> > [   14.821933] WARNING: CPU: 0 PID: 1542 at fs/jbd2/revoke.c:394 jbd2_journal_revoke+0x14b/0x160
> > [   14.824000] CPU: 0 PID: 1542 Comm: rm Not tainted 5.3.0-rc4-xfstests-00019-ga8d18e88fd60-dirty #1201
> > [   14.826111] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [   14.828039] RIP: 0010:jbd2_journal_revoke+0x14b/0x160
> > [   14.829217] Code: 4c 89 f7 e8 77 8c ef ff eb a6 e8 d0 8d ef ff 48 85 c0 49 89 c6 74 99 48 8b 00 a9 00 00 10 00 0f 84 5b ff ff ff e9 71 06 00 00 <0f> 0b eb 89 0f 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 0f
> > [   14.833505] RSP: 0018:ffffae0ec2683ad8 EFLAGS: 00010246
> > [   14.834721] RAX: 0000000000000000 RBX: ffff951876a9f410 RCX: 1111111111111120
> > [   14.836287] RDX: 0000000000000004 RSI: 0000000000000006 RDI: ffff951876a9f410
> > [   14.837853] RBP: ffff951874f1f6c8 R08: 0000000373745034 R09: 0000000000000000
> > [   14.839244] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000840d
> > [   14.840799] R13: ffff951876695000 R14: ffff951876a9f410 R15: 0000000000000001
> > [   14.842349] FS:  00007f39e17b5540(0000) GS:ffff95187d800000(0000) knlGS:0000000000000000
> > [   14.844125] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   14.845403] CR2: 00007f39e16ba4a0 CR3: 0000000075b9e006 CR4: 0000000000360ef0
> > [   14.847055] Call Trace:
> > [   14.847628]  __ext4_forget+0xf2/0x280
> > [   14.848470]  ext4_free_blocks+0x9c8/0xc00
> > [   14.849270]  ? __lock_acquire+0x447/0x7c0
> > [   14.850174]  ? kvm_sched_clock_read+0x14/0x30
> > [   14.851182]  ext4_remove_blocks+0x33c/0x630
> > [   14.852190]  ext4_ext_rm_leaf+0x1fb/0x7a0
> > [   14.853493]  ext4_ext_remove_space+0x556/0xa80
> > [   14.855020]  ? ext4_es_remove_extent+0x9d/0x180
> > [   14.856325]  ext4_truncate+0x413/0x520
> > [   14.857374]  ext4_evict_inode+0x29c/0x670
> > [   14.858329]  evict+0xd0/0x1a0
> > [   14.859157]  ext4_xattr_inode_array_free+0x27/0x40
> > [   14.860341]  ext4_evict_inode+0x31c/0x670
> > [   14.861344]  evict+0xd0/0x1a0
> > [   14.862107]  do_unlinkat+0x1cd/0x2e0
> > [   14.862769]  do_syscall_64+0x50/0x1b0
> > [   14.863387]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [   14.864219] RIP: 0033:0x7f39e16deff7
> > [   14.864813] Code: 73 01 c3 48 8b 0d 99 ee 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 ee 0c 00 f7 d8 64 89 01 48
> > [   14.867949] RSP: 002b:00007fff3ed46068 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
> > [   14.869197] RAX: ffffffffffffffda RBX: 0000561d094937b0 RCX: 00007f39e16deff7
> > [   14.870371] RDX: 0000000000000000 RSI: 0000561d09492340 RDI: 00000000ffffff9c
> > [   14.871544] RBP: 0000561d094922b0 R08: 0000000000000003 R09: 0000000000000000
> > [   14.872766] R10: 0000000000000100 R11: 0000000000000246 R12: 00007fff3ed46250
> > [   14.873950] R13: 0000000000000000 R14: 0000561d094937b0 R15: 0000000000000000
> > [   14.875156] irq event stamp: 2176
> > [   14.875720] hardirqs last  enabled at (2175): [<ffffffffb16663e1>] kmem_cache_free+0x51/0x220
> > [   14.877150] hardirqs last disabled at (2176): [<ffffffffb14016aa>] trace_hardirqs_off_thunk+0x1a/0x20
> > [   14.878702] softirqs last  enabled at (814): [<ffffffffb14297f3>] fpu__clear+0xb3/0x1b0
> > [   14.880055] softirqs last disabled at (812): [<ffffffffb14297b5>] fpu__clear+0x75/0x1b0
> > [   14.881926] ---[ end trace 4d44757f1901181f ]---
> > _check_dmesg: something found in dmesg (see /results/ext4/results-4k/ext4/026.dmesg)
> >  [14:11:44]
> > 
> > 
> > generic/233 		[14:18:34][   19.736637] run fstests generic/233 at 2019-09-30 14:18:34
> > [   21.400934] EXT4-fs (vdc): Delayed block allocation failed for inode 131809 at logical offset 209 with max blocks 9 with error 122
> > [   21.404197] EXT4-fs (vdc): This should not happen!! Data will be lost
> > [   21.404197]
> >  [14:18:36] 2s
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
