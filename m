Return-Path: <linux-ext4+bounces-5377-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB189D5E22
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 12:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C81F2269E
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CC71DDA3E;
	Fri, 22 Nov 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fddus++1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC425171E6E
	for <linux-ext4@vger.kernel.org>; Fri, 22 Nov 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275212; cv=none; b=dWSJUpXdo+meRwZoX1EI2fFL3zNryc0SBNLM72olxDllSTu9uApn2SeegHw5+2St61PFiMLMznohdo0pzVf+xd10PfO9ADkc0g0zFW2gns4Vt2WnghtnYeQ4YVaztf6/UxFelsdUpT9SXEWQlkfgJwI1sUoxTCljahjHhecInP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275212; c=relaxed/simple;
	bh=NFfMw87tfYpjP1VEj7hqtvCcige94NQGnjmjiF8IW5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oIhG3SqHoF7VnnNPsakkE3jzHjEt8Hcryo/UA6Gb0+nkzc/9XCNjzDWqGuGx+EdqyItmOXR418z/gmIbWXZCRC8VfG55GBZQLI4tdGDUfLmFQfyYcMjZJFB879Dzc3OJ3NOv+6nKxmZ+s8GoDAlw0kL+2I7UH88570vPzGi41pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fddus++1; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WywmIsuimWkfYfrvI+jSrsQicFuskKCjtm2gUwSTFFc=; b=fddus++1oNFhgLQLPiWkL2s9gS
	txVQFgIHojZ2sJlY99yE5zyKluREkDmx4erG4xzMeiP0w4bWd4iVQhjTwJ8z+Xnej13zrZenK9Njo
	wrDoZCh5PqaIqXMcjrjo+e2SS0T0IsK+Lw+odwTP2paVwG6FgH/o9CvW7nNHwXMyyLM7J5FlhWzPm
	6hd9mvqsdASv2vPg0E3YP+Dff8U075IBwwBQsp1cCsAWAsyPWkok3r+RNfbnlBlhwBhQaeHJaqPIw
	XqsYokAYYf+vSREM6V8GrecCjkAG6vFAnGzeZ8jxmGbNb7IGQdHmIB2H+/A2ZBT8g6n7KHlr8+x/P
	f7sHpIKw==;
