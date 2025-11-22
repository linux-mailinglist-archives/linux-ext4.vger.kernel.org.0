Return-Path: <linux-ext4+bounces-12005-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0DBC7C35F
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 03:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8223935DB36
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 02:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EBC264612;
	Sat, 22 Nov 2025 02:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAFfPZmT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86FC2135AD
	for <linux-ext4@vger.kernel.org>; Sat, 22 Nov 2025 02:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763779783; cv=none; b=LCLDm5YUkt7ybsI2BthY8/0SNz+/csuudk87WnG4rHQBUlF7odCD5Z1Ru+ju1wV0EyhaNLi7maY82Rg75eCCkyAkZcBxOl7zOczaaUkJcj2OVrWeqEVETEMa8THU6HJJzh4+i/emifRq4s3XpZzxVQaTAHPFHh/yqG7ir0QQbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763779783; c=relaxed/simple;
	bh=sa6mcig//Mcew/EeLoyFl/4GJB8qLX2slgNI2llnzD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLDwaqRFwSMSuTZFfWpl0P9UvBw3s+r7q9eN/ZYRysM1lmvwwh3A4YS6Zhj/u4cp9LGt9EPXRA9GseQCR1FZsGZLL1+/003D605/lRXDW/61UI2Hd8HqnF4oSlJu+K2OUyyEB0Q9r3miYrQWg9GnfBwzSKAeLP8XmzQwAqIPbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAFfPZmT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso4331197a12.0
        for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 18:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763779780; x=1764384580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnHYS7bdbqInDphgttN+cPizyxQKoLAz9iQUAbHEgu8=;
        b=XAFfPZmTTDFeG0moayZIWI+/YP+fDNXptDQBN72YopmCWaKT6I8VKs6qHwNyOHDXa8
         Jbe6oe/7eCPSJHJgsstQc8MNId25jjUXjrz3Hiy+VtRIZ5rORTxpNHa1y0/UyUekHywT
         MCK1ipO4E+YnX2zb2W+4hgK1mtse0QihyBgpL2z98QCvSj5JpNYkQmfL+H31lRzL9LvV
         x4d9u/cJvj+hJTFJKgubXO/zG1w3SnfrznCVuklURH5DA50YwSN0sUe6wBVOW3hBQGjU
         6FgJre0bZDE2bquaoW1lUvZt1BKoabqAlcf9AdLjD0XKq3KLJ1y9Xp07fGpfI6ZnTCG2
         r1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763779780; x=1764384580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KnHYS7bdbqInDphgttN+cPizyxQKoLAz9iQUAbHEgu8=;
        b=sRs51Sjv+kl1Nt62le9CZoaCM7oJR8o+BylmHeY50wy9zidCVoqwE/qS1UbWyirP8j
         mNNPCITd3x3+8a5z+Ou3zBRSq7ygpaVea/GpaFd9pCumUyRYj4cu2IOVUY8/XNPnhTiL
         hBezZ17/iNTnupv87ZMQaJPCmg0gVjsy2RrH8WLfJwfkozWXixXaJh3h4LqXalXLF6Pw
         P1MbMtnj6zX98k96wn2qWjcNiFE7tGLkQjRoMzBugVHCe//4x5GqgAcmO17so93yQRi3
         2GM6iXf03J8QtuXSx33n520eP0JYWcoEZDTmEN8H4lj5sdP6PJwYxMGi7GwluJ6Sf7JZ
         U//A==
X-Gm-Message-State: AOJu0YyhWS4hl1y2TrRfUFgRCViE+CO1/kRKdQi9eoSLaMDkt9ol9WxG
	A9iSld8pKu31j1sI05AJmiitZLXT90sKvFj1tro3zgN+7H9kMpI0Nlzs
X-Gm-Gg: ASbGncvCsib3wq2gotyjrb1zmwlEUBVndMJrXjp+6c9QpelCyokhM2eufFMGhGfI/ti
	3CpUTR8BAZmZs2qXVD5CtAXt5ETVTZqyDjyCJs/CXKjFJ1SLLUcaxcIJ3rjdmWbThI6BT1wquX+
	WJpO04l87P7bUls2tSVDUAmLWNN1di08alJuUhib0u5u5acmW434ZMFbRUdql5nlAzLAeQxKjNW
	F8bqd2hcev4YzA5WyTup18+tj4lapv6spzkjdcFX3fzoTp6+dFUPrZKxGFMP6+WoQt6ok7pWj2P
	zmQoPg2UmGMnuBsk2D1E3UKXL6n6HGHsLq8I1DQIUqf7CunwWWdGw50MqKES8EycBbL9uCZ8XUH
	zs9iCglhZjRwllqIJ5Ocg7Zag0p29IZn1z5eefSpY9sdHz7as4LISbaavF1vPrq2VgeU6f5N3ZH
	Df/4qOgO06LA4w
