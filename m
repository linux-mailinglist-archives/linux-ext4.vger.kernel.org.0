Return-Path: <linux-ext4+bounces-13468-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJs/BwbqgGleCAMAu9opvQ
	(envelope-from <linux-ext4+bounces-13468-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 19:16:38 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AED69D007D
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 19:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 191C13019D44
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Feb 2026 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92A62DF131;
	Mon,  2 Feb 2026 18:16:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2482DC35A
	for <linux-ext4@vger.kernel.org>; Mon,  2 Feb 2026 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056194; cv=none; b=gROmtgQeJUDxvuk4EOvAUyYxr7H4RLX1ym23RttzWG/Ch30oYnsYwMptAM87q6upoQ77KneXW+y/KY5rC1FbMGFYy5d0kRDeOWtIZ035BsakcYopNpZUdFaAPbxWNBWb0/At75TLgzi0hU7TXxDRymVUOL9XbRbPVIV3W/O8J7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056194; c=relaxed/simple;
	bh=jFnMqtTmWFcR7sducWrXbQvtmVbuG8dc50u3vRxIrqk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MFMGQJYzFBBhKw4TGSe42tD1Abrmo3W4R3XbQUe13pH+zzHT5kkDSqCQ3dl6YGGorotqLlQKEI2x00/Z7eGwrckuS3usCLZVjTXwX1FZZhsQVgF1qTzBEefKDi6MePmk+OOrjBFQ9kdfPy7oKXHEf1uvWrDd29h569wpjsAHDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-66314e79f6cso14297613eaf.2
        for <linux-ext4@vger.kernel.org>; Mon, 02 Feb 2026 10:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056192; x=1770660992;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeM9Cc+ZxVsP+XJId6dL+oom/SOv15NBealpu8riIbE=;
        b=M5K09zW5aAhpL7BJAHc2nlVdW0blnRxM1Cd7sxjXYVMa28pSSnySEkrA6AvjmDNVOg
         QKRSJk4vRxwR8SsqWX4krZS5byQGiP3ZlFa0nFFIfp4MPeRIwqu2m9xbcGy75GbzrVUP
         dmzqh6+95a6ERdk++2490kInqGXE7pMVbIBXzhaAaOUuI2iK3EtXUq92sa7Wq+oEnyIM
         EXu5CuRL15SfwJGKJLvH1Hqq8vbv+9g2zHgvf+ZGPxAGWwkgJQ6kZ+psvFqbZTrfTYcF
         Je5c9JOGTW3TmJ5E8TTWxPj2Vohq1dsbaGLzfaCGhfFkhC0Gjki6C+1KLqs3Jk2lsHTt
         2JTg==
X-Forwarded-Encrypted: i=1; AJvYcCUYW0MJci8Nh/yTd9j7iQcH9xPTmC//7Fhjt2c7I0ArARFAwhdg4FPTrBQwKLvhWZiott+hitggrNdG@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCbahVxR4C/GfezEeMvuiSPV8wqb6BuS4rmFiLDE7cYDLzmk8
	Fu2Rk8y2Nsx9j66n3Bd5AClvHc/TtmXKQ7xyGM5tlJMs1Yt59w3fSvEqf5U4WqZNP9ZWG8ZCzf4
	GoMP92tXVkHCTXC4oMP8PXeECm0jgv+Scsh3/P0z3xSnwCLZizw1bzGXr2K0=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4cc7:b0:663:e77:3cde with SMTP id
 006d021491bc7-6630f3ab512mr4409117eaf.76.1770056191870; Mon, 02 Feb 2026
 10:16:31 -0800 (PST)
Date: Mon, 02 Feb 2026 10:16:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6980e9ff.050a0220.16b13.00a9.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (4)
From: syzbot <syzbot+7de5fe447862fc37576f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=fea461e951c03b1b];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13468-lists,linux-ext4=lfdr.de,7de5fe447862fc37576f];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,googlegroups.com:email,goo.gl:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AED69D007D
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    162b42445b58 Merge tag 'iommu-fixes-v6.19-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c48402580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fea461e951c03b1b
dashboard link: https://syzkaller.appspot.com/bug?extid=7de5fe447862fc37576f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ec7bfa580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98939f243052/disk-162b4244.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ce9a7b8e049/vmlinux-162b4244.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99eb2d7c3e94/bzImage-162b4244.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/82c4262402e2/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1196145a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7de5fe447862fc37576f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:240!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6836 Comm: syz.5.137 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:ext4_write_inline_data+0x40b/0x4f0 fs/ext4/inline.c:240
Code: fe e8 e9 70 3f ff 42 8d 44 23 c4 bb 3c 00 00 00 89 44 24 08 44 29 e3 e9 aa fe ff ff e8 ce 70 3f ff 90 0f 0b e8 c6 70 3f ff 90 <0f> 0b e8 be 70 3f ff 48 8d 3d b7 58 f6 0d 48 c7 c2 60 5b ac 8b 4c
RSP: 0018:ffffc9000b0b74e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffffff82c7675b
RDX: ffff88802c845b80 RSI: ffffffff82c7697a RDI: ffff88802c845b80
RBP: ffff888075742918 R08: 0000000000000006 R09: 0000000000004000
R10: 000000000000003c R11: 0000000000000000 R12: 0000000000003000
R13: 0000000000004000 R14: ffffc9000b0b7580 R15: ffff888075742e82
FS:  00007fb1c0b036c0(0000) GS:ffff8881245dc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f284e6ff000 CR3: 000000005cb37000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x2a8/0xdb0 fs/ext4/inline.c:817
 ext4_da_write_end+0x4f7/0xf20 fs/ext4/inode.c:3286
 generic_perform_write+0x513/0xa40 mm/filemap.c:4335
 ext4_buffered_write_iter+0x119/0x440 fs/ext4/file.c:299
 ext4_file_write_iter+0xa3d/0x1d90 fs/ext4/file.c:723
 iter_file_splice_write+0x82b/0x10a0 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0x192/0x6c0 fs/splice.c:1161
 splice_direct_to_actor+0x345/0xa30 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x174/0x240 fs/splice.c:1230
 do_sendfile+0xadc/0xe20 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64 fs/read_write.c:1417 [inline]
 __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb1bfb9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb1c0b03028 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fb1bfe15fa0 RCX: 00007fb1bfb9aeb9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007fb1bfc08c1f R08: 0000000000000000 R09: 0000000000000000
R10: 000000000e3aa6ea R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb1bfe16038 R14: 00007fb1bfe15fa0 R15: 00007ffc03931cf8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data+0x40b/0x4f0 fs/ext4/inline.c:240
Code: fe e8 e9 70 3f ff 42 8d 44 23 c4 bb 3c 00 00 00 89 44 24 08 44 29 e3 e9 aa fe ff ff e8 ce 70 3f ff 90 0f 0b e8 c6 70 3f ff 90 <0f> 0b e8 be 70 3f ff 48 8d 3d b7 58 f6 0d 48 c7 c2 60 5b ac 8b 4c
RSP: 0018:ffffc9000b0b74e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffffff82c7675b
RDX: ffff88802c845b80 RSI: ffffffff82c7697a RDI: ffff88802c845b80
RBP: ffff888075742918 R08: 0000000000000006 R09: 0000000000004000
R10: 000000000000003c R11: 0000000000000000 R12: 0000000000003000
R13: 0000000000004000 R14: ffffc9000b0b7580 R15: ffff888075742e82
FS:  00007fb1c0b036c0(0000) GS:ffff8881246dc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efdf1812000 CR3: 000000005cb37000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

