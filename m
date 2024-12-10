Return-Path: <linux-ext4+bounces-5542-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0CA9EB8A2
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 18:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B499B1888C11
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263701AA786;
	Tue, 10 Dec 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GqN828JO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07078F26;
	Tue, 10 Dec 2024 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852975; cv=none; b=HXSKyYcGzHwwfPdPaZQP3SrRMr3x+1TERTiO/MmcnLmw+LmsdwzyAFc2+HC5PlZcb1r9TE+eZ0YAVxhInLakIU8MZbiA5sY5O/J33hXuRMF9cv/8nw5kUxSblFKVRznpCRw6lgp/4lRUVeNsK8QPWFVNexo+2190qt2P+uvY8xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852975; c=relaxed/simple;
	bh=ExU11VC6rWHXYqOE404mBwyFvdZ8q2PU9XnURq+zJ+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mnUJtI55Ic9vlPEzujie6sA/H0crMjGZEGyu5ynpejao/KprDh7SfM6bDGhd6PSpTvkO2aRiqpkKDSYOLliVIQmVDhABEba46ur1DSDwLphN0e3oUutk+lA95auluwih6Av+3OzOJXq1ErtopuObF8xCj/4ITmm5K6dIfx/vETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GqN828JO; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Lf/qfxDPCkH7W0jnGYW3MUEKxeT9TdRhA4oiRRnph4Y=; b=GqN828JOIysQOCYZnxpi1kv2by
	etR8mXQ3OQcbuE1q0vUzZvkiuDxDn9dk1EQ+/vttzMMiv/5GBIAYgCXibUkM+QdD8QaTHtCX/7vN9
	xqtkb0maCd+PvEuJCpiiz7ws1iOOxjOB0e3T2CD9Tj6RDmW6YLBvYpj/MqmSDXfkH9kz+HwQdpv2K
	urld2aXpOXNqxzSa+db5K07sSdT6HC6qh/i1HIRSMLMyDYahIGxngNzfZJD1nWGaBHGEK5M1KagBz
	m+mD3BUG7iSqmd+sqOp9jV0VyDL/fe/YQCTmiDYC3Op3iqXljgWaq+s1UW0fDD2ZPlh0mBIIbh6mo
	qgPJN4ng==;
