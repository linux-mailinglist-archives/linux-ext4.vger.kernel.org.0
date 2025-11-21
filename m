Return-Path: <linux-ext4+bounces-11947-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9370C76C38
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 01:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73A2D35E985
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 00:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932DB24E4AF;
	Fri, 21 Nov 2025 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLsHGPYA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D422A4F1
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 00:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684565; cv=none; b=VVgx9cJ70R46ob4QFdamIa2Zfsq5VTcb3w1qAMWIxE1CPTeYk3c/iaP+1uZuJ5cNVz8zJP/2LRzKs9znqHxd2J0FfqDKL2EFd0MTAvEgB/Q5wFyGRGwpuEbhYdvZHYM1FYN52dZ9gyDu2FBu86Me4zS6p/kannsKJSyttGevY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684565; c=relaxed/simple;
	bh=rom/AwKjWUnt+Gj6Y8kFDA1w9rDZCmrd55mGQuNpbgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oxs22MnaAbb5aeDNO3/PUkFB0q7bbz6/edbj+/l5hXsT12E+i1kPAle86jrXB6K0kDCH8Zi1T/91d8ifZAqMwhqL5zqHKeUrTtyxqDavtEIll6/kMnANIccR9/6Aq48rh0ijvu6EVI/3TN+y2mc/R8cjkz4fdTS+5QoM2g7NDkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLsHGPYA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b725ead5800so191139566b.1
        for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 16:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763684562; x=1764289362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5eibNO90Ald5K87n6GVEVhxh4o5x1NRdi3fUbNI3Ks=;
        b=eLsHGPYAo8l43wx6e/Z0D9my5/pwyJxn9lWhF+myyO7m8KfGAElJxf+ZicvdRZWeb7
         pt3gRdHq9Xz8bEBts5oXaF6DtfmdW8QUhNNqqmrkkIVjAZXnQqdR0mugO16CYWalaYm4
         M6qvkc3CnZvidxSv/ujRhPhb3gRypwgEy+C+KdjWd7K5xqQAf+laCcOfiRPeFwARXP5G
         6RU+bIcFSzXipsgyGY3aT6gn1DqC9EuB3qYa5OEM8Uw7+OQfw28EayDcPa1SM8aEi7Or
         k+LrpERMi0VOXh10/pqPO31umpQp1SzD2npmx6zU14lVWaoMSXUyQXTUV1myEU4BTIVe
         adKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684562; x=1764289362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5eibNO90Ald5K87n6GVEVhxh4o5x1NRdi3fUbNI3Ks=;
        b=w7rhqTyWXTanLLiyF9alsVLLswxNbZXr1R/ztMS29dxQg0LyNEtEiejCNlXMqvQK4B
         n0zn3HRZugWkTtnfYJpO2ALxwphBtQu0SI1ddIIQ2j1G/wGs/ulTt4VHOIoaNrtUTHAC
         J1h1JeSilY9lq6zYEulqczRiqHsRvx7b9MOJHOsngX5k4sVrov0/HyrhdYzjR67TZVY4
         rsjxVN4fpcp04kRw3NFW/VeRaaG8/9EOfpKdZJNVofb9+u7bbKq4OiR7m/9g54nKL7fs
         tHBxj73gPbGk8vyEh0zt9GoKwf1HL9AkjD0y1HDuwHvukotXar+CxljQ9itJ5Mb5SEE4
         SCTQ==
X-Gm-Message-State: AOJu0YwzwgHo5f+VU/ETp3sbULuolWQgqHsFzsxhSWhHaGLX/qMvkrF+
	pt11LcXVED0guzRCQ3BrsWFuew5Mbk2hN6xWjIRLRL8knQ4Vpkjdqtu6
X-Gm-Gg: ASbGnctaUWPpvnUd4ORcYjKwHaTz/NVXH2yc2JemRNyCwLWM3BNZ3srewpvGoPkD/zY
	VMvcGFo/ojYFy5XbQ4Nv5BhHgWGwJmcTJVIisE0wnV5R+F9fXl7hf6tV/Vba6Zjjwsp1GmeuEO/
	PXpKpu/BX01PMoljqzRI9iYc9MV+60A/BOIySjCBddo7/xEOEuTSh+b2D8pBP88H/OSQqEzSYES
	lsDfL555ChnhLeSBo+5FGnlHGK/B0cJcqtj8PyboHg6FP0NK7l4ODVzYjnispE9IdI35hlm9HUk
	uTmGx9C6eiDhCxtqvVlHUYz8HL1Na7R0/eCc241CCYAfAoBMUo7DhPCtzIkfOE0lESA3WnKu5/I
	O2J6FyD/gErbOLNqPtm6IMEhsbjRNm1F2587NVWmvH2vCo4kDKzHEf6kxwmTp4KiVXOmyPE8Eqj
	Gy3RWmea9UW6Y=
X-Google-Smtp-Source: AGHT+IFUFHpAifxZcReeziSuOwRDZUEv66W2Z4nfjWxiQbaXSc3qoEN/J/SAU6TFywHoHAyBWMWpHg==
X-Received: by 2002:a17:906:4fc7:b0:b73:42df:27a with SMTP id a640c23a62f3a-b767151b071mr22897166b.1.1763684562161;
        Thu, 20 Nov 2025 16:22:42 -0800 (PST)
Received: from eray-kasa.. ([2a02:4e0:2d18:6ce:7ff1:1161:673b:41e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d502cfsm322788966b.19.2025.11.20.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:22:41 -0800 (PST)
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
Subject: [PATCH] ext4: fix unaligned preallocation with bigalloc
Date: Fri, 21 Nov 2025 03:22:10 +0300
Message-ID: <20251121002209.416949-2-eraykrdg1@gmail.com>
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

Tested with kvm-xfstests -c bigalloc_4k -g quick, no regressions found.

Reported-by: syzbot+ee60e584b5c6bb229126@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=ee60e584b5c6bb229126
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/ext4/mballoc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9087183602e4..549d6cf58f3c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5291,6 +5291,21 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
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
+			ex.fe_len += (ex.fe_logical - aligned_start);
+			ex.fe_logical = aligned_start;
+
+			if (ex.fe_logical + ex.fe_len > orig_goal_end)
+				ex.fe_len = orig_goal_end - ex.fe_logical;
+		}
 		ac->ac_b_ex.fe_logical = ex.fe_logical;
 
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
@@ -5336,6 +5351,7 @@ static noinline_for_stack void
 ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
 {
 	struct super_block *sb = ac->ac_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_locality_group *lg;
 	struct ext4_prealloc_space *pa;
 	struct ext4_group_info *grp;
@@ -5347,7 +5363,15 @@ ext4_mb_new_group_pa(struct ext4_allocation_context *ac)
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


