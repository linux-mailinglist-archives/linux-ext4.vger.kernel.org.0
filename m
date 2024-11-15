Return-Path: <linux-ext4+bounces-5205-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D249CF02B
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 16:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D1028939A
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1539D1E7643;
	Fri, 15 Nov 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CzPngsSg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D01D54FA
	for <linux-ext4@vger.kernel.org>; Fri, 15 Nov 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684702; cv=none; b=QIDf+buwhg9DN9i5MgRB2Db3cc+sSIMpU26NKFalgSzDx/F3+EWxIwDN6rjT/vT1bGDdFQ7q0BhC+ptg80Z7xORNOxkJBe2LiwoI6DN1kykUUHdSs3lMrzO83/m6OxfS/8Tth6DtWNu7xK0YkC8EbOIGH1HOCJZ95vGg21my/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684702; c=relaxed/simple;
	bh=+vh7XYQNc0Mmotjj/me3TyhwT+zvkyytR/geptCocis=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJglP4eiRK2h+G/WcYmKFtRWf6IidRmo2vD03YbI7fn7Eu4Jlmffa4rYeeb/NZUw+0exY3sQfdXtVNiDHgEzEtW02jDYlwTslF4cg5Kr+z4g17oHlH/gKXy7bh69MrE7WvPgEGQ4QgWOgRUzZgf1xXVtgbKrSsAvbig6L9ge6hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CzPngsSg; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ea07d119b7so16596207b3.0
        for <linux-ext4@vger.kernel.org>; Fri, 15 Nov 2024 07:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684700; x=1732289500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28nbpQbjD2HwWvaUP2yIn55iQ73mbNzvgMCNeqvC6/0=;
        b=CzPngsSg0Ayw3cUraqYxPvvJeSwl+98SJlyONkNew3pXIGP4C+89njHXE6gH3xvyWt
         E98tBfyqeIMK/auuK7/I4H4DtI0vDHAOjcBJxxck45fhscVx9hz3Lula421yi+Z2oNjJ
         kw+dJ71JpXOFuTgi3oa7OMkGO9YnRWiq+HYhT/10Rmj9bCcdFS7+BVKIz5wqI4w3uMmp
         Je3TDKHj4Vb7cX9t0SPehKaslDonRsROR+SwO9qBxJSe92mqgSQBvvDb/B+lO13rR4dy
         o6/+Kx4fj+THDZvfe0vmDNXP1r2K95+kG/xLe2FhQFiTsUOIbifZhJrBM417v8JECcpD
         xZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684700; x=1732289500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28nbpQbjD2HwWvaUP2yIn55iQ73mbNzvgMCNeqvC6/0=;
        b=XvVqbV92Nq8Q7yKHg5HJFygEuI+Fk1jXZGTo17kmuXgDSaWLhsbn/iY5MmV2IEwlUL
         yAnXxRNh0PgJ2m07M8IPNQ0/MdyWvLBm992+kX1whAOFjfE2s9fr47uKUGn+ByIjc2iU
         GBe5fPFdRXGQKfeDR7bvHE2gYPcGluTLc+Edi/edpG6PAuMj4Z50oE/KgjTf8IzqVVOO
         crjYDKajO2Mw2KyUIggGDQwz6QUNBMPi28V4pQWH7an69eJCZeyowFd7z5XZ75BuhDKy
         n+LfD+CW2u/hiwB/vSCp3/i5GFHnwapUjzTgXSy32dU674oWaiFz2KAeZjrU8y74bm3g
         iCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/iJO+xXq6zrnwx6sQIBmfIncgOeGOyFEUB0reFwSs/3rrIBDx6aqzvfZv1iidERyuGvKBO77eeooD@vger.kernel.org
X-Gm-Message-State: AOJu0YxpaumLvg293IC3U+qeTAMEKeFcNHfqxwi4ESIyu2JhZYiKngqe
	oPmmKhHX2eb1RR6MWhI5SCGbRC1gDadl88AODaXhzWdiIQlZW0PZ2vF+iIvvV6c=
