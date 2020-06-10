Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B608F1F5DF8
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jun 2020 23:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgFJV4F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 17:56:05 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:36922 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgFJV4F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Jun 2020 17:56:05 -0400
Received: by mail-il1-f200.google.com with SMTP id n2so2483165ilq.4
        for <linux-ext4@vger.kernel.org>; Wed, 10 Jun 2020 14:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zPzq8Z3GKSk3UIRzJdOGFkl1eD/aaIDkUJNbvpb5G54=;
        b=QxgcKh4gKTIS1ESDqMpkMp8GoxWwVzBdL7519VCYSaWAaoPDGgxXGHPrpgQpp3XeyT
         lowrqZHa2t+4WT0PevogAfsFny9n1Y3MIWewRh5VRX9Z8oti1x1GrZSeSGp4AQkuwn8q
         cd2noOccC3YHJseRblpYSk/ALzz3fkmEmoxxmvKtS9MEY77KoACvOl7J2heSRsZ5odSU
         8x0e+4MnTFGI7hZsK6tttVayOWyHgxRpkqzlv0Kb4354rfgt+7rs4hyIRcqtHEvbDMMW
         sqPJZiJavUnWcc1LdSv/y3OBz038wC5CjcwoayOSlAH9tlpDNApr9cbRrOuI7jD1mFYd
         Efew==
X-Gm-Message-State: AOAM5338NeH+yxSMqhHACMVLKciDQ2kriT+W1cQE/o5TXp+dtIfSKe81
        9Bcbi0wb/NL6oMZUrYpTiyPAwesw2sUsI4w/OKx2ZAsuPMEt
X-Google-Smtp-Source: ABdhPJwdkWvMBc1TJXeW0mgdyMOWPQe+AxeV8HWhb/kgzkEPdNlxjttn1vdto1D35yO45FopICQEQGsF9FDHXLO3hZla1CRUNIII
MIME-Version: 1.0
X-Received: by 2002:a92:c6c5:: with SMTP id v5mr3414047ilm.1.1591826163957;
 Wed, 10 Jun 2020 14:56:03 -0700 (PDT)
Date:   Wed, 10 Jun 2020 14:56:03 -0700
In-Reply-To: <20200610214107.GK1347934@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c06da05a7c1e93d@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 generic_perform_write (2)
From:   syzbot <syzbot+bca9799bf129256190da@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered crash:
BUG: unable to handle kernel NULL pointer dereference in generic_perform_write

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD a3819067 P4D a3819067 PUD a2ea0067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9214 Comm: syz-executor.1 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90006d1fa38 EFLAGS: 00010246
RAX: ffffffff883cb0a0 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff888082b89a60 RDI: ffff88808a414a80
RBP: ffff888082b89a60 R08: 0000000000000000 R09: ffffc90006d1fac0
R10: ffff888072cd6607 R11: ffffed100e59acc0 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90006d1fd18
FS:  00007f310f3f3700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000000904f1000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 generic_perform_write+0x20a/0x4e0 mm/filemap.c:3302
 ext4_buffered_write_iter+0x1f7/0x450 fs/ext4/file.c:270
 ext4_file_write_iter+0x1ec/0x13f0 fs/ext4/file.c:642
 call_write_iter include/linux/fs.h:1907 [inline]
 new_sync_write+0x4a2/0x700 fs/read_write.c:484
 __vfs_write+0xc9/0x100 fs/read_write.c:497
 vfs_write+0x268/0x5d0 fs/read_write.c:559
 ksys_write+0x12d/0x250 fs/read_write.c:612
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c889
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f310f3f2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f310f3f36d4 RCX: 000000000045c889
RDX: 0000000000000001 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 000000000076bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000cdc R14: 00000000004cf042 R15: 000000000076bfac
Modules linked in:
CR2: 0000000000000000
---[ end trace ff42a65b331528ba ]---
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90006d1fa38 EFLAGS: 00010246
RAX: ffffffff883cb0a0 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff888082b89a60 RDI: ffff88808a414a80
RBP: ffff888082b89a60 R08: 0000000000000000 R09: ffffc90006d1fac0
R10: ffff888072cd6607 R11: ffffed100e59acc0 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90006d1fd18
FS:  00007f310f3f3700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000076c061 CR3: 00000000904f1000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Tested on:

commit:         5b8b9d0c Merge branch 'akpm' (patches from Andrew)
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
console output: https://syzkaller.appspot.com/x/log.txt?x=158b23ca100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c5a352e32a1944
dashboard link: https://syzkaller.appspot.com/bug?extid=bca9799bf129256190da
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

