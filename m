Return-Path: <linux-ext4+bounces-10466-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D58D5BA6EC0
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 12:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DDB1880577
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815C02DC33F;
	Sun, 28 Sep 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JudKWoKZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC42D9EE3
	for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759054196; cv=none; b=JyJ5w4jMQ46xLTL94BNighZiBD7URiDUEt/IeZJSa1d3SM0vwQ/gh7FUwoEn8Or3GECbCbDvxRUvvbDGlnsKNCAHv0WxfUJByhehAMHAyyXGb4diurKDMLp+AbFc8Ef7zVyQH8CXcPgHvNVHkVIw8qR7dt/Cug0NFAHGzq8ISC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759054196; c=relaxed/simple;
	bh=rTIEfIHyol16evnoilqvUSKNW7krl5FuRjb+UuNeQQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYzKVMj2KyMysGZg0S8rH96w9oww1G/LcIlThAdFw+CHu/pQO6YsW4IF/BKnb7UHFEOLWTBgvDhrUZNabapcv8xSFTMHxE49cZd/TDEbVPfA+e5CK7yIKpn8ubdcTEVevD+Uc5obEjYe2HxxTVIlKGhgyYvbL9jmAB+M9bwcSrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JudKWoKZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27edcbbe7bfso37716255ad.0
        for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759054194; x=1759658994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEaRyqcNalrKfX0bmpo1LGgUVgua5hE0vbu7vpC1J+A=;
        b=JudKWoKZxkB40WVKiwYh2uHef98wcxQmxo7PIAbclDenWCwQ4PVMzM00fboYIwz/qh
         jqMzbAB8YRBLwcTsnba4dbVKu46uiGYwArtDHkLvuUB6Rd386iDf6wTijcxL2KMYkLXu
         5MueIzvNEBM1I/vHGKgUFtpUZ6x35CBgtBi6Zlk8SQacH8fGQCiTT5k8IZUPxRyDmlFM
         SqrXq8InEzXKWxzf8uYD/3GcLtknslRKvYX+OIns6r9VJx7Kpi3R9R4iqDDBNYaAzSIq
         zCs5bdjHw0gSrI/e+lSGzSGldYRpL+OcslHzoYWSa+SLC1ZM0rp15JRxg0CAplpmSwM/
         J0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759054194; x=1759658994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEaRyqcNalrKfX0bmpo1LGgUVgua5hE0vbu7vpC1J+A=;
        b=IsLManAkO+3nmF3mbBRtEJw48VTbzEIVCX75SBIcfyNjBimn6jPm3opc9TfBbLF6ms
         5aW3M/QvRlj7PwN38ViAZ2/sjG3L0GFFnh0HLTrlgOm8SOV46/BgVaf8phL4jJahGSwz
         mF1jAKOFZsVgVwOksMiTVAaRXP4bs0972ZZ4n9WIddIZgbCpIphuMj84PNCb5/shbn5Q
         aoavcnuDTYSpqCA9Cr9+epBEim7cQWK2qHcdF0hJaXyA2wJ1Oz0h/tVIjoyBbR0C/Gq9
         EVy2PkcM55ZdNrqH6cSmcbFZHKHKwSHhPsiSsWBG5GTM2zem9BowJAA/Ie3xUgtResWA
         6GtA==
X-Gm-Message-State: AOJu0YyAE2qazAmW13ZKIqurETp6/qlZuU+pVQyELk0guHPodHgLtAyX
	u2N390llkRkqAqiMsizRIjqh9OO4g3Y9sSPg9e25pxMbCSQ3hCqI1qUD
X-Gm-Gg: ASbGncuyBc4bSJ1z+Zlt5YvLVYthNNwSTYP3heBDz4O9mlHbPvItBg3q8s0rnC+qVTt
	48cX7NTrR5bUk44FE4SQelib0Shobg8mMTGdQJE8ObjM2unOHWmLHV394vQa+GzHWsI1jE8vwnT
	AhYce3WGBIW8n65jF7JYr7j4kc8NKxd1/SFuzau+ekWnSebe6/Jj7/g7B0HKNKt2V5jHN5qCwRQ
	+U3FIuqfbjTFnlV/0PSeRY+5by+4qe4c9UeY3GfmJ/JGNliPm1YBAQLuvsMjN0WEy2uOReTJrwF
	96Z7a57r86A4hL40yaRWxgwZpNFy2NKx1GO/dD0jqbfpULaT++zs5MqWwT7H4n5993ozSDLQv+9
	7NVdr0sSsswaYtnbaOh4n0guluErfMDCc6y3dZiMtzXVX/E9CArkRLdW0PUVJzHt3fcswwVj7MN
	f0hu2FfgcUE/vSXg==
X-Google-Smtp-Source: AGHT+IGQn6LWV6iO53lyCYBVGI/gp6UKhS19n/WsBwNq3wacSvChYo5sSsOyWQJP3LB28kS3hR4IVQ==
X-Received: by 2002:a17:903:244a:b0:25c:d4b6:f117 with SMTP id d9443c01a7336-27ed4a3de3cmr143931065ad.35.1759054194123;
        Sun, 28 Sep 2025 03:09:54 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:aa9a:16e7:7fcc:f4d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347224b0f7sm10473322a91.7.2025.09.28.03.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 03:09:53 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Subject: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Date: Sun, 28 Sep 2025 15:39:46 +0530
Message-ID: <20250928100946.12445-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a BUG_ON in ext4_es_cache_extent() triggered when
opening a verity file on a corrupted ext4 filesystem mounted without
a journal.

The issue occurs when the extent tree contains out-of-order extents,
which can happen in a corrupted filesystem. ext4_find_extent() calls
ext4_cache_extents() without validating the extent entries when the
tree depth is 0 (leaf level). This allows corrupted extent trees with
out-of-order extents to be cached, triggering a BUG_ON in
ext4_es_cache_extent() due to integer underflow when calculating hole
sizes:

  If prev = 4352 and lblk = 1280:
  lblk - prev = 1280 - 4352 = -3072 (as signed)
  = 4294964224 (as unsigned)
  end = lblk + len - 1 = 4352 + 4294964224 - 1 = 1279 (after overflow)
  BUG_ON(end < lblk) triggers because 1279 < 4352

Fix this by adding extent entry validation using the existing
ext4_valid_extent_entries() function before caching. This ensures
corrupted extent trees are detected and handled properly through the
error path, preventing both the BUG_ON and potential use-after-free
issues.

Reported-and-tested-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..f8e45623f7ea 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -924,8 +924,18 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	path[0].p_bh = NULL;
 
 	i = depth;
-	if (!(flags & EXT4_EX_NOCACHE) && depth == 0)
+	if (!(flags & EXT4_EX_NOCACHE) && depth == 0) {
+		ext4_fsblk_t pblk = 0;
+
+		if (!ext4_valid_extent_entries(inode, eh, 0, &pblk, 0)) {
+			EXT4_ERROR_INODE(inode,
+				"invalid extent entries, pblk %llu",
+				pblk);
+			ret = -EFSCORRUPTED;
+			goto err;
+		}
 		ext4_cache_extents(inode, eh);
+	}
 	/* walk through the tree */
 	while (i) {
 		ext_debug(inode, "depth %d: num %d, max %d\n",
-- 
2.43.0


