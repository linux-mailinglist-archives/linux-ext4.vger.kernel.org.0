Return-Path: <linux-ext4+bounces-3191-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC06192E13D
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 09:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EB2B2148A
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 07:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0067A15381C;
	Thu, 11 Jul 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U0rpWiAW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB13150997;
	Thu, 11 Jul 2024 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684190; cv=none; b=RI2S8Yw34hD0zmQ8iak4HzHIwj75KO63gjiNILa065aDHUnb/qB163O26txoU2rDwmwGmM3IzUP8oucV3X0mv3LFVFjYGZmHx+L+x+M6v6/Czebk0y+GH7NpAY6+hVUfknFusQ/pLFd5obegVI2gkDiaya8NuGjIEluZsuEpeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684190; c=relaxed/simple;
	bh=s4t6ohU0MtcRBXarNqAE1eNK8YuDB//6S6YolUZvKX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1pdwiYppUL2mCjRyrtcuv2aZmSTI5wSUAlDbu2hPaxx0Ix0bgqSkXCnLJau8XAwP55jgE2JR9lrjHzB9kwdWmtVjA230N/aaZtsWgODY8Fe+NjM6A7ad4M2DK9BSttrUH2COLg3Y4U0lTs3cu8C4kOR14hgmGPH9ZKVMvY2LBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U0rpWiAW; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720684187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mvI9A8h/Y5bWS/0nnv7dns2BHflaYgKGDmzquHt/oQs=;
	b=U0rpWiAWEUzjZS2+HWWLA903HnIPzwMLBJvJWmYhEPS0mPj8TQrwz9ld5INtXG0BqBCWnh
	Bm7XYNoSGhKEh3/eZHW/CSN7dDFoUMD6y6afKhy7RPuu0QADwODeT9/CRKNdkWUJ7iiBoa
	m17x3Jq8dEX2SUUzarB0aP2nOxGRAH0=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: clm@fb.com
X-Envelope-To: josef@toxicpanda.com
X-Envelope-To: dsterba@suse.com
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger.kernel@dilger.ca
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-btrfs@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 3/3] fs: Add {init, exit}_sequence_fs() helper functions
Date: Thu, 11 Jul 2024 15:48:59 +0800
Message-Id: <20240711074859.366088-4-youling.tang@linux.dev>
In-Reply-To: <20240711074859.366088-1-youling.tang@linux.dev>
References: <20240711074859.366088-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

In theory init_sequence_fs() and exit_sequence_fs() should match their
sequence, thus normally they should look like this:
    init_sequence_fs()   |   exit_sequence_fs()
-------------------------+------------------------
    init_A();            |
    init_B();            |
    init_C();            |
                         |   exit_C();
                         |   exit_B();
                         |   exit_A();

Providing {init, exit}_sequence_fs() helps functions ensure that modules
init/exit match their order, while also simplifying the code.

For more details see commit 5565b8e0adcd ("btrfs: make module init/exit
match their sequence").

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/btrfs/super.c   | 36 ++----------------------------------
 fs/ext4/super.c    | 41 ++---------------------------------------
 fs/f2fs/super.c    | 36 ++----------------------------------
 include/linux/fs.h | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 107 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f05cce7c8b8d..1101991a9a63 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2478,13 +2478,6 @@ static void unregister_btrfs(void)
 	unregister_filesystem(&btrfs_fs_type);
 }
 
-/* Helper structure for long init/exit functions. */
-struct init_sequence {
-	int (*init_func)(void);
-	/* Can be NULL if the init_func doesn't need cleanup. */
-	void (*exit_func)(void);
-};
-
 static const struct init_sequence mod_init_seq[] = {
 	{
 		.init_func = btrfs_props_init,
@@ -2551,40 +2544,15 @@ static const struct init_sequence mod_init_seq[] = {
 
 static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
 
-static __always_inline void btrfs_exit_btrfs_fs(void)
-{
-	int i;
-
-	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
-		if (!mod_init_result[i])
-			continue;
-		if (mod_init_seq[i].exit_func)
-			mod_init_seq[i].exit_func();
-		mod_init_result[i] = false;
-	}
-}
-
 static void __exit exit_btrfs_fs(void)
 {
-	btrfs_exit_btrfs_fs();
+	exit_sequence_fs(mod_init_seq, mod_init_result, ARRAY_SIZE(mod_init_seq));
 	btrfs_cleanup_fs_uuids();
 }
 
 static int __init init_btrfs_fs(void)
 {
-	int ret;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mod_init_seq); i++) {
-		ASSERT(!mod_init_result[i]);
-		ret = mod_init_seq[i].init_func();
-		if (ret < 0) {
-			btrfs_exit_btrfs_fs();
-			return ret;
-		}
-		mod_init_result[i] = true;
-	}
-	return 0;
+	return init_sequence_fs(mod_init_seq, mod_init_result, ARRAY_SIZE(mod_init_seq));
 }
 
 late_initcall(init_btrfs_fs);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ec1e63facb10..cb5b7449c80b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7328,13 +7328,6 @@ static void unregister_ext(void)
 	unregister_filesystem(&ext4_fs_type);
 }
 
