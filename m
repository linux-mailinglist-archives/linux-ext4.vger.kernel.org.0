Return-Path: <linux-ext4+bounces-5020-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3D69C467E
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 21:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFCE1F22E94
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB991BBBDC;
	Mon, 11 Nov 2024 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FF61wmJC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9591AAE1A
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356351; cv=none; b=W/hz6Dwwe8FzEySN8SBefIRL9INyxgnakdvJ5DK7q3xcdOhsGhbreWurclAR3Ncwn4WsLgoB3FoWi9Qjeli/06coMFbD6R5wmrCQIHWkSTIS2wjWXFUE3u5Geeg2HjLJxOfSSjcKNVHBZ36k58WzBIH3FVYosROIAhF6zE2LSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356351; c=relaxed/simple;
	bh=vjD4OwpRem9TPu2ocewh7lTIgYYZ3zDQs0yfGPZF/n0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emn9Q+YxgqvAmcchDm31oVBXBppYJQx/CLaJmzW2qZQMIuN5/BAfLXw4Aw6gnebXIdRlKrKeRf+d7gOWUXcwMPRL1+rNVcI7PucCyXJCRD3g9jDZJdD10LKT9ZslpLoezj+kMymXWYAolIDe3oaQOOh6AVRI0uvZY/IDSHitX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FF61wmJC; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46098928354so37673181cf.1
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 12:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356348; x=1731961148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7uBdkMZBWHBDqGd5Y6AU6Zp9KPmNzsckryemzg27pk=;
        b=FF61wmJCAs5sW+Ltc6hHnxfHNfLuSS7EMPDwSNYovAe+4O30IGEFLbvgSQ/1+G/bgT
         2CUt9Jkw09SkKvfwSpHaOBCFYUqdV3/wPQwVSya9LUhSFMhlnaEI5rgB0IU2n/5HBZm9
         7Mq22KkcPAUM+hV2NtsjGK/6LBNe4SvVco9EbJ/DBG8z3CF6HXmP2GRtUSeUmBH5qduJ
         67VrcBL2bmAPVgsy1gneIE0pjP7rB86Whn5T5NlV+y56u5IZziA9h6y3tufOAtyd7RQr
         Q7/Cvq/WTHVjlXcFPbSYPqELsIv6MMN63gqUPJunZVa9NLa0lj9i3y+M96JZy5jDn3Ir
         HzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356348; x=1731961148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7uBdkMZBWHBDqGd5Y6AU6Zp9KPmNzsckryemzg27pk=;
        b=IPh91B8sxO3NgipN24O9lKW/NEi0QzvdqbA3Tf0bNDDB5uIgexRMKMGiQDUc0B+r90
         9O41I01VkCBLpJNWRoE2Iqzx+fFCkGVY6AKd/3gTjRA3dEllmyudNBDYCW29csOUqb+2
         +IZnJQg8ce0495TuHpS513YQ3mQP+wTi/cFIZ2ejRFDaTK9zU1NaU4mL2ze83q/+ivua
         6Cuof1fLIDJsgnNPfSTJDNW5ce3jwFrRY9Mybvsfsk57FlrrOUg+YRfi0pVIpQDFBMkk
         P6CCd9362KkR3tsMQcZM9WuxPQdsPEbiuYGD/RsWuM7IVdhRsrzM0BB5lGFP/KqCKm6n
         sYhg==
X-Forwarded-Encrypted: i=1; AJvYcCUVb8G+FS6T9g88M3fRaETz//I1eL7I69G3wWxNG8ZajnRABS4aRuCSRnVSzdqIRPsawVdSLDsep5KQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzqhQK917rNLAV2Zg5SvfBW1v39jZbubEhjnKpvXV9jYf4keU1A
	tQdHCOfJPITIJJOvsUp1QlnR/FZIpZYJpTsJ4lAi6DhBy3iOCACQVGtS999VjFA=
X-Google-Smtp-Source: AGHT+IEBguTWGGBpfMXX3i8vnE5t3UsJSDJvfVnQMRYjxbDOQbaxUPSmwC+HZSzOw+awlnAlKaw9jA==
X-Received: by 2002:ac8:7390:0:b0:463:eef:baaf with SMTP id d75a77b69052e-4630eefbc12mr132991331cf.29.1731356348402;
        Mon, 11 Nov 2024 12:19:08 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df534sm66530971cf.10.2024.11.11.12.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:07 -0800 (PST)
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
Subject: [PATCH v6 01/17] fanotify: don't skip extra event info if no info_mode is set
Date: Mon, 11 Nov 2024 15:17:50 -0500
Message-ID: <a1be4ec39d230eda892191e972aa5e077d50186e.1731355931.git.josef@toxicpanda.com>
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

New pre-content events will be path events but they will also carry
additional range information. Remove the optimization to skip checking
whether info structures need to be generated for path events. This
results in no change in generated info structures for existing events.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8e2d43fc6f7c..d4dd34690fc6 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -160,9 +160,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	int fh_len;
 	int dot_len = 0;
 
-	if (!info_mode)
-		return event_len;
-
 	if (fanotify_is_error_event(event->mask))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
@@ -757,12 +754,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	buf += FAN_EVENT_METADATA_LEN;
 	count -= FAN_EVENT_METADATA_LEN;
 
-	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
-						buf, count);
-		if (ret < 0)
-			goto out_close_fd;
-	}
+	ret = copy_info_records_to_user(event, info, info_mode, pidfd,
+					buf, count);
+	if (ret < 0)
+		goto out_close_fd;
 
 	if (f)
 		fd_install(fd, f);
-- 
2.43.0


