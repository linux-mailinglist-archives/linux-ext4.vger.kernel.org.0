Return-Path: <linux-ext4+bounces-11538-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC712C3D014
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 19:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB2F24F4FEA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E916D354AEB;
	Thu,  6 Nov 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksfDpozy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B694350D5D
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452082; cv=none; b=OQS0Zg7atLgbohi6OHnH3jWDTqEm5DcJYEYoqdaqyADYOKlWVW8e5a/+g+t2pcuyKB1QhF1D4KzhXtrzlodH/vp8+QWf5A0iJqZzGRjER6sUAR7GhHbhodcQ+2fkh0vdbV3MkYnMKU2ZXB+DPmQts9JdsdUKc9CkU2hkuwmPjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452082; c=relaxed/simple;
	bh=5LtjXMmzmSXGmRg7hUCR8hen8AGyJaa9v1b6R+l+ZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5e1zuLyLa3SfollUGbWETBr8fmfDNcgmdTgYIc9y6gq4QMBkD+fNd9bTCGKgSuvQWm0A7ZFT73PlwIvkEFAgoUwf7PsVHi1bcSNRtkFB9Uiu62UOsexzusP9AcdrpmEtTUVEkfe65WDdPYtsMPWTJ2xjrp7uHsBusrOAG26YUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksfDpozy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b70bee93dc4so169856766b.3
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 10:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452078; x=1763056878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHuntKUQFzTj1tqfj6SLYorj+0zzI3N/cN4KqeV4e68=;
        b=ksfDpozy9aJfz/EUpiJfskYRq+dCuyo+MdyvKVLgQWYOKA3U/oP4V37TUcatiRcn0Y
         ozrykxYtA1iluwVsgqI2yDU4CiweuryNlQhk987UGvLDaVaqNt6iIHZU0dIL0t+ZYk2n
         9yWOyPgDDF8G20G/lRqwUOKML+RFuCPR2Tusw//LqaCCbupghIZbs9qdA4oBD1LKU31y
         eZDwOxRUp4Z1OQmjTIPQJU8g82bnK5yL28E7ZGT2C88GJFvZFniSzVtFfp8tpZ5ZhRDc
         78x5j6U0Hg/ekgDutVkCy6gs9MfJmepJKmjqPzXmNiywMX6OuadjvA4H8WH+WWThV1Kx
         lfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452078; x=1763056878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHuntKUQFzTj1tqfj6SLYorj+0zzI3N/cN4KqeV4e68=;
        b=ESkkhjVzKGsm8nOAR8sd4h7aA5EnWuqSFQz/18wP1FTEoqGgJMKKOrpuj0WG6Jz+kV
         YKriHvuvoaT1oc+k5+mKTEWQf0IZY1+wzsiD+g9R/udFpDhjcda86gjY5+eI60TKZvz7
         4hsYkfxWbmLuiGouNX7rypSQB2SXFLcrnm+zWO8BOK/7tvytbANLT7efjbVvYOxfAvWk
         hA9Dgrb7MSRfgCKgfVv+Dh7QSyYrIdTKVYgrFUCBtAyeZw3gAe9JTpdNQDt4l6A06O7u
         ICiWMTdo093+x5HMuaDfBEfaexH0wV+Ly9Ct1LzLqv+K05rHSVkEnpAP7gJcBkUEkeT6
         LMbw==
X-Forwarded-Encrypted: i=1; AJvYcCX9ESBYXHyxTYaPrzLErolc+Hv9kb5qY9wVSo/yG1f9BQ00U146iIHKUkNx3BLqz7YfoIZynCEX4of4@vger.kernel.org
X-Gm-Message-State: AOJu0YzMD+MB2q9rz2iGKn2c17hLErUoIKlGaUMegDS8km/iLsceTG9W
	ggLG8P1+Ftj0Z02vDAqULhLQOrUl+i+5SVmJA+IjKfimjIdBMsgN7usk
X-Gm-Gg: ASbGncu2uVBRECdxuzVEue+rAkOgLujtqXbs5rd+AnfuQQcPnjKL0tOhemLdAyg8VPd
	gJUbA33/rhCDUKVgCWQYSpC1A1JppIfInYg20dJUi3+O5aUGzyZgU/tveKZGZYxjqavOb+Heyjp
	7FRuIjmXaKzViUzwkM8EpyJJ+haKanIqETeYlS110vJ5lrbA86ifiDiTyp5gB/xyFpN8UB+YPUz
	XcbWoXbeLrFraXjvrCdplXXWfM7dmsWI7M/nPc82wBJNDq8gXeshCeCMm3U3AF3+6HpNu/AoqpT
	OGDqvPhzbhp1s8B8eU/4emrkzaLLbcMsLUbopPa1UUjXxxCh7/jflpc9C8x6NQV/jDUzvJEkC7e
	C5vMcsF0vI242AFP2ExJZ8oRaYmHWPMDyFtYVY2UOYE7IDX68VjAZYCqx3qG3vzEN1ThcZh0Dxk
	6SfR5hv8vePG0NFRaATqDDjUCx/NrYNoidEGKaW5wWUmDaEwrM
X-Google-Smtp-Source: AGHT+IEH7VQOvOdhRi3okWflF+KjH86D1HQeDcRUW3puSes+/n0te4BbALgaZq5PqIhcusM+kRCOPA==
X-Received: by 2002:a17:907:3f91:b0:b70:b1e6:3c78 with SMTP id a640c23a62f3a-b72c0d67c80mr3453866b.34.1762452077678;
        Thu, 06 Nov 2025 10:01:17 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:17 -0800 (PST)
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
Subject: [PATCH v2 3/4] btrfs: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:01 +0100
Message-ID: <20251106180103.923856-4-mjguzik@gmail.com>
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
 fs/btrfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 42da39c1e5b5..42df687a0126 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5852,6 +5852,8 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		inode_enable_fast_may_exec(&inode->vfs_inode);
 	unlock_new_inode(&inode->vfs_inode);
 	return inode;
 }
@@ -6803,8 +6805,11 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	}
 
 	ret = btrfs_create_new_inode(trans, &new_inode_args);
-	if (!ret)
+	if (!ret) {
+		if (S_ISDIR(inode->i_mode))
+			inode_enable_fast_may_exec(inode);
 		d_instantiate_new(dentry, inode);
+	}
 
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
@@ -9163,6 +9168,11 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
+/*
+ * NOTE: in case you are adding MAY_EXEC check for directories:
+ * inode_enable_fast_may_exec() is issued when inodes get instantiated, meaning
+ * calls to this place can be elided.
+ */
 static int btrfs_permission(struct mnt_idmap *idmap,
 			    struct inode *inode, int mask)
 {
-- 
2.48.1


