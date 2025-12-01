Return-Path: <linux-ext4+bounces-12096-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1813C95C8A
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 07:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF7DC4E10D2
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 06:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6C923D7CA;
	Mon,  1 Dec 2025 06:21:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4826F2AA
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764570083; cv=none; b=pvHWp9ASy98/1J4vO9FEY5oc5CAa8MsESW0enONyI8IKosAPzNqN3eu+Bts07D3NKTraax9qjRyJe+ii0AG3QA/CdKhxlsR1/YZaQWlXyMC1YG3NoUBC4UBmArEOUN0wouhbDPDJdZUkBA4qYf6AnNW+A8kn+BC6ZlkbzuUwXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764570083; c=relaxed/simple;
	bh=Ss+akbSycPyqA3WXQmqtOcMS+Q8wQGPx2TDCeDTnsY0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Izkg3lOTOStRjG4bYpIqBm/RIOoCMkgvgoBtKT//aUnJKofEdavqwRKSBKZdz3s3pX9dXByIZGMjvZVwoZO1rXCzqqG85AQqiRVGgCGxuFPTtEyqpnwagv0P9ZDI3rN5aewDRWPiKEP0Gywy54yq2f3z0YAWcFpx1DtkvAJJ8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-435a4ea3e62so33106335ab.1
        for <linux-ext4@vger.kernel.org>; Sun, 30 Nov 2025 22:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764570081; x=1765174881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4Sqr9OtSoxd8GpuVfVN42hwLoKDisxxQypSJ1p39Sw=;
        b=nZNZQQ8IztgKU08vbV33pKe9kku6aTcF4lTlQlPmeVrVDWpyqJei+o7KiXj6iWOo6p
         IFz8ca4JIVZT51N7A1cMBlEUyyUdQ7Jv2rSPGXdppXVMPZoHokQTLOmIQeGqL5PhM3km
         VpqyaEmmf78S1z09d2apSJ/iMvJPFhp0yNwn5qihdthFA45Xg0XqebzeVb39lDtWS6NB
         BpAaNsazqpWOM8joGtpfDHW/AOdJji/zZistkD7y3sh3mvDzqywapYWcPuxoTd/2/ky/
         P3V/djx4kqTJr52CQFXphMLzM6gOAfqADed4J2L0c75HdtK6vi2npaS5OU02xfambLJi
         hJOw==
X-Forwarded-Encrypted: i=1; AJvYcCVdb9/dOHe9J7DD5PWdbxHUbPYJ52SEOYsv/mQMyu2euubQ1YO3IKEvNqcJHa+ZsRHxheQ6PX4Sdu1j@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0cFY2hdI7EZsxM6fq76ZDFpI6m2R4/HR+7KscHmEQcYIPJzIP
	ekT1zy8GuANklUJ2X8NELeNQSACXjExIB9ym3L3wJKfxAYIDWKxGxjJN4nFBvh/J7ZL52uUhtaI
	iK9FfUyRybRRN/SXVAcV6kO3ZTcE2wWo7vUaodU6WhvaFzyw2bGLDhSYJrBM=
X-Google-Smtp-Source: AGHT+IGOqZqPMV82C9yXfev7inQtwdTF8pLX81dhI2mQFWw4H6lk7Sm0A12J60Gdj1390qcGhzstbkib9Iefjs7K74Y1J5WmLVD3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe5:b0:433:39bc:2f6e with SMTP id
 e9e14a558f8ab-435dd0eda8dmr200092305ab.26.1764570080796; Sun, 30 Nov 2025
 22:21:20 -0800 (PST)
Date: Sun, 30 Nov 2025 22:21:20 -0800
In-Reply-To: <690bcad7.050a0220.baf87.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692d33e0.a70a0220.d98e3.017d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_destroy_inline_data (2)
From: syzbot <syzbot+bb2455d02bda0b5701e3@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1209f912580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
dashboard link: https://syzkaller.appspot.com/bug?extid=bb2455d02bda0b5701e3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1442c192580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108802b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad90de/disk-7d31f578.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca7/vmlinux-7d31f578.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc0448ab2411/bzImage-7d31f578.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/c224e4ae2f71/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16b5c512580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/6a86b64b703d/mount_1.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=170802b4580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb2455d02bda0b5701e3@syzkaller.appspotmail.com

EXT4-fs: Ignoring removed bh option
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.28/6033 is trying to acquire lock:
ffff88805e5deaa8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
ffff88805e5deaa8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1797

