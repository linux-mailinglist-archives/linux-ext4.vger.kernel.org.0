Return-Path: <linux-ext4+bounces-13677-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFVaAEywjGkDsQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13677-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 17:37:32 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AC9126352
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E62073010B9E
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F3342C8E;
	Wed, 11 Feb 2026 16:37:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A3933FE17
	for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827848; cv=none; b=T3DfxqpoMKq+lVC0aiE8uRSj5gmAXL95MMqkt3edAOxGECEudDk4jRXAGYiqRzZzRiR3bvw0b0tCBoPvC8HO4ROI1P8t47kv7/XAeJYjH4aA0FmhJ/sHxhrCMOfrjuR4qw9xiaesCovLz1TB28gQc57uQvbznxLmS2HTMq7s+5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827848; c=relaxed/simple;
	bh=jorlHSRmS7/xt7i4l4Pyghks1Pvdlk0GEZ4CUANMrdY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rWKvAjAdsATckxSyJkx4GWXEBmsBVrwuvVLAeqdnXNqW0QaxOA/KZN4wxFT9mZVcSgWhOCwtSN4xozB4BwmcwxZ17rFm5F+S827e73OrFVUkOOLJYMi2N4ZTqQ61OJtH/YoXe/wpctCBpjKm1Fd8yPxtt7UylmHNV4YA7b5Kpgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-67358e1771bso4844427eaf.0
        for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 08:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770827846; x=1771432646;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exeiSYntXVdj6w0wteLjMpe8skF48q4LTcb+YxISNVc=;
        b=bwrb7z8mFB74tg8mSsdh/WeRGVq88iIgFTddTRwtdM47bV09bebMaqZmzVYxGGiTNO
         yPSeBtM0w3LJwveCrp2cpOq6Ia4m193pYufmmLjNHlpf+N7MCFyFz4vybNyYF56H+Rjh
         Rxnu4kG7811+yMEmXLIGsi2z39RYGfekCQ5kc5B5RsbdTOkS52SGKvwExzGP0/utSKXK
         H8q2fVoejmbIez0CE55jb6VujKYqLSBGMnQm4CjU+JB6NhaVreLuj5HPlKa343O5ymok
         32Ic+Wq7I7CaYsYZWeyJ8cokSWeCVROOqbKvbtD456smFfrc6/Kufu13WBwlBK1CWdYu
         4LDg==
X-Forwarded-Encrypted: i=1; AJvYcCVr0mHkeFA00qMuRNJusGfVQ0GqxRJX/CVXviDvf7GoMQQgNOJ3yggehzhwpmB6NNlU0QW7BVEzYpJ8@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNATR8x1AkbEq44Z0rW0B5hAeYm5lP+0oxCfO9CpU5JIzekUP
	v6n6CzkGK+xrL6MLlwmrxHw/9LRuuyGt5Du/imALjb9Hd5wz3lxhOGzqf7PEiIk0mzIMuURaaRi
	NRuAbNQQmEUYcGbzSJOQVl3vYUdSJsjJWBIPFoj9wEqG9RdiSSQD0ehJK0iM=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:61a:b0:66a:bd71:f058 with SMTP id
 006d021491bc7-672e61d6c5dmr3339679eaf.28.1770827845731; Wed, 11 Feb 2026
 08:37:25 -0800 (PST)
Date: Wed, 11 Feb 2026 08:37:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698cb045.050a0220.2eeac1.009b.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in block_read_full_folio (3)
From: syzbot <syzbot+03afbb29537f0336b7ad@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13677-lists,linux-ext4=lfdr.de,03afbb29537f0336b7ad];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goo.gl:url,googlegroups.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 54AC9126352
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    2687c848e578 x86/vmware: Fix hypercall clobbers
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158c2a5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
dashboard link: https://syzkaller.appspot.com/bug?extid=03afbb29537f0336b7ad
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131aab22580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/988f106eda78/disk-2687c848.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/52aad858e7e7/vmlinux-2687c848.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99f1cbe5967b/bzImage-2687c848.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/405f0d179069/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16a9265a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03afbb29537f0336b7ad@syzkaller.appspotmail.com

