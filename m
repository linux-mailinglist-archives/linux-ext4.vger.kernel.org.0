Return-Path: <linux-ext4+bounces-3996-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2AE96693B
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2717C1F248FC
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F691BC099;
	Fri, 30 Aug 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTJI934K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF41BAED9
	for <linux-ext4@vger.kernel.org>; Fri, 30 Aug 2024 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044376; cv=none; b=HK4vTX6113+oiVxmqJImAENIYt7tZ1AyM7tiRjrwIlLeyOY2Xeq1jFpDW2kpe9Nc4pMLI5Oj15Ueg21Hf/QSnwkRpwLj6Ip3fPTpKXFQ0BkonnJAuxdIQa4YFWxJ5cWd6VAlMK/GOzugUOcFoi2hwYML+Y4sWlAcu0dMfMn5mJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044376; c=relaxed/simple;
	bh=1OJeRZgxu3vXyjSqsTNs5iNXEWOriX96q60gDhJ5lW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FK5ZvG4c2Lr6fSk73wyM23G5la6kzwW7PruUgXY9vI7UEzq2tBv5OQnm0oMtiWr6GX+kVpJlX7Ptr+40IlXRoLnwsM9RLT5FjeE2Yfncp03oavuaHDIvh0OdCrI4i24CJYXhZmkUn6z9YjufC+eOumLnuMz2fvWybwGZICeEVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aTJI934K; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71433096e89so1861118b3a.3
        for <linux-ext4@vger.kernel.org>; Fri, 30 Aug 2024 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725044374; x=1725649174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o2aWYMqpKCTdLGxLYP5Pap8M4aMLNuxyS8EvFXLBpKo=;
        b=aTJI934KGfj546NaTZvi85upTa58pDg7l59S1RF6OPLvGcyOi5zBHNXxDMNHkIYYGL
         JeaHx7eS4uDj4WKwz8eXwTVbJM9CdgnpAMPdwzod+SKUciQENJnIhWP8klm+26MejpQd
         UOYxlp1cW/igubRVW7imElfkvluIFt2w/lsqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725044374; x=1725649174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2aWYMqpKCTdLGxLYP5Pap8M4aMLNuxyS8EvFXLBpKo=;
        b=HrtVT/irnIyfhNA3dYD1Ay0mYY8OjgGiZqTLffa3oDUG+hhaFZeFgJBDUJFVL1P6Kk
         TZ+/0NUBxiXDNiuSc0HE/M8nrhC40gxIE91CmzfoszE4TqOmya4BcxpQXlwNHLbFeLHy
         7Ke4W4hUch8CP1xp+xoszZzWcIQ5w3v3bPLC+dTFh9/GxIYo7gkaQyKvE3hud0J1bgzs
         oeHRMBzqs8BPcFrD4G0qvW8M8KanOM4FSfl6yGKTYrc4eCChJye3iz4iLWwlRU0uBtC9
         jfS+JgTxyH52nFIkGfW/d1r7Zd9P7/e2iGvk5+IaIOPhlxagjSWLQ82bxMULG2laMUJc
         PEnw==
X-Gm-Message-State: AOJu0YyMeoHjs9y4zW+w6Aej+ersfuT3ckz2yORFfDDVx3fQ3KdV5ywg
	SfkfOJ/bIuFjKAPTKjjigMd/Jc6NA4q3Nq3I+hNbXHue8AAplusWCdNbNG9K5A==
X-Google-Smtp-Source: AGHT+IFRebUt7dwmU0U9t10aGKLLWURaN1itrXg0J3x1/jgXT1rjgqUltGnyy9DqL55CLZvTC/36bw==
X-Received: by 2002:a05:6a20:9f05:b0:1be:bfa2:5ac3 with SMTP id adf61e73a8af0-1cece5d136amr460746637.35.1725044374515;
        Fri, 30 Aug 2024 11:59:34 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:f9da:6f24:36e4:560])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-715e569ededsm3085258b3a.123.2024.08.30.11.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 11:59:33 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: tytso@mit.edu,
	uekawa@chromium.org
Cc: linux-ext4@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] tune2fs: do not update quota when not needed
Date: Fri, 30 Aug 2024 11:59:21 -0700
Message-ID: <20240830185921.2690798-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling quota is expensive: All inodes in the filesystem are scanned.
Only do it when the requested quota configuration does not match the
existing configuration.

Test:
Add a tiny patch to print out when core of function
handle_quota_options() is triggered.
Issue commands:
truncate -s 1G unused ; mkfs.ext4 unused

| commands                                                | trigger | comments
+---------------------------------------------------------+---------+---------
| tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | Y       |
                  Quota not set at formatting.
| tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | N       |
                  Already set just above
| tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | Y       |
                  Disabling a quota option always force a deep look.
| tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | Y       |
                  See just above
| tune2fs -Qusrquota,grpquota -O quota unused             | N       |
                  No change from previous line.
| tune2fs -Qusrquota,^grpquota -O quota unused            | Y       |
                  Disabling a quota option always force a deep look.
| tune2fs -Qusrquota -O quota unused                      | N       |
                  No change from previous line.
| tune2fs -O ^quota unused                                | Y       |
                  Remove quota
| tune2fs -O quota unused                                 | X       |
                  function handle_quota_options() not called, default values
                  (-Qusrquota,grpquota) used.
| tune2fs -O quota -Qusrquota unused                      | N       |
                  Already set just above
---
 misc/tune2fs.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 6de40e93..3cce8861 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -1804,6 +1804,41 @@ static int handle_quota_options(ext2_filsys fs)
 			qtype_bits |= 1 << qtype;
 	}
 
+	/*
+	 * Check if the filesystem already has quota enabled and more features
+	 * need to be enabled and are not, or some features need to be disabled.
+	 */
+	if (ext2fs_has_feature_quota(fs->super) && qtype_bits) {
+		for (qtype = 0 ; qtype < MAXQUOTAS; qtype++) {
+			if ((quota_enable[qtype] == QOPT_ENABLE &&
+			     *quota_sb_inump(fs->super, qtype) == 0) ||
+			    (quota_enable[qtype] == QOPT_DISABLE)) {
+				/* Some work needed to match the configuration. */
+				break;
+			}
+		}
+		if (qtype == MAXQUOTAS) {
+			/* Nothing to do. */
+			return 0;
+		}
+	}
+	/*
+	 * Check if the user wants all features disabled and it is already
+	 * the case.
+	 */
+	if (!ext2fs_has_feature_quota(fs->super) && !qtype_bits) {
+		for (qtype = 0 ; qtype < MAXQUOTAS; qtype++) {
+			if (*quota_sb_inump(fs->super, qtype)) {
+				/* Some work needed to match the configuration. */
+				break;
+			}
+		}
+		if (qtype == MAXQUOTAS) {
+			/* Nothing to do. */
+			return 0;
+		}
+	}
+
 	retval = quota_init_context(&qctx, fs, qtype_bits);
 	if (retval) {
 		com_err(program_name, retval,
-- 
2.46.0.469.g59c65b2a67-goog


