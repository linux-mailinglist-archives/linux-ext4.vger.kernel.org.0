Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3171EF034
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 06:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFEENC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 00:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgFEENC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jun 2020 00:13:02 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2E820738;
        Fri,  5 Jun 2020 04:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591330381;
        bh=+NxZeQQV122stsr2nScCsU71IkrPpO3LGJL9ob3Ylfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eSFGS2diQET6j2vGSoHzUnXsAJ9v+U94pytvnWomxYEowwy3E9mwRNj1YPIQfvOIM
         pubHOYTXzYrlR/mAay9MkjQ74s6bJpmSIfTrQUr76QSRG/yBG51VXM0I/CXhuPrv5X
         WxPZ6FCG1vjd3P9t3+E7hsI33ozr7o6PpuUQ2npg=
Date:   Thu, 4 Jun 2020 21:13:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+cd8a20b91d68ef113b45@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: syz-fuzzer/6927
Message-ID: <20200605041300.GF2667@sol.localdomain>
References: <00000000000098f29705a7181812@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000098f29705a7181812@google.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 02, 2020 at 04:20:17AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    0e21d462 Add linux-next specific files for 20200602
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1597f2fe100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ecc1aef35f550ee3
> dashboard link: https://syzkaller.appspot.com/bug?extid=cd8a20b91d68ef113b45
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cd8a20b91d68ef113b45@syzkaller.appspotmail.com
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: syz-fuzzer/6927
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 1 PID: 6927 Comm: syz-fuzzer Not tainted 5.7.0-next-20200602-syzkaller #0
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
> RIP: 0033:0x4b02a0
> Code: Bad RIP value.
> RSP: 002b:000000c0000cf4b8 EFLAGS: 00000212 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 000000c00002c000 RCX: 00000000004b02a0
> RDX: 00000000000001c0 RSI: 000000c000116be0 RDI: ffffffffffffff9c
> RBP: 000000c0000cf510 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: ffffffffffffffff
> R13: 0000000000000060 R14: 000000000000005f R15: 0000000000000100
> 
> 

#syz dup: linux-next test error: BUG: using smp_processor_id() in preemptible [ADDR] code: syz-fuzzer/6792

