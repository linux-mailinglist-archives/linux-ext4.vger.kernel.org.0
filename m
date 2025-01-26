Return-Path: <linux-ext4+bounces-6236-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D01A1C6A0
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 08:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5FC3A66E3
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67C419D083;
	Sun, 26 Jan 2025 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwXfhOVY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED790199935;
	Sun, 26 Jan 2025 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737876392; cv=none; b=mBVXzNtxYY0rgMsgr+kcnq6Xf6DdzRZ89S5bl9m8IOVuyENeh+Vsk5vZosU3cGoR3kv1HeJPuguqV9aKfC+5q1TzZkXoAWM6Vq0Uv2L3wDaQ+l2PLvRjh9MB+3QdpNNwXeii8bk5csVOtBaXqwHIifCOaguGxnIbq9XPACQPSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737876392; c=relaxed/simple;
	bh=NyRI9Satwu4DQJH+8IfZu6r0UeUiVWZIi2bjDu2lW2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCwOgWFL/6sOf2CK/TDzgTOZ0DlRfq7hQwtPWSqFUOAfGUabLFDm9OVxPm+6O5Pvt/4Q6Il0d+PlWvxkmPH+oxNCfI9JMHxWaYK7PDfHXXeBWqkDEuXB6u50p9viiEyMb9Sgi1F6gtTq5EMCtq+0fZmGEH+0Gj0uJuaNNbeksdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwXfhOVY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163dc5155fso60302915ad.0;
        Sat, 25 Jan 2025 23:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737876390; x=1738481190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFI0HaY8q73gv6QwNnnXtgPC3k8vf0PbOjWX90oh3Ew=;
        b=kwXfhOVY5thwQo7D+37Lxo3vdgpmfFISYFxLJEhX7j4MEfNpGUvPFDVVA5aC5PPDP4
         5yBSVhiFY+FOrCMUuiUoPqTN3blP7AJGb1xkZNbxGfl5AktYYh9f3HiRoQVf8PaaS1Ty
         mbpUup/LvhTJEuLhMkB7wSA3PiJGurpgc6CFZVFLQl2fnZqB/+veiC/zuyGldjTGbtWq
         7f+flAoBUt2qV70eBMHhdMtZIvnBmVsdFUo3MhOdl9cmpwKJAqFQe62TCzDFTJ+Tca/P
         dEQSTE+P44rm4bLDYmxK/ISUQX97eic5yw7eFkQbICJN/nZfDGltlCqKbRLkKjhNKozR
         4rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737876390; x=1738481190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFI0HaY8q73gv6QwNnnXtgPC3k8vf0PbOjWX90oh3Ew=;
        b=QU9mZizzuNouQ7Bi43RUuo6ZWjFbBkqw1QN5BWhMDeeMm8d2H4mLQOBzSUTHc22l7p
         Axs1Vax2CxVFceM9wSAcXOGPwqy3saxAyA3kG8kjX52cUmRNse+KaYcX5mogtevKD3FI
         snZBT/3ArQmNOe36DZAodJvN2Q/Gb+Ce5VX6fTJSGdFcHWrAO3XiIp6PI8Lzxl2IF1j1
         BOd5Ayv2euTLXAqyICNHVTVFegnQ4gsSR0Hp9/D3GBjFuXg2Cq9fL2/8Gu28fB9IxCZX
         tmUuwl32xaRrvpWKVJhJVKlQRcRE+ChA0tGCESOKhtl6dmjRQq5pK22MCI+o/Zztr0Ge
         ikLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7n57+27k5ato+xDqSugxVIfwkln4J406TGdhUnN0NjuGcR8a6vVF+WQJrp+1vN8IdGT6Gb8PhcuCu@vger.kernel.org, AJvYcCXfYC/QY8dnnvMmkBO3AAlRNRmN6WrhIukvksy3NBwdOM9C+OCe899/CGfOOKbaH50cYTktHy1mt8K8WXxn@vger.kernel.org
X-Gm-Message-State: AOJu0YyToiu8J8994whdujmGznZYx6T1rDZfhtojUgchcnQKLQ4olda5
	eX1vwo8FxwWjCcnwCfUqRHZt6xjSMIEm7N/o1TLzHV3QDV/9dppprvFn2nxz
