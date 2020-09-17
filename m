Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED9126D11B
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIQC2P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 22:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgIQC2L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Sep 2020 22:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600309687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=589jv5dcEXFCuXf0aJXsqiIdxN7TBSpdb/yY5Un5eFk=;
        b=BLuP5TDTBiQ1arEPQQnY+HBIwfI3xlLVLcAsmmGPH844wwek4vJkIv6gaIe2GfWm4WfFPI
        Y0YgApLVXQ/LuZ09whBVbhYHQEPNa9T/E+eQU1HNeHlV4OuGpryiG0sAubOAmfYUTAGteO
        tGScJ86lLq9hFZi+FZV4+itQLbv4ohM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-CXovhrWkPt2pdtFB99xyIg-1; Wed, 16 Sep 2020 22:21:03 -0400
X-MC-Unique: CXovhrWkPt2pdtFB99xyIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6588D807355;
        Thu, 17 Sep 2020 02:21:02 +0000 (UTC)
Received: from T590 (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E0CB1992F;
        Thu, 17 Sep 2020 02:20:55 +0000 (UTC)
Date:   Thu, 17 Sep 2020 10:20:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200917022051.GA1004828@T590>
References: <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
 <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
 <20200915044519.GA38283@mit.edu>
 <20200915073303.GA754106@T590>
 <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590>
 <20200916202026.GC38283@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916202026.GC38283@mit.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 16, 2020 at 04:20:26PM -0400, Theodore Y. Ts'o wrote:
> On Wed, Sep 16, 2020 at 07:09:41AM +0800, Ming Lei wrote:
> > > The problem is it's a bit tricky to revert 568f27006577, since there
> > > is a merge conflict in blk_kick_flush().  I attempted to do the bisect
> > > manually here, but it's clearly not right since the kernel is not
> > > booting after the revert:
> > > 
> > > https://github.com/tytso/ext4/commit/1e67516382a33da2c9d483b860ac4ec2ad390870
> > > 
> > > branch:
> > > 
> > > https://github.com/tytso/ext4/tree/manual-revert-of-568f27006577
> > > 
> > > Can you send me a patch which correctly reverts 568f27006577?  I can
> > > try it against -rc1 .. -rc4, whichever is most convenient.
> > 
> > Please test the following revert patch against -rc4.
> 
> Unfortunately the results of the revert is... wierd.
> 
> With -rc4, *all* of the VM's are failing --- reliably.  With rc4 with
> the revert, *some* of the VM's are able to complete the tests, but
> over half are still locking up or failing with some kind of oops.  So
> that seems to imply that there is some kind of timing issue going on,
> or maybe there are multiple bugs in play?

Obviously there is other more serious issue, since 568f27006577 is
completely reverted in your test, and you still see list corruption
issue.

So I'd suggest to find the big issue first. Once it is fixed, maybe
everything becomes fine.

......

> 
> v5.9-rc4 with the revert of 568f27006577: we're seeing a similar
> 	number of VM failures, but the failure signature is different.
> 	The most common failure is:
> 
> 	[  390.023691] ------------[ cut here ]------------
> 	[  390.028614] list_del corruption, ffffe1c241b00408->next is LIST_POISON1 (dead000000000100)
> 	[  390.037040] WARNING: CPU: 1 PID: 5948 at lib/list_debug.c:47 __list_del_entry_valid+0x4e/0x90
> 	[  390.045684] CPU: 1 PID: 5948 Comm: umount Not tainted 5.9.0-rc4-xfstests-00001-g6fdef015feba #11
> 	[  390.054581] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> 	[  390.063943] RIP: 0010:__list_del_entry_valid+0x4e/0x90
> 	[  390.069731] Code: 2e 48 8b 32 48 39 fe 75 3a 48 8b 50 08 48 39 f2 75 48 b8 01 00 00 00 c3 48 89 fe 48 89 c2 48 c7 c7 10 13 12 9b e8 30 2f 8c ff <0f> 0b 31 c0 c3 48 89 fe 48 c7 c7 48 13 12 9b e8 1c 2f 8c ff 0f 0b
> 	[  390.088615] RSP: 0018:ffffae95c6ddba28 EFLAGS: 00010082
> 	[  390.094079] RAX: 0000000000000000 RBX: ffffce95bfc007d0 RCX: 0000000000000027
> 	[  390.101338] RDX: 0000000000000027 RSI: ffffa0c9d93d7dc0 RDI: ffffa0c9d93d7dc8
> 	[  390.108659] RBP: ffffe1c241b00408 R08: 0000006ba6bff7dc R09: 0000000000000000
> 	[  390.115925] R10: ffffa0c9d3f444c0 R11: 0000000000000046 R12: ffffa0c9d8041180
> 	[  390.123186] R13: ffffa0c86c010e00 R14: ffffe1c241b00400 R15: ffffa0c9d8042240
> 	[  390.130637] FS:  00007fb227580080(0000) GS:ffffa0c9d9200000(0000) knlGS:0000000000000000
> 	[  390.138860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	[  390.144721] CR2: 00007ff72d2dfe74 CR3: 00000001cdbb8002 CR4: 00000000003706e0
> 	[  390.152022] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 	[  390.159314] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 	[  390.166569] Call Trace:
> 	[  390.169148]  free_block+0xec/0x270
> 	[  390.173100]  ___cache_free+0x488/0x6b0
> 	[  390.177062]  kfree+0xc9/0x1d0
> 	[  390.181202]  kmem_freepages+0xa0/0xf0
> 	[  390.185009]  slab_destroy+0x19/0x50
> 	[  390.188653]  slabs_destroy+0x6d/0x90
> 	[  390.192339]  ___cache_free+0x4a3/0x6b0
> 	[  390.196477]  kfree+0xc9/0x1d0
> 	[  390.199651]  kmem_freepages+0xa0/0xf0
> 	[  390.203459]  slab_destroy+0x19/0x50
> 	[  390.207060]  slabs_destroy+0x6d/0x90
> 	[  390.210784]  ___cache_free+0x4a3/0x6b0
> 	[  390.214672]  ? lockdep_hardirqs_on_prepare+0xe7/0x180
> 	[  390.219845]  kfree+0xc9/0x1d0
> 	[  390.222928]  put_crypt_info+0xe3/0x100
> 	[  390.226801]  fscrypt_put_encryption_info+0x15/0x30
> 	[  390.231721]  ext4_clear_inode+0x80/0x90
> 	[  390.235774]  ext4_evict_inode+0x6d/0x630
> 	[  390.239960]  evict+0xd0/0x1a0
> 	[  390.243049]  dispose_list+0x51/0x80
> 	[  390.246659]  evict_inodes+0x15b/0x1b0
> 	[  390.250526]  generic_shutdown_super+0x37/0x100
> 	[  390.255094]  kill_block_super+0x21/0x50
> 	[  390.259066]  deactivate_locked_super+0x2f/0x70
> 	[  390.263638]  cleanup_mnt+0xb8/0x140
> 	[  390.267248]  task_work_run+0x73/0xc0
> 	[  390.270953]  exit_to_user_mode_prepare+0x197/0x1a0
> 	[  390.277333]  syscall_exit_to_user_mode+0x3c/0x210
> 	[  390.282171]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 	[  390.287348] RIP: 0033:0x7fb2279a6507
> 	[  390.291128] Code: 19 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 19 0c 00 f7 d8 64 89 01 48
> 	[  390.310018] RSP: 002b:00007ffd41391c08 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> 	[  390.317711] RAX: 0000000000000000 RBX: 000055b889e1f970 RCX: 00007fb2279a6507
> 	[  390.324969] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055b889e24f00
> 	[  390.332300] RBP: 0000000000000000 R08: 000055b889e24f20 R09: 00007fb227a27e80
> 	[  390.339543] R10: 0000000000000000 R11: 0000000000000246 R12: 000055b889e24f00
> 	[  390.346818] R13: 00007fb227acc1c4 R14: 000055b889e1fa68 R15: 000055b889e1fb80
> 	[  390.354075] irq event stamp: 3176310
> 	[  390.357762] hardirqs last  enabled at (3176309): [<ffffffff9a090df2>] kfree+0x132/0x1d0
> 	[  390.365891] hardirqs last disabled at (3176310): [<ffffffff9a090df9>] kfree+0x139/0x1d0
> 	[  390.374021] softirqs last  enabled at (3174992): [<ffffffff9ac00347>] __do_softirq+0x347/0x45f
> 	[  390.382762] softirqs last disabled at (3174535): [<ffffffff9aa00f72>] asm_call_on_stack+0x12/0x20
> 	[  390.391742] ---[ end trace 8fb872d4de3e00ed ]---

Looks it is more like a memory corruption issue, is there any helpful log
dumped when running kernel with kasan?

BTW, I have kvm/qumu auto test which runs blktest/xfstest over virtio-blk/virito-scsi/loop/nvme
with xfs/ext4 every two days, and not see such failure recently, but the kernel config is based
rhel8's config.


thanks,
Ming