INFO: task syz.3.1794:12741 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.1794      state:D stack:23768 pid:12741 tgid:12736 ppid:5962   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0x14ea/0x5050 kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:6964
 io_schedule+0x7f/0xd0 kernel/sched/core.c:7791
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit_lock+0xec/0x4e0 kernel/sched/wait_bit.c:93
 out_of_line_wait_on_bit_lock+0x13b/0x190 kernel/sched/wait_bit.c:120
 wait_on_bit_lock_io include/linux/wait_bit.h:221 [inline]
 __lock_buffer fs/buffer.c:71 [inline]
 lock_buffer include/linux/buffer_head.h:432 [inline]
 block_read_full_folio+0x38f/0x830 fs/buffer.c:2439
 filemap_read_folio+0x137/0x3b0 mm/filemap.c:2496
 do_read_cache_folio+0x358/0x590 mm/filemap.c:4096
 read_mapping_folio include/linux/pagemap.h:1028 [inline]
 read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
 amiga_partition+0xe0/0x1dd0 block/partitions/amiga.c:53
 check_partition block/partitions/core.c:141 [inline]
 blk_add_partitions block/partitions/core.c:589 [inline]
 bdev_disk_changed+0x765/0x14c0 block/partitions/core.c:693
 loop_reread_partitions drivers/block/loop.c:448 [inline]
 loop_set_status+0x9ab/0xe40 drivers/block/loop.c:1277
 loop_set_status64 drivers/block/loop.c:1373 [inline]
 lo_ioctl+0xc21/0x1fb0 drivers/block/loop.c:1559
 blkdev_ioctl+0x5e3/0x740 block/ioctl.c:792
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0918d9aeb9
RSP: 002b:00007f0919c77028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0919015fa0 RCX: 00007f0918d9aeb9
RDX: 00002000000003c0 RSI: 0000000000004c04 RDI: 0000000000000005
RBP: 00007f0918e08c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0919016038 R14: 00007f0919015fa0 R15: 00007ffe22744b08
 </TASK>
