Return-Path: <linux-ext4+bounces-7243-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F9A88910
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C718894EA
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413A289347;
	Mon, 14 Apr 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHheITV1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1136288C84
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649688; cv=none; b=U5nstBDFuLMIs8h/RxNvHG6Cg5opzyH7wfzXgA67YBYjZ30zQs95ArvSi2+6kMxL4xpZpKzjhqZj4jwl49WWJkkDy/LyPqO6X8eRG4RsdZ2oDh/TnCdMK7I4A5HH2g01+v/4v6yegQTobxeEO96npPbr640Ki1EBGXW0YRANS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649688; c=relaxed/simple;
	bh=qZuo/vsfpPGvO6ZOTtvaZpQ7VUjpQxPGhtLyoSuuh0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pT+ndXZQQZ+kbNRKpMMGnasXTRAkvqOslZWC67L8nR+Laz8ejUSw0CkQe36gTcMYQceKxiGlO4NpcJYT88Sx5+NXxtDLL2olT2/xf9zDkBrOZ4Lmmc8TqEEnrd8gRLFqkL2zCNBDOYYjJ0GLZg7/6aUOQBIf2Me8bZNWRldVL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHheITV1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30384072398so4133544a91.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649685; x=1745254485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s2Xpn+03cL7PI/4gtP+VQ/hcYDSrP65xWMke49XZAM=;
        b=kHheITV1y6WdbcavYxewBLlaYry/pX/qYq3UYgvLvKkzE4YwMnsMKd8yyYOieBgsRO
         PCZm1uOLRTn2pbuUGIi9IxSxM50It3BVkCGBG4SG9llz7abgH0NxMepXxUFiuCzxxRC3
         7hKo3HhXKjPYKOupF282O2JXE5NEu085EbjX4d39t6rpgZDs9FnBJUZISNHF6qwfX1ET
         v/PkCRzQiADowkMnHJjEke0OyTkePPAW2FFV14D2QsVmLUJENNBETYk1o7quIPwmMAdn
         U4vp0UYdWhHO1YE/HlwHhW4lSkKkj0B7FK6NzVmeUuySiWq7NUgYX3meEt5/2o1eYrAA
         KwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649685; x=1745254485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8s2Xpn+03cL7PI/4gtP+VQ/hcYDSrP65xWMke49XZAM=;
        b=fGBxmFirbu72Ti91UlukHzHClPsgN/gZ93WE1eO1LGu+szY4F5naB0TLDTNcsidryF
         /edXCvwZ13X6GQTI14eMD7u1dzitrrEUeU7WUKBSyDEpUx5wt8u8PiI9ofgCD0Nl0d9m
         b2aJtUbz5J+i6reO9xZ1IfD6gzTlwNep1G10/E8AnwqOtACgx5g8Fidc/E0qSDxeadKw
         SR8dqSd153y8i2OP6XOi2DuU/xhQjbbBu2sx3ra1kW5fUMrZZWefieeW0kWTDVeUizoJ
         1mBOqZ+0504wWNZXIpbcoOWN1UvMXmR4XkoZS0nS9qrRTipemN9PSvTfVjFQ4ZlkXVKm
         URfQ==
X-Gm-Message-State: AOJu0YwR3EjHPESx70TDMobkaNfHCcYeD0sGOj4rKNvSVw4lNQLqq3id
	DouwQ9dmGv9aLFzcfh28DWzeBdSp6ogFebABNq7ZEkosUAKs89V6dGWgZsJ3dMI=
X-Gm-Gg: ASbGnctV8mjRgAJUOYElKs1ECv2Oz3GOdLKRVAsUKusz5zsmftaYXJiIr8T69hhg0GD
	gE0DieAMX01sHCwm/GEggpgAOdcWRJfZAIlTt+OgO2Pe/GleVJKCjdOHust+SkzSF/CQFG6js7B
	78DyvfKRxrnWS2pgIMdSBCyQryz/veJ8JxoJ8hs+hKQz5IBl/0VMJJ7M2iSuavbOVFeaD0BTBOI
	V60vZzLqhOIzJnh1e1jNzPMWyC0h83KZhE78e1lX7feujXWAcqLu5jS36iAl9L3bI9u8cwJy3aa
	kAQNDjWuvZLE7vo3ahvsrX6qrcF6ihUC8MOb5Lwem5J9iBLkUvcJsixm1ZHYqIwqHqTdcVN6MTm
	OaiGOS+c0Ghc31kmqac7AjnhdbBC7YkLH7A==
X-Google-Smtp-Source: AGHT+IHUqIks69KPyY8VP6K3qmfyhGcVDPNpZrPkb+em3JSMLWa+PPWBIsgQAilL4u+8DTkQDi5osQ==
X-Received: by 2002:a17:90b:3908:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-3082378daaamr19060749a91.15.1744649685349;
        Mon, 14 Apr 2025 09:54:45 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:44 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 3/9] ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
Date: Mon, 14 Apr 2025 16:54:10 +0000
Message-ID: <20250414165416.1404856-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark inode dirty first and then grab i_data_sem in ext4_setattr().

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cd0879f5f178..cb50786121a6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5547,9 +5547,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			down_write(&EXT4_I(inode)->i_data_sem);
 			old_disksize = EXT4_I(inode)->i_disksize;
 			EXT4_I(inode)->i_disksize = attr->ia_size;
-			rc = ext4_mark_inode_dirty(handle, inode);
-			if (!error)
-				error = rc;
+
 			/*
 			 * We have to update i_size under i_data_sem together
 			 * with i_disksize to avoid races with writeback code
@@ -5560,6 +5558,9 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			else
 				EXT4_I(inode)->i_disksize = old_disksize;
 			up_write(&EXT4_I(inode)->i_data_sem);
+			rc = ext4_mark_inode_dirty(handle, inode);
+			if (!error)
+				error = rc;
 			ext4_journal_stop(handle);
 			if (error)
 				goto out_mmap_sem;
-- 
2.49.0.604.gff1f9ca942-goog


