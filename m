Return-Path: <linux-ext4+bounces-9673-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D852CB36EF4
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730219846DD
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EDA3431FD;
	Tue, 26 Aug 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BILrCV0W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61F371E97
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222923; cv=none; b=lOwYrNf0/caY0SEADEpP8Ci0n9kLPgtJX4mRG7qj7GilG1+e+nVqyZjlpsOp+lk/8A+pcpFHhONpnxiGPrYhIe+qtPYfyy4Kg2Gl5MfbQw2WCzM+ilMNjvF/xsxFcjcjVF/vopPFJlZ4OSOnvH+wqXdqX+aIRe8VA1P7RWuowVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222923; c=relaxed/simple;
	bh=MRbjz58EJk2DIV/CMfsuQeru3Gjlj5upRwbvX0t3mqA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pts9Pren+Rg8Jl3BLENI6jM4OE2/g5wsbnUc8gfoZZ44feCXuurmCJ0cgf5LDEDFFz8UT8dUM7jqu2nUzQ8I6CIKzGEJr6blAodNInffoT+dyOOv7Au/QFSAbdjnzObRvS5lNfUZb6yXm8+7m2dD671EpHzBq1Bl93NAs7bDbg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BILrCV0W; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603f13abso50824497b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222921; x=1756827721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=BILrCV0WYnWT1+2jq6fXe3vKn1IHeBBILGrrJVAnTnpJcJYKAMzR3plnA76m6YeXxF
         a6pcAgQ3YvsnQlJBDZcbjUKnbWHJIRT+cixh8gcWP4ozxfkU3ayzIPS4WbvCgVM1V1J9
         JivlLLAyTLjmRyOshv7iUp7r/q08xiYFz/EZOzzeVwBZrD+XfNGu6Z8H70D2dCsk7QVB
         kMEYOeV4tsj1mLQdqgYFePAosHW+XMhrIGGEFCXaEAWEtoZarqJJMIzyqhK4SfnsdTzY
         duTPScZDefdP6Ngt2VeLd7tNlT3lkFmPY6rGXWhbi9BCBCri92kMMlbCwHc8levsNrco
         GlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222921; x=1756827721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6Y2vCrhkZTJ22Wp+VyocA6nDD0iA/acEwKo6i4LTMQ=;
        b=EVLWWCyDH+6L0a0WZYJ11nwPUISQpCgwGQxVBrBNMCG7+bByn89WuaaY11Y5+MhgL6
         c5diANrPisCGYQzC9ZrU407bcVFu2u2NQ2DGqQBZ+/e9zMndsKwQNLpN7IZ2/m8FaGB9
         5MMU4fGE4l8unuqdAclGZKcoca1rXdmeunyRaUsDLb7cIJ8FfcJ/yd4i15hMwF2OfjIf
         OrLD2u3voJE04EAo6+Qvf5WRCOFk1xGJBHUywki1u5X2odsqc2LndSW/7zbFjV97BboA
         m/OQ8F32Nyq7csEV3byyxLw+RgcfRxlVMFCVqOxo8///pJbPGJ2CMN/NTdugHpeM1Pxx
         te2g==
X-Forwarded-Encrypted: i=1; AJvYcCWESSsHR8s3K3TLsWTxS3MYt6y8xo59VjV+4MPHU84u8ejezizUODOANXKhNfHlk08TrLP1YguaDch0@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJY3bhBUUDW8WLbN69oUQpqVrHHl0vRWvKWCwtH1/sh6l9j08
	e4aRmLxU2FX7popIgAM/icDN0WLx/jnzTYyW1R4XxsaQMDZyWUXgGI+pA5f9lcandq8=
X-Gm-Gg: ASbGncs3N6tlYYj96l2IX1e8fxroCM8wHjL5s8LfzhXQ9ILcBTmjwUpTui551fpIc8+
	zjDUPEIruuI5g5ZWTihrjSFbxYT15O+J5G4hxlPztiJQuBF7EVWmev/VTGDo9ySPrNuNU/witOr
	Xni5SzVh9hJWeR8njCdFv8zYfnd62dzTkyXbJ818nF4NQPBrLVaAXYud8L0m57pQM3y/ulCDASH
	P9fBk+EqK3s2AVh92yJx1c7iAklMNJkR5UcDWphSQe6ZIqXYzn3zemfeT3Y0JggtWHyyk/Fb/i3
	w/XytyA1URCCZwFwggUhExKMK0j2i8u7kLs/fzqvzIYFixHBs0M142j0buZalQVMcKi7fLj2Lm5
	40hTCp92wknhZqzpwcMA/X0dzg+HBRsu++CTznEkghZXG32lwXHbx1TzrGob11qJ7AvvVuw==
X-Google-Smtp-Source: AGHT+IEMOMVn8rVVn/LrSUqLRsgPs8HrTr922RJlf5aayGldBVTuMlA9OhISdmU7x/PsUdxbw40paw==
X-Received: by 2002:a05:690c:680c:b0:71d:5782:9d4c with SMTP id 00721157ae682-71fdc3e0679mr159524887b3.28.1756222920808;
        Tue, 26 Aug 2025 08:42:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5fbb1a885absm419060d50.4.2025.08.26.08.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:42:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 49/54] xfs: remove reference to I_FREEING|I_WILL_FREE
Date: Tue, 26 Aug 2025 11:39:49 -0400
Message-ID: <681053424e9eefe065dc689a325e94f79d0f918b.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfs already is using igrab which will do the correct thing, simply
remove the reference to these flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/scrub/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 2ef7742be7d3..b0bb40490493 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1086,8 +1086,7 @@ xchk_install_handle_inode(
 
 /*
  * Install an already-referenced inode for scrubbing.  Get our own reference to
- * the inode to make disposal simpler.  The inode must not be in I_FREEING or
- * I_WILL_FREE state!
+ * the inode to make disposal simpler.  The inode must be live.
  */
 int
 xchk_install_live_inode(
-- 
2.49.0