INFO: task syz.3.1794:12749 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.1794      state:D stack:22936 pid:12749 tgid:12736 ppid:5962   task_flags:0x440140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5260 [inline]
 __schedule+0x14ea/0x5050 kernel/sched/core.c:6867
 __schedule_loop kernel/sched/core.c:6949 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:6964
 io_schedule+0x7f/0xd0 kernel/sched/core.c:7791
 folio_wait_bit_common+0x6d8/0xbc0 mm/filemap.c:1323
 folio_lock include/linux/pagemap.h:1170 [inline]
 __find_get_block_slow fs/buffer.c:205 [inline]
 find_get_block_common+0x23c/0xe60 fs/buffer.c:1408
 bdev_getblk+0x53/0x6e0 include/linux/gfp.h:-1
 __getblk include/linux/buffer_head.h:380 [inline]
 sb_getblk include/linux/buffer_head.h:386 [inline]
 __ext4_get_inode_loc+0x7d8/0xfa0 fs/ext4/inode.c:4860
 ext4_get_inode_loc fs/ext4/inode.c:4963 [inline]
 ext4_reserve_inode_write+0x18b/0x360 fs/ext4/inode.c:6287
 __ext4_mark_inode_dirty+0x14b/0x6e0 fs/ext4/inode.c:6465
 ext4_ext_insert_extent+0x2062/0x4b50 fs/ext4/extents.c:2192
 ext4_ext_map_blocks+0x19d1/0x6b80 fs/ext4/extents.c:4404
 ext4_map_create_blocks fs/ext4/inode.c:613 [inline]
 ext4_map_blocks+0x8da/0x1830 fs/ext4/inode.c:816
 ext4_getblk+0x1ca/0x780 fs/ext4/inode.c:984
 ext4_bread+0x2a/0x180 fs/ext4/inode.c:1047
 ext4_quota_write+0x239/0x580 fs/ext4/super.c:7350
 write_blk fs/quota/quota_tree.c:70 [inline]
 get_free_dqblk+0x368/0x720 fs/quota/quota_tree.c:136
 do_insert_tree+0x256/0x11d0 fs/quota/quota_tree.c:347
 do_insert_tree+0x9d7/0x11d0 fs/quota/quota_tree.c:402
 do_insert_tree+0x9b2/0x11d0 fs/quota/quota_tree.c:402
 do_insert_tree+0x9b2/0x11d0 fs/quota/quota_tree.c:402
 dq_insert_tree fs/quota/quota_tree.c:432 [inline]
 qtree_write_dquot+0x4b1/0x5e0 fs/quota/quota_tree.c:451
 v2_write_dquot+0x183/0x260 fs/quota/quota_v2.c:372
 dquot_acquire+0x328/0x620 fs/quota/dquot.c:473
 ext4_acquire_dquot+0x2e9/0x4c0 fs/ext4/super.c:6982
 dqget+0x7b1/0xf10 fs/quota/dquot.c:980
 __dquot_initialize+0x3ba/0xd30 fs/quota/dquot.c:1508
 ext4_xattr_set+0xdb/0x340 fs/ext4/xattr.c:2543
 __vfs_setxattr+0x43c/0x480 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:234
 vfs_setxattr+0x16a/0x2e0 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x281/0x630 fs/xattr.c:665
 path_setxattrat+0x3f3/0x430 fs/xattr.c:713
 __do_sys_lsetxattr fs/xattr.c:754 [inline]
 __se_sys_lsetxattr fs/xattr.c:750 [inline]
 __x64_sys_lsetxattr+0xbf/0xe0 fs/xattr.c:750
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0918d9aeb9
RSP: 002b:00007f0919c56028 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007f0919016090 RCX: 00007f0918d9aeb9
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000200000000180
RBP: 00007f0918e08c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0919016128 R14: 00007f0919016090 R15: 00007ffe22744b08
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/32:
 #0: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by udevd/5187:
 #0: 
ffff8881423cc358
 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:962
 #1: 
ffff8881423cb448
 (
&lo->lo_mutex
){+.+.}-{4:4}, at: lo_open+0x4f/0xd0 drivers/block/loop.c:1721
2 locks held by getty/5574:
 #0: ffff88814e76c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13c0 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/5970:
 #0: ffffffff8e560c78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
 #0: ffffffff8e560c78 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x38d/0x770 kernel/rcu/tree_exp.h:956
1 lock held by udevd/10512:
 #0: ffff8881423cc358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xe0/0xd30 block/bdev.c:962
1 lock held by udevd/10515:
 #0: ffff888148c4e3a8 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1042 [inline]
 #0: ffff888148c4e3a8 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: blkdev_read_iter+0x2f8/0x440 block/fops.c:855
1 lock held by syz.3.1794/12741:
 #0: ffff8880247da358 (&disk->open_mutex){+.+.}-{4:4}, at: loop_reread_partitions drivers/block/loop.c:447 [inline]
 #0: ffff8880247da358 (&disk->open_mutex){+.+.}-{4:4}, at: loop_set_status+0x986/0xe40 drivers/block/loop.c:1277
5 locks held by syz.3.1794/12749:
 #0: ffff888031f7e420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:499
 #1: ffff888060996420 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #1: ffff888060996420 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: vfs_setxattr+0x143/0x2e0 fs/xattr.c:320
 #2: ffff88805edd7228 (&dquot->dq_lock){+.+.}-{4:4}, at: dquot_acquire+0x67/0x620 fs/quota/dquot.c:461
 #3: ffff888031f7e208 (&s->s_dquot.dqio_sem){++++}-{4:4}, at: v2_write_dquot+0xab/0x260 fs/quota/quota_v2.c:367
 #4: ffff888060990c10 (&ei->i_data_sem/2){++++}-{4:4}, at: ext4_map_blocks+0x7d7/0x1830 fs/ext4/inode.c:815
