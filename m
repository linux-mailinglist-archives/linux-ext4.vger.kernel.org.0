Return-Path: <linux-ext4+bounces-5206-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4219CF0E8
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B2BB33359
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E105E1E7C2D;
	Fri, 15 Nov 2024 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Sq+4zBoF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB661E630C
	for <linux-ext4@vger.kernel.org>; Fri, 15 Nov 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684703; cv=none; b=dKthqK32e5rzTG2f4MC2z44eG2utut1UOxtm+E0FhRRyHHlzqNjOGAZEFYGjruzpNseXzUUJeIpY4BPBSI1XcbYIjDwQWO+Ihy+l997qsc2kDuUBT9AjxIUgHiqHjZFEnLy1L5S3d/dXVCK+WFHkGH/1w1HRlT+tcANDXMBkqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684703; c=relaxed/simple;
	bh=wJBpuZKjarBs8HwRCSHfMpMBiZ+HVYWNz5ARDhZnhyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ0W3CcaRnIG/D2WR4lahm3+xsVB3IpR0Ukf5pGuDYoHx8FZi3cSoW1LIy8NEZk3gO3lBE7UJSLRvrYhF4qBaNha+5XXKgzBBY4woaTnuYO4nLP0SYH/ymYrax+uH0tzut/J3zS3f2gLRZKfM7kQ5nG8dSe6KuXI1WJ9BMpmAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Sq+4zBoF; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso2190013276.1
        for <linux-ext4@vger.kernel.org>; Fri, 15 Nov 2024 07:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684701; x=1732289501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSuoTi14zhdgmEJ2e8nj/BNpHIFoytvzNxhl/LStwJg=;
        b=Sq+4zBoFR0URvFIUh05vyK1u/Sos3Fl7p0V25nCVbtRGaI1ZZ7MPG0l8yIpnHG2xku
         hLsR7o/CU2RIeJ1No5o1TdseUV+3KMkg1Nc7Ql7jrN008rcQUxmyWxjU3cTuiIoidMAp
         x1eOLg94bBNx+Zlzh+cfuYLHv1tQs20aWLioiHWnLzVRZCEMpTSQgXK1Gp+ew+hQsE4n
         rQz+uKar0RBr6XWNqwX8wUg4pHOXvBq4RM6oxBY0l9ocs1RFxLSWsgKZ+Iq3FvGw4Pxv
         tn6DKnzq3wDApu9o08yxEmIgKLVA28TLcfr2Qd3mqOLXriFVUs79/tKIf0sqPh5lReY+
         PUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684701; x=1732289501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSuoTi14zhdgmEJ2e8nj/BNpHIFoytvzNxhl/LStwJg=;
        b=OCFGOD8T+5E2G+3To+5nXw3mE9Ma8SnhKCscrpnbOwDDQrpF/AWrSWOmDcnROhrsj3
         IsSx8hNf2sdIXkfBH4I1AKQGACL9QGOXl7C29sAs37zAkU3zd677owRrjfnoyIhczMoZ
         95EweSMTBWPtESngBaEWugGRDYXPr7QYmbzFy7FGYZaGbybDCpLmWI7ov5WcqkD5FW3S
         F+cH0EVaK/C/p+FFuoyiXvGcA57AQGSh43RbEyEwigPdwN0N7xeYoNwSP/A40HwLESqf
         VHmWhgPvb1+mHTy3tKahAxrRADwxEyPj38xfaPIUlVB6TOm6is2N+gjkPRxoX+fMvgUX
         82Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUVqEmiywhZ7jePiTb+RvFJEC8Bt0CueCgK4Yg5fGC2xI9yH2+MNh/2i32nzLFyXr8v1F3r3ba2QiCM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UdDrRAuRXO5AZKx7aRaZlVQGgxXyGlz7OYAkK0pUJBX70dJj
	KvT9+ztNnMm5Z4keQkoPenrXlfrRIUIbrjkMOWSojzkvwjp08PWZAV+Yuiab55URFi27tJm/s5p
	N
X-Google-Smtp-Source: AGHT+IHJEyVOG62NvWa9d1qggTtMCjzt+EKNCXFckK971VFGqKmUTAI/9H3Oo1mgh59gFKizdUDdeA==
X-Received: by 2002:a05:6902:1242:b0:e35:e173:3341 with SMTP id 3f1490d57ef6-e3825bdd813mr3265588276.0.1731684690002;
        Fri, 15 Nov 2024 07:31:30 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38152c61d4sm989132276.5.2024.11.15.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:29 -0800 (PST)
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
Subject: [PATCH v8 05/19] fanotify: rename a misnamed constant
Date: Fri, 15 Nov 2024 10:30:18 -0500
Message-ID: <8776ab90fe538225aeb561c560296bafd16b97c4.1731684329.git.josef@toxicpanda.com>
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

FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8fca5ec442e4..456cc3e92c88 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -117,7 +117,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -172,14 +172,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
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
 
@@ -501,7 +501,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0


