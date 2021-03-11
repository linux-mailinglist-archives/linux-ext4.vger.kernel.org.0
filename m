Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591A13370B6
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Mar 2021 12:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhCKK7p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Mar 2021 05:59:45 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47782 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhCKK7O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Mar 2021 05:59:14 -0500
Received: by mail-io1-f72.google.com with SMTP id o4so15034089ioh.14
        for <linux-ext4@vger.kernel.org>; Thu, 11 Mar 2021 02:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lDX1WDkJkF7VdBPnD5IlYa41IyUfFq4jroNsiDOeVew=;
        b=ddTou0Usy0w6fliDZkNiAF8cSs3n/6EkZQGJbIG4zgM0LnIgRBeND8bEWjcoiF54Z8
         5XdQQUqpBd94TSMaJLs2P12U31DzDYmY3ZnzRPyWNiADoYCYN7vV5EEqIfLjvRfDGJdj
         TVbLJzc6+AKU3HxbzTyTYjE3mvLQHTjte0XIVzobiuH2HyBBsC7v3IRhFXkW+EQl8+Pj
         F5qFW5WxnfNSOVsuLThxEAVQfQJTDHSW+/KwMqj5jrT4wxoZplkWsrsXk6NB/2RMeVoQ
         7pNTzYTMYZdp3D6MLSWyJ80bjTEzoeMpUNGMSGzYu0Oob0Y7btHPLLCMZKz1ibJNvfYR
         nWBw==
X-Gm-Message-State: AOAM531ZSbhwTURsWKR6+ilzKmMbQh0GbJG095SYyUIKLW/W6p1gVG2D
        xC+RIdJ2cMz4EvDn7mjq6IzjZBb8796A9noITDuEezySGg6n
X-Google-Smtp-Source: ABdhPJzxPMppGclvRHn4P4Rx3FGdqjaBYLoQCNkdnd6VjRCCoz8N0lO7u1X5L7upaSpoAGargYG0ZM5gyY7pymXapRrHRXciYfQZ
MIME-Version: 1.0
X-Received: by 2002:a92:d843:: with SMTP id h3mr6663016ilq.306.1615460354089;
 Thu, 11 Mar 2021 02:59:14 -0800 (PST)
Date:   Thu, 11 Mar 2021 02:59:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008de88005bd40ac36@google.com>
Subject: [syzbot] KCSAN: data-race in start_this_handle / start_this_handle
From:   syzbot <syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a74e6a01 Merge tag 's390-5.12-3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159f69ecd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de394bbaade74fb7
dashboard link: https://syzkaller.appspot.com/bug?extid=30774a6acf6a2cf6d535
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30774a6acf6a2cf6d535@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in start_this_handle / start_this_handle

write to 0xffff888103880870 of 8 bytes by task 29956 on cpu 1:
 jbd2_get_transaction fs/jbd2/transaction.c:125 [inline]
 start_this_handle+0xceb/0x1010 fs/jbd2/transaction.c:400
 jbd2__journal_start+0x1fc/0x3f0 fs/jbd2/transaction.c:503
 __ext4_journal_start_sb+0x159/0x310 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
 ext4_da_write_begin+0x460/0xaf0 fs/ext4/inode.c:2998
 generic_perform_write+0x196/0x3a0 mm/filemap.c:3575
 ext4_buffered_write_iter+0x2e5/0x3e0 fs/ext4/file.c:269
 ext4_file_write_iter+0x48a/0x10b0 fs/ext4/file.c:502
 call_write_iter include/linux/fs.h:1977 [inline]
 do_iter_readv_writev+0x2cb/0x360 fs/read_write.c:740
 do_iter_write+0x112/0x4c0 fs/read_write.c:866
 vfs_iter_write+0x4c/0x70 fs/read_write.c:907
 iter_file_splice_write+0x40a/0x750 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x80/0xa0 fs/splice.c:936
 splice_direct_to_actor+0x345/0x650 fs/splice.c:891
 do_splice_direct+0xf5/0x170 fs/splice.c:979
 do_sendfile+0x7a6/0xe20 fs/read_write.c:1260
 __do_sys_sendfile64 fs/read_write.c:1319 [inline]
 __se_sys_sendfile64 fs/read_write.c:1311 [inline]
 __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1311
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffff888103880870 of 8 bytes by task 29936 on cpu 0:
 start_this_handle+0x1c1/0x1010 fs/jbd2/transaction.c:352
 jbd2__journal_start+0x1fc/0x3f0 fs/jbd2/transaction.c:503
 __ext4_journal_start_sb+0x159/0x310 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:320 [inline]
 ext4_da_write_begin+0x460/0xaf0 fs/ext4/inode.c:2998
 generic_perform_write+0x196/0x3a0 mm/filemap.c:3575
 ext4_buffered_write_iter+0x2e5/0x3e0 fs/ext4/file.c:269
 ext4_file_write_iter+0x48a/0x10b0 fs/ext4/file.c:502
 call_write_iter include/linux/fs.h:1977 [inline]
 do_iter_readv_writev+0x2cb/0x360 fs/read_write.c:740
 do_iter_write+0x112/0x4c0 fs/read_write.c:866
 vfs_iter_write+0x4c/0x70 fs/read_write.c:907
 iter_file_splice_write+0x40a/0x750 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x80/0xa0 fs/splice.c:936
 splice_direct_to_actor+0x345/0x650 fs/splice.c:891
 do_splice_direct+0xf5/0x170 fs/splice.c:979
 do_sendfile+0x7a6/0xe20 fs/read_write.c:1260
 __do_sys_sendfile64 fs/read_write.c:1319 [inline]
 __se_sys_sendfile64 fs/read_write.c:1311 [inline]
 __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1311
 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 29936 Comm: syz-executor.5 Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
