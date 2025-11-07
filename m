Return-Path: <linux-ext4+bounces-11649-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A529C404C7
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15C8B4F162F
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6C32AACF;
	Fri,  7 Nov 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETVmxdsL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E46329C6E
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525327; cv=none; b=mIS8qrdhnEb+12dHkx8WCmD+LsTmSWK6CPg6sO4Qq1fL8sRJNoap3Ppvq09Yy8USCxs2yVZy1UaRDExb5wdBiID7QXdXmwk9jtK9oi0lOHNatvu7XJz9Myx2euSbyf53d0Srn1q74Z2rOEEvIEuiAyy5b5A0ulig+5tpbasHviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525327; c=relaxed/simple;
	bh=128KSekg9ZnF2sASoMn8sOUDRGbIcWBCHawlZ+Q48b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+L1hm0hbDvvnaCC3OINSVG5/D0N6l1BTL2TdRnbugBKnOVXl/zZCxakZWZh3KL/43BrzSwHlsYu646b0GpZXvTUzfoC9+oqFrK6oPo4cieNywwirXr98Nu9T+eZ/0iJGOcjjeX/6X9HOc2vwm7ZvNr0XCgt8X9V1zUyFXjJxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETVmxdsL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b72db05e50fso27844566b.0
        for <linux-ext4@vger.kernel.org>; Fri, 07 Nov 2025 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525322; x=1763130122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT6MSCAlH/pIZcAzO5vrkwY0EcFJEg7V7STMnWnK/pQ=;
        b=ETVmxdsL50D5FLUBG/X9tr4eyj0jP+bGDTcSp4R9wzOn3zi+uVAoox6ikqXiO80Td+
         OVe/LnO45No33dcaVpNyy1rfTbEnYYO++sgWGnMx75rCSbBSgVX3q4857YpiQ6pwrX8k
         dkpZRo44UCYNbM+WXT9GrMTDL4mrdun/dzxHvNpKqOpqJuDAzGkrK2zpu36UWG0iVj0w
         xd9wkVAvTL/KqxPCgzV7l+WporwzZu8FTdaq5qC0T2BJuW49/1PXEH9gdpw4rFq7PO2b
         kRrIzLlCMm5/R3UpCTsL+HvZKb+UQZhUpgw7lzZdd/aYuXkHguc/Oee/eTeGSZv4NKEX
         0JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525322; x=1763130122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wT6MSCAlH/pIZcAzO5vrkwY0EcFJEg7V7STMnWnK/pQ=;
        b=UROMGlMtKYMFvh5s3wCcRIeJwbeluwL6kKTqUcyGgCCP0u/+42IZppg07CqUf/UC7e
         6z6eF92ABix7iZdIBQ8l0yehjt993xqcgkh5qgNRc/rsHwOI6b9/lc+WwrBig/Fyz4iW
         HOhX2LfkWwLCUzf+y0jKEpRB6nW/pumI5C0R1lg0qHjwfeMj4r12NUhFxKRJ42GsX5Um
         7sX4nGIirf8FDcmgDnhU5sNwy1pyGr2WbXVeZKWlRcOW21pulUwgsElbhbWp63gGunr/
         De1IrOOhNIqbiESSOobqUtodtm1f5+zt8ayacZVOfvIdWoEH9jOuEZlHOisjN7898drw
         PbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+lokn4X0ERBpwhzrCQWO+NACC4eYyvXRnF2G1TccnmcADGNxq/Yq6nwbV1CuYldG60o8+Cus9uhhY@vger.kernel.org
X-Gm-Message-State: AOJu0YzajPDAFrprEXQs/6/EQz9HZlYyEtSBigNOeGW85GkFIM6Ctsi+
	tcjt68gDXkHsFBiHAwuT5PADttwUgh/RLHzeGQB/XCwnxzw74HHlFgFz
X-Gm-Gg: ASbGncvIoAbOLNpXaUHGJVQJwHpWzZ4zSOf4ILkoPrxW3CKMgAka211pDXJKKL0uDap
	vzKWl0t5P0JMkE8JrzUJzlfXvv90PJgyafXYgvA9Yg6M+buh2wZjqOYbsgtD/iCXC2xG2tXMnai
	eDfuvsUCi/RhCIVab1BK7jLqi0AO0aCIvKJrrqCG+XwM5o3JY9Dpd2+joTy2/oulId1swDTmRf3
	6IO6Q7fC8Ln1fce5gnYzAPNsTNCPqBhb627wK8E45UlObSvh3efZ29AmqEit1LyUJlVJ/iDJpR4
	/TPb/mcsxrlqgTG8Tp59Xu/9mr2Sz0OMmxSmCSUNGW+myOhjzo5YXykNyKQIuQYBaSfNqteAHkh
	IMhwJZZeZIEcHSvVeVA5EmFNHFjQbk1sfSy/fVRAUF0Ryr2Elm/adO5dBPYz273qRbw+KYOebi8
	zdrlKJpFr/JPPHSD/S9WdDGU5eW5LhglY88BYEm1vXuUCTj2AJ
X-Google-Smtp-Source: AGHT+IGrbWD7yFMbT4C/yX4TspKvFS9f6XhDjvBKE1AYLhGSfZjTB0CFxn4t/7QjDw74UBz/8iB09w==
X-Received: by 2002:a17:907:3f1f:b0:b70:8e7d:42a4 with SMTP id a640c23a62f3a-b72c0ae2029mr426905166b.36.1762525321480;
        Fri, 07 Nov 2025 06:22:01 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:22:01 -0800 (PST)
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
Subject: [PATCH v3 2/3] btrfs: utilize IOP_FASTPERM_MAY_EXEC
Date: Fri,  7 Nov 2025 15:21:48 +0100
Message-ID: <20251107142149.989998-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107142149.989998-1-mjguzik@gmail.com>
References: <20251107142149.989998-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Root filesystem was ext4, btrfs was mounted on /testfs.

Then issuing access(2) in a loop on /testfs/repos/linux/include/linux/fs.h
on Sapphire Rapids (ops/s):

before: 3447976
after:	3620879 (+5%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/btrfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 42da39c1e5b5..1a560f7298bf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5852,6 +5852,8 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		inode->vfs_inode.i_opflags |= IOP_FASTPERM_MAY_EXEC;
 	unlock_new_inode(&inode->vfs_inode);
 	return inode;
 }
@@ -6803,8 +6805,11 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	}
 
 	ret = btrfs_create_new_inode(trans, &new_inode_args);
-	if (!ret)
+	if (!ret) {
+		if (S_ISDIR(inode->i_mode))
+			inode->i_opflags |= IOP_FASTPERM_MAY_EXEC;
 		d_instantiate_new(dentry, inode);
+	}
 
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
@@ -9163,6 +9168,11 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
+/*
+ * NOTE: in case you are adding MAY_EXEC check for directories:
+ * we are marking them with IOP_FASTPERM_MAY_EXEC, allowing path lookup to
+ * elide calls here.
+ */
 static int btrfs_permission(struct mnt_idmap *idmap,
 			    struct inode *inode, int mask)
 {
-- 
2.48.1