2 locks held by ext4lazyinit/15775:
 #0: ffff88805aa420e0 (&type->s_umount_key#31){++++}-{4:4}, at: ext4_lazyinit_thread+0x1b7/0x1830 fs/ext4/super.c:3818
 #1: ffff88805aa42420 (sb_writers#4){.+.+}-{0:0}, at: kthread+0x726/0x8b0 kernel/kthread.c:463
3 locks held by syz.1.3370/18614:
 #0: ffff8881423cb448 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0xc3/0xe40 drivers/block/loop.c:1235
 #1: ffff888142392680 (&q->q_usage_counter(io)#18){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:954 [inline]
 #1: ffff888142392680 (&q->q_usage_counter(io)#18){++++}-{0:0}, at: loop_set_status+0x310/0xe40 drivers/block/loop.c:1251
 #2: ffff8881423926b8 (&q->q_usage_counter(queue)#2){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:954 [inline]
 #2: ffff8881423926b8 (&q->q_usage_counter(queue)#2){+.+.}-{0:0}, at: loop_set_status+0x310/0xe40 drivers/block/loop.c:1251
4 locks held by syz.1.3370/18624:
 #0: ffff88805aa42420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:499
 #1: ffff88807863a0c0 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #1: ffff88807863a0c0 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: vfs_setxattr+0x143/0x2e0 fs/xattr.c:320
 #2: ffff8880785a2968 (&dquot->dq_lock){+.+.}-{4:4}, at: dquot_acquire+0x67/0x620 fs/quota/dquot.c:461
 #3: ffff88805aa42208 (&s->s_dquot.dqio_sem){++++}-{4:4}, at: v2_read_dquot+0x50/0x1d0 fs/quota/quota_v2.c:342
3 locks held by syz.0.3371/18615:
 #0: ffff8881423c8448 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0xc3/0xe40 drivers/block/loop.c:1235
 #1: ffff888142391cf8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:954 [inline]
 #1: ffff888142391cf8 (&q->q_usage_counter(io)#17){++++}-{0:0}, at: loop_set_status+0x310/0xe40 drivers/block/loop.c:1251
 #2: ffff888142391d30 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:954 [inline]
 #2: ffff888142391d30 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: loop_set_status+0x310/0xe40 drivers/block/loop.c:1251
4 locks held by syz.0.3371/18626:
 #0: ffff88803381c420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:499
 #1: ffff8880786920c0 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #1: ffff8880786920c0 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: vfs_setxattr+0x143/0x2e0 fs/xattr.c:320
 #2: ffff8880785a3ca8 (&dquot->dq_lock){+.+.}-{4:4}, at: dquot_acquire+0x67/0x620 fs/quota/dquot.c:461
 #3: ffff88803381c208 (&s->s_dquot.dqio_sem){++++}-{4:4}, at: v2_read_dquot+0x50/0x1d0 fs/quota/quota_v2.c:342
3 locks held by syz.4.3374/18631:
 #0: ffff8880247dc448 (&lo->lo_mutex){+.+.}-{4:4}, at: loop_set_status+0xc3/0xe40 drivers/block/loop.c:1235
 #1: ffff888142394318 (&q->q_usage_counter(io)#21){++++}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:954 [inline]
 #1: ffff888142394318 (&q->q_usage_counter(io)#21){++++}-{0:0}, at: loop_set_status+0x310/0xe40 drivers/block/loop.c:1251
 #2: ffff888142394350 (&q->q_usage_counter(queue)#5){+.+.}-{0:0}, at: blk_mq_freeze_queue include/linux/blk-mq.h:954 [inline]
 #2: ffff888142394350 (&q->q_usage_counter(queue)#5){+.+.}-{0:0}, at: loop_set_status+0x310/0xe40 drivers/block/loop.c:1251