X-Gm-Gg: ASbGncuzHQAyxKpvcpSFlC8/GP+vGxJKVs+Qk8YgVWAXJ4NcGudY4/+rzDQESlJWg+Z
	0aplNgineTpFxH/h/vr2wmpPMw0mdDcTtTbEy4mJdMz5AkCjereWowWfaHnv3kVSw/U0Hlx6tR5
	eXvPyKcYJ5wG4g3SMkgqWA0VVI7lef9pg3Q4QFgBmKS26NhyzhWw8pa1aT/Vcgrs0PdBnYpnPzQ
	xFpVbPpICyqSqhZ65TlDwRVCA8TeMDpZRK4y3LdGWEkVUvwbqBd7wB1ZuLNMRtBtDT4ieOfmJpa
	Cj2NeWb6DHTzturIifYsxDFXzRsi
X-Google-Smtp-Source: AGHT+IHWPwQzogsNSXBVIXjCZN69QYpzzS/w7TRxE9yb6ZQtXD/7HhfNnYiRm8XxIUmD11zSTcGaAA==
X-Received: by 2002:a17:903:1ce:b0:216:4a06:e87a with SMTP id d9443c01a7336-21c355dc64bmr580552455ad.40.1737876389737;
        Sat, 25 Jan 2025 23:26:29 -0800 (PST)
Received: from jren-d3.localdomain ([221.222.59.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c605sm41804905ad.41.2025.01.25.23.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 23:26:29 -0800 (PST)
From: Imkanmod Khan <imkanmodkhan@gmail.com>
To: stable@vger.kernel.org
Cc: luis.henriques@linux.dev,
	tytso@mit.edu,
	patches@lists.linux.dev,
	gregkh@linuxfoundation.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Imkanmod Khan <imkanmodkhan@gmail.com>
Subject: [PATCH 6.6.y] ext4: fix access to uninitialised lock in fc replay path
Date: Sun, 26 Jan 2025 15:26:20 +0800
Message-ID: <20250126072620.8474-1-imkanmodkhan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>

[ commit 23dfdb56581ad92a9967bcd720c8c23356af74c1 upstream ]

The following kernel trace can be triggered with fstest generic/629 when
executed against a filesystem with fast-commit feature enabled:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 866 Comm: mount Not tainted 6.10.0+ #11
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0x90
 register_lock_class+0x759/0x7d0
 __lock_acquire+0x85/0x2630
 ? __find_get_block+0xb4/0x380
 lock_acquire+0xd1/0x2d0
 ? __ext4_journal_get_write_access+0xd5/0x160
 _raw_spin_lock+0x33/0x40
 ? __ext4_journal_get_write_access+0xd5/0x160
 __ext4_journal_get_write_access+0xd5/0x160
 ext4_reserve_inode_write+0x61/0xb0
 __ext4_mark_inode_dirty+0x79/0x270
 ? ext4_ext_replay_set_iblocks+0x2f8/0x450
 ext4_ext_replay_set_iblocks+0x330/0x450
 ext4_fc_replay+0x14c8/0x1540
 ? jread+0x88/0x2e0
 ? rcu_is_watching+0x11/0x40
 do_one_pass+0x447/0xd00
 jbd2_journal_recover+0x139/0x1b0
 jbd2_journal_load+0x96/0x390
 ext4_load_and_init_journal+0x253/0xd40
 ext4_fill_super+0x2cc6/0x3180
...

In the replay path there's an attempt to lock sbi->s_bdev_wb_lock in
function ext4_check_bdev_write_error().  Unfortunately, at this point this
spinlock has not been initialized yet.  Moving it's initialization to an
earlier point in __ext4_fill_super() fixes this splat.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
Link: https://patch.msgid.link/20240718094356.7863-1-luis.henriques@linux.dev
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 71ced0ada9a2..f019ce64eba4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5366,6 +5366,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
 
+	spin_lock_init(&sbi->s_bdev_wb_lock);
+
 	ext4_fast_commit_init(sb);
 
 	sb->s_root = NULL;
@@ -5586,7 +5588,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * Save the original bdev mapping's wb_err value which could be
 	 * used to detect the metadata async write error.
 	 */
-	spin_lock_init(&sbi->s_bdev_wb_lock);
 	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
-- 
2.25.1


