Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308586A5D2F
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 17:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjB1Qey (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 11:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjB1Qex (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 11:34:53 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB79F2448D;
        Tue, 28 Feb 2023 08:34:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q189so6014932pga.9;
        Tue, 28 Feb 2023 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VEVi55Um5zbjxtbiNbKO4HkIKWrPOjc+1piWqgByaiU=;
        b=VrybE3SYeg4Y4ioXoWOTPNsahjlU0PckVsNHyP4CpE8AHrXErpIRYDgnTDlznmdXoG
         hxtUwLDfADUAk7Wtv0+agfCoB1a6YAahBvx2WiOKZsuC2epG3eWOD3bdX+eu3sJqOG++
         fbVLNXV1cX7FEltA29UbLJdIsmLWalirIDiq6uqj2Pq0STxYUWLj5sioLIB5nxPrRlbS
         6jiO4ZngurFMt7dtksoKtlcSNY9ZvlDbBMT+cM/4XIBWSNqyylfczlBlDKewI7vjmQhv
         boMbctNNofEYZKav2l0Me9wkRBBKdSSsHCRaxlxH84v+I7nXPYYEWydMRv5UpEvfKc5R
         73ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEVi55Um5zbjxtbiNbKO4HkIKWrPOjc+1piWqgByaiU=;
        b=nVjdMYJUcHSnGP0gKMzb0kSQaPe15XjMq9Qruu2q5xchf4bz1lIgmcRSiCQi4aHej3
         et6AXZLyfG8++ZNnnz6CdiMyk1LddVUQ2MFPMvszQZo2Zh/OV5N3b1dGVgLhe7E/1koc
         ZsS6p8+cmc74R2MqQyvfd/HHQOuMqIsGEYNRraSi2J8gfHiPJ28Ccn+26/VythkDp0gF
         1Zus2ZBmuPvdEI0ukpjB/2CrHRw+DDkM6FuV/mP6DjntvbWXDRjrdSegg+oP2wAu2Gdg
         ErjW0wd1O8CWmYtPpgc3+er1nHpyQhfcPEEu7sB3TfhJnK4tBrbP+qI/SgXUaxUt79au
         Rnrg==
X-Gm-Message-State: AO0yUKVISrqSkQeu5N2/hPYPbwVsT8XhhKjUgI0ORfKvivuwZ+erKZA3
        rh42L2T6VwVY7kBicIql3Ng=
X-Google-Smtp-Source: AK7set9ZBtb0mrfp/QMLYxkbshuqdBTBMeKARyhvFV7LQREJQ1nzHZASBwvLc8ge7IMVPTE/4TZYgQ==
X-Received: by 2002:aa7:9a05:0:b0:5a8:b6cf:1a74 with SMTP id w5-20020aa79a05000000b005a8b6cf1a74mr2999502pfj.18.1677602086893;
        Tue, 28 Feb 2023 08:34:46 -0800 (PST)
Received: from rh-tp ([2406:7400:63:469f:eb50:3ffb:dc1b:2d55])
        by smtp.gmail.com with ESMTPSA id c9-20020a637249000000b00502f20aa4desm5943182pgn.70.2023.02.28.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:34:46 -0800 (PST)
Date:   Tue, 28 Feb 2023 22:04:35 +0530
Message-Id: <87356pwxyc.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH v2 00/20] Some bugfix and cleanup to mballoc
In-Reply-To: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> Hi, this series contain some random cleanup patches and some bugfix
> patches to make EXT4_MB_HINT_GOAL_ONLY work properly, protect pa->pa_free
> from race and so on. More details can be found in git log.
> Thanks!

Hi Kemeng,

Did you run any testing on these patches? Because I was very easily able
to hit ext/009 causing kernel BUG_ON with default mkfs/mount options.
It's always a good and recommended practice to ensure some level of
testing on any of the patches we submit to community for review
and call out in the cover letter on what has been tested and what is not.

<Call stack>

[  208.545365] run fstests ext4/009 at 2023-02-28 21:44:06
[  216.581660] EXT4-fs (loop7): mounted filesystem 33805b33-04c1-48c3-8de3-9c78f99a7598 with ordered data mode..
[  216.709050] EXT4-fs (loop7): unmounting filesystem 33805b33-04c1-48c3-8de3-9c78f99a7598.
[  218.878042] EXT4-fs (loop7): mounted filesystem 8a919af6-f8f4-4ef4-949b-673ccd9ae8c7 with ordered data mode..
[  255.517357] ------------[ cut here ]------------
[  255.520274] kernel BUG at fs/ext4/ext4.h:3331!
[  255.522233] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
[  255.524740] CPU: 7 PID: 2567 Comm: xfs_io Not tainted 6.2.0-rc8-xfstests-00041-gb1b4634ed055 #21
[  255.527807] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.4
[  255.531645] RIP: 0010:ext4_get_group_info+0x272/0x2f0
[  255.533682] Code: 0f 85 a9 fe ff ff 48 c7 c2 c0 9b 7d 84 be fd 02 00 00 48 c7 c7 c0 95 7d 84 c6 05 9e b4 3b 8
[  255.539798] RSP: 0018:ffff8881fcd6f6b0 EFLAGS: 00010246
[  255.541721] RAX: 0000000000000000 RBX: ffff8881bfc54000 RCX: ffffffff81ec3d1a
[  255.544181] RDX: 1ffff11040b8a208 RSI: 0000000000000050 RDI: ffff888205c51040
[  255.546695] RBP: ffff888205c51000 R08: 0000000000000000 R09: ffff8881bfc54000
[  255.549151] R10: ffffed102af9756b R11: ffff8881fcd6f5b4 R12: ffff8881fcd6f8a8
[  255.551588] R13: ffff8881bfc546e8 R14: ffff888157c189b8 R15: ffff888157c189e0
[  255.554039] FS:  00007ffff7e58840(0000) GS:ffff8883ecc00000(0000) knlGS:0000000000000000
[  255.556788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  255.558806] CR2: 00007ffff7a7bd58 CR3: 0000000181db4005 CR4: 0000000000170ee0
[  255.561259] Call Trace:
[  255.562248]  <TASK>
[  255.563164]  ? kasan_set_track+0x25/0x30
[  255.564710]  ext4_mb_find_by_goal+0xf1/0xda0
[  255.566317]  ? ext4_alloc_file_blocks.isra.0+0x2a7/0x9a0
[  255.568230]  ? ext4_fallocate+0x28b/0x7d0
[  255.569727]  ? vfs_fallocate+0x2b0/0xb90
[  255.571238]  ? __x64_sys_fallocate+0xb9/0x110
[  255.572852]  ? do_syscall_64+0x3f/0x90
[  255.574372]  ? __pfx_ext4_mb_find_by_goal+0x10/0x10
[  255.576131]  ? set_track_prepare+0x40/0x70
[  255.577677]  ? kmem_cache_alloc+0x388/0x440
[  255.579207]  ext4_mb_regular_allocator+0x1f7/0x1970
[  255.580981]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  255.582874]  ? ___slab_alloc+0xc93/0xd40
[  255.584329]  ? ext4_mb_new_blocks+0xc8f/0x15c0
[  255.585976]  ? __pfx___lock_release+0x10/0x10
[  255.587652]  ? __pfx_ext4_mb_regular_allocator+0x10/0x10
[  255.589554]  ? rcu_read_lock_sched_held+0x47/0x80
[  255.591293]  ? trace_kmem_cache_alloc+0x2d/0xe0
[  255.592997]  ? kmem_cache_alloc+0x25a/0x440
[  255.594552]  ? ext4_mb_new_blocks+0xc8f/0x15c0
[  255.596176]  ext4_mb_new_blocks+0xd3b/0x15c0
[  255.597767]  ? ext4_find_extent+0x742/0xbf0
[  255.599301]  ? __pfx_ext4_mb_new_blocks+0x10/0x10
[  255.601021]  ? lock_is_held_type+0xda/0x130
[  255.602601]  ext4_ext_map_blocks+0x151a/0x2490
[  255.604237]  ? __pfx_ext4_ext_map_blocks+0x10/0x10
[  255.605980]  ? __pfx___lock_acquired+0x10/0x10
[  255.607648]  ? lock_is_held_type+0xda/0x130
[  255.609199]  ? ext4_map_blocks+0x6c9/0x1670
[  255.610757]  ? ext4_map_blocks+0x6c9/0x1670
[  255.612289]  ? lock_acquired+0x10d/0x2b0
[  255.613759]  ? rcu_read_lock_sched_held+0x47/0x80
[  255.615467]  ? ext4_es_lookup_extent+0x43e/0xa20
[  255.617152]  ext4_map_blocks+0x724/0x1670
[  255.618655]  ? lock_is_held_type+0xda/0x130
[  255.620179]  ? __pfx_ext4_map_blocks+0x10/0x10
[  255.621813]  ? rcu_read_lock_sched_held+0x47/0x80
[  255.623512]  ? jbd2__journal_start+0x4ef/0x780
[  255.625191]  ext4_alloc_file_blocks.isra.0+0x2a7/0x9a0
[  255.627019]  ? __pfx_ext4_alloc_file_blocks.isra.0+0x10/0x10
[  255.629034]  ? __pfx_file_modified_flags+0x10/0x10
[  255.630797]  ? lock_is_held_type+0xda/0x130
[  255.632320]  ext4_fallocate+0x28b/0x7d0
[  255.633855]  vfs_fallocate+0x2b0/0xb90
[  255.635252]  __x64_sys_fallocate+0xb9/0x110
[  255.636789]  do_syscall_64+0x3f/0x90
[  255.638135]  entry_SYSCALL_64_after_hwframe+0x72/0xdc


-ritesh