X-Google-Smtp-Source: AGHT+IEjW291jTkKzHI4Ae+C3bnCRuhWYH/1lq2dSUG1bbeWzCUoX3SJFcI3pBBBVFezHIznGLjunA==
X-Received: by 2002:a05:690c:67c9:b0:6ee:4bee:d912 with SMTP id 00721157ae682-6ee55c304afmr35158487b3.21.1731684699892;
        Fri, 15 Nov 2024 07:31:39 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee44413323sm7692477b3.77.2024.11.15.07.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:39 -0800 (PST)
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
Subject: [PATCH v8 11/19] fanotify: report file range info with pre-content events
Date: Fri, 15 Nov 2024 10:30:24 -0500
Message-ID: <b90a9e6c809dd3cad5684da90f23ea93ec6ce8c8.1731684329.git.josef@toxicpanda.com>
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

With group class FAN_CLASS_PRE_CONTENT, report offset and length info
along with FAN_PRE_ACCESS pre-content events.

This information is meant to be used by hierarchical storage managers
that want to fill partial content of files on first access to range.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h      |  8 +++++++
 fs/notify/fanotify/fanotify_user.c | 38 ++++++++++++++++++++++++++++++
 include/uapi/linux/fanotify.h      |  8 +++++++
 3 files changed, 54 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 93598b7d5952..7f06355afa1f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -448,6 +448,14 @@ static inline bool fanotify_is_perm_event(u32 mask)
 		mask & FANOTIFY_PERM_EVENTS;
 }
 
+static inline bool fanotify_event_has_access_range(struct fanotify_event *event)
+{
+	if (!(event->mask & FANOTIFY_PRE_CONTENT_EVENTS))
+		return false;
+
+	return FANOTIFY_PERM(event)->ppos;
+}
+
 static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 {
 	return container_of(fse, struct fanotify_event, fse);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 5ea447e9e5a8..c7938d9e8101 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -121,6 +121,8 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
+#define FANOTIFY_RANGE_INFO_LEN \
+	(sizeof(struct fanotify_event_info_range))
 
 static int fanotify_fid_info_len(int fh_len, int name_len)
 {
@@ -180,6 +182,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	if (info_mode & FAN_REPORT_PIDFD)
 		event_len += FANOTIFY_PIDFD_INFO_LEN;
 
+	if (fanotify_event_has_access_range(event))
+		event_len += FANOTIFY_RANGE_INFO_LEN;
+
 	return event_len;
 }
 
@@ -516,6 +521,30 @@ static int copy_pidfd_info_to_user(int pidfd,
 	return info_len;
 }
 
+static size_t copy_range_info_to_user(struct fanotify_event *event,
+				      char __user *buf, int count)
+{
+	struct fanotify_perm_event *pevent = FANOTIFY_PERM(event);
+	struct fanotify_event_info_range info = { };
+	size_t info_len = FANOTIFY_RANGE_INFO_LEN;
+
+	if (WARN_ON_ONCE(info_len > count))
+		return -EFAULT;
+
+	if (WARN_ON_ONCE(!pevent->ppos))
+		return -EINVAL;
+
+	info.hdr.info_type = FAN_EVENT_INFO_TYPE_RANGE;
+	info.hdr.len = info_len;
+	info.offset = *(pevent->ppos);
+	info.count = pevent->count;
+
+	if (copy_to_user(buf, &info, info_len))
+		return -EFAULT;
+
+	return info_len;
+}
+
 static int copy_info_records_to_user(struct fanotify_event *event,
 				     struct fanotify_info *info,
 				     unsigned int info_mode, int pidfd,
@@ -637,6 +666,15 @@ static int copy_info_records_to_user(struct fanotify_event *event,
 		total_bytes += ret;
 	}
 
+	if (fanotify_event_has_access_range(event)) {
+		ret = copy_range_info_to_user(event, buf, count);
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		count -= ret;
+		total_bytes += ret;
+	}
+
 	return total_bytes;
 }
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 7596168c80eb..0636a9c85dd0 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -146,6 +146,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_DFID	3
 #define FAN_EVENT_INFO_TYPE_PIDFD	4
 #define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_RANGE	6
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -192,6 +193,13 @@ struct fanotify_event_info_error {
 	__u32 error_count;
 };
 
+struct fanotify_event_info_range {
+	struct fanotify_event_info_header hdr;
+	__u32 pad;
+	__u64 offset;
+	__u64 count;
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
-- 
2.43.0


