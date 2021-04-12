Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7545435BFB8
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 11:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhDLJG3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 05:06:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239147AbhDLJCc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 12 Apr 2021 05:02:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2ECFEAF1B;
        Mon, 12 Apr 2021 09:02:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E74FF1F2B65; Mon, 12 Apr 2021 11:02:12 +0200 (CEST)
Date:   Mon, 12 Apr 2021 11:02:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jack@suse.com,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: More KCSAN data-race Reports
Message-ID: <20210412090212.GA31090@quack2.suse.cz>
References: <CACkBjsYrsp5LekZciBjSbnJLHvBwQF3YM5TiKEMPeUX-D_DaSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsYrsp5LekZciBjSbnJLHvBwQF3YM5TiKEMPeUX-D_DaSA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Sun 11-04-21 11:42:05, Hao Sun wrote:
> Since the last KCSAN report[1], I found two more KCSAN reports that
> Syzbot had not reported.
> Not sure if they are valid bugs, I hope the stack information in
> reports can help you locate the problem.
> Kernel config can be found in the attachment.

Do we have symbolic decoding of the traces below? Because involved
functions are really big so it's difficult to guess what KCSAN is
complaining about... At least I wasn't able to guess it after looking into
the stacktraces for a while.

								Honza

> 
> Here is the detailed information:
> commit:   3b9cdafb5358eb9f3790de2f728f765fef100731
> version:   linux 5.11
> git tree:    upstream
> 
> Report-1
> ==================================================================
> BUG: KCSAN: data-race in ext4_mark_iloc_dirty / jbd2_journal_commit_transaction
> 
> read-write to 0xffff88804451d800 of 8 bytes by task 4821 on cpu 1:
>  jbd2_journal_commit_transaction+0x222/0x3200
>  kjournald2+0x253/0x470
>  kthread+0x1f0/0x220
>  ret_from_fork+0x1f/0x30
> 
> read to 0xffff88804451d800 of 8 bytes by task 8418 on cpu 0:
>  ext4_mark_iloc_dirty+0x14ec/0x16e0
>  __ext4_mark_inode_dirty+0x4d2/0x5d0
>  ext4_evict_inode+0xb9f/0xed0
>  evict+0x1a6/0x410
>  iput+0x3fc/0x510
>  do_unlinkat+0x2c9/0x4d0
>  __x64_sys_unlink+0x2c/0x30
>  do_syscall_64+0x39/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Report-2
> ==================================================================
> BUG: KCSAN: data-race in __ext4_handle_dirty_metadata /
> jbd2_journal_commit_transaction
> 
> read-write to 0xffff88800e142800 of 8 bytes by task 4823 on cpu 0:
>  jbd2_journal_commit_transaction+0x222/0x3200
>  kjournald2+0x253/0x470
>  kthread+0x1f0/0x220
>  ret_from_fork+0x1f/0x30
> 
> read to 0xffff88800e142800 of 8 bytes by task 7925 on cpu 1:
>  __ext4_handle_dirty_metadata+0x11a/0x590
>  ext4_mark_iloc_dirty+0x12dd/0x16e0
>  __ext4_mark_inode_dirty+0x4d2/0x5d0
>  ext4_dirty_inode+0x86/0xa0
>  __mark_inode_dirty+0x70/0x6b0
>  file_update_time+0x3ab/0x3f0
>  file_modified+0x62/0x80
>  ext4_buffered_write_iter+0x1f9/0x3d0
>  ext4_file_write_iter+0x45e/0x10d0
>  vfs_write+0x6db/0x7c0
>  ksys_write+0xce/0x180
>  __x64_sys_write+0x3e/0x50
>  do_syscall_64+0x39/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> 
> [1] https://lore.kernel.org/lkml/CACkBjsZW5Sp4jB51+C5mrMssgq73x8iEko_EV6CTXVvtVa7KPQ@mail.gmail.com/


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
