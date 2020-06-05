Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46A1EF036
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 06:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgFEENR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 00:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgFEENR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jun 2020 00:13:17 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9BE820738;
        Fri,  5 Jun 2020 04:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591330397;
        bh=so4ftMBRfRZ2uAQJS8l2hAr7SRmnXb5f1MCTFUk4cWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=weLvwXueD24nI+aAaChwea8wK/OK4r2XN2J0kpwBhk5Ll9oFvAPn7wOVyvY+RzPZw
         B75SP1ODXyfcj96IhR28ARGDakr6IGxhthVz+Cu27cTHtKYTqMg859Eje76dAgGnFg
         Q1R0c5ZZ4XOVKBLXZgwfiHxvmPwhA4ql/CGUwFUc=
Date:   Thu, 4 Jun 2020 21:13:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+94f7894cc5600cc07094@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: systemd-rfkill/6726
Message-ID: <20200605041315.GG2667@sol.localdomain>
References: <0000000000009406b205a718eb10@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009406b205a718eb10@google.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 02, 2020 at 05:19:16AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    0e21d462 Add linux-next specific files for 20200602
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a7ffe2100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ecc1aef35f550ee3
> dashboard link: https://syzkaller.appspot.com/bug?extid=94f7894cc5600cc07094
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+94f7894cc5600cc07094@syzkaller.appspotmail.com
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: systemd-rfkill/6726
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 6726 Comm: systemd-rfkill Not tainted 5.7.0-next-20200602-syzkaller #0
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
> RIP: 0033:0x7fa49b78d687
> Code: Bad RIP value.
> RSP: 002b:00007ffde44382d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> RAX: ffffffffffffffda RBX: 00005647ba692985 RCX: 00007fa49b78d687
> RDX: 00007ffde44381a0 RSI: 00000000000001ed RDI: 00005647ba692985
> RBP: 00007fa49b78d680 R08: 0000000000000100 R09: 0000000000000000
> R10: 00005647ba692980 R11: 0000000000000246 R12: 00000000000001ed
> R13: 00007ffde4438460 R14: 0000000000000000 R15: 0000000000000000

#syz dup: linux-next test error: BUG: using smp_processor_id() in preemptible [ADDR] code: syz-fuzzer/6792

