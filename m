Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BFA372377
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 01:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhECXQH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 May 2021 19:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhECXQG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 May 2021 19:16:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E58DC061574
        for <linux-ext4@vger.kernel.org>; Mon,  3 May 2021 16:15:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d14so8288866edc.12
        for <linux-ext4@vger.kernel.org>; Mon, 03 May 2021 16:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3dcs0o0ml4UaR9eTP5ZePBkm/FD4w4aK0nQ1lXlCrg=;
        b=Q5Sq4CTz3yWwuJBPGEGzSYJAl4hj88eRB2la37uDOSKmJfbv9V0difxHB1Euqnb+GE
         DLORJZYVqmIZL5f6as2NUebznIXg11Z+E/9kaFnlUipxF8PGIMdD1Sznp50b95b//omM
         2/qq3jQt2u0UfFw5RYoEx6SEaa7BpvOnayL12LUas23jHNhs+y6mx9C5qhv2fTQx1rSq
         t/OCDmGXzjfmyvw2knJRPjZjARQc+vXGnqMtb5J3JMZcpCgXydbEJ/qNwq5X8eTjHOmD
         EXyJrp20CDqcpcYiFOMab9OE0vnHPbWmo3bdD7zflU76XDydayeP2/7bliBCgfY7FaM4
         B9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3dcs0o0ml4UaR9eTP5ZePBkm/FD4w4aK0nQ1lXlCrg=;
        b=WPCJWC+dgNVbBKwVPZBlesAW/D5Zh/vXXBxVX4+ZTA6rFiumD+ioCB/lZ+Yx54tM0j
         UYtJAHv1kuo1X4gkboAUC7j4OFVg09mJJk6nwgLxDX0OIo00zhTDQXgb1f7xZe1CelSd
         1l8vC78RrDsLNbsgfTNlawaRHYGTVOMRm46DBfDgP4uj0L6bUqpJOhKYxDDoN8wy3p5H
         HTuLZ9e38INmYdpmixeYmymMVeJuELDBPHRaBwjVbL0XwEULZuXtmotmxHItDCsf5fEm
         eJU2CgJsN5GJ594JhRcYb8HpJ1n/cVFaUT9O0EXuM/UhtrcH88y3ZQFBHvKfx2pxTAgW
         sd4A==
X-Gm-Message-State: AOAM5308AnoDIRJxU7iTJyWpq1CkUxSlqBW+9CU2ieL/TDtEEyq/qzNg
        E6W6/0aaFhL+iCoxcuViP0BsAAWfjA3i5ucI7AI=
X-Google-Smtp-Source: ABdhPJxJioqR0QUQz0+2J1Nvbkb3htAqMxHXU7aM3rGP9H3H4zFZ79A2Vzlu4HIPGks+E8D4Kx/ioxDuoHWndlpXP+M=
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr23153207edv.87.1620083710993;
 Mon, 03 May 2021 16:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <6cceb9a75c54bef8fa9696c1b08c8df5ff6169e2.1619692410.git.riteshh@linux.ibm.com>
In-Reply-To: <6cceb9a75c54bef8fa9696c1b08c8df5ff6169e2.1619692410.git.riteshh@linux.ibm.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 3 May 2021 16:14:59 -0700
Message-ID: <CAD+ocbzDRw7vvyVGt5KGYjoL3GTyiaJJoTF0BPTXfySke4t3aQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix accessing uninit percpu counter variable with fast_commit
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, this looks good to me!

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Thu, Apr 29, 2021 at 3:43 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> When running generic/527 with fast_commit configuration, below issue is
> seen on Power.
> With fast_commit, during ext4_fc_replay() (which can be called from
> ext4_fill_super()), if inode eviction happens then it can access an
> uninitialized percpu counter variable.
>
> This patch adds the check b4 accessing the counters in ext4_free_inode() path.
>
> [  321.165371] run fstests generic/527 at 2021-04-29 08:38:43
> [  323.027786] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: block_validity. Quota mode: none.
> [  323.618772] BUG: Unable to handle kernel data access on read at 0x1fbd80000
> [  323.619767] Faulting instruction address: 0xc000000000bae78c
> cpu 0x1: Vector: 300 (Data Access) at [c000000010706ef0]
>     pc: c000000000bae78c: percpu_counter_add_batch+0x3c/0x100
>     lr: c0000000006d0bb0: ext4_free_inode+0x780/0xb90
>     pid   = 5593, comm = mount
>         ext4_free_inode+0x780/0xb90
>         ext4_evict_inode+0xa8c/0xc60
>         evict+0xfc/0x1e0
>         ext4_fc_replay+0xc50/0x20f0
>         do_one_pass+0xfe0/0x1350
>         jbd2_journal_recover+0x184/0x2e0
>         jbd2_journal_load+0x1c0/0x4a0
>         ext4_fill_super+0x2458/0x4200
>         mount_bdev+0x1dc/0x290
>         ext4_mount+0x28/0x40
>         legacy_get_tree+0x4c/0xa0
>         vfs_get_tree+0x4c/0x120
>         path_mount+0xcf8/0xd70
>         do_mount+0x80/0xd0
>         sys_mount+0x3fc/0x490
>         system_call_exception+0x384/0x3d0
>         system_call_common+0xec/0x278
>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/ext4/ialloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 755a68bb7e22..e4a92642e487 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -322,14 +322,16 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
>         if (is_directory) {
>                 count = ext4_used_dirs_count(sb, gdp) - 1;
>                 ext4_used_dirs_set(sb, gdp, count);
> -               percpu_counter_dec(&sbi->s_dirs_counter);
> +               if (percpu_counter_initialized(&sbi->s_dirs_counter))
> +                       percpu_counter_dec(&sbi->s_dirs_counter);
>         }
>         ext4_inode_bitmap_csum_set(sb, block_group, gdp, bitmap_bh,
>                                    EXT4_INODES_PER_GROUP(sb) / 8);
>         ext4_group_desc_csum_set(sb, block_group, gdp);
>         ext4_unlock_group(sb, block_group);
>
> -       percpu_counter_inc(&sbi->s_freeinodes_counter);
> +       if (percpu_counter_initialized(&sbi->s_freeinodes_counter))
> +               percpu_counter_inc(&sbi->s_freeinodes_counter);
>         if (sbi->s_log_groups_per_flex) {
>                 struct flex_groups *fg;
>
> --
> 2.30.2
>
