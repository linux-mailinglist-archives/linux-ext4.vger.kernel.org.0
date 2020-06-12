Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7988A1F77C3
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jun 2020 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFLMP4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jun 2020 08:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLMP4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Jun 2020 08:15:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A5F20792;
        Fri, 12 Jun 2020 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591964155;
        bh=ZPk3RP/f0vKFwVoKwXnjqpyMNkSKgrEOjYa45LKg+rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mYukDCqvVukI/cgKxL76dOAdzJ8ilgzVdwGLOAbWjq2kaml+oL68YHhQsMI75wf8U
         wniLfUuujTb0AAsPLlWrfPdwepSMGEvlPRPc6BKBFEcxxOG0cVMl71asG7PlskTvvt
         A4Z00Fr8TCqm0kXjnQtLkp3A2guSt4kEspl+V0fo=
Date:   Fri, 12 Jun 2020 14:15:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Cc:     syzbot <syzbot+0113b9be6667b5b50840@syzkaller.appspotmail.com>
Subject: Re: upstream test error: BUG: using smp_processor_id() in
 preemptible code in ext4_mb_new_blocks
Message-ID: <20200612121549.GA2603@kroah.com>
References: <0000000000007a16f705a7b1096d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007a16f705a7b1096d@google.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 09, 2020 at 06:48:13PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    5b14671b Merge tag 'fuse-update-5.8' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a11ec1100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d1ea633f7958e008
> dashboard link: https://syzkaller.appspot.com/bug?extid=0113b9be6667b5b50840
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0113b9be6667b5b50840@syzkaller.appspotmail.com
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: systemd-rfkill/6740
> caller is ext4_mb_new_blocks+0xa77/0x3b30 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 6740 Comm: systemd-rfkill Not tainted 5.7.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  check_preemption_disabled lib/smp_processor_id.c:47 [inline]
>  debug_smp_processor_id.cold+0x88/0x9b lib/smp_processor_id.c:57
>  ext4_mb_new_blocks+0xa77/0x3b30 fs/ext4/mballoc.c:4711
>  ext4_ext_map_blocks+0x2044/0x3410 fs/ext4/extents.c:4244
>  ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
>  ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
>  ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
>  ext4_append+0x153/0x360 fs/ext4/namei.c:67
>  ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
>  ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
>  vfs_mkdir+0x419/0x690 fs/namei.c:3641
>  do_mkdirat+0x21e/0x280 fs/namei.c:3664
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x7f449ff49687
> Code: Bad RIP value.
> RSP: 002b:00007ffdd3b9fe58 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> RAX: ffffffffffffffda RBX: 00005567752fd985 RCX: 00007f449ff49687
> RDX: 00007ffdd3b9fd20 RSI: 00000000000001ed RDI: 00005567752fd985
> RBP: 00007f449ff49680 R08: 0000000000000100 R09: 0000000000000000
> R10: 00005567752fd980 R11: 0000000000000246 R12: 00000000000001ed
> R13: 00007ffdd3b9ffe0 R14: 0000000000000000 R15: 0000000000000000

I am seeing this all over the place on Linus's tree right now:

[  +0.008563] BUG: using smp_processor_id() in preemptible [00000000] code: systemd/1
[  +0.000011] caller is ext4_mb_new_blocks+0x2ac/0xc10
[  +0.000002] CPU: 31 PID: 1 Comm: systemd Not tainted 5.7.0-14371-g25ae6195a4c7 #66
[  +0.000002] Hardware name: Micro-Star International Co., Ltd. MS-7C59/Creator TRX40 (MS-7C59), BIOS 1.50 05/13/2020
[  +0.000001] Call Trace:
[  +0.000008]  dump_stack+0x57/0x70
[  +0.000004]  debug_smp_processor_id.cold+0x4e/0x53
[  +0.000001]  ext4_mb_new_blocks+0x2ac/0xc10
[  +0.000004]  ? ext4_find_extent+0x3e8/0x450
[  +0.000002]  ext4_ext_map_blocks+0x9f6/0x1b10
[  +0.000003]  ? ext4_mark_iloc_dirty+0x60f/0xa50
[  +0.000003]  ? __ext4_journal_get_write_access+0x2d/0x70
[  +0.000004]  ext4_map_blocks+0x119/0x5a0
[  +0.000004]  ext4_getblk+0x66/0x1c0
[  +0.000003]  ext4_bread+0x26/0xc0
[  +0.000002]  ext4_append+0x49/0xe0
[  +0.000002]  ext4_mkdir+0x233/0x450
[  +0.000005]  vfs_mkdir+0x11d/0x1b0
[  +0.000003]  do_mkdirat+0x92/0x130
[  +0.000004]  do_syscall_64+0x43/0x80
[  +0.000004]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000003] RIP: 0033:0x7fef3df7a72b
[  +0.000001] Code: Bad RIP value.
[  +0.000001] RSP: 002b:00007ffdb4eba0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
[  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fef3df7a72b
[  +0.000001] RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 0000563b11cf26e0
[  +0.000001] RBP: 0000563b11cf2731 R08: 000000000000000d R09: 0000000000000002
[  +0.000000] R10: 11175e4331068ed5 R11: 0000000000000246 R12: 0000563b11cf26e0
[  +0.000002] R13: 00007fef3e019c20 R14: 00007ffdb4eba0f0 R15: 8421084210842109

Just a constant stream of them.

There's a few other fun:

[  +0.453222] BUG: unable to handle page fault for address: ffffb59cc2719000
[  +0.000004] #PF: supervisor write access in kernel mode
[  +0.000001] #PF: error_code(0x000b) - reserved bit violation

messages at times, but I don't think that's an ext4 issue, but rather
something in the sound stack...

EXT4 developers, any hints/patches to try?

thanks,

greg k-h