-/* Helper structure for long init/exit functions. */
-struct init_sequence {
-	int (*init_func)(void);
-	/* Can be NULL if the init_func doesn't need cleanup. */
-	void (*exit_func)(void);
-};
-
 static const struct init_sequence mod_init_seq[] = {
 	{
 		.init_func = ext4_init_es,
@@ -7371,40 +7364,10 @@ static const struct init_sequence mod_init_seq[] = {
 
 static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
 
-static __always_inline void ext4_exit_ext4_fs(void)
-{
-	int i;
-
-	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
-		if (!mod_init_result[i])
-			continue;
-		if (mod_init_seq[i].exit_func)
-			mod_init_seq[i].exit_func();
-		mod_init_result[i] = false;
-	}
-}
-
 static void __exit ext4_exit_fs(void)
 {
 	ext4_destroy_lazyinit_thread();
-	ext4_exit_ext4_fs();
-}
-
-static __always_inline int ext4_init_ext4_fs(void)
-{
-	int ret;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mod_init_seq); i++) {
-		ASSERT(!mod_init_result[i]);
-		ret = mod_init_seq[i].init_func();
-		if (ret < 0) {
-			ext4_exit_ext4_fs();
-			return ret;
-		}
-		mod_init_result[i] = true;
-	}
-	return 0;
+	exit_sequence_fs(mod_init_seq, mod_init_result, ARRAY_SIZE(mod_init_seq));
 }
 
 /* Shared across all ext4 file systems */
@@ -7421,7 +7384,7 @@ static int __init ext4_init_fs(void)
 	for (int i = 0; i < EXT4_WQ_HASH_SZ; i++)
 		init_waitqueue_head(&ext4__ioend_wq[i]);
 
-	return ext4_init_ext4_fs();
+	return init_sequence_fs(mod_init_seq, mod_init_result, ARRAY_SIZE(mod_init_seq));
 }
 
 MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 19509942b837..b4be24865ab3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4950,13 +4950,6 @@ static void unregister_f2fs(void)
 	unregister_filesystem(&f2fs_fs_type);
 }
 
-/* Helper structure for long init/exit functions. */
-struct init_sequence {
-	int (*init_func)(void);
-	/* Can be NULL if the init_func doesn't need cleanup. */
-	void (*exit_func)(void);
-};
-
 static const struct init_sequence mod_init_seq[] = {
 	{
 		.init_func = init_inodecache,
@@ -5017,39 +5010,14 @@ static const struct init_sequence mod_init_seq[] = {
 
 static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
 
-static __always_inline void f2fs_exit_f2fs_fs(void)
-{
-	int i;
-
-	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
-		if (!mod_init_result[i])
-			continue;
-		if (mod_init_seq[i].exit_func)
-			mod_init_seq[i].exit_func();
-		mod_init_result[i] = false;
-	}
-}
-
 static void __exit exit_f2fs_fs(void)
 {
-	f2fs_exit_f2fs_fs();
+	exit_sequence_fs(mod_init_seq, mod_init_result, ARRAY_SIZE(mod_init_seq));
 }
 
 static int __init init_f2fs_fs(void)
 {
-	int ret;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mod_init_seq); i++) {
-		BUG_ON(mod_init_result[i]);
-		ret = mod_init_seq[i].init_func();
-		if (ret < 0) {
-			f2fs_exit_f2fs_fs();
-			return ret;
-		}
-		mod_init_result[i] = true;
-	}
-	return 0;
+	return init_sequence_fs(mod_init_seq, mod_init_result, ARRAY_SIZE(mod_init_seq));
 }
 
 module_init(init_f2fs_fs)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0283cf366c2a..b173194b7f14 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2598,6 +2598,44 @@ extern void iput(struct inode *);
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);
 
+/* Helper structure for long init/exit functions. */
+struct init_sequence {
+	int (*init_func)(void);
+	/* Can be NULL if the init_func doesn't need cleanup. */
+	void (*exit_func)(void);
+};
+
+static __always_inline void exit_sequence_fs(const struct init_sequence *mod_init_seq,
+					     bool *mod_init_result, int num)
+{
+	int i;
+
+	for (i = num - 1; i >= 0; i--) {
+		if (!mod_init_result[i])
+			continue;
+		if (mod_init_seq[i].exit_func)
+			mod_init_seq[i].exit_func();
+		mod_init_result[i] = false;
+	}
+}
+
+static __always_inline int init_sequence_fs(const struct init_sequence *mod_init_seq,
+					    bool *mod_init_result, int num)
+{
+	int ret, i;
+
+	for (i = 0; i < num; i++) {
+		BUG_ON(mod_init_result[i]);
+		ret = mod_init_seq[i].init_func();
+		if (ret < 0) {
+			exit_sequence_fs(mod_init_seq, mod_init_result, num);
+			return ret;
+		}
+		mod_init_result[i] = true;
+	}
+	return 0;
+}
+
 /* /sys/fs */
 extern struct kobject *fs_kobj;
 
-- 
2.34.1