X-Google-Smtp-Source: AGHT+IFsP8W53rvT11Kbkp3Q1NBm6rQma1a4c0VWOCZYCdxPAkvafeClv3FEkEEKh622Y3fsOcqKZw==
X-Received: by 2002:a05:6402:42c7:b0:640:b07c:5704 with SMTP id 4fb4d7f45d1cf-645550f2186mr4469181a12.15.1763779779940;
        Fri, 21 Nov 2025 18:49:39 -0800 (PST)
Received: from eray-kasa.. ([2a02:4e0:2d15:1b7a:7e69:bd3d:4508:8aee])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363aca03sm6307532a12.3.2025.11.21.18.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 18:49:39 -0800 (PST)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+ee60e584b5c6bb229126@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [PATCH v2] ext4: fix unaligned preallocation with bigalloc
Date: Sat, 22 Nov 2025 05:45:56 +0300
Message-ID: <20251122024555.140798-2-eraykrdg1@gmail.com>
In-Reply-To: <20251121002209.416949-2-eraykrdg1@gmail.com>
References: <20251121002209.416949-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported a use-after-free in ext4_find_extent() when using
bigalloc. The crash occurs during the extent tree traversal when the
system tries to access a freed extent path.

The root cause is related to how the multi-block allocator (mballoc)
handles alignment in bigalloc filesystems (s_cluster_ratio > 1).
When a request for a block is made, mballoc might return a goal start
block that is not aligned to the cluster boundary (e.g., block 1 instead
of 0) because the cluster start is busy.

Previously, ext4_mb_new_inode_pa() and ext4_mb_new_group_pa() did not
strictly enforce cluster alignment or handle collisions where aligning
down would overlap with busy space. This resulted in the creation of
Preallocation (PA) extents that started in the middle of a cluster.
This misalignment causes metadata inconsistency between the physical
allocation (bitmap) and the logical extent tree, eventually leading to
a use-after-free during inode eviction or truncation.

This patch fixes the issue by enforcing strict cluster alignment for
both inode and group preallocations.

Using AC_STATUS_BREAK ensures that we do not manually free the PA
(avoiding double-free bugs in the caller's cleanup path) and allows
the allocator to find a more suitable block group.

Tested with kvm-xfstests -c bigalloc_4k -g auto, no regressions found.

Reported-by: syzbot+ee60e584b5c6bb229126@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=ee60e584b5c6bb229126
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
v2:
 - Removed incorrect logic that was adding block offset to cluster length
   (fe_len), which caused unit mismatch between clusters and blocks.
---
 fs/ext4/mballoc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9087183602e4..fefa3cc6adf8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5291,6 +5291,22 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 		ex.fe_logical = ac->ac_o_ex.fe_logical;
 adjust_bex:
+		if (sbi->s_cluster_ratio > 1) {
+			loff_t mask = ~(sbi->s_cluster_ratio - 1);
+			loff_t aligned_start = ex.fe_logical & mask;
+
+			if (aligned_start < ac->ac_g_ex.fe_logical) {
+				ac->ac_status = AC_STATUS_BREAK;
+				return;
+			}
+
+			ex.fe_logical = aligned_start;
+
+			if (extent_logical_end(sbi, &ex) > orig_goal_end) {
+				ac->ac_status = AC_STATUS_BREAK;
+				return;
+			}
+		}
 		ac->ac_b_ex.fe_logical = ex.fe_logical;
 
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
@@ -5336,6 +5352,7 @@ static noinline_for_stack void
 ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 {
 	struct super_block *sb = ac->ac_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_locality_group *lg;
 	struct ext4_prealloc_space *pa;
 	struct ext4_group_info *grp;
@@ -5347,7 +5364,15 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 	BUG_ON(ac->ac_pa == NULL);
 
 	pa = ac->ac_pa;
+	if (sbi->s_cluster_ratio > 1) {
+		loff_t mask = ~(sbi->s_cluster_ratio - 1);
+		loff_t pstart = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
 
+		if ((pstart & mask) < pstart) {
+			ac->ac_status = AC_STATUS_BREAK;
+			return;
+		}
+	}
 	pa->pa_pstart = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
 	pa->pa_lstart = pa->pa_pstart;
 	pa->pa_len = ac->ac_b_ex.fe_len;
-- 
2.43.0


