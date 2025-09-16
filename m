Return-Path: <linux-ext4+bounces-10214-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D018FB598D0
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 16:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83F416B538
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAA936808F;
	Tue, 16 Sep 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3nhuz8Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD6368095
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031212; cv=none; b=q6uHTlh1sMk5E7QFy1JKHnrubB/oxRvzRrPYtOaQOee9hoUkDiQd1/aCTwpbmiEZH5RB7xSFCZQ9wLpEBVTL6ac5hJg0+eF6XmE3r6ig2YbuMRK5omgQAbZt162bCVfEqhWsRUbQ+xBWoI2Rc03e8GAz7aET0pw8Air61C1uUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031212; c=relaxed/simple;
	bh=QCGFM/cnMeWMX3htX5p6eryZx4ChTW6raUZie6Xkq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sd+3eLIcAZBB5UHAGPjUKxNo2FTAkBaE6NTsoJ8QrPPo8sLrrxq5iSi71QjFATFT5Bq7WqlnlAzue8MTMfocjoOrDr2wOcW5Cl7xMiazwpx0M1sm/trX0Gl7wec3f/oz2Ef3qK9tIuvtUKHRIXoubuUhG2HE9N6oeBEYRE9t5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3nhuz8Z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so52703715e9.3
        for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031208; x=1758636008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3p/HZf12MlzeyzMfr2O5f/PDaT3y6+eiNIS1WtKNH8=;
        b=L3nhuz8Z9oR2kJSqns3xH/4NNgB63DxIRTaNe5oIxa1VLEVdkRdB/o3wev4JT9FNev
         eYpTXmtMWdeLljSdxJ79OLMkhJkiqrc6h7LHAZW+X5s3QVxcasSgLD7hAUeJrGRLubrB
         rulGsgIDFkzQK+2p9g4U8tVgIq95EgJGWBcjRk5IWOXboTPeJq5Wl8CIcLDDTCttURg+
         Z/kpRYpJML9Zm7dCljBFAix9m7eNOll6G7VSP+j67BxEW1aC/WZ7ZjSMe8UMq+FpcsCJ
         Gpseb7IWms7Lemr8sJ3X2y84OXx4aqfDuLL8yMdr7v3hdlC3zgsgY4glFyVdW2zXXK2M
         b5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031208; x=1758636008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3p/HZf12MlzeyzMfr2O5f/PDaT3y6+eiNIS1WtKNH8=;
        b=I0HT2O1N/hRPT1/J/jBwoY4mqwNu/7Irb+vTVsl3RN+puyH0CisoMcjpgvWcXEyrOD
         lxbWDhqMTAJKwPyGqPntiVY+yEg6Dv5MG6T5MDdH+7+wzy6lNLzTgoJKWv/of6BbH3ew
         4V7NkNvdSkhgOc5VnBg/DUC0xcyK/E8KUr/jtRTDz7RsvHjF5zEA+bFwsBiYmoPZgd8v
         3YDtXujaGHtnOcbe3ELH+PAt98px9NkenZ2Lgo8D6Ab2fmq2r4jvFmNobgkRfLS+sr4E
         4AiTEpdzolV4NxM/10+d/csj8M7FLEOl0FPtPsANpsLbNP9scOHvZcAFeIggl3SeJs/I
         MhWg==
X-Forwarded-Encrypted: i=1; AJvYcCVeoSE+zgWGLH3XnXQ4RWGPqTTnIyEVldm8v2/f4fTWpS+6I7AtDolQxzNKF1gskjhZyfZmGfzrlapC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Kkc/UMcsqaffAdPMTEU2R6y7PFMJUJ+4WSQdzIUqVEk4dfJJ
	db+Pa1l6giqc68C8CNQYGG9bAY7Oy5FD9vB9ujkO0hYM2iNeQavWRn78
X-Gm-Gg: ASbGncv3NR6cI+/fBAK1mekATGB20Ze87Jkc2yDGYq1hj9jadnBjakpV8Jq3kakSnVe
	sVxfJsUtjiTZkSzdI9piwVsvAKy0Wh8WaOGnDHGqU2edQdZUdFQE7D2oyyb/N1I3bUfPDmglCO5
	pm7W5+S3BqxXUXFJurwF2GdTtSKqAA/I4ack6KnFfzyopWD1SDL3QW+v/3byuf1QUDnqyyTC6q5
	j6DZcKSFN7oNf7qzprh55ZY+5uAT4B3LQ3oiS5ydoHJC0YMkGi4V7xounkLaZZqKMAdnghMT1V5
	YduuTOGRTFDSPXuykH9SlLOfB9wt6vICRIZT5WbHVwFQiAyCYzZl0uLCqBqScQGhaFRMg1fqzpV
	lovQCoC6S8aORmhHVJ70rUmuZhh8IYkT7PgMDMFCcL30+uwiOqdB3tPCbecjcB8tVpc19ScKe
X-Google-Smtp-Source: AGHT+IG3ojTnTVy1hdNr03FmdV6E3sTeXWaDybJz1f1E1nvEGmI8CA+2Pel84ZsC9/O7zHxZywZmtw==
X-Received: by 2002:a05:600c:5246:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45f211c8aa9mr181401305e9.10.1758031208380;
        Tue, 16 Sep 2025 07:00:08 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:00:07 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 12/12] fs: make plain ->i_state access fail to compile
Date: Tue, 16 Sep 2025 15:59:00 +0200
Message-ID: <20250916135900.2170346-13-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to make sure all accesses are properly validated.

Merely renaming the var to __i_state still lets the compiler make the
following suggestion:
error: 'struct inode' has no member named 'i_state'; did you mean '__i_state'?

Unfortunately some people will add the __'s and call it a day.

In order to make it harder to mess up in this way, hide it behind a
struct. The resulting error message should be convincing in terms of
checking what to do:
error: invalid operands to binary & (have 'struct inode_state_flags' and 'int')

Of course people determined to do a plain access can still do it, but
nothing can be done for that case.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11eef4ef5ace..80c53af7bc5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -782,6 +782,13 @@ enum inode_state_flags_enum {
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
 #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
 
+/*
+ * Use inode_state_read() & friends to access.
+ */
+struct inode_state_flags {
+	enum inode_state_flags_enum __state;
+};
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -840,7 +847,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_enum i_state;
+	struct inode_state_flags i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -906,19 +913,19 @@ struct inode {
  */
 static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
 {
-	return READ_ONCE(inode->i_state);
+	return READ_ONCE(inode->i_state.__state);
 }
 
 static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	return inode->i_state;
+	return inode->i_state.__state;
 }
 
 static inline void inode_state_add_raw(struct inode *inode,
 				       enum inode_state_flags_enum addflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | addflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | addflags);
 }
 
 static inline void inode_state_add(struct inode *inode,
@@ -931,7 +938,7 @@ static inline void inode_state_add(struct inode *inode,
 static inline void inode_state_del_raw(struct inode *inode,
 				       enum inode_state_flags_enum delflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~delflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~delflags);
 }
 
 static inline void inode_state_del(struct inode *inode,
@@ -944,7 +951,7 @@ static inline void inode_state_del(struct inode *inode,
 static inline void inode_state_set_raw(struct inode *inode,
 				       enum inode_state_flags_enum setflags)
 {
-	WRITE_ONCE(inode->i_state, setflags);
+	WRITE_ONCE(inode->i_state.__state, setflags);
 }
 
 static inline void inode_state_set(struct inode *inode,
-- 
2.43.0


