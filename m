Return-Path: <linux-ext4+bounces-6257-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000D9A20637
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 09:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B163A7AFA
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA691DF25D;
	Tue, 28 Jan 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N4Ae4i64"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B02EAF6;
	Tue, 28 Jan 2025 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052890; cv=none; b=ATXpabZ4mWfYX1LJTuBg/Hd7OOipb2nYPM//Wr8YE0CUjpKbt12mbran8p9B8SxWC4oc87w7cVrFxeWtLrGzqZA9JkODeiD1xUs6zCPn2qqXQ3yn7YoJdUs1SBBGbjQw6Sd3Qg+nC8SYPT1L9xY8rdlTkHQuKm1drP3SXKbkNHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052890; c=relaxed/simple;
	bh=tsq3LU0MaWCJBXCiu2ilyjVYASOiii5Hca2oEoY3FDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O94XOLZrv7vuU89W1kl+btmGZHRTQnHz178LISB1e8uxlwDvjTwuEkxZC0RZeBO494cVzM3m1u4gX6AC1CJvOed2J9suTYl9yNQPcGdNbexc1TYlF2P9O1t3qWAOhCGqaFfT//Yl89IXxWm0y7rl8zXMxjj87NzF9cS7InxML1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=N4Ae4i64; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BlTH/Lk1wgtBJLbRtVNoD4mc4g230K+3KDSRzCfQCcM=; b=N4Ae4i64dQF+9Ck33MbSJY4j6+
	Iy++ZQik8Iq8MjjMmSGGNzDMOdBMn4o/GS2qrBabXC0O7ipCPbkLvvN/2+Ln3NY4EzXoJFSCObdwz
	WjQwNeCwyYHAnGIGlVT7Gth3gT33l66nXUOGp8oKCm3yYrFvMTTRv89ulHqgi6/gvJQJjwQ3tUG3w
	bPZpUPeIAJo0u8+Pes4iC6QgkUYCI1y1Tfz2/pdsvEWV2LGaNYYhfhNxhEBap+nr9prZHweY62mkZ
	kHTAVjMpISkKPHOXm/KjSC/KNBgPBPlEGpByj2YRp9TWsVY8khJk4JIwmrjjiMiht9lOsFY459naX
	v/jrwmZw==;
Received: from [223.233.66.58] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tcgx2-003dn0-HB; Tue, 28 Jan 2025 09:28:04 +0100
From: Bhupesh <bhupesh@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: bhupesh@igalia.com,
	tytso@mit.edu,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	revest@google.com,
	adilger.kernel@dilger.ca,
	cascardo@igalia.com,
	syzbot+b244bda78289b00204ed@syzkaller.appspotmail.com
Subject: [PATCH v2 1/2] fs/ext4/xattr: Ignore xattrs past end
Date: Tue, 28 Jan 2025 13:57:50 +0530
Message-Id: <20250128082751.124948-2-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250128082751.124948-1-bhupesh@igalia.com>
References: <20250128082751.124948-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once inside 'ext4_xattr_inode_dec_ref_all' we should
ignore xattrs entries past the 'end' entry.

This fixes the following KASAN reported issue:

==================================================================
BUG: KASAN: slab-use-after-free in ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
Read of size 4 at addr ffff888012c120c4 by task repro/2065

CPU: 1 UID: 0 PID: 2065 Comm: repro Not tainted 6.13.0-rc2+ #11
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x1fd/0x300
 ? tcp_gro_dev_warn+0x260/0x260
 ? _printk+0xc0/0x100
 ? read_lock_is_recursive+0x10/0x10
 ? irq_work_queue+0x72/0xf0
 ? __virt_addr_valid+0x17b/0x4b0
 print_address_description+0x78/0x390
 print_report+0x107/0x1f0
 ? __virt_addr_valid+0x17b/0x4b0
 ? __virt_addr_valid+0x3ff/0x4b0
 ? __phys_addr+0xb5/0x160
 ? ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
 kasan_report+0xcc/0x100
 ? ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
 ext4_xattr_inode_dec_ref_all+0xb8c/0xe90
 ? ext4_xattr_delete_inode+0xd30/0xd30
 ? __ext4_journal_ensure_credits+0x5f0/0x5f0
 ? __ext4_journal_ensure_credits+0x2b/0x5f0
 ? inode_update_timestamps+0x410/0x410
 ext4_xattr_delete_inode+0xb64/0xd30
 ? ext4_truncate+0xb70/0xdc0
 ? ext4_expand_extra_isize_ea+0x1d20/0x1d20
 ? __ext4_mark_inode_dirty+0x670/0x670
 ? ext4_journal_check_start+0x16f/0x240
 ? ext4_inode_is_fast_symlink+0x2f2/0x3a0
 ext4_evict_inode+0xc8c/0xff0
 ? ext4_inode_is_fast_symlink+0x3a0/0x3a0
 ? do_raw_spin_unlock+0x53/0x8a0
 ? ext4_inode_is_fast_symlink+0x3a0/0x3a0
 evict+0x4ac/0x950
 ? proc_nr_inodes+0x310/0x310
 ? trace_ext4_drop_inode+0xa2/0x220
 ? _raw_spin_unlock+0x1a/0x30
 ? iput+0x4cb/0x7e0
 do_unlinkat+0x495/0x7c0
 ? try_break_deleg+0x120/0x120
 ? 0xffffffff81000000
 ? __check_object_size+0x15a/0x210
 ? strncpy_from_user+0x13e/0x250
 ? getname_flags+0x1dc/0x530
 __x64_sys_unlinkat+0xc8/0xf0
 do_syscall_64+0x65/0x110
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x434ffd
Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 8
RSP: 002b:00007ffc50fa7b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007ffc50fa7e18 RCX: 0000000000434ffd
RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 00007ffc50fa7be0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc50fa7e08 R14: 00000000004bbf30 R15: 0000000000000001
 </TASK>

The buggy address belongs to the object at ffff888012c12000
 which belongs to the cache filp of size 360
The buggy address is located 196 bytes inside of
 freed 360-byte region [ffff888012c12000, ffff888012c12168)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12c12
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x40(head|node=0|zone=0)
page_type: f5(slab)
raw: 0000000000000040 ffff888000ad7640 ffffea0000497a00 dead000000000004
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 0000000000000040 ffff888000ad7640 ffffea0000497a00 dead000000000004
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 0000000000000001 ffffea00004b0481 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888012c11f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888012c12000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888012c12080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff888012c12100: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff888012c12180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Reported-by: syzbot+b244bda78289b00204ed@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b244bda78289b00204ed
Suggested-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 fs/ext4/xattr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7647e9f6e190..6ff94cdf1515 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1176,15 +1176,24 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 {
 	struct inode *ea_inode;
 	struct ext4_xattr_entry *entry;
+	struct ext4_iloc iloc;
 	bool dirty = false;
 	unsigned int ea_ino;
 	int err;
 	int credits;
+	void *end;
+
+	if (block_csum)
+		end = (void *)bh->b_data + bh->b_size;
+	else {
+		ext4_get_inode_loc(parent, &iloc);
+		end = (void *)ext4_raw_inode(&iloc) + EXT4_SB(parent->i_sb)->s_inode_size;
+	}
 
 	/* One credit for dec ref on ea_inode, one for orphan list addition, */
 	credits = 2 + extra_credits;
 
-	for (entry = first; !IS_LAST_ENTRY(entry);
+	for (entry = first; (void *)entry < end && !IS_LAST_ENTRY(entry);
 	     entry = EXT4_XATTR_NEXT(entry)) {
 		if (!entry->e_value_inum)
 			continue;
-- 
2.38.1