but task is already holding lock:
ffff8880347c0b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
ffff8880347c0b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
ffff8880347c0b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1ca/0x350 fs/ext4/inode.c:3025

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
       ext4_writepages+0x1ca/0x350 fs/ext4/inode.c:3025
       do_writepages+0x32e/0x550 mm/page-writeback.c:2598
       __writeback_single_inode+0x133/0x1240 fs/fs-writeback.c:1737
       writeback_single_inode+0x493/0xc70 fs/fs-writeback.c:1858
       write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2924
       iput_final fs/inode.c:1941 [inline]
       iput+0xa77/0x1030 fs/inode.c:2003
       ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2203
       ext4_xattr_move_to_block fs/ext4/xattr.c:2668 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
       ext4_expand_extra_isize_ea+0x12da/0x1ea0 fs/ext4/xattr.c:2831
       __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6349
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6392 [inline]
       __ext4_mark_inode_dirty+0x45c/0x6e0 fs/ext4/inode.c:6470
       ext4_evict_inode+0x79c/0xe60 fs/ext4/inode.c:253
       evict+0x5f4/0xae0 fs/inode.c:837
       ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:472
       __ext4_fill_super fs/ext4/super.c:5658 [inline]
       ext4_fill_super+0x58a1/0x6160 fs/ext4/super.c:5777
       get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
       vfs_get_tree+0x92/0x2a0 fs/super.c:1751
       fc_mount fs/namespace.c:1209 [inline]
       do_new_mount_fc fs/namespace.c:3646 [inline]
       do_new_mount+0x302/0xa10 fs/namespace.c:3722
       do_mount fs/namespace.c:4045 [inline]
       __do_sys_mount fs/namespace.c:4234 [inline]
       __se_sys_mount+0x313/0x410 fs/namespace.c:4211
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->xattr_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
       ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1797
       ext4_do_writepages+0x4e6/0x4500 fs/ext4/inode.c:2811
       ext4_writepages+0x203/0x350 fs/ext4/inode.c:3026
       do_writepages+0x32e/0x550 mm/page-writeback.c:2598
       filemap_writeback mm/filemap.c:387 [inline]
       filemap_fdatawrite_range mm/filemap.c:412 [inline]
       file_write_and_wait_range+0x23e/0x340 mm/filemap.c:786
       generic_buffers_fsync_noflush+0x70/0x1d0 fs/buffer.c:609
       ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
       ext4_sync_file+0x322/0xae0 fs/ext4/fsync.c:147
       generic_write_sync include/linux/fs.h:2616 [inline]
       ext4_buffered_write_iter+0x2ca/0x3a0 fs/ext4/file.c:305
       ext4_file_write_iter+0x292/0x1bc0 fs/ext4/file.c:-1
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x5c9/0xb30 fs/read_write.c:686
       ksys_pwrite64 fs/read_write.c:793 [inline]
       __do_sys_pwrite64 fs/read_write.c:801 [inline]
       __se_sys_pwrite64 fs/read_write.c:798 [inline]
       __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:798
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->s_writepages_rwsem);
                               lock(&ei->xattr_sem);
                               lock(&sbi->s_writepages_rwsem);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

2 locks held by syz.0.28/6033:
 #0: ffff8880347c2420 (sb_writers#4){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2681 [inline]
 #0: ffff8880347c2420 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0x211/0xb30 fs/read_write.c:682
 #1: ffff8880347c0b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 #1: ffff8880347c0b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
 #1: ffff8880347c0b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1ca/0x350 fs/ext4/inode.c:3025

stack backtrace:
CPU: 1 UID: 0 PID: 6033 Comm: syz.0.28 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
 ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
 ext4_destroy_inline_data+0x28/0xe0 fs/ext4/inline.c:1797
 ext4_do_writepages+0x4e6/0x4500 fs/ext4/inode.c:2811
 ext4_writepages+0x203/0x350 fs/ext4/inode.c:3026
 do_writepages+0x32e/0x550 mm/page-writeback.c:2598
 filemap_writeback mm/filemap.c:387 [inline]
 filemap_fdatawrite_range mm/filemap.c:412 [inline]
 file_write_and_wait_range+0x23e/0x340 mm/filemap.c:786
 generic_buffers_fsync_noflush+0x70/0x1d0 fs/buffer.c:609
 ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
 ext4_sync_file+0x322/0xae0 fs/ext4/fsync.c:147
 generic_write_sync include/linux/fs.h:2616 [inline]
 ext4_buffered_write_iter+0x2ca/0x3a0 fs/ext4/file.c:305
 ext4_file_write_iter+0x292/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:798
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2eec38f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff228a92f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f2eec5e5fa0 RCX: 00007f2eec38f749
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f2eec413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2eec5e5fa0 R14: 00007f2eec5e5fa0 R15: 0000000000000004
 </TASK>
EXT4-fs error (device loop0): ext4_mb_generate_buddy:1306: group 0, block bitmap and bg descriptor inconsistent: 25 vs 150994969 free clusters
EXT4-fs (loop0): Delayed block allocation failed for inode 15 at logical offset 31 with max blocks 33 with error 28
EXT4-fs (loop0): This should not happen!! Data will be lost

EXT4-fs (loop0): Total free blocks count 0
EXT4-fs (loop0): Free/Dirty block details
EXT4-fs (loop0): free_blocks=2415919104
EXT4-fs (loop0): dirty_blocks=64
EXT4-fs (loop0): Block reservation details
EXT4-fs (loop0): i_reserved_data_blocks=4


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

