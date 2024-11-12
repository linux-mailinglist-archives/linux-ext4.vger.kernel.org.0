Return-Path: <linux-ext4+bounces-5095-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A69C5FA0
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 18:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DB31F24065
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8D821767C;
	Tue, 12 Nov 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jBB1u7L0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C25216E07
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434197; cv=none; b=dLULtq5ejELTYod3eDOiewhFS6G4SwNfHKuwmlMnoF6iKEJJ0c4Oppo0SI77aD/otSk7A6JubA8ww7AMW/vXnT+l/VgIqtTt1VmpC5hakUUd3LavPlarE7Tc56P9OQVqBpOvgGIu6Pcc4lmw3cOxbX4jMutNdpRJQQNP6tCqXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434197; c=relaxed/simple;
	bh=S9iJZLC3kW1AcdAAZXs7jDb7QSsAWUdTUn2Xw7khTW0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqCCWIs1/i7NXm4+UjTtslROqsiK8by4AO1bpsdg7p5EAmLWBxF9+BBHM48RO9+SDu+eeARJ9qt1AfMHqGT0rAKnQI9ZjEWXDVihlE4lHaMk6j71V5FHuPL4wgMDLkh/ZlLZS04xZwbZu/r1EuWQ97qOecPL142qGtXTz8RV/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jBB1u7L0; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e2918664a3fso3723276.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434193; x=1732038993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLBk0eY4CldnJ4xEhkKNTvdMfXwQixnxnwnrlcZUems=;
        b=jBB1u7L0m/LXhuHZy7gUl97BSCkPWmsm6cmMadOwA3Q9sCbO19IBQiwGfczMHlLYM/
         pt/ZN9enORDmu5aGJ1uJA8I9EJ/1A+nta39bndgKZUIu6fPgWxX9nPHtGpFOWMJg6zOy
         /HsJO4vPQidrvQ1UmCQq2uiUp6XuitdYzUK18G2NQ0gfFTCUomGcX7SJprfijVvF1GOl
         6i1mkff/dasrrqrYcZYOlpkSQQhTAGANco3MyjxxqSchtOXAv0uV/HC/1KOdutlb+qAB
         Vq3B2BquxBbiwtYALc8qUKvHbogG3TI56LC9kaERQ3vdjYYJDc3hTXhoyEKHhU1+q3NL
         0orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434193; x=1732038993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLBk0eY4CldnJ4xEhkKNTvdMfXwQixnxnwnrlcZUems=;
        b=HWr5Yb6weju5pBXa5S23MQ+2MQjZj0Tlo0+hw8PSCOOOYLQvDvnZvRZ1fiJM7MxwG5
         nW4MIe9uopctAAvrnPBUGitlAOsQuLPpxtOxFktaHwRVRf7LwZOMJ4byLm5w3A+oaXU0
         56af7zy1CEyMyYfLLgZWplaDY2Lmf7RefsGDfwZ9cmCsFTmmTclcytJidkrIh/QIsIXq
         O2ePEEOsZyh3wKE4RMU4R6KHJssPh+J6q1MIccbw7Jud97eGneEnSpU8+NkbwgFT0l7f
         7m1x1oY4nizBcIvetMMclyRUlZqyklQG30xcAt4v6tcSf6U0qQMLDoEiexF7xR5YZ+1Q
         Qh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/kefAfC+ZaQpHyHdAQWmv27OyLFYS5aTt/iChfnzcScGUnGhz9mMDm49XoWus8AnZzJdI+8Za9BD0@vger.kernel.org
X-Gm-Message-State: AOJu0YxSNL/k4xh/F9yyD1eoXMWeB3cU122689/5AdyViPLPosnu8xRx
	7ygVVfIPQmXrnuluv4yfLYO6l00s5vJigojXo4CT0YRMDKa7pHSsIgr5OstQ1tA=
X-Google-Smtp-Source: AGHT+IGq9atUwLu6yRfGGU3gZisyi+y0UAqwpKFwzP1csSwnkEjcF1T1CgCueeohLnBc8+4LN1Gtbg==
X-Received: by 2002:a25:8481:0:b0:e29:2988:ecf0 with SMTP id 3f1490d57ef6-e337e102bdfmr14488297276.10.1731434192790;
        Tue, 12 Nov 2024 09:56:32 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ee1526dsm2752624276.2.2024.11.12.09.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:31 -0800 (PST)
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
Subject: [PATCH v7 03/18] fanotify: rename a misnamed constant
Date: Tue, 12 Nov 2024 12:55:18 -0500
Message-ID: <2142cdfd0bce931024cb715b6e178f3f5c49e797.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8528c1bfee7d..9cc4a9ac1515 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -118,7 +118,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -173,14 +173,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
 		dot_len = 1;
 	}
 
-	if (info_mode & FAN_REPORT_PIDFD)
-		event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
-
 	if (fanotify_event_has_object_fh(event)) {
 		fh_len = fanotify_event_object_fh_len(event);
 		event_len += fanotify_fid_info_len(fh_len, dot_len);
 	}
 
+	if (info_mode & FAN_REPORT_PIDFD)
+		event_len += FANOTIFY_PIDFD_INFO_LEN;
+
 	return event_len;
 }
 
@@ -503,7 +503,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0


