Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2FD31B8BB
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Feb 2021 13:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBOMHE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Feb 2021 07:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhBOMHB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Feb 2021 07:07:01 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF81C061574
        for <linux-ext4@vger.kernel.org>; Mon, 15 Feb 2021 04:06:20 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id c16so5875759otp.0
        for <linux-ext4@vger.kernel.org>; Mon, 15 Feb 2021 04:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nYfV4im58SGUzn/onSf8UJpfEn4jJNIua0MlsFfnhgg=;
        b=QCbfIjt+ZUxplnZ6xxd7PXt1ApuZyrISWfmuEKh132GtGj3JPMZ9mgOmlq8Rv+Q1kd
         1Ci4CbfyiJZ0ldLhFCAS5pZpF6oas/eX83Bs22rPdUhUTV19U/jkWs74DNPpoXIqNx2n
         uxia4CinNDW53putr24rCH+DdY6pDpjMjnaPPGPL7Guh55XSQafs94SKaNzVlv2kPMJE
         zZKGc7nNCzqmsfFGFMivPFjA7YECeTv6XE2orzYGe4jFiZke5P9Q9d5wRjge/tUDSpl3
         LTDE+1PeTfziVVN50RaHoJY21hLyH5Xrd+qBAstEMbDAA7OQEMk2IWylX4YjrERLi2j+
         cgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nYfV4im58SGUzn/onSf8UJpfEn4jJNIua0MlsFfnhgg=;
        b=FKbpPGjZU4sX79GzifNTfvHAeWs7xPpwaHijb6Z8/nAYoFgI8UzgZxBx4MotAha9ou
         rF6q8ZxayTHhLnFP1kzcGpP+4nwc7jE1kKpRzBWBZIucreaoCvOyiyO2nrb46xy66yQY
         KgqGHLCt/I8LfesTJ2pBYzWGMTY4uRlNPW7q1k7z1yV6sdhjw7+Vhg/c4fqcVaPEna9P
         81NkI4RY/oR01ritr8df8b6LXxv6IbJ/yp4NtfJJl+Xo7MZYvidO6V09N3NhEjBY0geG
         6FxuYtcyQi5665ZlYxdohkXo002PWVjzapg+nQUfcuVX7eY4qCgy2ME0jG0X6G61vbN6
         druw==
X-Gm-Message-State: AOAM531jO5plYKzUk3QnHw2EiatHZ1TlWY1CavDrp47Cdca+UtHJhINl
        WGPIZBWff0kNVfGJR3psML/XJqL3B+0pvBVuHPnNIe3so+I=
X-Google-Smtp-Source: ABdhPJwkg5Rsvywt15oSITAyytSq1V7jupd/SE4+ZfkOZAav6xQmruo5KLPS1Btvj5+9itwvNr3HaWsA8SI4+pNhSQo=
X-Received: by 2002:a9d:4c13:: with SMTP id l19mr11206454otf.226.1613390779477;
 Mon, 15 Feb 2021 04:06:19 -0800 (PST)
MIME-Version: 1.0
From:   Shashidhar Patil <shashidhar.patil@gmail.com>
Date:   Mon, 15 Feb 2021 17:36:08 +0530
Message-ID: <CADve3d6ShQXHZhfHsh2rhPD-=sZsO9VJcu5H5yfLjdwe5Sg4=A@mail.gmail.com>
Subject: jbd2 task hung in jbd2_journal_commit_transaction
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,
      We are seeing problem with many tasks hung in 'D' state and
stack output of jbd2 thread is hung at
jbd2_journal_commit_transaction().

The stack trace of jdb2 task is:

[<0>] jbd2_journal_commit_transaction+0x26e/0x1870^M
[<0>] kjournald2+0xc8/0x250^M
[<0>] kthread+0x105/0x140^M
[<0>] ret_from_fork+0x35/0x40^M
[<0>] 0xffffffffffffffff^M

The symptoms look similar to
https://www.spinics.net/lists/linux-ext4/msg53502.html.

The system has zswap configured with swap backing is an ext4 file.
There are oom kills recorded in the dmesg.

As per Theodore in the above link the issue is caused by a leaked
atomic handle. But one of the backtraces collected (below) points to
a.possile problem of cylic dependency.
This is explained in below steps
1. sys_write processing allocates atomic handle for journaling
2. as part of write processing page allocation is called.
3. Because of lack of page frames zswap gets invoked to free up a page frame.
4. zswap backup ram is full so it tries to free up some pages and
initiates a disk writeback. In this case the swap file is on the same
partition on which write() call is done.
5. Until the write request is processed the atomic handle is not
released(journal_stop)
6. The write transfer hangs in transaction_commit since there is an
open atomic handle.

