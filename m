Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF41F8237
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jun 2020 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgFMJQZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Jun 2020 05:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgFMJQX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 13 Jun 2020 05:16:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28131206D7;
        Sat, 13 Jun 2020 09:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592039782;
        bh=Ls5GKOCBUIeEFZSrLiEOowJ2rHuV6lGNQpo7uIq9sjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEeYW4tv293H4PQ3DcuB9/XfL4Mwrd9uc/gGs14RBARXcIcsVfMD9AhDbNRfLd5O3
         w6FBRoVpKH9tvH7PpHaFTJhqSrJm/FFo2/CQQdR62T2eg0r3H01A/YbRU2hfV4RTSs
         I1e+NSozpJdorD4bqtWQ31sGb8+Ps7o2NMu+cl1s=
Date:   Sat, 13 Jun 2020 11:16:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu,
        syzbot <syzbot+0113b9be6667b5b50840@syzkaller.appspotmail.com>
Subject: Re: upstream test error: BUG: using smp_processor_id() in
 preemptible code in ext4_mb_new_blocks
Message-ID: <20200613091620.GC2606625@kroah.com>
References: <0000000000007a16f705a7b1096d@google.com>
 <20200612121549.GA2603@kroah.com>
 <20200612165036.415A752052@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612165036.415A752052@d06av21.portsmouth.uk.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 12, 2020 at 10:20:35PM +0530, Ritesh Harjani wrote:
> > I am seeing this all over the place on Linus's tree right now:
> > 
> > [  +0.008563] BUG: using smp_processor_id() in preemptible [00000000] code: systemd/1
> > [  +0.000011] caller is ext4_mb_new_blocks+0x2ac/0xc10
> > [  +0.000002] CPU: 31 PID: 1 Comm: systemd Not tainted 5.7.0-14371-g25ae6195a4c7 #66
> > [  +0.000002] Hardware name: Micro-Star International Co., Ltd. MS-7C59/Creator TRX40 (MS-7C59), BIOS 1.50 05/13/2020
> > [  +0.000001] Call Trace:
> > [  +0.000008]  dump_stack+0x57/0x70
> > [  +0.000004]  debug_smp_processor_id.cold+0x4e/0x53
> > [  +0.000001]  ext4_mb_new_blocks+0x2ac/0xc10
> > [  +0.000004]  ? ext4_find_extent+0x3e8/0x450
> > [  +0.000002]  ext4_ext_map_blocks+0x9f6/0x1b10
> > [  +0.000003]  ? ext4_mark_iloc_dirty+0x60f/0xa50
> > [  +0.000003]  ? __ext4_journal_get_write_access+0x2d/0x70
> > [  +0.000004]  ext4_map_blocks+0x119/0x5a0
> > [  +0.000004]  ext4_getblk+0x66/0x1c0
> > [  +0.000003]  ext4_bread+0x26/0xc0
> > [  +0.000002]  ext4_append+0x49/0xe0
> > [  +0.000002]  ext4_mkdir+0x233/0x450
> > [  +0.000005]  vfs_mkdir+0x11d/0x1b0
> > [  +0.000003]  do_mkdirat+0x92/0x130
> > [  +0.000004]  do_syscall_64+0x43/0x80
> > [  +0.000004]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [  +0.000003] RIP: 0033:0x7fef3df7a72b
> > [  +0.000001] Code: Bad RIP value.
> > [  +0.000001] RSP: 002b:00007ffdb4eba0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> > [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fef3df7a72b
> > [  +0.000001] RDX: 0000000000000000 RSI: 00000000000001c0 RDI: 0000563b11cf26e0
> > [  +0.000001] RBP: 0000563b11cf2731 R08: 000000000000000d R09: 0000000000000002
> > [  +0.000000] R10: 11175e4331068ed5 R11: 0000000000000246 R12: 0000563b11cf26e0
> > [  +0.000002] R13: 00007fef3e019c20 R14: 00007ffdb4eba0f0 R15: 8421084210842109
> > 
> > Just a constant stream of them.
> > 
> > There's a few other fun:
> > 
> > [  +0.453222] BUG: unable to handle page fault for address: ffffb59cc2719000
> > [  +0.000004] #PF: supervisor write access in kernel mode
> > [  +0.000001] #PF: error_code(0x000b) - reserved bit violation
> > 
> > messages at times, but I don't think that's an ext4 issue, but rather
> > something in the sound stack...
> > 
> > EXT4 developers, any hints/patches to try?
> > 
> 
> Below patch should fix the ext4 issue coming from ext4_mb_new_blocks().
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=811985365378df01386c3cfb7ff716e74ca376d5

Thanks, that should work, I'll try it out on Monday.

greg k-h
