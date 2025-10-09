Return-Path: <linux-ext4+bounces-10714-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14900BC7EAB
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 10:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1492F3B2674
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Oct 2025 08:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BF2E9EDA;
	Thu,  9 Oct 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbvDejU9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6A2E8E0F
	for <linux-ext4@vger.kernel.org>; Thu,  9 Oct 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996814; cv=none; b=XGMRg9jwSJhw6ImAkgxuWpkP2DIvUCz/FGq0YMCLkXqfHlQjF9OlxSvqs9lT75QQyYFTJmqzUSJaUcKqp57YeTcAXhhvAlQBFMPvPHu25bwq2t704HeXGDgww5xRhBB9cazlZH7Xom1YTAeMmpEVwge316wDa47NqNvjPmutZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996814; c=relaxed/simple;
	bh=xlG7nR5Wpn4toAnFh4yZG5U7bqMO2Ibqli2pgrWdpe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZL6FRb1OVnnHsr1uEXPTeoIZfQ1w5JUUYDKi4bryStE2diJ2TU6tiMnUKXasKHzvvOuJqugSxWzV6nvc7sz6pbTYO4YbSWJabmmi5o9qMfJY9r1FOc2DVe0q8mI0myJpx/mbTjiWRdtkP3gj6aVKIbLbNxczmVpAligdfm9jO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbvDejU9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so104937366b.3
        for <linux-ext4@vger.kernel.org>; Thu, 09 Oct 2025 01:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996809; x=1760601609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5cEv8KCvxqRx2Vo792Uxij3yHT/Pkk8+e6W56mfmGo=;
        b=SbvDejU9ggXuvwZcyBQN7Wh/w7QFoavPE+9gM8uuiuVmO1ELw5sKW93FFpq0UEpTkq
         Ryj/7rO/SHMvr+NwtFE5QTSf5WS341LygOQn3KW7t0vLGZCQTLjHrjRyobIyOLnCITUf
         tzlzCFocGJ4GpNMGGc8xHvX9bSHUppgKd1qcC+NjyZxY8Z7hp+K3ixktQxfiZtv7ESnw
         xndW9hExYjaGy3CHpa5bkadYCG5PWfhGVNiCZT9uLlc+c8hEjNrRTCQ82+h6MLHDdNu/
         WvQgPk7LktcDwjsfXh7eYvK/3q2818LaXoD+P0Hwqy+j8s9Z8YVRBE6t9qPBrNSb0JHf
         54fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996809; x=1760601609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5cEv8KCvxqRx2Vo792Uxij3yHT/Pkk8+e6W56mfmGo=;
        b=FuUKGU/ZGvRTzbHQDtl6hDF/QSGE01z8OQB8jFnJFYH166jQ8vb1PBPqFJ6xHpWmzZ
         ePB4PVvaQFsHu18/m3wNj6dqhzCQIkOdyff6QjSgKR6ScmqK0y6OB4bEV6z2PFLVIKcq
         igMBu0T/IDB+J/dzLurkHm/kTqaR6e4gXm15M63nYVwjAuTJmEgMahEhHCJ9ZAhYBK6i
         lPwO5nHn8+oP2IgPmOuLtr6ZcBWalAd2XuVh5WQ7Uf3Xf3o/QRSvjz3tjvq/LlJfXNP3
         /1R+4Ry9UaTMdHSl/u954mo5+Ui1aoStlnfwJQ2M8zK0J1X4i/YxxUyxs/3d+85lgXPS
         zJCA==
X-Forwarded-Encrypted: i=1; AJvYcCVGAacqjcRSZLV+HIyXLtc/GeXxZwHTWosKpga66QMMxSuRzMbQ0yfI7Wl0MsdQijYYHC4kD0CxEbmR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eqW+NG5lP/zKbbi8yC2cjNSDUycgB7hWODtTHoYH8aI//p66
	83NB28TWDvc30pQtFibfYcLXioX7ZTwWvWz5pzAIo3ttAIsZ56U4L/MS
X-Gm-Gg: ASbGncs1IWNtRe0VlFGAscsJuCokKS3Na8Bn3i0v+0Iu2Lz1W7+jnKhvnC8V4P9jHKY
	75dhu6rnQKmhA+OQmTjN8oh1fdQZjRYzFJDn53BrH2P6VGpBUJlwTy4UCUm9MSaQNyY4IMn2F2H
	wpym3jvJK8VKPwXVlUuwES72QZ2i+rw6+5RaaqL0MAH6P9+jN+rzaD+HjmfJBlGQnea7PCijhof
	CZP4sbIxAFHOz22v40hStcSFSDiqKAQWcs+ex7GNpAO5HNyD89lE3xlhlNqsoySNExEcePv0kAz
	Z7Da6ZXZm5zDw4a2DprnLbPZvPR44GkuXsAemrspKYIrknuK926h3h5Meajp+gCxIqvzoUMUCvo
	Vq7CWu5tkBxWjL/53zuylzGLgdPJ9xGzVC4IDQyVBRismjbQ9DgIHuGoPE87HQ+k2WqM/Bd2iOX
	CG/ddDZhxX15OATyT78fpeZ0SutWkNmQrd
X-Google-Smtp-Source: AGHT+IHLM13r5LQMnt/OJInRecUisomAa2MvrC2cG1/52NjvwtuMZLiyrwCa048XZprJyFm6wajB2w==
X-Received: by 2002:a17:907:3daa:b0:b40:5dac:ed3f with SMTP id a640c23a62f3a-b50a9d59a8cmr718516366b.7.1759996806312;
        Thu, 09 Oct 2025 01:00:06 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.01.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:00:05 -0700 (PDT)
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
Subject: [PATCH v7 14/14] fs: make plain ->i_state access fail to compile
Date: Thu,  9 Oct 2025 09:59:28 +0200
Message-ID: <20251009075929.1203950-15-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
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
 include/linux/fs.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 77b6486dcae7..21c73df3ce75 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -785,6 +785,13 @@ enum inode_state_flags_enum {
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
@@ -843,7 +850,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_enum i_state;
+	struct inode_state_flags i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -909,19 +916,19 @@ struct inode {
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
 
 static inline void inode_state_set_raw(struct inode *inode,
 				       enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | flags);
 }
 
 static inline void inode_state_set(struct inode *inode,
@@ -934,7 +941,7 @@ static inline void inode_state_set(struct inode *inode,
 static inline void inode_state_clear_raw(struct inode *inode,
 					 enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~flags);
 }
 
 static inline void inode_state_clear(struct inode *inode,
@@ -947,7 +954,7 @@ static inline void inode_state_clear(struct inode *inode,
 static inline void inode_state_assign_raw(struct inode *inode,
 					  enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, flags);
+	WRITE_ONCE(inode->i_state.__state, flags);
 }
 
 static inline void inode_state_assign(struct inode *inode,
@@ -962,7 +969,7 @@ static inline void inode_state_replace_raw(struct inode *inode,
 					   enum inode_state_flags_enum setflags)
 {
 	enum inode_state_flags_enum flags;
-	flags = inode->i_state;
+	flags = inode->i_state.__state;
 	flags &= ~clearflags;
 	flags |= setflags;
 	inode_state_assign_raw(inode, flags);
-- 
2.34.1


