Return-Path: <linux-ext4+bounces-5021-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D0C9C4682
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 21:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BA9286D4C
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 20:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4CE1BC08B;
	Mon, 11 Nov 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pkHVyBmK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102271AD5DE
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356352; cv=none; b=kL+hMkFyFhJ5ogBfgPTHQ2uOzyP704qVSmf3KxTnt6IKmRDS+upMPQgd2HurZP6+7xK9qBKu8nJowwftjQriKaDuL56Bf0IWiL2bFONdyAEQEQFsmYN29u9il0AG185eTbdjkqQd73sTTEyEPLDemqVUYritHWPb+9WYAVslojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356352; c=relaxed/simple;
	bh=Yq6xhWaRCpSl+5XXK6zGiPVmtIxpSCGzuPRG5Myp0n0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5Jz17QTymcgCeBvJBREsimMaDIi46Y0ItNE2V49FC5/+uV4NkPfvligFcjE2mJyLAKrM2JXYutiyfdUdbt0gmfbWLRwVMbuElMg/1e0IqVW4/V/buVqmzxMLdEWMvl/BxR1hbeDkl8pG/a/nxQp7In0xZm9Dix0kDkKqux46uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pkHVyBmK; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-718123ec383so2825049a34.3
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731356350; x=1731961150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFLPxoJTcjCEj1ORcqyvSgazShZk3E55Emf6HOBV3dQ=;
        b=pkHVyBmKyihtWfY5VNku/ohy2lUhNLzwjZ9p2ytaO9NOHXtb6rlsUwzg6+x8jtm4lP
         PhfxClfxk/tRo0+YjaAUYuLfO6f4THzSV0/UUCunrOKdF4jTUS3rcrCvJ9UA57TTLbBR
         otJWdyRobKJmXBZQVJq84/lLi7zJu21YmvMwOfK1g88ja1bZpU02bpzKDdvs5KSwAEea
         S6TXDOngvmeBKvmLq/4CLBqRSP/WeTFg0sZNxcrz4Q4kbJpVJOlbcoDCL47t2A+dR94j
         i1M4UotJNIr6Tf/JOsuNuoybIXoPnc3xFl27iirC4txk7e17xpocHjmu9PPS1XZpY/24
         h9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356350; x=1731961150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFLPxoJTcjCEj1ORcqyvSgazShZk3E55Emf6HOBV3dQ=;
        b=KelNbqhaClElvxiNjwaSKgCcpAITwHBSguAkU1zHxmdcskCCPN8/uPI1WLwdCvvGjR
         CySoNqCfyzNxzh1Tn4fGQBJsBIAksBfD8sl1JVJZ1zVUOnEqc/A+yggi+Q40b2d8yxJA
         DY6/RYk8UnrebG7t4rpDVNHOIIxF8CBp5z1GBJ+ntaDLftCeJSrPfW9jG4QbRA6SJO4F
         7jAF6K27F8bx/Wgaojj9wardlI6+Z6pT9XDk3oPAnQzDjKoXnAt8jUnsBOlMe2hc2T39
         LU201Nx/AWcBsYuAHRUqOFfChMn2Bb7s8zTl6wZh4tKMcaJMPfuNhUgcBKAnGtgLX+uq
         lPCA==
X-Forwarded-Encrypted: i=1; AJvYcCVq8nCon4GwWauyBOOih/aC5h9Iv873HiJJUbbCUWf7dOkrOrMucY1EbQtZA7/FLUJdpvT538xuoWY2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Kb+cd6wiU1FPA4k/h52RQa6TiulIa8iok/54mBZheJxKBhB6
	H8meRCp6j990XxeVwop9D/ZXdwkKqMhsK0/GE3QtRIGZeWx2ywEfMolMf4V4o3E=
X-Google-Smtp-Source: AGHT+IG2MV5qcj0/qv1T8GLtm7r8mUhtQUE4d7uFXdf1Vo811CIBSN+1LBAjgReufZYAxzjdCeh83g==
X-Received: by 2002:a05:6830:6081:b0:718:12af:c89b with SMTP id 46e09a7af769-71a51545819mr54277a34.1.1731356350161;
        Mon, 11 Nov 2024 12:19:10 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acae562sm528957285a.83.2024.11.11.12.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:19:09 -0800 (PST)
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
Subject: [PATCH v6 02/17] fanotify: rename a misnamed constant
Date: Mon, 11 Nov 2024 15:17:51 -0500
Message-ID: <ea4ed332d38e67f509b40b5c661a2042a120ad61.1731355931.git.josef@toxicpanda.com>
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

FANOTIFY_PIDFD_INFO_HDR_LEN is not the length of the header.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index d4dd34690fc6..0ae4cd87e712 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -119,7 +119,7 @@ struct kmem_cache *fanotify_perm_event_cachep __ro_after_init;
 #define FANOTIFY_EVENT_ALIGN 4
 #define FANOTIFY_FID_INFO_HDR_LEN \
 	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
-#define FANOTIFY_PIDFD_INFO_HDR_LEN \
+#define FANOTIFY_PIDFD_INFO_LEN \
 	sizeof(struct fanotify_event_info_pidfd)
 #define FANOTIFY_ERROR_INFO_LEN \
 	(sizeof(struct fanotify_event_info_error))
@@ -174,14 +174,14 @@ static size_t fanotify_event_len(unsigned int info_mode,
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
 
@@ -504,7 +504,7 @@ static int copy_pidfd_info_to_user(int pidfd,
 				   size_t count)
 {
 	struct fanotify_event_info_pidfd info = { };
-	size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
+	size_t info_len = FANOTIFY_PIDFD_INFO_LEN;
 
 	if (WARN_ON_ONCE(info_len > count))
 		return -EFAULT;
-- 
2.43.0


