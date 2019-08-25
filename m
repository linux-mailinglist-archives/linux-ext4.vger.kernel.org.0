Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C50F9C524
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Aug 2019 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfHYRcI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 13:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbfHYRcI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 25 Aug 2019 13:32:08 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC0E206BA;
        Sun, 25 Aug 2019 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754327;
        bh=GoJnBwE6ux3df0ua3WYR2r2vAbi8yOxzMO1UWSyD77c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qs9WLKt64GgjrNa7aJnLTi8rcexwuoxF8SXlarOr70SU/kh82aDlu73MbUPK/iFsz
         a+cty8jVtBQWtrWEEc7MdSQWKYs8ATuCMVevDMkqOk34J1Y/V5FuZr+/oQmeNdSUKA
         Yt1BwJYtNekJ2qA9LAbT7IwP61sTWGukSFeb+IGw=
Date:   Sun, 25 Aug 2019 10:32:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca
Subject: Re: [PATCH v5] ext4: fix potential use after free in system zone via
 remount with noblock_validity
Message-ID: <20190825173205.GB9505@sol.localdomain>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "zhangyi (F)" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca
References: <1565869639-105420-1-git-send-email-yi.zhang@huawei.com>
 <20190825034000.GE5163@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825034000.GE5163@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 24, 2019 at 11:40:00PM -0400, Theodore Y. Ts'o wrote:
> On Thu, Aug 15, 2019 at 07:47:19PM +0800, zhangyi (F) wrote:
> > Remount process will release system zone which was allocated before if
> > "noblock_validity" is specified. If we mount an ext4 file system to two
> > mountpoints with default mount options, and then remount one of them
> > with "noblock_validity", it may trigger a use after free problem when
> > someone accessing the other one.
> > 
> >  # mount /dev/sda foo
> >  # mount /dev/sda bar
> > 
> > User access mountpoint "foo"   |   Remount mountpoint "bar"
> >                                |
> > ext4_map_blocks()              |   ext4_remount()
> > check_block_validity()         |   ext4_setup_system_zone()
> > ext4_data_block_valid()        |   ext4_release_system_zone()
> >                                |   free system_blks rb nodes
> > access system_blks rb nodes    |
> > trigger use after free         |
> > 
> > This problem can also be reproduced by one mountpint, At the same time,
> > add_system_zone() can get called during remount as well so there can be
> > racing ext4_data_block_valid() reading the rbtree at the same time.
> > 
> > This patch add RCU to protect system zone from releasing or building
> > when doing a remount which inverse current "noblock_validity" mount
> > option. It assign the rbtree after the whole tree was complete and
> > do actual freeing after rcu grace period, avoid any intermediate state.
> > 
> > Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Applied, thanks!
> 
> I changed the patch summary to:
> 
>     ext4: fix potential use after free after remounting with noblock_validity
> 
> I also added:
> 
>     Reported-by: syzbot+1e470567330b7ad711d5@syzkaller.appspotmail.com
> 
> since this had been noted by Syzkaller:
> 
>    https://syzkaller.appspot.com/bug?extid=1e470567330b7ad711d5
> 
> Cheers,
> 
> 					- Ted

This patch is causing:

=============================
WARNING: suspicious RCU usage
5.3.0-rc4-00016-gc747f2a0aa5e #9 Not tainted
-----------------------------
fs/ext4/block_validity.c:333 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by umount/605:
 #0: 00000000961e5b1d (&type->s_umount_key#26){++++}, at: deactivate_super+0x130/0x150 fs/super.c:361

stack backtrace:
CPU: 1 PID: 605 Comm: umount Not tainted 5.3.0-rc4-00016-gc747f2a0aa5e #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-20181126_142135-anatol 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x86/0xca lib/dump_stack.c:113
 lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5357
 ext4_release_system_zone+0xfe/0x130 fs/ext4/block_validity.c:333
 ext4_put_super+0x18c/0xbb0 fs/ext4/super.c:992
 generic_shutdown_super+0x128/0x320 fs/super.c:458
 kill_block_super+0x97/0xe0 fs/super.c:1310
 deactivate_locked_super+0x7b/0xd0 fs/super.c:331
 deactivate_super+0x138/0x150 fs/super.c:362
 cleanup_mnt+0x298/0x3f0 fs/namespace.c:1102
 __cleanup_mnt+0xd/0x10 fs/namespace.c:1109
 task_work_run+0x103/0x180 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x10b/0x130 arch/x86/entry/common.c:163
 prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
 do_syscall_64+0x343/0x450 arch/x86/entry/common.c:299
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7face39bfd77
Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 8
RSP: 002b:00007ffd297f2fb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 000055f7506ae060 RCX: 00007face39bfd77
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000055f7506b0c90
RBP: 000055f7506b0c90 R08: 000055f7506afec0 R09: 0000000000000014
R10: 00000000000006b4 R11: 0000000000000246 R12: 00007face3ec1e64
R13: 0000000000000000 R14: 000055f7506ae240 R15: 00007ffd297f3240
==================================================================
