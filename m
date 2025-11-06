Return-Path: <linux-ext4+bounces-11537-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA9C3D002
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 19:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8D43BF5F7
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 18:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F1350D66;
	Thu,  6 Nov 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXEtAkGs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A734FF5C
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452079; cv=none; b=eU7Om8zJ4PekooLaaxybDhqSqvyucGdrOPU81kzCyDRruj+xWXSceEGpKPOF7graT+TNS5eEXrlCWzSCAgo0vIrKGPxfqNxJRl2Wm/FvLedEDU1GqsvLXoy8RUBKyDCAO2MPWOYnOO92kHDjDrvS2OQzbyI4hkhnsrYKzjiYNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452079; c=relaxed/simple;
	bh=ecKx94Uloyw5Ypg7LHJi/wxlymzsTKHjuBzKSBg9xEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fak7ZKxyR3LocgvTU8wcYqueTsIfel0tnnZqfdM7zVEi6dVlAc/dubslZMcsbf2TsmMllN/kLc2kHQ1KZX/iUoNBKH/G9YnGdgb7FLYVFkrmvbwkDktqd9KKucGBung6XqOcdnPpZFSqlHyGMauoxp+7TCd4uWfLAmP975zUlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXEtAkGs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b719ca8cb8dso268297466b.0
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452075; x=1763056875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rM5YuHXRVa3PD4FJFdTxSM6sbhjSzqRHVaQqfGflXZM=;
        b=cXEtAkGsAMSpPV0eqxFPKAklkaT1xQOUfrnbecZluVxpVDLgHWVdA1yDX3GNSP6TyG
         /wU8aLnLQFrxKZF0fucd+VCCFsgdxQSBjkAKdiHBwUDTUcDg/YDWDrRO6740rEs7tBrl
         opNnuGdHVHdWvEIMR0P8kkzDU7gW2XebRcOgD3KN93ZphfxVFJIh2Kiox+/ZwRJriXiG
         IGNG8Druwc3ypXVQ8eOqbXxH8K1cE2U+NLHvnmC0jxtO65zIo8Zjd3sxobpnprzRU3ed
         pLZykLeM4eMzVqZBYVoX0Af6FTsb91Btk0dNfafWy17bJssZCom6V8M3XWMbdkfBuCP1
         uYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452075; x=1763056875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rM5YuHXRVa3PD4FJFdTxSM6sbhjSzqRHVaQqfGflXZM=;
        b=VX2NgFDYf7PY2QP6rhay8r/008JJPj4pXu0bDbSe8js2cYuIEIEFH4QvxFwUh+eetQ
         LdPDVKAZ0eDe57QE7RhF5iSqxXOlnyP49LqM1s1IjyKLbhHWdP5AL7dXxq9Nrj2FfuJ3
         kra5ZSheXwcjadtA3konYohYtibEBOQ5LNZVrD8cDqL3R/fIrPHBSUi2uKXgP+4S1WgP
         0K1+I2YYpa5lWBextM4ehZKQ5ICpxxHmQBT9vZwBdawdScLFzYll+2LNLPhRS/4LatrE
         cMfgo1lAB27z89tWihAs6xxAWS849TDC7ST5Kez2is+8zknrCMufH1wJ6yLWLBzno88H
         r+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCX2n3VKu9mP3GW3h+kbZl1QAA6puE9LW/znWbcz5ZDKukqxZZc9OIeWtc4f+KR3n0+YUn7YMaFgvDlS@vger.kernel.org
X-Gm-Message-State: AOJu0Yytf/sp2cDI+UCO8RyOLi8lHkQ0N0ex3NycZBWvaxszGAPft5y0
	INuo9R8bCxYsRttZHBLEC/P1kUgq1LBjKouRKM/nNHeugZA1J85wbvNo
X-Gm-Gg: ASbGncv6yopSBgUX8sdw7x7qrB6NW9b+khKGLIGdNuSutPok9LgRHzb8AeES4AYq41T
	jvlB1S/nV7BajmTjZYUKw1nlwEzoabxTMvtKnk2wkxP1Cl7SUltl66GkkMSat4+uFKWKwe4fHmS
	GEJtgKwRnwENF3QCEVIoBKyMI/zdKfxrwz5LmqT9kGY8xJJrA6FR/aE1Fx/dioR1TFk4VRWGDQI
	BcRLNOyPApLNEcxlaec540RMMbYpEKKQdGOi9CM1ELSqUu41AwhL45u573sWZ39odS3BTg0hvtI
	jUQ8DSO5ttnTycL8sPgCSfBYAXv+ewxtLG8EMy3lKdFyWltCuwhn/4Jed3eIJMN4fAWKylulpxZ
	N2tGApwFppJ3SYAziieIossjhHz6IHacIcNoEmw9m2Rp3qBSrghxbEgU+y1bQiMClth2RFFvBpJ
	AsSVBD8UDOQ7Dwu6AW/uEClwRT2WUPVzcsmQ0TZL5Cr2N53vZC
X-Google-Smtp-Source: AGHT+IGe8qAFLbn4/vX5i0Ow1/iT5EGUdVcCOuyeIG6eX5kopi8FhtvrktlTKE/4N10OlP9KFFo2Ww==
X-Received: by 2002:a17:907:9627:b0:b72:56ad:c9c0 with SMTP id a640c23a62f3a-b72c078d329mr10605466b.17.1762452074675;
        Thu, 06 Nov 2025 10:01:14 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:14 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/4] ext4: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:00 +0100
Message-ID: <20251106180103.923856-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/ext4/inode.c | 2 ++
 fs/ext4/namei.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eaf776cd4175..7d5369f66686 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5522,6 +5522,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
 		cache_no_acl(inode);
 
+	inode_enable_fast_may_exec(inode);
+
 	unlock_new_inode(inode);
 	return inode;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2cd36f59c9e3..870bee252e54 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3038,6 +3038,7 @@ static struct dentry *ext4_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	err = ext4_mark_inode_dirty(handle, dir);
 	if (err)
 		goto out_clear_inode;
+	inode_enable_fast_may_exec(inode);
 	d_instantiate_new(dentry, inode);
 	ext4_fc_track_create(handle, dentry);
 	if (IS_DIRSYNC(dir))
-- 
2.48.1