Received: from [177.180.73.242] (helo=quatroqueijos..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tL4MR-001ZhR-6N; Tue, 10 Dec 2024 18:49:27 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Mingming Cao <cmm@us.ibm.com>,
	Kalpak Shah <kalpak@clusterfs.com>,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	syzbot+57934e2c8e7a99992e41@syzkaller.appspotmail.com
Subject: [PATCH] ext4: only test for inode xattr state when expanding inode
Date: Tue, 10 Dec 2024 14:48:50 -0300
Message-Id: <20241210174850.4027690-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When expanding inode size, a check for the xattr magic code could fail
because the underlying data was corrupt or changed by directly writing to
the block device.

But instead of detecting such corruption, the current test would clear the
data but keep the EXT4_STATE_XATTR bit set in the inode state.

When later deleting the inode, this would lead for a test for such bit to
succeed and then an out-of-bounds access.

Since the state could only be set when the magic code has been detected
(and when such bit is cleared, so is the magic code), it is sufficient to
test for such state when deciding whether expanding the inode size is safe.

Here is the KASAN report.

[   35.283769] ==================================================================
[   35.284710] BUG: KASAN: use-after-free in ext4_xattr_delete_inode+0xa33/0xa70
[   35.285676] Read of size 4 at addr ffff88800aaee000 by task repro/188
[   35.286694]
[   35.286912] CPU: 4 UID: 0 PID: 188 Comm: repro Not tainted 6.13.0-rc1+ #281
[   35.287560] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   35.288709] Call Trace:
[   35.289368]  <TASK>
[   35.289790]  dump_stack_lvl+0x68/0xa0
[   35.290621]  print_report+0xcb/0x620
[   35.291400]  ? __virt_addr_valid+0x222/0x400
[   35.292325]  ? ext4_xattr_delete_inode+0xa33/0xa70
[   35.293198]  kasan_report+0xbd/0xf0
[   35.293738]  ? ext4_xattr_delete_inode+0xa33/0xa70
[   35.294461]  ext4_xattr_delete_inode+0xa33/0xa70
[   35.295200]  ? __pfx_ext4_xattr_delete_inode+0x10/0x10
[   35.295975]  ? __ext4_journal_start_sb+0x7b/0x520
[   35.296849]  ? lock_is_held_type+0x9e/0x120
[   35.297711]  ext4_evict_inode+0x64b/0x14f0
[   35.298225]  ? __pfx_lock_release+0x10/0x10
[   35.298724]  ? do_raw_spin_lock+0x131/0x270
[   35.299256]  ? __pfx_ext4_evict_inode+0x10/0x10
[   35.299824]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   35.300593]  evict+0x334/0x790
[   35.300991]  ? __pfx_evict+0x10/0x10
[   35.301890]  ? do_raw_spin_unlock+0x58/0x220
[   35.302817]  ? _raw_spin_unlock+0x23/0x40
[   35.303676]  ? iput+0x441/0x610
[   35.304218]  vfs_rmdir+0x44b/0x5a0
[   35.304769]  ? lookup_one_qstr_excl+0x24/0x150
[   35.305297]  do_rmdir+0x28e/0x370
[   35.305678]  ? __pfx_do_rmdir+0x10/0x10
[   35.306148]  ? trace_kmem_cache_alloc+0x24/0xb0
[   35.306703]  ? getname_flags+0xb3/0x410
[   35.307190]  __x64_sys_rmdir+0x40/0x50
[   35.307641]  do_syscall_64+0xc1/0x1d0
[   35.308096]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   35.308701] RIP: 0033:0x7f071988381b
[   35.309147] Code: f0 ff ff 73 01 c3 48 8b 0d 02 36 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 54 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 d1 35 0e 00 f7 d8
[   35.311700] RSP: 002b:00007ffc6ed5f4f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
[   35.313089] RAX: ffffffffffffffda RBX: 00007ffc6ed62948 RCX: 00007f071988381b
[   35.314271] RDX: 0000000000000000 RSI: 000056215a1fd2e0 RDI: 00007ffc6ed606c0
[   35.315464] RBP: 00007ffc6ed605e0 R08: 0000000000000073 R09: 0000000000000000
[   35.316537] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[   35.317452] R13: 00007ffc6ed62958 R14: 00005621223ddc70 R15: 00007f07199d6000
[   35.318345]  </TASK>
[   35.318625]
[   35.318827] The buggy address belongs to the physical page:
[   35.319896] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x67 pfn:0xaaee
[   35.320879] flags: 0x80000000000000(node=0|zone=1)
[   35.321361] raw: 0080000000000000 ffffea00002abbc8 ffffea00002ac348 0000000000000000
[   35.322478] raw: 0000000000000067 0000000000000000 00000000ffffffff 0000000000000000
[   35.323460] page dumped because: kasan: bad access detected
[   35.324149]
[   35.324347] Memory state around the buggy address:
[   35.324958]  ffff88800aaedf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   35.326113]  ffff88800aaedf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   35.327190] >ffff88800aaee000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   35.328162]                    ^
[   35.328700]  ffff88800aaee080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   35.329505]  ffff88800aaee100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   35.330516] ==================================================================
[   35.332287] Disabling lock debugging due to kernel taint

Reported-by: syzbot+57934e2c8e7a99992e41@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=57934e2c8e7a99992e41
Fixes: 6dd4ee7cab7e ("ext4: Expand extra_inodes space per the s_{want,min}_extra_isize fields")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 89aade6f45f6..ed32c26abbfd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5867,8 +5867,7 @@ static int __ext4_expand_extra_isize(struct inode *inode,
 	header = IHDR(inode, raw_inode);
 
 	/* No extended attributes present */
-	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
-	    header->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC)) {
+	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		memset((void *)raw_inode + EXT4_GOOD_OLD_INODE_SIZE +
 		       EXT4_I(inode)->i_extra_isize, 0,
 		       new_extra_isize - EXT4_I(inode)->i_extra_isize);
-- 
2.34.1


