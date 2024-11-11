Return-Path: <linux-ext4+bounces-5025-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A49C46A1
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 21:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28E1B28C54
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 20:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D471BD9FC;
	Mon, 11 Nov 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EjWQBVgF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4201BC9E9
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356361; cv=none; b=eYvFJcWDzAn+8OB5Krp9pcW8oJYltHrBo6iZdEpQb6kP6Hk2qMPSRvNDiii1a3fQDrlYEtOqGeHagbQyOQvEZ+8i9zKwEhUqjxkecGxYtKnEDD7vmBlVKUCq9AFort+QhJMbPdCgO8SK1q8iBnPvKLkJiQOg7sXIK/fDwdQgjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356361; c=relaxed/simple;
	bh=TmnKu6gi+WKKtr7qPjxxquG53LAeVZdzHoqpUlbbS2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SstcUbJcBDemCRWXRXMHTQzs6w+Y4gDy5KqsCWp+9tmD3qq7E+H4ZpsiiON2PV8jywWWe7nq6wgXeUiws2lzYAooRzFYY23PcwRcy5tN/6olYWN4kjNpMFwEWyry5R5ojo0oYqOwFh6TvQH8gG++6Q29KkILE1wBwlYp3FwP0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EjWQBVgF; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460c2418e37so38296001cf.0
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356358; x=1731961158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gc+ksxaIwBOBmlko1WTmjrx90HfK/kHGON+QNx8apDo=;
        b=EjWQBVgF7zw+qFqexL/S7ovocSsG7/9psnTNs7bun9l1TWbRKUkg38WT4N1hegsn0P
         p7szfHJNSsndulSd8IC9d2LpgjA8yU5y77ziKwB7Du04A7ggNFtp5daWGC1O56JsJ0o6
         60x20h231kIJDinBm1Qq83pAkup2RvZyLqvuqVce7qBnLNjycdGxUl2EBBOtgIYI2R2r
         6MrS1ZLoJh3mdwqkkf7dhm2s1Pr8VN7Bkd71J4jG7q7EaoWbB3l6eJXGmvnDomXSKHku
         yEPCDc6+RpRYqc1OK/15dQvL/GK7ZYPcSb+QF2GwoQsBOo+u+kj5O3ctLyZmbB6SA/Ze
         B3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356358; x=1731961158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc+ksxaIwBOBmlko1WTmjrx90HfK/kHGON+QNx8apDo=;
        b=R6KJ4QjCbKE9f/tsqMVUL2ijD+2ihqC8yhquYYO2RqddXre7zyOWUsxJRHm1wZTfDR
         1QsUZO9RaL3WR0o8kqaWGoUTA8fN7veSH7xu2sB+XhGAFTEmzhrGVL+IAmJsMoMfLlai
         qFvZHgmwH579BiicE+ly5TYLauwizAo95Ya6wlL/HWqIJc+N3fRGz2JNsWcoc43LpnpF
         FNnz3vFnszHpDwfFEoi11z6EXqj6hqAL83fnd3VntHYV9DM3wG+fSU69qAAG0bM7MEtW
         aPR/PnDbHI/TvWzq1LrTFbYJfVz3N+hCIavj5kvbG2pX2NCaq5q5DmVmr7RVjV9mMnhs
         PfEA==
X-Forwarded-Encrypted: i=1; AJvYcCUIfdaIJNdxUL7f1+BTomMDc+BPor6LbSmailyqy6JXaeW/ktdOi2Hq/z7/D4Dh9j+rKPdiXi1hackh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0r5KlNePez2FmUvbvVD0WWvjjnoTHsmKjfa6Rvp7xQHYYytvt
	kYEbTKfrxnt4IJE7tbbi+mNx+w4xkqDaB8gRpPD/93WPxfiD2M7Y9SSBTTZ2bwU=
X-Google-Smtp-Source: AGHT+IHqngnO/59yGfndmsDZIAVzuHVhRF3bKyXBU2iniiGLSmmnpck59CK/mpALqfBlBcxTed5EdA==
X-Received: by 2002:a05:622a:4d:b0:460:c5b2:58b7 with SMTP id d75a77b69052e-4630942cc70mr178650181cf.51.1731356358100;
        Mon, 11 Nov 2024 12:19:18 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e2385sm66402261cf.88.2024.11.11.12.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:17 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v6 06/17] fsnotify: generate pre-content permission event on open
Date: Mon, 11 Nov 2024 15:17:55 -0500
Message-ID: <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
References: <cover.1731355931.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Generate pre-content event on open in addition to FS_OPEN_PERM,
but without sb_writers held and after file was truncated
in case file was opened with O_CREAT and/or O_TRUNC.

The event will have a range info of [0..0] to provide an opportunity
to fill entire file content on open.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/namei.c               | 10 +++++++++-
 include/linux/fsnotify.h |  4 +++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4a4a22a08ac2..b49fb1f80c0c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3782,7 +3782,15 @@ static int do_open(struct nameidata *nd,
 	}
 	if (do_truncate)
 		mnt_drop_write(nd->path.mnt);
-	return error;
+	if (error)
+		return error;
+
+	/*
+	 * This permission hook is different than fsnotify_open_perm() hook.
+	 * This is a pre-content hook that is called without sb_writers held
+	 * and after the file was truncated.
+	 */
+	return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0);
 }
 
 /**
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 22150e5797c5..1e87a54b88b6 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -171,6 +171,8 @@ static inline int fsnotify_pre_content(const struct file *file,
 
 /*
  * fsnotify_file_area_perm - permission hook before access of file range
+ *
+ * Called post open with access range [0..0].
  */
 static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 					  const loff_t *ppos, size_t count)
@@ -185,7 +187,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	/*
 	 * read()/write and other types of access generate pre-content events.
 	 */
-	if (perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)) {
+	if (perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS | MAY_OPEN)) {
 		int ret = fsnotify_pre_content(file, ppos, count);
 
 		if (ret)
-- 
2.43.0


