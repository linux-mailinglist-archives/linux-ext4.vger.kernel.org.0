Return-Path: <linux-ext4+bounces-5201-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C977F9CF018
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90950288C53
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4231E2830;
	Fri, 15 Nov 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uKQ/P9Pu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF71D7E21
	for <linux-ext4@vger.kernel.org>; Fri, 15 Nov 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684694; cv=none; b=pnaPJficumQIjaRVciXfu2aTp0xutM/w5IUbKjMVNahnGhga4jMU/q0rOdXWFIgC3bh2ijzzg4YD27ttYugo6WUni5oDV+IT6hLjfHjHX5ygHyorMEDntE0Mhxa5lfxoxqf8onnOi8omuSiqWE+Wg38PXBBYoABK/gGMUzSeoYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684694; c=relaxed/simple;
	bh=6M2usmJQkSj6QxVwbWiMg28e+rwVNQY/NgVhiKLrG4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FioqhaoFNmbohXHV2z/rutYluIH2DtqZIO0zm8unNzmzSX0Us7QRmvVFkOWFdW6KhMRce2EodKVTyYKWpCzLa2AFlsm2TGFRwXHTT//QKF1Y5H9oCp0po8AIopyoTZCGrpVlfZ+KAxnY6GLbuX9uT6vM9uBMgt7U6KZHDQ7DsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uKQ/P9Pu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e38232fc4d8so937755276.2
        for <linux-ext4@vger.kernel.org>; Fri, 15 Nov 2024 07:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684692; x=1732289492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZU0dZL52CuS55HBpnlFc9Ffg6kvih/VgFXFf1fJzIbE=;
        b=uKQ/P9PuFqn2v7/y0fPda/iahcVOvKuurxOPKOGMxz9eSY4nXNQDVsnvDGU2Ec8mjZ
         v89OE1RLsZdFLxGDqwUJktUi8JyMhBAkBylNKxz/f250qEWPWI31Yap7XI9JWr5W28Nn
         A+lur0VaWwtsm+zcVfUrp7E8nIwdQK9/g/9M1d3v+XDOB4oHPKT3BFokosAtiAj5ZvWr
         SbSYUgLs8vEpzWW1WUbOqwOfC1zktamhOQuDGWodGqjORQmXMoxvtDoSID4YA9fKlEwW
         XUAT9ZuW5tqUDv6tzOGdWM9A6S2AmccWeMvZczUHR1fWVk++64ofO1Id/eIiMg2BHMEK
         TC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684692; x=1732289492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU0dZL52CuS55HBpnlFc9Ffg6kvih/VgFXFf1fJzIbE=;
        b=tA6gxHDhuuQ9DOhrVtc/kKKJ3kGoLmbZUAUPRw7ZDwm42WA/hTQPtqFvMs5WhXjWJc
         r1w96WwnzwhmTH2nQ/MQIICaLWyjfWiblY2dyJ3vNch/L8cAcztsR1hrOAEP4xZtu0ld
         O9hQIZ3AJ/XpQXq5t050rad1Ubs38svSHm2tRCmSxzcLkPiLCyuOfqNroF8HGmfilNZ1
         6Q+wyp5AdJ8PGhlwE4fTeyC2pZyNPrsJXsvsmE21oPb73WzpCefWf8/CyPcXtnIpxEYa
         HSYz4DAXagSWQ6FEyxtY4Hj5w1s9+SDnnWVHBU9uN5A25z68QstVO1ARjQBPNo+yeJq/
         hrng==
X-Forwarded-Encrypted: i=1; AJvYcCVejS/5NXBKW+4CtLig33WxgL8YnKTrCorC6nj0id9mqpKOmKrCO0nHep1ErfvDL20D7JGXvqh2UmrW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Q2dI15MLOvlbiBjTH3Jio0W6/AggqqpqtaasCJJLQeBKWhEk
	1iIVTY4AXjIJmOjnCNtjfZ7biNsFlxFCURCud0NMXNXIYUWaLkEGvKeEB3Xww3o=
X-Google-Smtp-Source: AGHT+IGL1oUEZJ3rWhtkHzcHN//l4Kwa6WIU+uMQ5VnS4NxAxx6XDhapJjpe9N68qs8G4gEKoRwuyw==
X-Received: by 2002:a05:6902:1825:b0:e28:fa51:634a with SMTP id 3f1490d57ef6-e382615f44fmr2204741276.31.1731684691641;
        Fri, 15 Nov 2024 07:31:31 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152caccdsm1011626276.14.2024.11.15.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:30 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 06/19] fanotify: reserve event bit of deprecated FAN_DIR_MODIFY
Date: Fri, 15 Nov 2024 10:30:19 -0500
Message-ID: <632d9f80428e2e7a6b6a8ccc2925d87c92bbb518.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Avoid reusing it, because we would like to reserve it for future
FAN_PATH_MODIFY pre-content event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify_backend.h | 1 +
 include/uapi/linux/fanotify.h    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 99d81c3c11d7..2dc30cf637aa 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -55,6 +55,7 @@
 #define FS_OPEN_PERM		0x00010000	/* open event in an permission hook */
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
+/* #define FS_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 /*
  * Set on inode mark that cares about things that happen to its children.
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 34f221d3a1b9..79072b6894f2 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -25,6 +25,7 @@
 #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
+/* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.43.0


