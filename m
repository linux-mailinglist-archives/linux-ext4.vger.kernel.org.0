Return-Path: <linux-ext4+bounces-11430-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FABC3056B
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 10:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2753B372F
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487730F531;
	Tue,  4 Nov 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="L+JxY2Uy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858E2C21D0
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249296; cv=none; b=uU/a24yOptoUyVt6ih+T5AVanCZ7DV7y/cunLDqlLm5tUBugU0AoJngLV45J+wSVzmMx92OeYHfftv5TGubbpY65ER44O6qxS8meOlbbIznP1XAfkh+YIpI37lJwTJSDzaP6uWJ+ZFxP1i7K1WeWzK3SJYVxiJFI2DwlpodJgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249296; c=relaxed/simple;
	bh=6mU0p+TvpkQfXPQZt2LO+UR175MeG0UZZ64X4x+p4MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvdedhj1ii76RSplp3SjBB6Tj4PdtUtmZ7uCI9djFRre5cU6SX9YXqEOuh/mHabftBGhhlQ82Puflvg1+0BT89hGclI1siN3/4KGtgPArjy/eJ1pGqCoS0SS4iJNuR8uK6rdxc5jceV9n+eQITjHVpQlX+cbdNQZtsWuHTR74Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=L+JxY2Uy; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 779CB1C0EBA
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 12:33:35 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1762248813; x=
	1763112814; bh=6mU0p+TvpkQfXPQZt2LO+UR175MeG0UZZ64X4x+p4MA=; b=L
	+JxY2UyySanGUaSXnKRWefto4fu0/jGwX1/HshRjjPyOtebKvvexvdmKCOE//4xJ
	90OjycrkWmzccta6cfEVFoSEYPKGAU24H9igzRhGpOoycC44trJV4SsOtd4l6ntf
	zTxmdxleA9czDPUvs3IKnpZ0/5Ky8GfVmgBU8EZM1g=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YGDv8rpDwLUN for <linux-ext4@vger.kernel.org>;
	Tue,  4 Nov 2025 12:33:33 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id BD4001C0E8F;
	Tue,  4 Nov 2025 12:33:32 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH RFC] ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()
Date: Tue,  4 Nov 2025 09:33:25 +0000
Message-ID: <20251104093326.697381-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a race between inline data destruction and block mapping.

The function ext4_destroy_inline_data_nolock() changes the inode data
layout by clearing EXT4_INODE_INLINE_DATA and setting EXT4_INODE_EXTENTS.
At the same time, another thread may execute ext4_map_blocks(), which
tests EXT4_INODE_EXTENTS to decide whether to call ext4_ext_map_blocks()
or ext4_ind_map_blocks().

Without i_data_sem protection, ext4_ind_map_blocks() may receive inode
with EXT4_INODE_EXTENTS flag and triggering assert.

kernel BUG at fs/ext4/indirect.c:546!
EXT4-fs (loop2): unmounting filesystem.
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:ext4_ind_map_blocks.cold+0x2b/0x5a fs/ext4/indirect.c:546

Call Trace:
 <TASK>
 ext4_map_blocks+0xb9b/0x16f0 fs/ext4/inode.c:681
 _ext4_get_block+0x242/0x590 fs/ext4/inode.c:822
 ext4_block_write_begin+0x48b/0x12c0 fs/ext4/inode.c:1124
 ext4_write_begin+0x598/0xef0 fs/ext4/inode.c:1255
 ext4_da_write_begin+0x21e/0x9c0 fs/ext4/inode.c:3000
 generic_perform_write+0x259/0x5d0 mm/filemap.c:3846
 ext4_buffered_write_iter+0x15b/0x470 fs/ext4/file.c:285
 ext4_file_write_iter+0x8e0/0x17f0 fs/ext4/file.c:679
 call_write_iter include/linux/fs.h:2271 [inline]
 do_iter_readv_writev+0x212/0x3c0 fs/read_write.c:735
 do_iter_write+0x186/0x710 fs/read_write.c:861
 vfs_iter_write+0x70/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x73b/0xc90 fs/splice.c:685
 do_splice_from fs/splice.c:763 [inline]
 direct_splice_actor+0x10f/0x170 fs/splice.c:950
 splice_direct_to_actor+0x33a/0xa10 fs/splice.c:896
 do_splice_direct+0x1a9/0x280 fs/splice.c:1002
 do_sendfile+0xb13/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1cf/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Fixes: c755e251357a ("ext4: fix deadlock between inline_data and ext4_expand_extra_isize_ea()")
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 fs/ext4/inline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..ef7821f7fd26 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -446,9 +446,13 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 	if (!ei->i_inline_off)
 		return 0;
 
+	down_write(&ei->i_data_sem);
+
 	error = ext4_get_inode_loc(inode, &is.iloc);
-	if (error)
+	if (error) {
+		up_write(&ei->i_data_sem);
 		return error;
+	}
 
 	error = ext4_xattr_ibody_find(inode, &i, &is);
 	if (error)
@@ -487,6 +491,7 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 	brelse(is.iloc.bh);
 	if (error == -ENODATA)
 		error = 0;
+	up_write(&ei->i_data_sem);
 	return error;
 }
 
-- 
2.43.0


