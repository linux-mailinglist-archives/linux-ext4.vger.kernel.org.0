Return-Path: <linux-ext4+bounces-4254-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F83D97E032
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 07:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC99B1F213E2
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 05:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51418F2CF;
	Sun, 22 Sep 2024 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eXvMQYVY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5EB1DFCB;
	Sun, 22 Sep 2024 05:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726984022; cv=none; b=secUcqmbJsVGUbPfvGTJrNsXKxCeKow3bQELSPvr/wY//GvoWnFqS0sO49cQvCa413aFBIVPHlI7bVWDXECIS+oNNtO4PdmlZyBuJC9xBlNo03F/zF0SKZw1BrQAGA8UOxlNNEzhSsUwSX7gXOBUGk9IEFN40imG/i1KqpGcvos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726984022; c=relaxed/simple;
	bh=8nr/cLUXFopPhAFql75WeQ4EN2Wa5X690MlP5oLQ6/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAVfwqVdMZoua8mqkNCHVx0Oe4mw2ufWlCKPxcWjKoIYQ3S8zxzZ9Iv8hV2UuFX32z3V+T72NMjMWWZpXoPBhLyYbfhsugLbLsGQD6q2YUgW5zvABDENY+DctvpmU7yrUL7KCfYEnEdJjCaJU1QCJI6o3uj4aw64nS0fY6wZkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eXvMQYVY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=isa+ilqZGLFW5BB7FM6u6Y5eiCAALL0Gb9yQF1cCasY=;
	b=eXvMQYVYmq/ICtdt4Gl3PC6jZbxbENc9/Co+mTNjrZwMzt0EjT6Tu8YtJzWsX4
	GUtVOZXfhcxwDYf/6jKEWBQfeeSDK+rXjN057pUzBG3upS0OAEYbmL4VzwsGpWtz
	Dd02LDQTV4xNRFLJGELu4q+EvUsghrje5oV99rYGLQhEs=
Received: from localhost (unknown [36.33.37.137])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wBHxJ4jr+9mFpEGOQ--.32791S2;
	Sun, 22 Sep 2024 13:46:11 +0800 (CST)
Date: Sun, 22 Sep 2024 13:46:11 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in
 ext4_xattr_set_entry
Message-ID: <Zu+vI3EipxSsPOMe@thinkpad.lan>
References: <66ef61d6.050a0220.3195df.0072.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ef61d6.050a0220.3195df.0072.GAE@google.com>
X-CM-TRANSID:_____wBHxJ4jr+9mFpEGOQ--.32791S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3tryxXw4rWr1xKry7AFW5Wrg_yoW8Jr17Wo
	ZFqr15CF48Ga45JFs5Ar4UtryUGFy8ZFsrJr1rur45GF9xZr1DCr13K3yYyr18tr45GF13
	Zr17tw1rW3yDXFn5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcasUDUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQNiambveN68GAABsE

