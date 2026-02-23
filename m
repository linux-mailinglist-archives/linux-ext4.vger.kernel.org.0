Return-Path: <linux-ext4+bounces-13770-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEwUH3ybm2lo3QMAu9opvQ
	(envelope-from <linux-ext4+bounces-13770-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 01:12:44 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D140C170E89
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 01:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE65E301CCEF
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 00:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3A634CDD;
	Mon, 23 Feb 2026 00:12:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC681CAB3
	for <linux-ext4@vger.kernel.org>; Mon, 23 Feb 2026 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771805553; cv=none; b=OcEzlu9hcOUvBmgkE7fAq5ukTgztAOYuG9GimvZwAhJ3DHslo7fw/IAHCTxc98Rj8pw6xNY0o6AKw+EvXYzf1x2E4F4/9Q4/6CJoYXG0hbLEpx9tnC7cvzIzWAjw1QodgPu+uxMs/W541lExkG/wVAYU2L1Ip9SbeyD6gGJfV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771805553; c=relaxed/simple;
	bh=5bUr7sH35IGltrfONE25zKXT4CvmNOONlESAbyC3Vlg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JK886QPAakahIq1oHcKGz6ZxWDmriXNHfEWKzbO/7zIOmtsB0Eebnr219ORIHgsRMSIKDzl++h71qQ17G6FqRgs8qBhOhlKOydSYqee0oS1rhW1OHunaiYTpqwOzuBN65Xondah2HhTTCFkOLNJtnjUVjwiO9txIfwAUgcJtDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679c6ef1538so26566032eaf.3
        for <linux-ext4@vger.kernel.org>; Sun, 22 Feb 2026 16:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771805551; x=1772410351;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVSwO3WjMzkZD2mJ7wvPOqX/OqMofdVFZgH8wLdFZUM=;
        b=eLhST95fdQV438IX81MfVtjw/7MktyqV756dl12/Tmoe8rGWJeAG3TOLd1keRF2mWN
         PG3yYwAGmmXoe8rz4xhh9uK+RbdhD4qAzTXXmCGIYg5O4I8UWnCu5wVbfBqDFNSyZLLl
         Q9E8qEuGmBHFbmHKd/WOkMVeOD6uciG9c95zbivkKnDMlfnPtjNADQi8Nc+CBMQVjtft
         DNkZY6If/3GhRdZyl+VxY6CTNgzVJ1/PId/BMrAzQ0q3UgrPhGPp8Cw4y2GyFFDkb3bb
         tXTAyb5zO5krmjIFqML8Yab4zt66wIE4Z20ZkMZRECbZroyAeEuqrgUm7E8hAUzGdATj
         Vomw==
X-Forwarded-Encrypted: i=1; AJvYcCWg+dpMdwDh7soEMDYMf6XXN6PJASC5b1WcXS3ps4qbvZBtMXY8gk+zC71Sr8tSqBYpaZJtwTDecT5E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SvYIWUVmqOVv2JJOMDJGb/1jsKxQSlryrgn7e2uIcO2ogtlA
	Z2FWTCprEbXNsYT507sFkJ4qdAW3rbAXvka2LLDcsrIueZz8Y2jHUmpFw5XuF0AzCioRBGa/dFF
	shTAnTieb9tNG1my0YZJKJITto9yE7THYYntisLrgkB+awOdwIRCQbBqx4LQ=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2223:b0:677:87ab:a78a with SMTP id
 006d021491bc7-679c4507febmr3469431eaf.61.1771805551145; Sun, 22 Feb 2026
 16:12:31 -0800 (PST)
Date: Sun, 22 Feb 2026 16:12:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699b9b6f.a70a0220.2c38d7.0189.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in xattr_find_entry (2)
From: syzbot <syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=665cbf0979cda6c5];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13770-lists,linux-ext4=lfdr.de,fb32afec111a7d61b939];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,storage.googleapis.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: D140C170E89
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    2961f841b025 Merge tag 'turbostat-2026.02.14' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156cb15a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=665cbf0979cda6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=fb32afec111a7d61b939
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a43b3a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157f895a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54d6a30cbc5f/disk-2961f841.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/40003e4ec76c/vmlinux-2961f841.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2db393aba9ff/bzImage-2961f841.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/07bdbcf04dc1/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=12b95c02580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com

