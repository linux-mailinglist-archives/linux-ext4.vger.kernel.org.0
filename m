Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABFF916562B
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 05:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBTERD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Feb 2020 23:17:03 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33759 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727476AbgBTERD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Feb 2020 23:17:03 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01K4Gp6k017152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 23:16:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5101C4211EF; Wed, 19 Feb 2020 23:16:51 -0500 (EST)
Date:   Wed, 19 Feb 2020 23:16:51 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Qian Cai <cai@lca.pw>
Cc:     adilger.kernel@dilger.ca, elver@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix a data race in EXT4_I(inode)->i_disksize
Message-ID: <20200220041651.GA476845@mit.edu>
References: <1581085751-31793-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581085751-31793-1-git-send-email-cai@lca.pw>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 07, 2020 at 09:29:11AM -0500, Qian Cai wrote:
> EXT4_I(inode)->i_disksize could be accessed concurrently as noticed by
> KCSAN,
> 
>  BUG: KCSAN: data-race in ext4_write_end [ext4] / ext4_writepages [ext4]
> 
>  write to 0xffff91c6713b00f8 of 8 bytes by task 49268 on cpu 127:
>   ext4_write_end+0x4e3/0x750 [ext4]
>   ext4_update_i_disksize at fs/ext4/ext4.h:3032
>   (inlined by) ext4_update_inode_size at fs/ext4/ext4.h:3046
>   (inlined by) ext4_write_end at fs/ext4/inode.c:1287
>   generic_perform_write+0x208/0x2a0
>   ext4_buffered_write_iter+0x11f/0x210 [ext4]
>   ext4_file_write_iter+0xce/0x9e0 [ext4]
>   new_sync_write+0x29c/0x3b0
>   __vfs_write+0x92/0xa0
>   vfs_write+0x103/0x260
>   ksys_write+0x9d/0x130
>   __x64_sys_write+0x4c/0x60
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  read to 0xffff91c6713b00f8 of 8 bytes by task 24872 on cpu 37:
>   ext4_writepages+0x10ac/0x1d00 [ext4]
>   mpage_map_and_submit_extent at fs/ext4/inode.c:2468
>   (inlined by) ext4_writepages at fs/ext4/inode.c:2772
>   do_writepages+0x5e/0x130
>   __writeback_single_inode+0xeb/0xb20
>   writeback_sb_inodes+0x429/0x900
>   __writeback_inodes_wb+0xc4/0x150
>   wb_writeback+0x4bd/0x870
>   wb_workfn+0x6b4/0x960
>   process_one_work+0x54c/0xbe0
>   worker_thread+0x80/0x650
>   kthread+0x1e0/0x200
>   ret_from_fork+0x27/0x50
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 37 PID: 24872 Comm: kworker/u261:2 Tainted: G        W  O L 5.5.0-next-20200204+ #5
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
>  Workqueue: writeback wb_workfn (flush-7:0)
> 
> Since only the read is operating as lockless (outside of the
> "i_data_sem"), load tearing could introduce a logic bug. Fix it by
> adding READ_ONCE() for the read and WRITE_ONCE() for the write.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Thanks, applied.

						- Ted
