Return-Path: <linux-ext4+bounces-7077-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11140A7B90D
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 10:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CBC189EF7A
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Apr 2025 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0626D1A23AD;
	Fri,  4 Apr 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="nnhfEQeH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBFA19F462;
	Fri,  4 Apr 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755871; cv=none; b=e3f/PbhZPb4WCPi0FWFoVK3PJKsFqgRjvwwVGFdXH6HlyDh8MRwxvEVPA+EzRac/iO2TeaT73IQsRRwr/WZZhoRCLXUWJEiM48+GId74kkf4s+k/OxcgttCQ88HKBWexOkfKPL3Aysp6TST4vHtFx6YJ0Pk+mMUptb+L4tDcoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755871; c=relaxed/simple;
	bh=pLibqvIcw1SHorZ/STK72m6aN/tlhopq9FXsc2/2oGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5C19f6lKPmgs6Ag6fqZp1aMJHB54cTVfEpqpnKl1U5zegDams87TtYb9EUzM6nXsogwPFZBZrRx1ccwudcjtWttiSceeoeMrkLzf0QzwiBr54h/b6xoFNjD0I0kIVt3Khl9eGaN5ougK7JODt6rl8x3dMqQHFa4IX3UiIx1UQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=nnhfEQeH; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [5.181.23.154])
	by mail.ispras.ru (Postfix) with ESMTPSA id 319674487843;
	Fri,  4 Apr 2025 08:30:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 319674487843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1743755448;
	bh=ny7HwWXxKnGKVGDtPWStKsa49RNI8QK9Rh+xecVN+hU=;
	h=From:To:Cc:Subject:Date:From;
	b=nnhfEQeH+4iUZRxuAfxl4Ojn7z68V9h6+xvsGZJ2f8kq84KcpEOfgUpT686fwaBen
	 dhKonu5Drm4xz+26lYxDB5C55fSI2ly1NHcbLY3+CHwz8iWyTcoN2vJimR4SuCkHLM
	 Z6Ns/18LDvQnKQORNb7ZVtfDZWy+fQqBoke9Jtuc=
From: Artem Sadovnikov <a.sadovnikov@ispras.ru>
To: linux-ext4@vger.kernel.org
Cc: Artem Sadovnikov <a.sadovnikov@ispras.ru>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Eric Sandeen <sandeen@redhat.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ext4: fix off-by-one error in do_split
Date: Fri,  4 Apr 2025 08:28:05 +0000
Message-ID: <20250404082804.2567-3-a.sadovnikov@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller detected a use-after-free issue in ext4_insert_dentry that was
caused by out-of-bounds access due to incorrect splitting in do_split.

BUG: KASAN: use-after-free in ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
Write of size 251 at addr ffff888074572f14 by task syz-executor335/5847

CPU: 0 UID: 0 PID: 5847 Comm: syz-executor335 Not tainted 6.12.0-rc6-syzkaller-00318-ga9cda7c0ffed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
 add_dirent_to_buf+0x3d9/0x750 fs/ext4/namei.c:2154
 make_indexed_dir+0xf98/0x1600 fs/ext4/namei.c:2351
 ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2455
 ext4_add_nondir+0x8d/0x290 fs/ext4/namei.c:2796
 ext4_symlink+0x920/0xb50 fs/ext4/namei.c:3431
 vfs_symlink+0x137/0x2e0 fs/namei.c:4615
 do_symlinkat+0x222/0x3a0 fs/namei.c:4641
 __do_sys_symlink fs/namei.c:4662 [inline]
 __se_sys_symlink fs/namei.c:4660 [inline]
 __x64_sys_symlink+0x7a/0x90 fs/namei.c:4660
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

The following loop is located right above 'if' statement.

for (i = count-1; i >= 0; i--) {
	/* is more than half of this entry in 2nd half of the block? */
	if (size + map[i].size/2 > blocksize/2)
		break;
	size += map[i].size;
	move++;
}

'i' in this case could go down to -1, in which case sum of active entries
wouldn't exceed half the block size, but previous behaviour would also do
split in half if sum would exceed at the very last block, which in case of
having too many long name files in a single block could lead to
out-of-bounds access and following use-after-free.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Cc: stable@vger.kernel.org
Fixes: 5872331b3d91 ("ext4: fix potential negative array index in do_split()")
Signed-off-by: Artem Sadovnikov <a.sadovnikov@ispras.ru>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cb5cb33b1d91..e9712e64ec8f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1971,7 +1971,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	 * split it in half by count; each resulting block will have at least
 	 * half the space free.
 	 */
-	if (i > 0)
+	if (i >= 0)
 		split = count - move;
 	else
 		split = count/2;
-- 
2.43.0


