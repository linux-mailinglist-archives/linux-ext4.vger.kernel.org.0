Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED76429963
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 00:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhJKWXj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 18:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbhJKWXi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Oct 2021 18:23:38 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B5BC061570;
        Mon, 11 Oct 2021 15:21:38 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id az39so4118534qkb.5;
        Mon, 11 Oct 2021 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWEHaLTdiLPzpqE2shnprm/Gl9iR2yUVLsqqjyZPONU=;
        b=EJwu1PS2uSvrbqNM6sq+WWp273riboz2Drlsn0tmaj0Gn9LpWOa0udTb1tkVII6Oz9
         335ylcl+efL3L1WSSjpC8rP6q0OdZZB/M30/WqphkyGx1qNV8uXtF5rqWqdL6qcd/pX8
         Gk3TQVxUAK+d7lYWkIcABKuzPKDEDyfi9xIXxvPiloGCut7KxWSwd6f6rWgzUlOJ3G/c
         p47gDNk5ljDqaIFj8tlJC5KJjk0vQVvMDBBoJTtx/KwqEcyuJfUbxLqmVsW/cIMC3LpU
         29MJW7bQraw3/gvDvOFmM47sp60wuMxlQhhwTq/LL0nTJa1cH02s7CSrkth7wK5EZOhw
         e2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWEHaLTdiLPzpqE2shnprm/Gl9iR2yUVLsqqjyZPONU=;
        b=3xTkc+rvIYBBAFsXyQnw0W238wrbDrrOIAXklne33FBHkD1gxee86zOZ4h7Wiv+EcN
         RSyvjmyrVSw6iAbGseHnk1km1+FosIbexG73SVRkbrWEeA8mecZBcUoHfl5HGDNwspXt
         tRyp3IsAFyho3GG4+I10o0aURPjwCtwLwLy3QzvGgV8AlH2pwmXqtpm2Rb2G3XS7EzxS
         al4T8VA9f4EosV38ezqKE/XsjyrzkO+Bmyf67Dgm5/bnxY8BEfqTd5OpP3j93qlfIAQZ
         skPy/F8uybDZKjrQoFAjfQH9h0Bm2OtgSbfq8z+xbUvpbpBDK4VKVzmbDTLq2fZFJLqN
         WHDw==
X-Gm-Message-State: AOAM532ioNXg8BQenPRPKdzoSZer4xGZxyohkcGcUD6vpCMpJU13U1p4
        jeLVn2lq8mFSlU4zuB+e9QeZo22OsZM=
X-Google-Smtp-Source: ABdhPJzHvlcPSaImdRCXxuN7X1mDlb9WRkxrGRUVC7OceUFBnc4Kf3eosrrWIdsgM/xbUOeD3D+6qw==
X-Received: by 2002:a37:4658:: with SMTP id t85mr16572873qka.195.1633990897208;
        Mon, 11 Oct 2021 15:21:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id c5sm1090658qkm.10.2021.10.11.15.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 15:21:36 -0700 (PDT)
