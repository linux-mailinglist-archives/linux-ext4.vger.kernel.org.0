Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69551EF03A
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 06:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFEENh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 00:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgFEENh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jun 2020 00:13:37 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2586220738;
        Fri,  5 Jun 2020 04:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591330416;
        bh=pfWBDrqdlk749Y/i0F/8G3oLTJV9aOFFYh9QeQbFajg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2V/Mt1ceEchrAdbru9eenh2n8XI29h5c10H1IDc3zI5YY/oVEfUw0OOjQM6B1rwTF
         BIMH62Vu1CZtUGv6RjQEQPrSrQ2/VMo7I+UPdKm5CPoEjXO7qvxp+W1TENnsgcEONo
         Y5sXU1pbL3ZwtgftVQfFrw5jTm3vAm6IkzZ2b3Ps=
Date:   Thu, 4 Jun 2020 21:13:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+8ea916061cc749544c8f@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: kworker/u4:LINE/6740
Message-ID: <20200605041334.GH2667@sol.localdomain>
References: <00000000000020b15e05a718ef22@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000020b15e05a718ef22@google.com>
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
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f3dcca100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ecc1aef35f550ee3
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ea916061cc749544c8f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+8ea916061cc749544c8f@syzkaller.appspotmail.com
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:6/6740
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 1 PID: 6740 Comm: kworker/u4:6 Not tainted 5.7.0-next-20200602-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: writeback wb_workfn (flush-8:0)
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
>  ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
>  ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
>  ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
>  mpage_map_one_extent fs/ext4/inode.c:2377 [inline]
>  mpage_map_and_submit_extent fs/ext4/inode.c:2430 [inline]
>  ext4_writepages+0x1ab5/0x3400 fs/ext4/inode.c:2782
>  do_writepages+0xfa/0x2a0 mm/page-writeback.c:2338
>  __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1453
>  writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1717
>  __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1786
>  wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1895
>  wb_check_old_data_flush fs/fs-writeback.c:1997 [inline]
>  wb_do_writeback fs/fs-writeback.c:2050 [inline]
>  wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2079
>  process_one_work+0x965/0x1690 kernel/workqueue.c:2269
>  worker_thread+0x96/0xe10 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:291
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

#syz dup: linux-next test error: BUG: using smp_processor_id() in preemptible [ADDR] code: syz-fuzzer/6792

