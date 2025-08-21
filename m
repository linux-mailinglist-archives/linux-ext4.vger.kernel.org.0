Return-Path: <linux-ext4+bounces-9506-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D762B3062F
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415A6622212
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D0372162;
	Thu, 21 Aug 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="H7FCKGiV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA43705B6
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807627; cv=none; b=lKSP9TSFoJgIV4xgBoxlxVFNHgZ7Czs2h9Cce96PtEeVO17++hahu2tFV2Dp1eDpsLKUKU8RYHTe69plfpFKEoaTklUXlrJ0sSkdz8JOCbLXxyPdJPXO6Hs9CIAss5IbOwFiBJMkhdvuPeyrrn6bAHmHto0sBfaRlFyWVMqndhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807627; c=relaxed/simple;
	bh=VW5j9pCOlroZhl/lnWfntKbo6qQXfaDKec+FJlQf3TY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+Z8Ce/Jt8OFU8hZGVbDKNFm6aHY0tAm5R3FyNJoVKtr07oq7Syp7Xb1cdghHlaZ6fYL1hwHNGoSGUTuzjPTiaBRIEbUSFjJNZGdrjvbmFWxDhj1P+twNNJUsvB66oXCnBVslKgUBTJ6PZsei3TZTHaLpOEFj5gs3yuTdx9CwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=H7FCKGiV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d603acc23so12079937b3.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807625; x=1756412425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VojWusNxgTfPnzlXh9Aw6r7SNSzmMD9Pubt2ZgZyin4=;
        b=H7FCKGiV9rPYtCdu1AbEOsJUd95oOwUHPt1VmyGHmjWdnwvzkiS2bRI1st3t+RaPEl
         3tlBu43SDBy9odOfNZaf4AOI6KR8fiL92bOuK2e3ZCzgbgXtMVRWWoW+snti4LeXgn7M
         nekQEGJnhGcExHdqIX5MM2qG4vHtigNNWlZA2sp4UIeY8ZgEvBfMN915r3q4dZfbOIGY
         Wv0jaxoLJApbEafnU76CRw39tUvjeYtb/1JvoZAu9tZxgbISevZCV+f5vM0MFUIghNrF
         coiLsBoF7bmf8F7HMD008zpv6aN+HQCEsiS0eutPQUyrGqZGWEhpEOL7ZuvhVU5QGMLl
         A1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807625; x=1756412425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VojWusNxgTfPnzlXh9Aw6r7SNSzmMD9Pubt2ZgZyin4=;
        b=d0GaKbTNJYtZY85v836Bo8UekX13u/BBxsZuwTRYHyWDyrMmdfyxtl+hJwVSGJMM2w
         hggIsztt6jvRNaPbnQ+ef3u9IIb6N/lJQ2M+7VnRl4cQ5mEY2Qln3WRp5jpUfq0Lt/fo
         Z7DxHeyCVke1dSWn/mzDgFyCkeyDgqYL3vNJmA/o/Z8atXhF0CM7/HjeuTEnYjKsQ7GG
         qhDXVM/e6kJKW2o2QsHhDVs86lEIM2SalFZAA9lQ6Kw6S29qzxKhp2edZ/NmFFgX8A/0
         BBfGzBxl1X4zdE16igePSlzE13qtebEuBFdu+zzSvWKu+1pbpON4VyjO6QB5eFriwrQz
         wN3g==
X-Forwarded-Encrypted: i=1; AJvYcCUKYN9vPm1sqIXvhpKBsryt0Dwugm4Anz6ozJSNy4cCUciGIAcyF96Xx4N+tV7QPwHQWuD1I8K7xXBe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/CjdWNlGNRjzdYp2SaZP9eDa8scLrC+UJLApuBi2hxrVuroZ0
	lGCZiz/VN7txCAtVVOEsqEvv/Dwl5ClPAgJqmG2tN1X9R8oCWTC4YK9KnVt1Pq6Ra1g=
X-Gm-Gg: ASbGncuFYKbalNsvbPBzaGGncPyWDbRnp8p0ju77BbI4qrAnTbWnBp0y/P3zlNKJZkY
	mRzqiO0vqt+AvXmI3hNfEp6/6cE50BzKdR+oET0O8ZHv/Gx8UOcGoNAIYuI4fkvIcY/7PNuXfMq
	tVGi/vJt5dacLwWX5MHH4OqYM6MmgCDdnNF49xahi+e9xfjY2CPI46jqQwSZ845ELWRQPonO3ef
	t6XEthz62/wTwGNNBCCEr9ZNG3uGDHBe9/H4jGy9DzZxwN/I0Rvt6yqJXEfl6Jlw0aJLG8kw9EH
	u6LYBp0pyibM+amcrflUd/2INA8nnsrZOH+Fs0I4TJb9lOPw1IO/Y2VtSOFnEVfQ/dbCWxQBQJV
	/+ggO8wR9vTWIFIX1TqzCMV+FkNp9+s2QtRsuwWlaS/IWxuR1Qt0GHDN+QPk=
X-Google-Smtp-Source: AGHT+IF8JBW4Xh52SDVildob/BUomhJ9K4wuNU15xnoWWWlqqaOPm3Y7fskuJegwPAQeudlS8EK8SA==
X-Received: by 2002:a05:690c:680c:b0:71f:b944:1034 with SMTP id 00721157ae682-71fdc530ce2mr6839237b3.49.1755807624618;
        Thu, 21 Aug 2025 13:20:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fdbedffd8sm1165897b3.5.2025.08.21.13.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 06/50] fs: hold an i_obj_count reference in writeback_sb_inodes
Date: Thu, 21 Aug 2025 16:18:17 -0400
Message-ID: <1a7d1025914b6840e9cc3f6e10c6e69af95452f5.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
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
index 24fccb299de4..2b0d26a58a5a 100644
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


