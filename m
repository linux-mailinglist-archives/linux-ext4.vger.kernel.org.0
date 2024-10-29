Return-Path: <linux-ext4+bounces-4841-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F09B41CB
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2024 06:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69291F22895
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2024 05:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E0200C91;
	Tue, 29 Oct 2024 05:25:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E21DE885
	for <linux-ext4@vger.kernel.org>; Tue, 29 Oct 2024 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730179523; cv=none; b=iJMP57/0u4RKPJThm7hMk+Uu6mIieZSzLReXXox40XrSRQ6W4ydHYMFnOQY+KcY5kgB/6XtvpyKryP5WkgxXHSvrsJgUv24xVPU4HgCVxCtuK0rNwzfn8eKJkswZhAAws0WnltteL2AId7pCEDjOGerAKPv5DSr6MmHSdS5BpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730179523; c=relaxed/simple;
	bh=ouaRojEgmeFmyMh3Zx7lTlSsvvjtG/+KEMGk818F4Mc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RqYkpiqd8AvhikOyFM8mmWdLM8/inBdoHGpQAGxIGTMW89rR29bUeSvXfsRdPD2iQyeU4i5GqiTpQ+VrUdrT3f1bqMCzrl+FnKDXLZW0QH/QlEMwNxQ6mTGM6kd9ZIT/LapcdXf+/5wQRBvp0PqDSlUC7MgWugcRnWKJXh+oT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4e77be28dso35119005ab.1
        for <linux-ext4@vger.kernel.org>; Mon, 28 Oct 2024 22:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730179520; x=1730784320;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtLW7kt2lpVHCZBstYleod/T5Fypm0cx/Eb+Hfave2Q=;
        b=uMnGYKgZ6Pl6Roc+Wg8HGUWsXz59DW4Oc86CqXJd33xApIxcazmxjS1RkeoqfUvr/d
         SBLaojfvzhuOROjLOichP5C9iqLCk3Xm+140KG1Q5p6pHMDsNQbC7sqqqClGjFedUOfS
         +phrJQUkk/VdcnZsrCcXn5cY8AswB8xiS7qtVhUZgxiHyTUcBHx5bsNcfcrLXFMdQ3rk
         UIrfUsmizO5HSo0hmHEw+UqgHRnkWyJq2sEetEKwtzF7t7yboG0hHBgKHNINVxgYld9h
         /ppPrmdWsYSwJoaFsC++KVlxLH7w+YhITw4j0wRaXZxPJ6/Yf3VkArScBqj0Z/b81lVZ
         aalw==
X-Forwarded-Encrypted: i=1; AJvYcCX03a/lLrhAXn84GG06/1eI/gi2ZmBHKXw+3Ri5PMW9eU2AwF2k5o8XPUs549RRfuCXk1ECR9231JFq@vger.kernel.org
X-Gm-Message-State: AOJu0YxIj2FjbJKdFXsp4nqur1aqR63oJWheV69YbGj8XLeKeDCNAwk4
	81b255W7kKo+12i0m5bT5Fblw4VgY4r5QwAqoGO1QjsmcCExG+C0w1wRWQznlHh3KbTHHEAXu4M
	mMTu+UOTuyEFKOelcW357K7FJ5+mUcRt/O2DYxheJCZdIX3hoXajp0Kg=
X-Google-Smtp-Source: AGHT+IFe3uyW25N53YtvRDYKHHo1+Ozqb90PdGhTd/1aG/Clhiy6nI8K2C/S13CG9yigzDdYzaEZ2NIeIIayh+fZNmy47K/114Zy
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d06:b0:3a4:ecdb:d615 with SMTP id
 e9e14a558f8ab-3a4ed28e34emr97439485ab.8.1730179520514; Mon, 28 Oct 2024
 22:25:20 -0700 (PDT)
Date: Mon, 28 Oct 2024 22:25:20 -0700
In-Reply-To: <00000000000042f2c5062143e9fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672071c0.050a0220.11b624.04bd.GAE@google.com>
Subject: Re: [syzbot] [ocfs2] kernel BUG in jbd2_journal_dirty_metadata
From: syzbot <syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com>
To: jack@suse.com, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e42b1a9a2557 Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14efef57980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=c28d8da3e83b3cc68dc6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d2064b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12efef57980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e42b1a9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3e2253169da8/vmlinux-e42b1a9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9d2f5008f24/bzImage-e42b1a9a.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/5f7c8b60a2d3/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/0a01b18a6599/mount_9.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com

(syz-executor419,5307,0):ocfs2_xa_prepare_entry:2152 ERROR: status = -30
(syz-executor419,5307,0):ocfs2_xa_set:2255 ERROR: status = -30
JBD2: assertion failure: h_type=0 h_line_no=0 block_no=19105 jlist=0
------------[ cut here ]------------
kernel BUG at fs/jbd2/transaction.c:1529!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5307 Comm: syz-executor419 Not tainted 6.12.0-rc5-syzkaller-00005-ge42b1a9a2557 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:jbd2_journal_dirty_metadata+0xbed/0xc00 fs/jbd2/transaction.c:1528
Code: 89 ff e9 88 fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c af fd ff ff 48 89 df e8 fe 1d 89 ff e9 a2 fd ff ff e8 64 61 1f ff 90 <0f> 0b e8 5c 61 1f ff 90 0f 0b 66 0f 1f 84 00 00 00 00 00 90 90 90
RSP: 0018:ffffc9000cf66a38 EFLAGS: 00010293
RAX: ffffffff8275772c RBX: 0000000000000000 RCX: ffff888000938000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 1ffff1100350b135 R08: ffffffff82756f44 R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: ffff88801a8589ac
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88801a858968
FS:  00005555742c7380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000032b9e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_journal_dirty+0x156/0x7c0 fs/ocfs2/journal.c:812
 ocfs2_xa_journal_dirty fs/ocfs2/xattr.c:1453 [inline]
 ocfs2_xa_set+0x225b/0x2b40 fs/ocfs2/xattr.c:2264
 ocfs2_xattr_block_set+0x46e/0x3390 fs/ocfs2/xattr.c:2986
 __ocfs2_xattr_set_handle+0x67a/0x10a0 fs/ocfs2/xattr.c:3388
 ocfs2_xattr_set+0x128c/0x1930 fs/ocfs2/xattr.c:3651
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:629 [inline]
 path_setxattr+0x37e/0x4d0 fs/xattr.c:658
 __do_sys_lsetxattr fs/xattr.c:683 [inline]
 __se_sys_lsetxattr fs/xattr.c:679 [inline]
 __x64_sys_lsetxattr+0xb8/0xd0 fs/xattr.c:679
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f84c9e37bb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffced766518 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f84c9e37bb9
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 00000000200000c0
RBP: 00007f84c9eb4610 R08: 0000000000000000 R09: 00007ffced7666e8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffced7666d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jbd2_journal_dirty_metadata+0xbed/0xc00 fs/jbd2/transaction.c:1528
Code: 89 ff e9 88 fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c af fd ff ff 48 89 df e8 fe 1d 89 ff e9 a2 fd ff ff e8 64 61 1f ff 90 <0f> 0b e8 5c 61 1f ff 90 0f 0b 66 0f 1f 84 00 00 00 00 00 90 90 90
RSP: 0018:ffffc9000cf66a38 EFLAGS: 00010293
RAX: ffffffff8275772c RBX: 0000000000000000 RCX: ffff888000938000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 1ffff1100350b135 R08: ffffffff82756f44 R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: ffff88801a8589ac
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88801a858968
FS:  00005555742c7380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000032b9e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

