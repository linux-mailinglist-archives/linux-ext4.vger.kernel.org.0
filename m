Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8879172EA6E
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbjFMSBR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 14:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjFMSBQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 14:01:16 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0351D13E
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 11:01:14 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-50-124.bstnma.fios.verizon.net [108.7.50.124])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35DI14X6013182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 14:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686679266; bh=/FvTGCKGyWS00GLIXeA/0xTqKtDCIUDf9tvM4002itE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DdYlT8FPQQ6IjwU+jYrv9DvjoT0swNzp7J6KOnWePEGoAEfYQLD6DAqDqmiDwHXJh
         c+uWh9CFV2FNQUmdJhhl+uQVZq8fYV/vueipCvNd8qsujFlMZ+CDwEa1wbhEY00LLG
         yDtTsS5aQ3Gajw1ykkyXhUUD6E49fI4qwDJSvAgS+wdqS1PflDcXiC2xkqHNtJn6pZ
         J9UNC6VRlfmFEH6hRScPl7G1Bsyu8PrvlHIEebtzQ5HWEtcCTO+xlPTHGg+ILcYM78
         /lUCW2926q1Al1lNJv9QVIifUt7IJea3VBWm+XsSJ21nYZcYcurCyujUWRo8umS5Uh
         HbJU2+mkRhxKg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 036E515C00B0; Tue, 13 Jun 2023 14:01:04 -0400 (EDT)
Date:   Tue, 13 Jun 2023 14:01:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] UBSAN: shift-out-of-bounds in ext2_fill_super
 (2)
Message-ID: <20230613180103.GC18303@mit.edu>
References: <00000000000079134b05fdf78048@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000079134b05fdf78048@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I wonder if we should have a separate syzkaller subsystem for ext2 (as
distinct from ext4)?  The syz reproducer seems to know that it should
be mounting using ext2, but also calls it an ext4 file system, which
is a bit weird.  I'm guessing there is something specific about the
syzkaller internals which might not make this be practical, but I
thought I should ask.

From the syz reproducer:

syz_mount_image$ext4(&(0x7f0000000100)='ext2\x00', ...)

More generally, there are a series of changes that were made to make
ext4 to make it more robust against maliciously fuzzed superblocks,
but we haven't necessarily made sure the same analogous changes have
been made to ext2.  I'm not sure how critical this is in practice,
since most distributions don't actually compile fs/ext2 and instead
use CONFIG_EXT4_USE_FOR_EXT2 instead.  However, while we maintain ext2
as a sample "simple" modern file system, I guess we should try to make
sure we do carry those fixes over.

Jan, as the ext2 maintainer, do you have an opinion?

						   - Ted

On Mon, Jun 12, 2023 at 04:58:57PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    908f31f2a05b Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=124e9053280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c1058fe68f4b7b2c
> dashboard link: https://syzkaller.appspot.com/bug?extid=af5e10f73dbff48f70af
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f66595280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14abde43280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/87d095820229/disk-908f31f2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a1bf67af9675/vmlinux-908f31f2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7784a88b37e8/Image-908f31f2.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/2816e591e0fa/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com
> 
> memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5969 'syz-executor354'
> loop0: detected capacity change from 0 to 512
> EXT2-fs (loop0): (no)user_xattr optionsnot supported
> ================================================================================
> UBSAN: shift-out-of-bounds in fs/ext2/super.c:1015:40
> shift exponent 63 is too large for 32-bit type 'int'
> CPU: 0 PID: 5969 Comm: syz-executor354 Not tainted 6.4.0-rc4-syzkaller-g908f31f2a05b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> Call trace:
>  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
>  show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
>  dump_stack+0x1c/0x28 lib/dump_stack.c:113
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x2f4/0x36c lib/ubsan.c:387
>  ext2_fill_super+0x2270/0x2450 fs/ext2/super.c:1015
>  mount_bdev+0x274/0x370 fs/super.c:1380
>  ext2_mount+0x44/0x58 fs/ext2/super.c:1491
>  legacy_get_tree+0xd4/0x16c fs/fs_context.c:610
>  vfs_get_tree+0x90/0x274 fs/super.c:1510
>  do_new_mount+0x25c/0x8c4 fs/namespace.c:3039
>  path_mount+0x590/0xe04 fs/namespace.c:3369
>  do_mount fs/namespace.c:3382 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3568
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
>  el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
>  el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
> ================================================================================
> EXT2-fs (loop0): error: can't find an ext2 filesystem on dev loop0.
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
