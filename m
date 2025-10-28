Return-Path: <linux-ext4+bounces-11112-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D260FC14C73
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 14:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1769F4F2199
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AE3314BC;
	Tue, 28 Oct 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="F2ypRzLO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA730C600;
	Tue, 28 Oct 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657031; cv=none; b=bfHns12PbIR/dpWYnK7Xsqr8RHYyfaPoHXOokcomAfzMCvxot92jBMzfQjYWKruxbPS0kSKp4VEgUz+DRZ5cNhDayKmupA8ziG9BF51J41OIzQABhnyh/NsRByYUg0/jg1N7L6JgIgMKIdvmDOUHhXBPjGQQ2x97TfYKKolBqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657031; c=relaxed/simple;
	bh=5AcqVujVKBPgf69fTtFsxf65JIeizyTHqi10Ci/8OCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZjmzfClJRamSeUTlyM7Bh6PjXBy/teohvT/Qqx99sVBgpqzkMQfqaJGWfUNwLdiEmB8AV7QtmqmPN75NQbsnjv5HzCTiUrRnM+A0v2TqQm5u0/u/qaauoIbQjG8uGa3L8Rz58WzDWpd1V6OSgbJlGDZah+wwCRpz1ZU8gWBJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=F2ypRzLO; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.13])
	by mail.ispras.ru (Postfix) with ESMTPSA id 833FB40D3C55;
	Tue, 28 Oct 2025 13:10:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 833FB40D3C55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761657019;
	bh=tlkcOsH3XzAfIdHxh1tv8lnDx92rtQpnwREuXOUdXXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2ypRzLOg/9SplRY0ZvqzYZvrXx12WVoCs45+mVjFvu/NVtPQlYWppASHGztKW2Gq
	 hnVH2H749E0bP0zQuuKsG5z9pj4zMxQAajiCnFOkUZoVzC8pnHqTK1U7G+Jk8+C1gS
	 InZN9mTfQouQRONG/rhwbshSI744WX7RfE5C4/es=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ext4: fix string copying in parse_apply_sb_mount_options()
Date: Tue, 28 Oct 2025 16:09:48 +0300
Message-ID: <20251028130949.599847-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028130949.599847-1-pchelkin@ispras.ru>
References: <20251028130949.599847-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strscpy_pad() can't be used to copy a possibly non-NUL-term string into a
NUL-term string.  Commit 0efc5990bca5 ("string.h: Introduce memtostr() and
memtostr_pad()") provides additional information in that regard.  So if
this happens, the following warning is observed:

strnlen: detected buffer overflow: 65 byte read of buffer size 64
WARNING: CPU: 0 PID: 28655 at lib/string_helpers.c:1032 __fortify_report+0x96/0xc0 lib/string_helpers.c:1032
Modules linked in:
CPU: 0 UID: 0 PID: 28655 Comm: syz-executor.3 Not tainted 6.12.54-syzkaller-00144-g5f0270f1ba00 #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__fortify_report+0x96/0xc0 lib/string_helpers.c:1032
Call Trace:
 <TASK>
 __fortify_panic+0x1f/0x30 lib/string_helpers.c:1039
 strnlen include/linux/fortify-string.h:235 [inline]
 sized_strscpy include/linux/fortify-string.h:309 [inline]
 parse_apply_sb_mount_options fs/ext4/super.c:2504 [inline]
 __ext4_fill_super fs/ext4/super.c:5261 [inline]
 ext4_fill_super+0x3c35/0xad00 fs/ext4/super.c:5706
 get_tree_bdev_flags+0x387/0x620 fs/super.c:1636
 vfs_get_tree+0x93/0x380 fs/super.c:1814
 do_new_mount fs/namespace.c:3553 [inline]
 path_mount+0x6ae/0x1f70 fs/namespace.c:3880
 do_mount fs/namespace.c:3893 [inline]
 __do_sys_mount fs/namespace.c:4103 [inline]
 __se_sys_mount fs/namespace.c:4080 [inline]
 __x64_sys_mount+0x280/0x300 fs/namespace.c:4080
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x64/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Since s_es->s_mount_opts might be non-NUL-term, annotate it with
__nonstring and use the proper memtostr_pad() routine to get its NULL-term
copy.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 8ecb790ea8c3 ("ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 fs/ext4/ext4.h  | 2 +-
 fs/ext4/super.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 57087da6c7be..4c8698316457 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1429,7 +1429,7 @@ struct ext4_super_block {
 	__le64	s_last_error_block;	/* block involved of last error */
 	__u8	s_last_error_func[32] __nonstring;	/* function where the error happened */
 #define EXT4_S_ERR_END offsetof(struct ext4_super_block, s_mount_opts)
-	__u8	s_mount_opts[64];
+	__u8	s_mount_opts[64] __nonstring;
 	__le32	s_usr_quota_inum;	/* inode for tracking user quota */
 	__le32	s_grp_quota_inum;	/* inode for tracking group quota */
 	__le32	s_overhead_clusters;	/* overhead blocks/clusters in fs */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 33e7c08c9529..57df129873e3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2483,7 +2483,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
+	memtostr_pad(s_mount_opts, sbi->s_es->s_mount_opts);
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-- 
2.51.0


