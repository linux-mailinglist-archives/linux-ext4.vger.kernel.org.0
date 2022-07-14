Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCF574D23
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiGNMKN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 08:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbiGNMJy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 08:09:54 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A43FA08
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 05:08:49 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f18-20020a5d8592000000b0067289239d1dso632614ioj.22
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 05:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WugDegGD5tYpRsXUE6iQPO7lN4FJAzAu9piPnbZrWMo=;
        b=ak5SCLLev1quv6XQTfAQNe9D/15pxolXKHqRGxcs/jt8HBtIUNurUq9A2ABJySFOOu
         pcC6ROAbI18zchpGtz8pG1U9aEYvWPgfwuAFnmJDln678966IY6/g6pdA6JdxKoeO6lp
         JhVBAq70y0g4OBeZnDH7mAilvIYn8tr0zVa4DRMFyoqK8ojOJqxoPYREYElQ3QxHNWS4
         XBgU0mvim2facwGzav6B0rc1Lvjq7mfiVmKPZiOXwckcHvQq4gyp6WTG/jmLj/3dn+0S
         Mm9dlLDTTrTyIEaYHgN0hACqCI/ubKarv94DJZMfVx/c6WEoJbpr/IYjocY++yLNKSqs
         Ioow==
X-Gm-Message-State: AJIora+3hPwDZCF2+Xlsh8GUzT8PA4NNmrAtKV2dYWQBkO9EzESGW3O5
        FX6+lcUiyCJ1dkVRMbrXx6dHJY0t9kD8VI3a7xu63SewDnD1
X-Google-Smtp-Source: AGRyM1stg3QufNq27r18ZDT8evXqsYrJV2PTeShtDN38PD5PDQy3L+MQLWCRjezDhgltpGSXqJ9Uhm394v5jnuq/E6I52bB9JU/U
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a:b0:33f:8881:888c with SMTP id
 q26-20020a056638041a00b0033f8881888cmr4039712jap.110.1657800505951; Thu, 14
 Jul 2022 05:08:25 -0700 (PDT)
Date:   Thu, 14 Jul 2022 05:08:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044115e05e3c2c2fb@google.com>
Subject: [syzbot] WARNING in ext4_iomap_begin
From:   syzbot <syzbot+c97a5f91bbd6de05e1c2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4a57a8400075 vf/remap: return the amount of bytes actually..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17460cac080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=970ac5ffe160d24
dashboard link: https://syzkaller.appspot.com/bug?extid=c97a5f91bbd6de05e1c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f964ac080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15655f92080000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12083f1c080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11083f1c080000
console output: https://syzkaller.appspot.com/x/log.txt?x=16083f1c080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c97a5f91bbd6de05e1c2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8422 at fs/ext4/inode.c:3418 ext4_iomap_begin+0x1aa/0x780 fs/ext4/inode.c:3418
Modules linked in:
CPU: 0 PID: 8422 Comm: syz-executor260 Not tainted 5.19.0-rc6-syzkaller-00115-g4a57a8400075 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
RIP: 0010:ext4_iomap_begin+0x1aa/0x780 fs/ext4/inode.c:3418
Code: 83 c0 01 38 d0 7c 08 84 d2 0f 85 d8 05 00 00 41 0f b7 9f c2 05 00 00 31 ff 89 de e8 70 72 5b ff 66 85 db 74 5c e8 46 76 5b ff <0f> 0b 41 bd de ff ff ff e8 39 76 5b ff 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000d87f260 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000000000bc RCX: 0000000000000000
RDX: ffff88807a848100 RSI: ffffffff821e24ea RDI: 0000000000000003
RBP: 0000000000000180 R08: 0000000000000003 R09: 0000000000000000
R10: 00000000000000bc R11: 0000000000000001 R12: 000000000000000c
R13: ffff88806f0aa6fa R14: ffffc9000d87f550 R15: ffff88806f0aa630
FS:  00007fcf662ec700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcf662cb718 CR3: 0000000021572000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_iter+0x454/0x1110 fs/iomap/iter.c:74
 __iomap_dio_rw+0x6b6/0x1a80 fs/iomap/direct-io.c:600
 iomap_dio_rw+0x3c/0xa0 fs/iomap/direct-io.c:689
 ext4_dio_write_iter fs/ext4/file.c:566 [inline]
 ext4_file_write_iter+0xe50/0x1520 fs/ext4/file.c:677
 call_write_iter include/linux/fs.h:2058 [inline]
 do_iter_readv_writev+0x3d1/0x640 fs/read_write.c:742
 do_iter_write+0x182/0x700 fs/read_write.c:868
 vfs_iter_write+0x70/0xa0 fs/read_write.c:909
 iter_file_splice_write+0x6fa/0xc10 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
 do_splice_direct+0x1a7/0x270 fs/splice.c:979
 do_sendfile+0xae0/0x1240 fs/read_write.c:1262
 __do_sys_sendfile64 fs/read_write.c:1327 [inline]
 __se_sys_sendfile64 fs/read_write.c:1313 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1313
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcf6633fe79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf662ec2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fcf663c54c0 RCX: 00007fcf6633fe79
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007fcf663920bc R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffdffa R11: 0000000000000246 R12: 00007fcf663910b8
R13: 0030656c69662f2e R14: e5d26e84aa4cf3c6 R15: 00007fcf663c54c8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
