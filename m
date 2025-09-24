Return-Path: <linux-ext4+bounces-10378-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E8B97FBD
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 03:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F329318976BB
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 01:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39431C54AA;
	Wed, 24 Sep 2025 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuBwAsZD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5A8C11
	for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676569; cv=none; b=jn4kC3mrGS+pywEEn546X6vPqgyp6+igIE2+ShcRM23FUZOWirgaQnR9017OIG7WTwtzAVoJudsg0WAmze14s2XOrXMRjsio/QcZFYEohG4DVGWjTazzlx0IG5CrNEKBNwKOhDXBmDMq07FLzoeSxOGO0HDgl/DRdzla7YdYUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676569; c=relaxed/simple;
	bh=AwRt98PLF+0uNY1wnFqWynqXeGH365J0oHAiztHFnH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bXiA5wA0wm7EKZ6JVN2Ll7CZJbKdjx/qJc8lwTbcYf06Ljape6+AlBA3ha6apWJ2yb+FjQNQhHon1gMkJVetHKD+mkJ3rWm+D9CrjARmFMigKOg99SnheFYuhQAP2MOC9rLlJ1Mmo8ytiJqxEFB+b53gYRbg0s/O+3Xu+F006i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuBwAsZD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24456ce0b96so6422015ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 18:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758676567; x=1759281367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmYWM8Z/roMtlrp5aO89HRVded3LToe4TxL6a/RxYVM=;
        b=JuBwAsZDV8bxKw2V8nhnIVTWY1wWutWmAhVw6qN2UbXCKA9NXu7RIqLmUTTki90TjF
         anXdaAcAfBhq3SH+RhN8nYdyCF3uR3krbuxBBHZt+HitBfXNKIWS2pPtDXLv+FwgzkRt
         5ONrXm1LEeP25h0MfVKGeYH8uk8kxRJO6om1e9zUmZb8i/PAXX+jnBsdpE84h8KddCfx
         ribQeWBG99ISSQWHdy+Z4Ea16YpADZHv+eyymHIxnINKt9/M6u4U3Vwp6i+exdLN6r5h
         lt9hMEUPumMtSuvCEL16qyDvDtweOrEyUSHqBWCr5PD30H4wSLW2voSAZGRFEVMiYugA
         +tKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758676567; x=1759281367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmYWM8Z/roMtlrp5aO89HRVded3LToe4TxL6a/RxYVM=;
        b=oZaTb8M/0Gav18vGz/NWDk16HFmCl39356QXmh0ShSMKuNhamCwxaTYEpal+x2BR8J
         ozeYsZsvrjQPC+VOfOSkAh2KGG/2P0EHLt0VD3UuHDxTDzljlNtnAYgxwOYOrhiMbPe4
         bGzZzsJ6vwtevFuIgmwd6UblhJVeyVdoyHAYscV1gEnXew6SSuLFoFesBi2RnC1peLUN
         PO0GNqOtLIBq4xiovdj2yCfq/xliglq0fMlwfisO/xR0lKlafpcf+hGXIFom9nY/Cc2f
         XFsHRdHLf7Ek0T1JfFM6OWqeZsLK3V51mPMdbrFfgeEHhn5FTrQhQ2yH0cEn2n/TYpeT
         7BSg==
X-Forwarded-Encrypted: i=1; AJvYcCVSmB1rjo8/M9015igPz8n58HGVybksbrhF/kGj1hDL92WRN2fugsGSlGbk939KFeuuwxm0LIP7a5cx@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQh7I7Pno7esEjFoiRVSPTO77uK4PcI6BKUup9DqOuJspHZyK
	6RhNOVGdNFbJ0NHDFBQxFQrTr7Mc0MZ3lZ4MbW0bnk6zmcJveAlsi60m
X-Gm-Gg: ASbGnct0+J4AxhauFqKWjSEFYdsiFZSt7uxN38dxQmnxX8n6EVAe01OB9LsolSXf+H3
	uh85MB+8MyshFkriaNoeOd4FbrtvBmSJlWbt/C1RcVhsVnfxQ6TUOiX0dORcsF+8/ARpT3EtO7G
	SuSdKH3MruS0CqsQ9wuGAi6HpBxHHc6xm26cAnn6EdAFPDo+We9BxhwPebHeg49tUml4nD4UChu
	XRu//IfJMX7az4+bBbUqDx6/LxMlq0Qi7xFWGUTn4l2JYu+VqIprv+fobvEgadpvERK+75sNzZA
	6FNCJh76/NV0XM18ws7E7mNUXjqzunFnOYSPr6ZRkfPick26f2poSzNIXk0zdrOUFDsNqPqYGT3
	V596ZWhgI612GMsVtzuXI3ou02eqj0qoDSF3kbiLlhjtIG6tanrmRAW9klwOMn0D8YY2QrDSkoh
	I1dGwOw0qBmXeG8iS1K5/mA0/ege7Wf1E=
X-Google-Smtp-Source: AGHT+IF2K4ME6oNGnHPP6a6Wh//Hbt1hnABF98AbnESIlitVBHjYmmiLru3v79EEvbaMsrGAJWCvsg==
X-Received: by 2002:a17:903:230b:b0:267:8b4f:df36 with SMTP id d9443c01a7336-27ec13cce7cmr6823895ad.29.1758676567287;
        Tue, 23 Sep 2025 18:16:07 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a860:817b:dcc:3e4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368fe3sm169878605ad.151.2025.09.23.18.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 18:16:06 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Wed, 24 Sep 2025 06:46:00 +0530
Message-ID: <20250924011600.1095949-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix WARNING in __alloc_pages_slowpath() when ext4_discard_preallocations()
is called during memory pressure.

The issue occurs when __GFP_NOFAIL is used during memory reclaim context,
which can lead to allocation warnings. Avoid using __GFP_NOFAIL when
the current process is already in memory allocation context to prevent
potential deadlocks and warnings.

Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Tested-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5898d92ba19f..61ee009717f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5656,9 +5656,11 @@ void ext4_discard_preallocations(struct inode *inode)
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
+		gfp_t flags = GFP_NOFS;
+		if (!(current->flags & PF_MEMALLOC))
+			flags |= __GFP_NOFAIL;
 
-		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+		err = ext4_mb_load_buddy_gfp(sb, group, &e4b, flags);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
-- 
2.43.0