4 locks held by syz.4.3374/18633:
 #0: ffff88805e0e8420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:499
 #1: ffff88807863e420 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #1: ffff88807863e420 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: vfs_setxattr+0x143/0x2e0 fs/xattr.c:320
 #2: ffff8880785a33e8 (&dquot->dq_lock){+.+.}-{4:4}, at: dquot_acquire+0x67/0x620 fs/quota/dquot.c:461
 #3: ffff88805e0e8208 (&s->s_dquot.dqio_sem){++++}-{4:4}, at: v2_read_dquot+0x50/0x1d0 fs/quota/quota_v2.c:342

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 32 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xf90/0xfe0 kernel/hung_task.c:515
 kthread+0x726/0x8b0 kernel/kthread.c:463
 ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 18624 Comm: syz.1.3370 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:400
Code: e8 ae ae 92 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 4f fe fa fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f e9 65 75 de fb cc 44 89 f9 80 e1 07
RSP: 0018:ffffc9000ce6ebf0 EFLAGS: 00000002
RAX: 1ffffffff3467000 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffffffff9a338530 R08: ffff8881482f0237 R09: 1ffff1102905e046
R10: dffffc0000000000 R11: ffffffff8531cb20 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff9a3382a0 R15: 0000000000000000
FS:  00007fc4d59d56c0(0000) GS:ffff8881256f3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0ae19e8600 CR3: 00000000527fe000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:128 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:150 [inline]
 wait_for_lsr+0x1a1/0x2f0 drivers/tty/serial/8250/8250_port.c:1961
 fifo_wait_for_lsr drivers/tty/serial/8250/8250_port.c:3234 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3257 [inline]
 serial8250_console_write+0x1348/0x1ba0 drivers/tty/serial/8250/8250_port.c:3342
 console_emit_next_record kernel/printk/printk.c:3129 [inline]
 console_flush_one_record kernel/printk/printk.c:3215 [inline]
 console_flush_all+0x718/0xb20 kernel/printk/printk.c:3289
 __console_flush_and_unlock kernel/printk/printk.c:3319 [inline]
 console_unlock+0xd1/0x1c0 kernel/printk/printk.c:3359
 vprintk_emit+0x485/0x560 kernel/printk/printk.c:2426
 _printk+0xdd/0x130 kernel/printk/printk.c:2451
 __quota_error+0x1a6/0x1d0 fs/quota/dquot.c:148
 write_blk fs/quota/quota_tree.c:73 [inline]
 get_free_dqblk+0x3cd/0x720 fs/quota/quota_tree.c:136
 do_insert_tree+0x256/0x11d0 fs/quota/quota_tree.c:347
 do_insert_tree+0x9d7/0x11d0 fs/quota/quota_tree.c:402
 dq_insert_tree fs/quota/quota_tree.c:432 [inline]
 qtree_write_dquot+0x4b1/0x5e0 fs/quota/quota_tree.c:451
 v2_write_dquot+0x183/0x260 fs/quota/quota_v2.c:372
 dquot_acquire+0x328/0x620 fs/quota/dquot.c:473
 ext4_acquire_dquot+0x2e9/0x4c0 fs/ext4/super.c:6982
 dqget+0x7b1/0xf10 fs/quota/dquot.c:980
 __dquot_initialize+0x3ba/0xd30 fs/quota/dquot.c:1508
 ext4_xattr_set+0xdb/0x340 fs/ext4/xattr.c:2543
 __vfs_setxattr+0x43c/0x480 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:234
 vfs_setxattr+0x16a/0x2e0 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x281/0x630 fs/xattr.c:665
 path_setxattrat+0x3f3/0x430 fs/xattr.c:713
 __do_sys_lsetxattr fs/xattr.c:754 [inline]
 __se_sys_lsetxattr fs/xattr.c:750 [inline]
 __x64_sys_lsetxattr+0xbf/0xe0 fs/xattr.c:750
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4d639aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc4d59d5028 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007fc4d6616090 RCX: 00007fc4d639aeb9
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000200000000180
RBP: 00007fc4d6408c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc4d6616128 R14: 00007fc4d6616090 R15: 00007ffed7e83f48
 </TASK>


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

