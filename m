Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B4A1EF03D
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 06:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgFEEN4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 00:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgFEEN4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jun 2020 00:13:56 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3138820738;
        Fri,  5 Jun 2020 04:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591330435;
        bh=xmmyxOLDxp4vA/v92jpb4ZNMB7XoNfpyVBAZ8tip5cY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2kTI43S9t7SOafMg3P2PRec8X7ElNxhEFnhyy/5+wILOsyhBKjwvCxhD9qXjz3XEU
         m4JLs7h+FbrziWYRIdELZDIUdOh5VVtdoLUwbwbRbTEmb2oEbhOnawL0yXb5t1G0eh
         YANLx0/8/hi3ks/Pxff1nUbjMPOncRL8zdqlKqVA=
Date:   Thu, 4 Jun 2020 21:13:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+7f2b4a7d4281e8c2aad0@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: systemd-rfkill/6731
Message-ID: <20200605041353.GI2667@sol.localdomain>
References: <00000000000024436605a718ef99@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000024436605a718ef99@google.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 02, 2020 at 05:20:16AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    0e21d462 Add linux-next specific files for 20200602
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=102c59ce100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ecc1aef35f550ee3
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f2b4a7d4281e8c2aad0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7f2b4a7d4281e8c2aad0@syzkaller.appspotmail.com
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: systemd-rfkill/6731
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 6731 Comm: systemd-rfkill Not tainted 5.7.0-next-20200602-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
>  ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
>  ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
>  ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
>  ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
>  ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
>  ext4_append+0x153/0x360 fs/ext4/namei.c:67
>  ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
>  ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
>  vfs_mkdir+0x419/0x690 fs/namei.c:3632
>  do_mkdirat+0x21e/0x280 fs/namei.c:3655
>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fe0d32c9687
> Code: Bad RIP value.
> RSP: 002b:00007fffd5e80488 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> RAX: ffffffffffffffda RBX: 000055fab378a985 RCX: 00007fe0d32c9687
> RDX: 00007fffd5e80350 RSI: 00000000000001ed RDI: 000055fab378a985
> RBP: 00007fe0d32c9680 R08: 0000000000000100 R09: 0000000000000000
> R10: 000055fab378a980 R11: 0000000000000246 R12: 00000000000001ed
> R13: 00007fffd5e80610 R14: 0000000000000000 R15: 0000000000000000
> 

#syz dup: linux-next test error: BUG: using smp_processor_id() in preemptible [ADDR] code: syz-fuzzer/6792