loop0: detected capacity change from 1024 to 64
EXT4-fs error (device loop0): ext4_find_dest_de:2050: inode #12: block 7: comm syz.0.17: bad entry in directory: directory entry overrun - offset=0, inode=268435456, rec_len=1280, size=56 fake=0
==================================================================
BUG: KASAN: use-after-free in xattr_find_entry+0x1a5/0x280 fs/ext4/xattr.c:334
Read of size 4 at addr ffff88806ee29004 by task syz.0.17/5997

CPU: 1 UID: 49663 PID: 5997 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 xattr_find_entry+0x1a5/0x280 fs/ext4/xattr.c:334
 ext4_xattr_ibody_get+0x232/0x4c0 fs/ext4/xattr.c:655
 ext4_xattr_get+0x123/0x6a0 fs/ext4/xattr.c:709
 ext4_get_acl+0x84/0x930 fs/ext4/acl.c:165
 __get_acl+0x27e/0x410 fs/posix_acl.c:159
 check_acl+0x3a/0x150 fs/namei.c:385
 acl_permission_check fs/namei.c:471 [inline]
 generic_permission+0x497/0x690 fs/namei.c:524
 do_inode_permission fs/namei.c:585 [inline]
 inode_permission+0x243/0x5f0 fs/namei.c:648
 lookup_inode_permission_may_exec fs/namei.c:-1 [inline]
 may_lookup fs/namei.c:1973 [inline]
 link_path_walk+0x1149/0x18d0 fs/namei.c:2595
 path_lookupat+0xe4/0x8c0 fs/namei.c:2803
 filename_lookup+0x256/0x5d0 fs/namei.c:2833
 user_path_at+0x40/0x160 fs/namei.c:3612
 do_mount fs/namespace.c:4156 [inline]
 __do_sys_mount fs/namespace.c:4348 [inline]
 __se_sys_mount+0x2dc/0x420 fs/namespace.c:4325
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f72cdd9c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6aba2c28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f72ce015fa0 RCX: 00007f72cdd9c629
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000000
RBP: 00007f72cde32b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000002094080 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f72ce015fac R14: 00007f72ce015fa0 R15: 00007f72ce015fa0
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7f3283789 pfn:0x6ee29
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001bb8a88 ffffea0001bb8908 0000000000000000
raw: 00000007f3283789 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 5981, tgid 5981 (sed), ts 108386366383, free_ts 108399318838
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1888
 prep_new_page mm/page_alloc.c:1896 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3961
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5249
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2485
 folio_alloc_mpol_noprof mm/mempolicy.c:2504 [inline]
 vma_alloc_folio_noprof+0xea/0x210 mm/mempolicy.c:2539
 folio_prealloc mm/memory.c:-1 [inline]
 alloc_anon_folio mm/memory.c:5200 [inline]
 do_anonymous_page mm/memory.c:5257 [inline]
 do_pte_missing+0x1656/0x3750 mm/memory.c:4467
 handle_pte_fault mm/memory.c:6308 [inline]
 __handle_mm_fault mm/memory.c:6446 [inline]
 handle_mm_fault+0x1bec/0x3310 mm/memory.c:6615
 do_user_addr_fault+0xa73/0x1340 arch/x86/mm/fault.c:1334
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1527
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
page last free pid 5981 tgid 5981 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1432 [inline]
 free_unref_folios+0xd38/0x14c0 mm/page_alloc.c:3039
 folios_put_refs+0x789/0x8d0 mm/swap.c:1002
 free_pages_and_swap_cache+0x2e7/0x5b0 mm/swap_state.c:423
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:398 [inline]
 tlb_flush_mmu+0x6d3/0xa30 mm/mmu_gather.c:405
 tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:530
 exit_mmap+0x453/0xdb0 mm/mmap.c:1290
 __mmput+0x118/0x430 kernel/fork.c:1174
 exit_mm+0x168/0x220 kernel/exit.c:581
 do_exit+0x62e/0x2320 kernel/exit.c:959
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1112
 __do_sys_exit_group kernel/exit.c:1123 [inline]
 __se_sys_exit_group kernel/exit.c:1121 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1121
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88806ee28f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806ee28f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88806ee29000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88806ee29080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88806ee29100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

