Return-Path: <linux-ext4+bounces-6235-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E73A1C68C
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 08:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A1A166FAC
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 07:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203D154C1D;
	Sun, 26 Jan 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3uaE59g"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE817082F;
	Sun, 26 Jan 2025 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737875196; cv=none; b=IH3cfpDvZkXMjSjaUDW+7ZdvGyp2ttdY8SSDRSwRSEiSba+gezt6pOC7+0sLwAshM6Q4D+yCLtuFZPDOKc1vK2sH6G2/lpVjqC143xQd2ZTC459oSL3NZQ+UdpoJk03j6EK6n3LnFh0Z41sIHWA0T3TA1LUEg9hKb98MFUhNkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737875196; c=relaxed/simple;
	bh=DokAvFMYHvCS7wwzqg/QbP3GSVrjtUU72Ulg1mCoC+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnb5ymcb6sjdedlZpnvB6Vem+wwTyIv6qaAvA39k071UdUTZc5XxAGSBLb0E8edJptiSzqFhp2ggnVERarv1xnzbFJAht5Udi2s09c1BmteRXUYxq9ESBWimfUHqP3CmBgl17HlCQZ1cPbBEVVvWAGU3UTJIXwyLA6uYjeuGArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3uaE59g; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso4606694a91.2;
        Sat, 25 Jan 2025 23:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737875194; x=1738479994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp7vJlctohKjGrnhTeUGmb5s8Xd2NGxP7ChmuU+0czI=;
        b=I3uaE59gGNVL+WJAEL/yIGGR4gF8WfBIAHVA5xQnjHCp/QFX0QYoHQFcGhHwuSQ2cA
         JCHlwg8BCObUVILqMbgEOpkcg2GkI7ve22a9AW6MpmYq04LTSUz4ZG6SjwvBVtc1ZvBd
         stXHGcAXzXk/rf8nE2+d/I1IOYVHpQlLoSzTnQ5h/Fs+N+niDrDo1pzXfmi9mpYRas9j
         ytINNv/oyjrQTnLnjrlVnJKB+7F0dc/ozPaDtgtnaAFTeisKkW3UF0gvhdLgKQMRct+/
         FvrEP4W76xwO8/yFgGlcrWTRmPKsbTb0TA7n+BJww2W2UnD1g+FJNK+N/FCH07H36qEI
         27/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737875194; x=1738479994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp7vJlctohKjGrnhTeUGmb5s8Xd2NGxP7ChmuU+0czI=;
        b=YrS48WXHe0SVarZkBeGJYwmXk12d/hV4Q0uWffxND2msaJ6L5IoUZiPv1kfXYJ1C4q
         zlVMw7yVPHcab+tx67VJOPiBGDNELIhVAXIF3FhgbNA0bHEhvuEgmy4NqZbRhVEGJCeo
         EW7dbRaernN1/lYXetl2/NLD2KMnph6EYkYNO/1NUFRusz52VokGfUguVJdmsY+nFj3g
         6+pQ7bs6uHYpkz3swvkRtJaXWzapVLzH81Rpegb710yQa6bkM3PVz8Acpfx58BHFANWn
         /ODz1XZtw2Ckq1YzBCv5lT3vSt/XFX+Q+Gxvr/Hf+bD4hk7PZ+Fl/2IeudpSK+E+lhDl
         DMtA==
X-Forwarded-Encrypted: i=1; AJvYcCUDw1zFsYiOIXq9NuUvARp0RxwD6S1VbQYrDPc0Q2PB5u27ScrnwJpG1ThY7ZBVST8DoQqVazuk4Or4@vger.kernel.org, AJvYcCUNjBT3jUMSDCm6trdhYMOuAAZ9guJtWN+9zrHkNWlvNd823AJZmJjVIpsAMhX4dyvZ6YBUqEckxT67Spap@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cFESPOryu/N+NJdJPVVuXOgMyep8kwlX1l2Nnqp78VSp0V3l
	H6OzL1lzBdv9TzX28Y8tvqmhoRuC8QC8nbeEqLpN64g54NR8hXLIVGCn0cOT
X-Gm-Gg: ASbGncs4nM8M2gvA0q706qS3fsgSiCnJ8TLfJlkVd7aJnQ8f1aa+cFCbXk5jxJ9ravB
	Of/55Eh8QM9TR3QoRLLgYJcs2TM55JYP4zH7yVK9RUkGWlIzU9YWMHSWwWfrTfi1PgZTEtPMHqj
	vMZxlu5Oan96Rb0ja+QXUeZAILhdeyrDhSOkXLjsqPQ6zN6wAcYmP/8vR/YRmr1TweDd7oLd1Q2
	HA29atrJUj+7ymzORsOMy8JnJ1IAlQY7Skcf4PIRraI2C4nxkm9OrdInFD7+gqwjzEaczZORnQu
	liRjkDQcS0arrvz2gEi9nGNMxr1v
X-Google-Smtp-Source: AGHT+IGVUgql88xL7lvmloKC6GraKhyom+fznIVGV33PTFWKzYWPbpAU52q//gQzVZ77A8dSRI3eyw==
X-Received: by 2002:a17:90b:280e:b0:2ee:7c65:ae8e with SMTP id 98e67ed59e1d1-2f782c700c6mr52588232a91.11.1737875193857;
        Sat, 25 Jan 2025 23:06:33 -0800 (PST)
Received: from jren-d3.localdomain ([221.222.59.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa77043sm5209527a91.35.2025.01.25.23.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 23:06:32 -0800 (PST)
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
Subject: [PATCH 6.1.y] ext4: fix access to uninitialised lock in fc replay path
Date: Sun, 26 Jan 2025 15:06:20 +0800
Message-ID: <20250126070620.8071-1-imkanmodkhan@gmail.com>
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
index 0b2591c07166..53f1deb049ec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5264,6 +5264,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
 
+	spin_lock_init(&sbi->s_bdev_wb_lock);
+
 	ext4_fast_commit_init(sb);
 
 	sb->s_root = NULL;
@@ -5514,7 +5516,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * Save the original bdev mapping's wb_err value which could be
 	 * used to detect the metadata async write error.
 	 */
-	spin_lock_init(&sbi->s_bdev_wb_lock);
 	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	sb->s_bdev->bd_super = sb;
-- 
2.25.1