Is this a possibility ? I have more logs captured with /proc/sysrq
which I can share as required.

Appreciate your help.


4,1707851,1121527990415,-; __schedule+0x3d6/0x8b0
4,1707852,1121527990416,-; schedule+0x36/0x80
4,1707853,1121527990417,-; io_schedule+0x16/0x40
4,1707854,1121527990418,-; wbt_wait+0x22f/0x380
4,1707855,1121527990419,-; ? trace_event_raw_event_wbt_timer+0x100/0x100
4,1707856,1121527990421,-; ? end_swap_bio_read+0xd0/0xd0
4,1707857,1121527990422,-; blk_mq_make_request+0x103/0x5b0
4,1707905,1121527990537,-; ? end_swap_bio_read+0xd0/0xd0
4,1707906,1121527990541,-; generic_make_request+0x122/0x2f0
4,1707907,1121527990544,-; submit_bio+0x73/0x140
4,1707908,1121527990547,-; ? submit_bio+0x73/0x140
4,1707909,1121527990549,-; ? get_swap_bio+0xcf/0x100
4,1707910,1121527990553,-; __swap_writepage+0x33f/0x3b0
4,1707911,1121527990555,-; ? lru_cache_add_file+0x37/0x40
4,1707912,1121527990558,-; ? lzo_decompress+0x38/0x70
4,1707913,1121527990561,-; zswap_writeback_entry+0x249/0x350
4,1707914,1121527990565,-; zbud_zpool_evict+0x31/0x40
4,1707915,1121527990568,-; zbud_reclaim_page+0x1e9/0x250
4,1707916,1121527990571,-; zbud_zpool_shrink+0x3b/0x60
4,1707917,1121527990574,-; zpool_shrink+0x1c/0x20
4,1707918,1121527990577,-; zswap_frontswap_store+0x274/0x530
4,1707919,1121527990580,-; __frontswap_store+0x78/0x100
4,1707920,1121527990584,-; swap_writepage+0x3f/0x80
4,1707921,1121527990587,-; pageout.isra.53+0x1e6/0x340
4,1707922,1121527990590,-; shrink_page_list+0x992/0xbe0
4,1707923,1121527990593,-; shrink_inactive_list+0x2af/0x5f0
4,1707924,1121527990596,-; ? _find_next_bit+0x40/0x70
4,1707925,1121527990599,-; shrink_node_memcg+0x36f/0x7f0
4,1707926,1121527990603,-; shrink_node+0xe1/0x310
4,1707927,1121527990606,-; ? shrink_node+0xe1/0x310
4,1707928,1121527990609,-; do_try_to_free_pages+0xee/0x360
4,1707929,1121527990612,-; try_to_free_pages+0xf1/0x1c0
4,1707930,1121527990614,-; __alloc_pages_slowpath+0x399/0xe90
4,1707931,1121527990616,-; __alloc_pages_nodemask+0x289/0x2d0
4,1707932,1121527990618,-; alloc_pages_current+0x6a/0xe0
4,1707933,1121527990619,-; __page_cache_alloc+0x86/0x90
4,1707934,1121527990620,-; pagecache_get_page+0x88/0x2c0
4,1707935,1121527990621,-; grab_cache_page_write_begin+0x23/0x40
4,1707936,1121527990623,-; ext4_da_write_begin+0xd8/0x460
4,1707937,1121527990624,-; generic_perform_write+0xba/0x1b0
4,1707938,1121527990625,-; __generic_file_write_iter+0x1a6/0x1f0
4,1707939,1121527990627,-; ext4_file_write_iter+0xc4/0x3b0
4,1707940,1121527990629,-; ? __handle_mm_fault+0xa67/0x1240
4,1707941,1121527990630,-; ? __switch_to_asm+0x41/0x70
4,1707942,1121527990632,-; new_sync_write+0xe5/0x140
4,1707943,1121527990633,-; __vfs_write+0x29/0x40
4,1707944,1121527990635,-; vfs_write+0xb8/0x1b0
4,1707945,1121527990636,-; ? syscall_trace_enter+0x1d6/0x2f0
4,1707946,1121527990637,-; SyS_write+0x5c/0xe0
4,1707947,1121527990639,-; do_syscall_64+0x73/0x130
4,1707948,1121527990640,-; entry_SYSCALL_64_after_hwframe+0x3d/0xa2
