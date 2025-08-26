Return-Path: <linux-ext4+bounces-9671-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88979B36EE3
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43759983B22
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED9371EBE;
	Tue, 26 Aug 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="c5I2z7r9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147434A32E
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222918; cv=none; b=Prw5RK2qHNbuHiQrrR5GnO5UkiOgn9d9PSmedO3hfoVpLiGLs3KWbMgcTKUQ+QuznrcYCSE03EoLAoOlVS61eZMl/akwAOy/v4KKO4OsgKfpWuUuhSOuvXGGk9lp1y2vY+5Q9e3GPSM5R4wC3Yq34R0Padf9B/BX6pKY+1r13n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222918; c=relaxed/simple;
	bh=tkUhaR2Wdt5kCnisT2HbbJH/eYzoHj1oGz3hiKRRSd0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsU52gK+Oi9nQM0UUEpG+py2Lckw0X0YZPiXi4PvY5BAYJ2xl6/FLZiayQ9a7eI17pspkRjAINQ6WcZcIT4WTLFddGhITdcpmhHhi7hgP4MZDxVQp/ziSBQtPdLvf3+K3/nn17BWfw+tC6bBrPGhC/TqJmlt+nXszdkbjzHgMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=c5I2z7r9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603b62adso50216647b3.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222916; x=1756827716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afAll3Ztw+chy5iK2sURo8W26thUm5pr0Qhfoj2rvnQ=;
        b=c5I2z7r9VVzoxl68ES1Z25gV+d6w6eJYv/6Bxlte/oj+84QvjtChOCwiegislYCmfg
         XFUBdiMCkmH3DimoO3xk+iXCCb/LektHh3tcGXDDRWBIL90wQjdtXCZ5uE/cs0KWovWF
         /eNoBYpC+RCgDGJS7HqroABXV8u6Hj3uQtFDPUdszi8bmi0c+UWIY918xSW1pjOTwKw4
         KJrsLIgxJ+FOcFyyrHaGWcFeEd8/FQ+AHBsDoI/zuInW9+lwZGnESZc9wMLr0NzhrIQC
         33lUYMb++s0q1v8cBpgCZ0fMEfZaZsQt+Wf2K5ERzoSXXY1peHTavVx/0Jr57qARt/X2
         C+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222916; x=1756827716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afAll3Ztw+chy5iK2sURo8W26thUm5pr0Qhfoj2rvnQ=;
        b=p5iHTGi5dsyPbz6smxWjXvlx7OcityLQO0cXiDkzOcsXWgsQhDD1gXvnKHIJl+71OH
         a+esoUx1/ubvvCF8ETL66QwBj+ClNLIWt+EsYyMyQ5F83OALqTKxIn2Ujuv8OocF1kv3
         +Dafkogyub8vtRonCVCgxg8FUetVhCTj+U6saAtA2w58S5JcBGsiNcBA4PuSdlQ/qjr9
         +ohWACkZnz61rkRo7j7yLf8CrK9KuiJIm+W4fwyRNKsN6DkniNhHEDqShY3w/E8CxZXc
         vamFUbj9X5lL1NXfKzGKracf6B2kSxGJaCkwTaAvvwY4GV5U52DLI5bNQ8jcsWlrV8ze
         T9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV3gJfyR7Zpshaw5smniHNE5HNuJpls2Vb067+pNoxmD50z2ChJahUhiFShQ19vJbmXxwCFjq5QWqMi@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWc96zoo0PQNTub2reGrWq4ylJsmAw/OhFLJK9PeIcjroWW/w
	5IpsLL5xzzNgnuesiLsOAp9gPZ0j/UZW7CXJCCbwOc8rwTuYbQFA3gW/W1kYipvbig8+lV9tr/N
	zEOoe
X-Gm-Gg: ASbGnctPagoulHZvCGNwzaEPK2BADjuOpArQ7QyYbUxF/XUqkn/W0bT01bqEROcrGjm
	qIPK/z2bzKa/NvzwnVIwfTBG1Wk+SB9Prf1G2QixCzcJFAIobcpDP9ODK9waPaDtkhDVtZ2gvI7
	9StpmD+5eJH6NYeOuxpINjGfNY4Lxs3Gn5dYgEGrs+VJPN77uQn1UlTZ4bs6slZzb0nroevsuxE
	OD0b2gL7zCB9UUD4Ha/95ilL3Nomjljo8D4qD6QW5Xas/xxhhlIXHDv8h+FXjZtU1l19/5iYizC
	oj07etdDPFTXgDoKfPUdBa/WOyRSodUajZnK6ATwHa0YWrDYpFFjUQ5xP0cUDwLoK1q3+aaMRIA
	xKWIR9FlEzA0l95TK7p8WJGHlpk9rQFXKU53rJAUP33ES9oIsXxuGwjfGAv4=
X-Google-Smtp-Source: AGHT+IGcJ0F+Yu8LKKYT4wPl7uuybVV1LKhPL6NkeZN/ZOA11iSP+ko8POCF1twTXQouIMsAmh++wg==
X-Received: by 2002:a05:690c:3348:b0:721:3bd0:d5ba with SMTP id 00721157ae682-7213bd0d69dmr13183867b3.41.1756222916060;
        Tue, 26 Aug 2025 08:41:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18e31acsm24874707b3.67.2025.08.26.08.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 46/54] ext4: remove reference to I_FREEING in orphan.c
Date: Tue, 26 Aug 2025 11:39:46 -0400
Message-ID: <5e023690acf2ba9a94f12a5d703bb6c66ec99723.1756222465.git.josef@toxicpanda.com>
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

We can use the i_count refcount to see if this inode is being freed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/orphan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 524d4658fa40..9ef693b9ad06 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     icount_read(inode) > 0 &&
 		     !inode_is_locked(inode));
 	/*
 	 * Inode orphaned in orphan file or in orphan list?
@@ -236,7 +237,8 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     icount_read(inode) > 0 &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
-- 
2.49.0