Date:   Mon, 11 Oct 2021 18:21:35 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG in ext4_da_get_block_prep
Message-ID: <20211011222135.GA17897@localhost.localdomain>
References: <CACkBjsb1dE7A_v_=yYfMOO0HSGT9a0Zc7=cC6cmYREWepHhxpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACkBjsb1dE7A_v_=yYfMOO0HSGT9a0Zc7=cC6cmYREWepHhxpw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Hao Sun <sunhao.th@gmail.com>:
> Hello,
> 
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
> 
> HEAD commit: 60a9483534ed Merge tag 'warning-fixes-20211005'
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1zMa_o4PaMiO_nYcQ4giUjNhFszYjFae-/view?usp=sharing
> kernel config: https://drive.google.com/file/d/1u-ncYGLkq3xqdlNQYJz8-G6Fhf3H-moP/view?usp=sharing
> Syzlang reproducer:
> https://drive.google.com/file/d/1LWQjzVVjjI8q6sO1f4AYlq5NlcN-shBP/view?usp=sharing
> 
> Sorry, I don't have a C reproducer for this crash, hope the symbolized
> report and Syzlang reproducer can help.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> 
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/inode.c:1721!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 19701 Comm: syz-executor Not tainted 5.15.0-rc4+ #22
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ext4_da_map_blocks fs/ext4/inode.c:1721 [inline]
> RIP: 0010:ext4_da_get_block_prep+0x52a/0x5a0 fs/ext4/inode.c:1830
> Code: 0f 0b ba 01 00 00 00 e9 d0 fd ff ff e8 7f 42 c0 ff f0 80 4b 01
> 01 4c 89 ef 31 ed e8 a0 c7 b3 ff e9 f2 fb ff ff e8 66 42 c0 ff <0f> 0b
> e8 5f 42 c0 ff 0f 0b e8 58 42 c0 ff 0f 0b e8 51 42 c0 ff 49
> RSP: 0018:ffffc9000f8978d0 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffff888121a493f0 RCX: ffffc900011f9000
> RDX: 0000000000040000 RSI: ffffffff81774f6a RDI: ffffffff853cd076
> RBP: 27ffffffffffffff R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc9000f897740 R11: 0000000000000002 R12: ffff88811560b220
> R13: 00000000000008f3 R14: 0000000000000004 R15: ffffffffffff0000
> FS:  00007f773e1d6700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f773e1abdb8 CR3: 000000000a5d7000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  ext4_block_write_begin+0x208/0x980 fs/ext4/inode.c:1078
>  ext4_da_write_begin+0x1d4/0x490 fs/ext4/inode.c:2969
>  generic_perform_write+0xce/0x220 mm/filemap.c:3770
>  ext4_buffered_write_iter+0xd6/0x190 fs/ext4/file.c:269
>  ext4_file_write_iter+0x80/0x940 fs/ext4/file.c:680
>  call_write_iter include/linux/fs.h:2163 [inline]
>  do_iter_readv_writev+0x1e8/0x2b0 fs/read_write.c:729
>  do_iter_write+0xaf/0x250 fs/read_write.c:855
>  vfs_iter_write+0x38/0x60 fs/read_write.c:896
>  iter_file_splice_write+0x2d8/0x450 fs/splice.c:689
>  do_splice_from fs/splice.c:767 [inline]
>  direct_splice_actor+0x4a/0x80 fs/splice.c:936
>  splice_direct_to_actor+0x123/0x2d0 fs/splice.c:891
>  do_splice_direct+0xc3/0x110 fs/splice.c:979
>  do_sendfile+0x338/0x740 fs/read_write.c:1249
>  __do_sys_sendfile64 fs/read_write.c:1314 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1300 [inline]
>  __x64_sys_sendfile64+0xc7/0xe0 fs/read_write.c:1300
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f773e1d5c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
> RBP: 00000000004e4809 R08: 0000000000000000 R09: 0000000000000000
> R10: 00008400fffffffb R11: 0000000000000246 R12: 000000000078c0a0
> R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007fffca657850
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 46bee01b7f620b60 ]---
> RIP: 0010:ext4_da_map_blocks fs/ext4/inode.c:1721 [inline]
> RIP: 0010:ext4_da_get_block_prep+0x52a/0x5a0 fs/ext4/inode.c:1830
> Code: 0f 0b ba 01 00 00 00 e9 d0 fd ff ff e8 7f 42 c0 ff f0 80 4b 01
> 01 4c 89 ef 31 ed e8 a0 c7 b3 ff e9 f2 fb ff ff e8 66 42 c0 ff <0f> 0b
> e8 5f 42 c0 ff 0f 0b e8 58 42 c0 ff 0f 0b e8 51 42 c0 ff 49
> RSP: 0018:ffffc9000f8978d0 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffff888121a493f0 RCX: ffffc900011f9000
> RDX: 0000000000040000 RSI: ffffffff81774f6a RDI: ffffffff853cd076
> RBP: 27ffffffffffffff R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc9000f897740 R11: 0000000000000002 R12: ffff88811560b220
> R13: 00000000000008f3 R14: 0000000000000004 R15: ffffffffffff0000
> FS:  00007f773e1d6700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f773e1abdb8 CR3: 000000000a5d7000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554

Hi:

Thanks for the report.

Violation of the assertion enforced on line 1721 in fs/ext4/inode.c has
already been reported separately in a recent upstream kernel.

It's not clear what can be done with the information reported here.  A
reproducer would be most useful but it's not obvious how to generate that
from this information.  The supplied log suggests that 1) the test
file system was encountering ENOMEM at least from time to time in ext4_setattr
and that 2) some sort of fault was being injected to force a failure prior to
the crash.

What sort of fault was being injected?

The fact that the test system was running out of memory is a potentially
useful hint.

Thanks,
Eric

P.S.  The supplied kernel configuration produces a kernel that runs so slowly
that a trial run of the ext4 test appliance has made almost no forward
progress on my test system in three hours of running time on ext4/032 alone
(4K test scenario).  So, that's not particularly useful.