On Sat, Sep 21, 2024 at 05:16:22PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a940d9a43e62 Merge tag 'soc-arm-6.12' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16689207980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1653f803fffa3848
> dashboard link: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11689207980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104d469f980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a940d9a4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/371e11b6a9e5/vmlinux-a940d9a4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/920eb0c53785/bzImage-a940d9a4.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/4146c0b2e744/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> 
> EXT4-fs (loop0): 1 truncate cleaned up
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
> ==================================================================
> BUG: KASAN: out-of-bounds in ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
> Read of size 18446744073709551572 at addr ffff888036426850 by task syz-executor264/5095
> 
> CPU: 0 UID: 0 PID: 5095 Comm: syz-executor264 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:93 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
>  ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
>  ext4_xattr_block_set+0xa39/0x3980 fs/ext4/xattr.c:2028
>  ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
>  ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
>  ext4_expand_extra_isize_ea+0x12d7/0x1cf0 fs/ext4/xattr.c:2836
>  __ext4_expand_extra_isize+0x2fb/0x3e0 fs/ext4/inode.c:5858
>  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5901 [inline]
>  __ext4_mark_inode_dirty+0x524/0x880 fs/ext4/inode.c:5979
>  __ext4_unlink+0x6c2/0xb50 fs/ext4/namei.c:3289
>  ext4_unlink+0x1bf/0x5a0 fs/ext4/namei.c:3318
>  vfs_unlink+0x365/0x650 fs/namei.c:4469
>  do_unlinkat+0x4ae/0x830 fs/namei.c:4533
>  __do_sys_unlink fs/namei.c:4581 [inline]
>  __se_sys_unlink fs/namei.c:4579 [inline]
>  __x64_sys_unlink+0x47/0x50 fs/namei.c:4579
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2549cabe99
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff914df8a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
> RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f2549cabe99
> RDX: 00007f2549cabe99 RSI: 00007f2549cabe99 RDI: 0000000020000180
> RBP: 0032656c69662f2e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff914df8e0
> R13: 00007fff914dfb08 R14: 431bde82d7b634db R15: 00007f2549cf503b
>  </TASK>
> 
> Allocated by task 5095:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:4159 [inline]
>  __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4178
>  kmemdup_noprof+0x2a/0x60 mm/util.c:133
>  ext4_xattr_block_set+0x88b/0x3980 fs/ext4/xattr.c:1976
>  ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
>  ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
>  ext4_expand_extra_isize_ea+0x12d7/0x1cf0 fs/ext4/xattr.c:2836
>  __ext4_expand_extra_isize+0x2fb/0x3e0 fs/ext4/inode.c:5858
>  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5901 [inline]
>  __ext4_mark_inode_dirty+0x524/0x880 fs/ext4/inode.c:5979
>  __ext4_unlink+0x6c2/0xb50 fs/ext4/namei.c:3289
>  ext4_unlink+0x1bf/0x5a0 fs/ext4/namei.c:3318
>  vfs_unlink+0x365/0x650 fs/namei.c:4469
>  do_unlinkat+0x4ae/0x830 fs/namei.c:4533
>  __do_sys_unlink fs/namei.c:4581 [inline]
>  __se_sys_unlink fs/namei.c:4579 [inline]
>  __x64_sys_unlink+0x47/0x50 fs/namei.c:4579
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff888036426800
>  which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 80 bytes inside of
>  1024-byte region [ffff888036426800, ffff888036426c00)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36424
> head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
> page_type: 0xfdffffff(slab)
> raw: 04fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000080080008 00000001fdffffff 0000000000000000
> head: 04fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
> head: 0000000000000000 0000000080080008 00000001fdffffff 0000000000000000
> head: 04fff00000000002 ffffea0000d90901 ffffffffffffffff 0000000000000000
> head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5049, tgid 5049 (dhcpcd), ts 74832155643, free_ts 73695396465
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
>  prep_new_page mm/page_alloc.c:1508 [inline]
>  get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3446
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
>  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2319
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2482
>  new_slab mm/slub.c:2535 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3721
>  __slab_alloc+0x58/0xa0 mm/slub.c:3811
>  __slab_alloc_node mm/slub.c:3864 [inline]
>  slab_alloc_node mm/slub.c:4026 [inline]
>  __do_kmalloc_node mm/slub.c:4158 [inline]
>  __kmalloc_noprof+0x25a/0x400 mm/slub.c:4171
>  kmalloc_noprof include/linux/slab.h:694 [inline]
>  load_elf_phdrs+0x162/0x260 fs/binfmt_elf.c:526
>  load_elf_binary+0x920/0x2680 fs/binfmt_elf.c:955
>  search_binary_handler fs/exec.c:1820 [inline]
>  exec_binprm fs/exec.c:1862 [inline]
>  bprm_execve+0xaf8/0x1770 fs/exec.c:1913
>  do_execveat_common+0x55f/0x6f0 fs/exec.c:2020
>  do_execve fs/exec.c:2094 [inline]
>  __do_sys_execve fs/exec.c:2170 [inline]
>  __se_sys_execve fs/exec.c:2165 [inline]
>  __x64_sys_execve+0x92/0xb0 fs/exec.c:2165
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 5032 tgid 5032 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1101 [inline]
>  free_unref_page+0xd22/0xea0 mm/page_alloc.c:2619
>  __slab_free+0x31b/0x3d0 mm/slub.c:4385
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3989 [inline]
>  slab_alloc_node mm/slub.c:4038 [inline]
>  __do_kmalloc_node mm/slub.c:4158 [inline]
>  __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4171
>  kmalloc_noprof include/linux/slab.h:694 [inline]
>  tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
>  tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
>  tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
>  security_inode_getattr+0x130/0x330 security/security.c:2371
>  vfs_getattr+0x45/0x430 fs/stat.c:204
>  vfs_fstat fs/stat.c:229 [inline]
>  vfs_fstatat+0xe4/0x190 fs/stat.c:338
>  __do_sys_newfstatat fs/stat.c:505 [inline]
>  __se_sys_newfstatat fs/stat.c:499 [inline]
>  __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Memory state around the buggy address:
>  ffff888036426700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888036426780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff888036426800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>                                                  ^
>  ffff888036426880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888036426900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
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
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

#syz test

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..336badb46246 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1776,7 +1776,14 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	} else if (s->not_found) {
 		/* Insert new name. */
 		size_t size = EXT4_XATTR_LEN(name_len);
-		size_t rest = (void *)last - (void *)here + sizeof(__u32);
+		size_t rest;
+
+		if (last < here) {
+			ret = -ENOSPC;
+			goto out;
+		} else {
+			rest = (void *)last - (void *)here + sizeof(__u32);
+		}
 
 		memmove((void *)here + size, here, rest);
 		memset(here, 0, size);
-- 
Best,
Qianqiang Liu


