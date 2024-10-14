Return-Path: <linux-ext4+bounces-4574-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF5699BE4A
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D571C221EB
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Oct 2024 03:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09A73176;
	Mon, 14 Oct 2024 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMP0+bPR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6D61FD7
	for <linux-ext4@vger.kernel.org>; Mon, 14 Oct 2024 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728877309; cv=none; b=XXqXiClDuS/RACTaLUvrezPtOXiIF8M4QQyYDIYFk4zPMgOzssTbjvNMGFRGystE/pr8yW4xf981OwxCUmLIfwbpealO4nQ4Dn84nORvzQkqp0m4ZEMBOuCpJ8bMFejfSK0kHHcEileGvgFVHL7/r0pMMe5Smu0fMPYX2FKUynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728877309; c=relaxed/simple;
	bh=ioIrSPsg3Rx2jU3UmvSnVcq9BursESAUvU+C75O1FbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HnHHvRcZytytm1HX+Umk4C0OH2CVP/M7SGB46JTPhId+ZZM+8dxkWXOePfeksxOJO3g4bEQVdYO0aR4yQEwXmmpNEs/i4Gmp4TtDs290inXPTzPp+35Yvr8w/quTgimeGReEa8BOfAVUCtE0AjmUt7QCrWadjYW2xdUGgdxwN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMP0+bPR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c767a9c50so29403475ad.1
        for <linux-ext4@vger.kernel.org>; Sun, 13 Oct 2024 20:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728877307; x=1729482107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7BLdusKPLE/M9oVHLfb7yp7wp0DcplBRn/5LMtWW8E=;
        b=CMP0+bPRBQqlW7P1+FkBRcAyJeK+3IaCv8LcsabjTeMJZwvB7IJ5Xq0Geji4xkJXQ+
         fsRhEUa88L8uf1DS1NfBg1VDp5mg6kE5lZ43spq29yqlph4K9GnUbHKRbu8UMORDm99m
         j1xkrQcXt2n8qluMDrUjR7DZSl/AeRe26II08DTKKeqacj0qzng0M1NunOAZ2ZihLii6
         EWhli30+lCTdzl449w4XV8khUZY+7x3kfEgP8dF+nad1zuxM9+wkoZ0ezlcPhLG2il4u
         wd3x8KzplrcKbE9MVr8koT6vIDeiwI3vYEKGrwF7hVw7lJlaBga0OPxFsx7/VT/zaGcg
         HQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728877307; x=1729482107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7BLdusKPLE/M9oVHLfb7yp7wp0DcplBRn/5LMtWW8E=;
        b=Hux1l13ZOLZfR9WeZdnfz5pgR7qPqQsJ16qBJ+cHWGK8kG6V3VSgdQMCskYTrBQixT
         x3uat9cwoVV3u0SE0afaW7IidgTYq4fjj5CLUJ0qMnrYzIkOxtVbl/a17MFePGVuymb6
         ojlysaib5VgGiGIL42KFcnplWb0Uqwd+1IyP+a3BE4Qyudn6wiuCrJeXx/LSl/SLBgi/
         qEKFPN840iZMjWm0MDlZD5RVFx759S7VeF1xduZCZs4GQiEWk8zox/f6K1Qq7daXFEt/
         Vb9WqI2h9geGTbeycxv4SUFWYkSAWWlYP3VaypfLNB2zAQBWyCiBokmtBlh1JCqNCEHW
         kStw==
X-Gm-Message-State: AOJu0YxDk2L27PR4MX2LaFPR/qRxV/zy+w0oNtykd7pZLrIP8LjV+vDR
	fDfSp6h1VA6HYmLSg6vIKXiog1eCmTCrRuotUbyWXsOOGpR4V5pn
X-Google-Smtp-Source: AGHT+IE3e2r3mDRi5MMbkOjXHJga70eSFD3vbTwODcQ6SVP3C3QEIQeHTU6UA4axgx6Y3uqAmUopQg==
X-Received: by 2002:a17:903:41c2:b0:20b:920e:8fd3 with SMTP id d9443c01a7336-20cbb1c407emr102352255ad.35.1728877306989;
        Sun, 13 Oct 2024 20:41:46 -0700 (PDT)
Received: from debianLT.home.io (67-60-32-97.cpe.sparklight.net. [67.60.32.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bada634sm57053715ad.5.2024.10.13.20.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 20:41:46 -0700 (PDT)
From: Nicolas Bretz <bretznic@gmail.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>
Subject: [PATCH] ext4: prevent delalloc to nodelalloc on remount
Date: Sun, 13 Oct 2024 20:41:43 -0700
Message-Id: <20241014034143.59779-1-bretznic@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implemented the suggested solution mentioned in the bug
https://bugzilla.kernel.org/show_bug.cgi?id=218820

Preventing the disabling of delayed allocation mode on remount.
delalloc to nodelalloc not permitted anymore
nodelalloc to delalloc permitted, not affected

Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
 fs/ext4/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 03373471131c..ef22d227802d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5875,6 +5875,12 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
 		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
 
+	if ((old_opts.s_mount_opt & EXT4_MOUNT_DELALLOC) & ~test_opt(sb, DELALLOC)) {
+		ext4_msg(sb, KERN_ERR, "can't disable delalloc during remount");
+		err = -EINVAL;
+		goto restore_opts;
+	}
+
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
-- 
2.39.5