Received: from 179-125-75-203-dinamico.pombonet.net.br ([179.125.75.203] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tERuV-00AvAa-Br; Fri, 22 Nov 2024 12:33:15 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Tao Ma <boyu.mt@taobao.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	syzbot+f6a8aa7e307cf6ee835e@syzkaller.appspotmail.com
Subject: [PATCH] ext4: avoid OOB when converting inline data
Date: Fri, 22 Nov 2024 08:32:45 -0300
Message-Id: <20241122113245.395016-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When converting an inline file to non-inline, if e_value_offs is changed
underneath the filesystem by some change in the block device, it will lead
to an out-of-bounds access that KASAN detects as an UAF.

[   17.272876] ==================================================================
[   17.273620] BUG: KASAN: slab-use-after-free in ext4_read_inline_data+0x19c/0x270
[   17.274286] Read of size 20 at addr ffff8880099821a3 by task repro/690
[   17.274949]
[   17.275487] CPU: 0 UID: 0 PID: 690 Comm: repro Not tainted 6.12.0-rc7-00078-g94f739ba5406 #164
[   17.276372] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[   17.277186] Call Trace:
[   17.277524]  <TASK>
[   17.277824]  dump_stack_lvl+0xf3/0x140
[   17.278391]  ? __pfx_dump_stack_lvl+0x10/0x10
[   17.278949]  ? _printk+0xa7/0xf0
[   17.279381]  ? __virt_addr_valid+0x142/0x340
[   17.279919]  print_report+0x163/0x4d0
[   17.280381]  ? __virt_addr_valid+0x142/0x340
[   17.280882]  ? __virt_addr_valid+0x2d9/0x340
[   17.281286]  ? ext4_read_inline_data+0x19c/0x270
[   17.281720]  kasan_report+0x99/0xd0
[   17.282024]  ? ext4_read_inline_data+0x19c/0x270
[   17.282407]  kasan_check_range+0x16a/0x170
[   17.282686]  ? ext4_read_inline_data+0x19c/0x270
[   17.283364]  __asan_memcpy+0x25/0x70
[   17.283883]  ext4_read_inline_data+0x19c/0x270
[   17.284354]  ext4_convert_inline_data_nolock+0x15b/0x7c0
[   17.284893]  ? find_held_lock+0x41/0x1d0
[   17.285326]  ? ext4_convert_inline_data+0x2f6/0x4d0
[   17.285833]  ? __pfx_ext4_convert_inline_data_nolock+0x10/0x10
[   17.286390]  ? ext4_convert_inline_data+0x26b/0x4d0
[   17.286752]  ? __pfx_down_write+0x10/0x10
[   17.287037]  ? ext4_journal_check_start+0x5e/0x1c0
[   17.287342]  ? __ext4_journal_start_sb+0x288/0x420
[   17.287677]  ext4_convert_inline_data+0x3aa/0x4d0
[   17.288007]  ? __pfx_ext4_convert_inline_data+0x10/0x10
[   17.288373]  ? lock_is_held_type+0x91/0x130
[   17.288659]  ext4_fallocate+0xd0/0x1840
[   17.288927]  vfs_fallocate+0x380/0x4d0
[   17.289233]  ksys_fallocate+0x33/0x60
[   17.289532]  __x64_sys_fallocate+0x92/0xb0
[   17.289863]  do_syscall_64+0xb6/0x160
[   17.290170]  ? clear_bhb_loop+0x45/0xa0
[   17.290498]  ? clear_bhb_loop+0x45/0xa0
[   17.290828]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.291265] RIP: 0033:0x7806623d0c7d
[   17.291583] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 81 0d 00 f7 d8 64 89 01 48
[   17.294082] RSP: 002b:00007ffd763fc498 EFLAGS: 00000203 ORIG_RAX: 000000000000011d
[   17.294838] RAX: ffffffffffffffda RBX: 00007ffd763fc5d8 RCX: 00007806623d0c7d
[   17.295697] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
[   17.296665] RBP: 00007ffd763fc4c0 R08: 0000000000000000 R09: 0000000000000000
[   17.297621] R10: 0000000000008000 R11: 0000000000000203 R12: 0000000000000000
[   17.298364] R13: 00007ffd763fc5e8 R14: 00005af91214ecc8 R15: 0000780662518000
[   17.299062]  </TASK>

Calling ext4_xattr_ibody_find after reading the inode with
ext4_get_inode_loc will lead to a check of the validity of the xattrs,
avoiding this problem.

Reported-by: syzbot+f6a8aa7e307cf6ee835e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6a8aa7e307cf6ee835e
Fixes: 0c8d414f163f ("ext4: let fallocate handle inline data correctly")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/inline.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..401a224f0956 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -2022,9 +2022,15 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 
 int ext4_convert_inline_data(struct inode *inode)
 {
+	struct ext4_xattr_ibody_find is = {
+		.s = { .not_found = -ENODATA, },
+	};
+	struct ext4_xattr_info i = {
+		.name_index = EXT4_XATTR_INDEX_SYSTEM,
+		.name = EXT4_XATTR_SYSTEM_DATA,
+	};
 	int error, needed_blocks, no_expand;
 	handle_t *handle;
-	struct ext4_iloc iloc;
 
 	if (!ext4_has_inline_data(inode)) {
 		ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
@@ -2045,8 +2051,8 @@ int ext4_convert_inline_data(struct inode *inode)
 
 	needed_blocks = ext4_writepage_trans_blocks(inode);
 
-	iloc.bh = NULL;
-	error = ext4_get_inode_loc(inode, &iloc);
+	is.iloc.bh = NULL;
+	error = ext4_get_inode_loc(inode, &is.iloc);
 	if (error)
 		return error;
 
@@ -2057,11 +2063,17 @@ int ext4_convert_inline_data(struct inode *inode)
 	}
 
 	ext4_write_lock_xattr(inode, &no_expand);
+
+	error = ext4_xattr_ibody_find(inode, &i, &is);
+	if (error)
+		goto out_xattr;
+
 	if (ext4_has_inline_data(inode))
-		error = ext4_convert_inline_data_nolock(handle, inode, &iloc);
+		error = ext4_convert_inline_data_nolock(handle, inode, &is.iloc);
+out_xattr:
 	ext4_write_unlock_xattr(inode, &no_expand);
 	ext4_journal_stop(handle);
 out_free:
-	brelse(iloc.bh);
+	brelse(is.iloc.bh);
 	return error;
 }
-- 
2.34.1


