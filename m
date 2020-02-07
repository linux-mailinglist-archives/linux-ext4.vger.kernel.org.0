Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F62155A6C
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 16:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBGPM0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Feb 2020 10:12:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43653 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgBGPMZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Feb 2020 10:12:25 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so2244945oif.10
        for <linux-ext4@vger.kernel.org>; Fri, 07 Feb 2020 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ho+ECGA5aN8XVM9hXBgMyckxUYcFKHvY/RoC9J7crsc=;
        b=BQd4XlRWJ0TW1PyivUmb3qB+LPSBkQ42JfPoIMnXOtNHciT7QbDThJ71JXzI6GzGqq
         f2bSt7kEIlCCbByAvDejtEe3P/Ml3DDDwFaSOxGPHL51qdHpfYQwnmb9rudEetDPx3sc
         ZU5ijfHm+M18dYk/N0jfroPTRySepImgEG4tWA2I2h5z0O7Fq4V0mCaYc4RXi3P2ufVm
         90AfLBmfflcqe7dbX6L4dJ9NNlPquvNOlHKr9abbmHu20UOto050K8K8ag0hfPeiNC7G
         Q6mISVG1QxgXo6seuk7yaFBR1vcHfkUXcL/V+Eo8N38hFNfPlyKMlFf6j5DVqeQfVGY+
         lx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ho+ECGA5aN8XVM9hXBgMyckxUYcFKHvY/RoC9J7crsc=;
        b=VCLbHfsEiV08c6omrLAV3o/GihQS3NyWX8cMuJm1n7UnFZvbSbXXyjvJMME0zwIaXr
         qDUW+Fw/tpcvwJ33ROS38nMSbLXH9DZEoYwETGjFTKBQKksUJ/kCpx9HXMCOhSNC83bD
         W7fnC3GUKKmM3v3pWp89Mu2VIyNnjcl5TNfWaMVubkRjf8erYbGZDrirzqKrh/V8nqRa
         b6AZa9C/zYQOwBHiuDkhWQbn4MVVupe3SuOl7JBcHClCPZ8e8bsvMtWqEeRHPXwHH+qv
         CBwhuulztUvVGCymU4fdQCyzik19+yPMiLDX6/2K41yiAgRKGveag7ulMN7U4dX9ojyC
         gc9A==
X-Gm-Message-State: APjAAAWaUjLhQt5TgY9s8txlMVn3U9A5jFO8z9xVmITg9KhQe33mzVYY
        /FPTKoGJLZ3B/myj9+IpYLatS3RYmpbjwfeqk1cQpHJd
X-Google-Smtp-Source: APXvYqxdZdiLpR8OTS0eJSlwX82i2AQDgR57x3LFoC+6Qh/MtodZ0ZXTDO0GKtnMgFZS339nqWaIKGk/qHw+KuNMJQM=
X-Received: by 2002:aca:c7ca:: with SMTP id x193mr2412814oif.70.1581088343061;
 Fri, 07 Feb 2020 07:12:23 -0800 (PST)
MIME-Version: 1.0
References: <1581085751-31793-1-git-send-email-cai@lca.pw>
In-Reply-To: <1581085751-31793-1-git-send-email-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 7 Feb 2020 16:12:10 +0100
Message-ID: <CANpmjNNqNzfMbFPGkSQgC7Q7yti30K0xcZmUsG9EtVdXsppjnw@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: fix a data race in EXT4_I(inode)->i_disksize
To:     Qian Cai <cai@lca.pw>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 7 Feb 2020 at 15:29, Qian Cai <cai@lca.pw> wrote:
>
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
> ---
>
> v2: also add WRITE_ONCE() which is recommended even for fixing load tearing.

Just a note: I keep seeing 'load tearing' mentioned as the only reason:

  - The WRITE_ONCE avoids store-tearing (and other optimizations).

  - We're not only interested in avoiding load/store tearing. There
are plenty other compiler optimizations that can break concurrent
code: https://lwn.net/Articles/793253/

Thanks,
-- Marco


>  fs/ext4/ext4.h  | 2 +-
>  fs/ext4/inode.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9a2ee2428ecc..8329ccc82fa9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3029,7 +3029,7 @@ static inline void ext4_update_i_disksize(struct inode *inode, loff_t newsize)
>                      !inode_is_locked(inode));
>         down_write(&EXT4_I(inode)->i_data_sem);
>         if (newsize > EXT4_I(inode)->i_disksize)
> -               EXT4_I(inode)->i_disksize = newsize;
> +               WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize);
>         up_write(&EXT4_I(inode)->i_data_sem);
>  }
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3313168b680f..6f9862bf63f1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2465,7 +2465,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>          * truncate are avoided by checking i_size under i_data_sem.
>          */
>         disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
> -       if (disksize > EXT4_I(inode)->i_disksize) {
> +       if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
>                 int err2;
>                 loff_t i_size;
>
> --
> 1.8.3.1
>
