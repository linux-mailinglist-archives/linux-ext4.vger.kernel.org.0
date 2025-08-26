Return-Path: <linux-ext4+bounces-9633-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92147B36E19
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334C11BA8818
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6C3568E6;
	Tue, 26 Aug 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Qx7xDk2Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0234DCE8
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222862; cv=none; b=aMMw6R//R5MXJ7bnxhVV/7550DDQ5bZu3dFZy8IYRso4zGj6Ke/3KQ1QRap/VRr3dFpQCrykU7N9Z49KjNqM6wbkijwlVfJzzVoc5etQaQxvEtKXMIlcIuURuULtJ0BAsuLT5PrQkEqfn97FGGKfoLTxSWTf3NV5aAgbgtZSWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222862; c=relaxed/simple;
	bh=vb3lgatLL22BxERk9/b+lCqLtXz3W8a2P/7Gr1XM4H4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRTy+GH4dJ5jW7wTplVJ+4MoI64hDJtvuT43Ua6MKKUykeS9zmXL+Ot7W3jXSzbSvfoOn7d1tknaTSgMypM+XzF3xzYFwVEB0UW1RrC1sa0eqe1Hszpkkab7VnmRZTlNQZi2w7rbfi666lHbllIEA7yIS8g4HjjaQoX/V3Q/jAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Qx7xDk2Z; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603acc23so45327347b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222860; x=1756827660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgvK09Ne5Aq6jRiEthgDjLIcJNkO/NakbksX6k8jf14=;
        b=Qx7xDk2ZZPH1b2wholEdBMKOO4Ugu9Bjzye6rSVT7PbRbJhUDERheM1oMAZR0k/jb/
         5/Ibffdz2WOiGrC1l3dKTc90rfmIvV16iXNw4tariDYGqhLaFGiq1ncqlrMYhPstSKMn
         8uHzstew7KMfdNxZUpzdGP/NKJ/b632/2eOdAN+cjiZIEkIDzorxXRMpjkz3wAAbkxFk
         v7Enw8MxdFr3Z6m/qKrTGIJ0yacWeiLBz6n3rchwtE3PiPZDqsW8msDwatxNMAEBNcsF
         G7MJv/v29W1PMa6Y3gg0MSmN1x3vnPgKWv0KUs/LE0rrjU9/jkwmxvkBiAWEE32429m4
         FtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222860; x=1756827660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgvK09Ne5Aq6jRiEthgDjLIcJNkO/NakbksX6k8jf14=;
        b=p3k3BoFvVpidak5HgInm1iUFwVBUkuKccNFh9JhJ7FyIqjxsOftKJc73oKSwBTrHus
         RT1Z/FGiJSBRF+s6LIS5ovrDvNSacVY2+ySHvgRcpz8bmdshS9cnkiXl+oDq0EZDVtoi
         QTLLpOItxvVryCITRH2x6RmCnrRHD8+0fVfP0d35BoIJLfHx2Qc3oky6kOxmAh1Fsqyp
         rdw1qZBKQrqwdyC5E8194E9QhHo+NF/4pipPQcIM93TySFC6bKCqWaed6n452XQw11AZ
         FlrmWPRmv9Lt+QDE2vtih7hEKw0pSU0DMAQueKrL17qeMk2e++zEsvpjDK+NGOWz3ICq
         t6rA==
X-Forwarded-Encrypted: i=1; AJvYcCVXD5crrMPavMAT1RWKEx1lSZL7xSKdp5sIl5UYuC6gWE7Cessg/WNU+0J6MYo3kWhm1jTobSm8JC/k@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtKGbjHMFl+HfX2eNLD4ButspBTJp3gnYOxzdiDWH9vIjD2Ka
	V0llVt2DQws/KP2lF/n9f3OcxBzoW8OkQkmBL2aFyzDVm4t93e0radmlj5ZNoq8hwUg=
X-Gm-Gg: ASbGncuZtNuJEkH4QjHMNThoRFWj5U8PyBSRvuahvippoOycrGTWD+z7B1KTUkGnpPa
	11y0csNc5PPcLecgf4Z3ymSy4FBmtf7MkuJbcQexKuVjxBZ8fIhxNXe71C01L5ZL61QqKxbxg8s
	9xVuoowxoBtgJpVs9wWDaFl7JYOD/CIgvH5TX1VE2DV2pyhZxPlv/fkdVnxHPpT12gSmcWkwSDC
	ypGSulOuCyY/M1bYmSUMc6eUgkUgQ0frVo1Fx2AGvnG/9lChZy9wXn+jHCc5b6xnTnE9ogtH3EW
	scvRLGHVF0R+frSy+yntp0qsig1jlSTZWmRlOu2prl0ZRIjSJsUfoEqHpuiBjsgi8n8B9aQyesI
	dIC6LD/mgiYr0mc+jmOAbGBxsdTRSzXJOU+xORkcZQk4uopH3+eMPnBJ6Utk=
X-Google-Smtp-Source: AGHT+IFHc0cd1vBL1NZ56pvHPXho4UE/Yj/BshipiSC1BWzt1LmJ0zTyz+AzopKHLGkL4tZhqzzqxw==
X-Received: by 2002:a05:690c:6108:b0:720:2af3:fad6 with SMTP id 00721157ae682-7202af3fbebmr100372157b3.17.1756222860145;
        Tue, 26 Aug 2025 08:41:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17339fdsm25180647b3.21.2025.08.26.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 08/54] fs: hold an i_obj_count reference in writeback_sb_inodes
Date: Tue, 26 Aug 2025 11:39:08 -0400
Message-ID: <1e555c73564393129833d550965e3175c142bb84.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We drop the wb list_lock while writing back inodes, and we could
manipulate the i_io_list while this is happening and drop our reference
for the inode. Protect this by holding the i_obj_count reference during
the writeback.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cf7fab59e4d5..773b276328ec 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1977,6 +1977,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 			trace_writeback_sb_inodes_requeue(inode);
 			continue;
 		}
+		iobj_get(inode);
 		spin_unlock(&wb->list_lock);
 
 		/*
@@ -1987,6 +1988,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		if (inode->i_state & I_SYNC) {
 			/* Wait for I_SYNC. This function drops i_lock... */
 			inode_sleep_on_writeback(inode);
+			iobj_put(inode);
 			/* Inode may be gone, start again */
 			spin_lock(&wb->list_lock);
 			continue;
@@ -2035,10 +2037,9 @@ static long writeback_sb_inodes(struct super_block *sb,
 		inode_sync_complete(inode);
 		spin_unlock(&inode->i_lock);
 
-		if (unlikely(tmp_wb != wb)) {
-			spin_unlock(&tmp_wb->list_lock);
-			spin_lock(&wb->list_lock);
-		}
+		spin_unlock(&tmp_wb->list_lock);
+		iobj_put(inode);
+		spin_lock(&wb->list_lock);
 
 		/*
 		 * bail out to wb_writeback() often enough to check
-- 
2.49.0


