Return-Path: <linux-ext4+bounces-9535-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE235B306B8
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2FB1D24931
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA73A39096E;
	Thu, 21 Aug 2025 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XT3KipCB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D2390950
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807670; cv=none; b=qPDYy6zoZKEjXodOib55wydf42De5FK6TVpUByBVIMhQihGkQGfsuMFrpbe7w6hccx0KQlaOPqTwxeG9t51xIkm+Ey8Cj1SaZ22UGxffDKY3L+DeJuee0wIh0ZmDQtJ5ls1tFQ8GudYmdsYGS7eHrbWFBVTQF9iI2fi6Q+c4DCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807670; c=relaxed/simple;
	bh=wctmqEmUpM1KjsZSQp5EFVFe+I/02AT+kFbU82cRaBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvgMGzjrlC4/NTWQ1qLvg45ze27pn6oKZ10zRLga4N7N1HpX8k/Ne34wsPbcBui1iCP0m7NNg9q3prl8WkxeotyEMXfjUk89+382DW4AtLA+FfOl+zj1WJfXRoiUVFkSuKiF89Ya0JT2nK/5sPXUb7qcMj8XOoJmcEpxIzARBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XT3KipCB; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e94f5dbf726so1328296276.3
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807668; x=1756412468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmjKaUwpj2DkmXlSJQoP2X7HjPrWpM7VXZkID8fwcAw=;
        b=XT3KipCB2jm6p152EyvrmRuqDRnjVcKIqaBwalMD7j2PyAoVdhlZtb1eZJwVf5A+WO
         PdAyXmiyjm6CzYXR7EUWG42Rm4JE/qM9YWEF0tXQVbP3kBHV98IKnpHgY+TmBU9VpZnf
         fwdbfVwt6AX8etvG9yApD/zYDVUlCGdoO7JXxrHNcRUj6j26i+59jzlCWy+Lsm/DphYY
         x0C3+0JtTbVRjLse7D60UFjkG6k4HGxQjxWzlADS/rfRCtLvh7G/pnQeSZo87xSCuTFo
         UfmmjmLop4AhyXmKAT7yp7/hGz7TZqxvJzZMEYo5T7t+ZTVRtGLGR1JykPAeJW7gvb4J
         qXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807668; x=1756412468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmjKaUwpj2DkmXlSJQoP2X7HjPrWpM7VXZkID8fwcAw=;
        b=UHHl1Xm9+J6Zig0oI0aRiGG6uNNtXmqZ+IQfebGaGpon1TUNBQbgcCtprvX22cIwie
         t5Z4Eg5hyUbV8kboofJ4WEnEuI61E/m5TVZIOnYQg+T5IgBGQ0cKzkD/OPltPzRtiC2k
         wf668/REAgvR95E0M3Hj7MIsY4+yYQdy2mMuK05IJyVrqLwW9wFerkgHEgCbYUhONqhE
         nD977rLp8ih4zLAJhyZBWAMeYIIVyuEAmDxOnH03dQORFvAdNsLU5AHhAR/OvcsCCIvJ
         kgaaeqgvAC5PKjNj+rC71ZzXpF3cSNKKIPZR30mBHjb3LLGGQzbYGPtgDNFE0JbVI7P6
         BFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgWlk9yW52sJ8DtJuDDiLcfcDZpT/rSJDv4bBnz7US8nTqmmgWGgCkAYGzAIOQF9Llh4thWYGla8pL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyg4OMfqIfgt2AkZQEJY5taOConQ4E3cP1nHCQi12FLgMO+j/w
	MBm833xa9Z0j/iEII3+WuAPObER/Ss9JPHEAn3Hw1kqyCucY851p+juN4LpStJEaDsU=
X-Gm-Gg: ASbGnctFqABZTzrwoLPZkAp5Q1jUvxf1qju3fCx8sCrZlq4Woj4q3oyYJ5h5UcGINWs
	4hb29SkJbiGn2/3qKXuy4toOsWUypmMjojgTNJEHG7CDaBOjv/MmF3lFrdurpWXuUVjb1xC4lnA
	FeHD54WPBtFxGI/y9AXjjPWYrtntgdUQeZVqJ5xGWJUhqvS5IR8lGbAuB4jjIYsqBs+u0UmuY72
	kC4NdOhg/EQn7HXMoiAWpXy4xETvjODeh0z14Waum2kfbzmKHp4gqTu7ZFnYPObiocKb2WcLegV
	kjFEbXLkSYmhBmHT/JiogJkxNXjZYqweGfo+oGnabuerUNbnhaCZn/L6wCFq2RQmwB0TKB4RfIB
	LEkCPRMZgdiMXnSJ+O7ZFipEOklpStoZ9p5gxZmd5FTK1QlpIuwAzXS3/x8k=
X-Google-Smtp-Source: AGHT+IH/T0dsDptJxPlJ9vX/O/NjsuJx3EIZW8Vubo/2lIk8PPtNqr+h2Z1PZdabpWGsbTrFvzNw7g==
X-Received: by 2002:a05:6902:6c02:b0:e94:e1e5:377d with SMTP id 3f1490d57ef6-e951c2da511mr1105376276.51.1755807667754;
        Thu, 21 Aug 2025 13:21:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94e3942c33sm3133839276.28.2025.08.21.13.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 34/50] ext4: stop checking I_WILL_FREE|IFREEING in ext4_check_map_extents_env
Date: Thu, 21 Aug 2025 16:18:45 -0400
Message-ID: <0350442f4267245bb0104506c95c05a1cc42e96b.1755806649.git.josef@toxicpanda.com>
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

Instead check the refcount to see if the inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..7674c1f614b1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    ((inode->i_state & I_NEW) || !refcount_read(&inode->i_count)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
-- 
2.49.0


