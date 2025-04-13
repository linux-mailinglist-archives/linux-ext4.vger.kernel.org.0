Return-Path: <linux-ext4+bounces-7220-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F68A870CC
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 06:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7031A3BDD12
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Apr 2025 04:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270374059;
	Sun, 13 Apr 2025 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glh+/bGK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41283145B25;
	Sun, 13 Apr 2025 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744520257; cv=none; b=WaGxnxCnVCmAWhw+btaeDowKMRnI0DDMGR2nsNTTXJW/wQb9uPhzA9EtsH+U0nkhtGy2tmE//PeLFvDVGaPsrdlMsoP75HYNqZukde//T8w5T3edsv1bLs3n1iUbRO6H7NF5ptmyw9lDFD/xnelJTZURAzAODTLYCb+FwCKT4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744520257; c=relaxed/simple;
	bh=V+OdSpChXxFdeuDfkZFCWnwFgJIm7CgcfzpC8IzAVwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=knAAgTx0XUC68CklQw9hKMxVLTyJ1Z38D6L3t8w89BRWC9MXtyGu9m/mCb01lXT8irS/CenHfGc0EcYXge8WLHJbqRBtaCBH2Uiu4QyCyLoBe9uChhyaidTDbDFzslBt8LWjwnqc2b8AyUY7k+ve7GpBubdmJor4N6PlbG62hV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glh+/bGK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2944853b3a.0;
        Sat, 12 Apr 2025 21:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744520255; x=1745125055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7qDXC5q4ASpK/ILgh5KtIP/kBQ8UqX67C9eLZIduHV4=;
        b=glh+/bGKKBjjPPpqTsI8jbVnksM09m96eCs+TaR9UO5l3zf9O7Nfx1eDmXl5k8t3sO
         db9eqNla9k2FQcHbd+shDJ3EJASX3dV33QYC/6gSX2otCXutxff1tM0++T2cwPg4VXae
         zok0Q5BarZrFuEPHtpg+B/t22zcpExxTA5PZ2xIPCgPWjiISPSSSZAJ4+ItGQTzbSfq2
         52gjd2mUISfKJf6MZPjGwFmAxQ1m3gQRaDGsm+GvBdqxhkp7MfZ1wXFxb/PAmGkNB1Z2
         FLRef2ZeEBvKGWLGtvRCVCfX07Zo6rlF2JHZrNTJ1NPsN7WtYw0sfNKO/t9lJovRWfOX
         KA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744520255; x=1745125055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qDXC5q4ASpK/ILgh5KtIP/kBQ8UqX67C9eLZIduHV4=;
        b=eWsEYWgcDyYRZuVLp6AUGTJIVHKtfyUVKeCr8Jj4pw/eVE5CNlXDIn7xTFyLvNqfuQ
         VZJ/jl5K35qbc2b08l0QlfPHdAw+GcxmkXyune161FhAgnYjp3p/caBi2hqcSpktUdjo
         5fHABiz0Bsp9OSBMYZvfpGh3F8YqO7frZiPP+QJM2Ehf+v0rZ5BRcRe7zZwOmk3ECQ6y
         va5jgGCracN4yfQdUoNT2CX/kvWSVJHcW9rpDLUCbwmlS0GIDMD5GrnuaeWg3r0EA35H
         7dcQih9CHO+5Bgj8xdw95IIl/cadBBm36VF8f8D5UqC40QhjC7D8E9Q2TYe6fZgbfXbG
         N3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW2qU0tjMq3WXg8KZSJkUJnMsICWoFP/E9fp3sJDf+StfW4QPXqZLyGlL7G89AFx8jPP8Kf5KqpDrbKHgjF@vger.kernel.org, AJvYcCXMRnQKfIGIenJXTsYVAEnXt4r8tD4yQHvVGmnsNNypsAEtKYs9kdFSog7YZCZ7UyDOaos+mX+x4HmU@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPieQwPf1HMKC3yozxG33SUNx4x1xz/sxg1t0PvX/FCE8DUAp
	FGbV9UJkptoG+dfBvtyyJrGMWhEDEULu4M/rxD2ZZbvgdxciBRpz
X-Gm-Gg: ASbGncvAijt3jqlXlE5Hf/X53f6xxdM2LmudEUoyOJ3zXBdsfKdL9RXr7Gypitdruc8
	rgyPBC03chSJju9aBU9waIbxgWoo+khJRB36VfNJ2ZikbwllaDdScohK0gcXGaOYdYVlTHTzF6L
	MmMS39qpxMqO9FI8NxL5xHsn3xZJvysowXe8p2zn0d7jSTRPLkKG34DNWt6h/Uq2+ZMPgDmFK5p
	LA63cuiGhUo6C1KovVHR23uYdyFgccnbJjz16/wqwPJAsruH4F8U6GUTr8ANnk5NH7UOMM7AEOe
	CqtWtUrim8hud/MuLjLL8BIJXA7yL/Vtn/fsZ8p/nzlU8QPaS+kEsCBV/CE=
X-Google-Smtp-Source: AGHT+IEC6KkIXJw/IeQCpPR3Yo19Wxe/bJ42Xl6Fl2ZoGtxsioyf3pkIYy/+4uaSBqS1TLeXOVkr7Q==
X-Received: by 2002:a05:6a00:22cd:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-73bd119ea62mr10936177b3a.5.1744520255132;
        Sat, 12 Apr 2025 21:57:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c408:a0b5:6154:df3d:5cdc:6ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e305sm4451350b3a.140.2025.04.12.21.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 21:57:34 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kevinpaul468@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH] ext4: filesystems without casefold feature cannot be mounted 
Date: Sun, 13 Apr 2025 10:27:18 +0530
Message-Id: <20250413045718.150126-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 985b67cd8639 ("ext4: filesystems without casefold feature cannot be
mounted with siphash") upstream

CONFLICT: A condition above this was wrapped in #ifdef making git not
able to merge them: Merge conflict

When mounting the ext4 filesystem, if the default hash version is set to
DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.

compile tested
Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 fs/ext4/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 541cfd118fbc..9bf073bec190 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3192,6 +3192,15 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 	}
 #endif
 
+	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
+			!ext4_has_feature_casefold(sb)) {
+		ext4_msg(sb, KERN_ERR,
+				"Filesystem without casefold feature cannot be "
+				"mounted with siphash");
+		return 0;
+	}
+
+
 	if (readonly)
 		return 1;
 
-- 
2.39.5


