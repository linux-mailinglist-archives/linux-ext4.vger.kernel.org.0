Return-Path: <linux-ext4+bounces-9547-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C90B306F4
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D2CB03704
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF9392A43;
	Thu, 21 Aug 2025 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TEWrLnET"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2E392A67
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807690; cv=none; b=WgtQ6HTUrfSvNIPi70/D6wKj8mE/CMzfYsLkK1/iigTR5X495Vfc9sibG5XFvVwdt1yU1rwpAnD/Yaciruwr+tE7tCCjPEsj8cmMcyy4s+pDQDhoFXq3LiTDuHXzNY2XFixjwGKddKvIzgjrwygkum11lLREEvqY/5RoXm82aTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807690; c=relaxed/simple;
	bh=0ZjV+DUCSr2pMjxDPkN/PoOVM2MR73/8MF8nar2aCc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFzSqTDcz05cxXdKjSyV6HWCEu9KoJjqR4SgUCdJz6GavgNeWtzIYbLqXtrlOTyHUHm1zF6+PkzCXiuqi2oW/s1SD2eRVTK9zrxPXnHvdLsyALZX/2zpHkrwPQHPU0OBI/YITPx769sOsFqyfATAGdwOHY53LTTEHc28NO+BWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TEWrLnET; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d5fb5e34cso14489747b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807688; x=1756412488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dx0/asqotG4rq6EdmXwwX9N7zT6RzPtjLNznPWUyIY=;
        b=TEWrLnETTuApOD8w4k4d//IFJ6OI5EZvWMpuaJPUzGULT7dD/cY096LjUstRV1m3QI
         lz4DI8QQo5OkOfaH1Huh+4ZZIAF/tVmc7G9vkAuJ9pf81vYeDIcnIE49TaAqMWAHyeqz
         q+DrYmNkudyQtL7dnTpHJlXcoOCy4QPvP58fRVBG/w7iHm7RQ0meEWM1liUQs4217FvA
         WyKxPyV6ZgqorAhj+ZjGvhVHexadMzYDJKvL4am74SWTR2n7eB6bm9v11jGg68lGvC9F
         PO3a+ILZW+/f1VgMDxLc+sNLodDICtkAWVQXfYMFKOr5Ho9oAYsTN7psR6t8sXvF6527
         Ic0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807688; x=1756412488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dx0/asqotG4rq6EdmXwwX9N7zT6RzPtjLNznPWUyIY=;
        b=j9FErV610f1m5X2PUsCsPOsgw59jWuEClG8uCkiLpvY1pzAge+TfCUMoAWg4pQV8gU
         BWMWk63w0rO0Ji4xXePxDnR3UV7wTms0G6ekmCnmeLoMwCmTPi5yluLd224NccoD66OV
         CoatRRRJ57p5jIlhHprsFLb6nQ3IfGVHA64tOLgIE/ZrtA/Cov3IjeSS69C+8lYnNPl3
         2Xrbb3PnZ+A2CF6zxrnWSNipRknSFzOQeqOY4V7fiySFZLDQFFrem6d3pKY+dav2+BQa
         DA3tozNHRWRh5bwNigMFzUrnX2Gb+94pvmdbNijJ5NH7vbOiYltFz4FwrBjmn2SsGB11
         5M7g==
X-Forwarded-Encrypted: i=1; AJvYcCXjvnXQnVRh9FuUxP+9N/NECjA8IkMjDLNU/VCJDcczQOLbvfvlgDdD4HUrENofYR+UziFxgNj/UHSb@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxyapFMdaLIcyz0jXRPN5M/s7tvN6ncEmGq/dfxx4mu0NOq2w
	Gxt2uWmm5M6QQAzgGVTKy+SgJj4z2T2/DlPvPPuVtA3PUXrxbBjPPJHkMNGQmHAJGvI=
X-Gm-Gg: ASbGncuE9TD6DTMtKUlmozNXuLXKPhb5FBR8DpNTOSHe5iJgHQ3OG88D5hv/nha8xi2
	xwm87XatggZfRWwtl1f6vz6J7XsdYI3t0VFvCx4v4lu1JKwquurAMI0dVMR1XstRvSF2uCgn+kW
	8LlIyWM94wYjOOnWPw0gCFsTa+A+xixPUqdAsYC7upR4OOAE/Hl6ZAdCO8qmCBkgiZuXr9Z5Udf
	jSeZ37ReSyitdWANoPFLXyDEElEVrbPwX7owicSMcS6ibZAMGvKURaKOK5+PlnYVOkCZib+EAjR
	UISD/3vk3B7UKzYj2EcfPwtxZoEzwMU6OekyWe2KnH0ynPLOtn8H3YazsQ0DJf8oIoR9p47A9I6
	O2ifwmoSw+DvZEQEioED8aF2V2V7lEaGuPokg5qVOBnpGLkmTMSe2jMH8gmNMPbD+AEysMw==
X-Google-Smtp-Source: AGHT+IE3MKR1OshrNQhYMfUHpxtul5RNV78jpcHZ1k48ccvq/Xk3W8ycFnx2cvyOFBjMaIDV2N2ulA==
X-Received: by 2002:a05:690c:3345:b0:71f:9a36:d330 with SMTP id 00721157ae682-71fdc8da73emr5864447b3.25.1755807682899;
        Thu, 21 Aug 2025 13:21:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fb71c1acfsm13948477b3.71.2025.08.21.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 44/50] ext4: remove reference to I_FREEING in orphan.c
Date: Thu, 21 Aug 2025 16:18:55 -0400
Message-ID: <cd9f2a5d78d6863fa529da33950e5f2f0f26de60.1755806649.git.josef@toxicpanda.com>
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

We can use the i_count refcount to see if this inode is being freed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/orphan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 524d4658fa40..40d3eac7b003 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     refcount_read(&inode->i_count) > 0 &&
 		     !inode_is_locked(inode));
 	/*
 	 * Inode orphaned in orphan file or in orphan list?
@@ -236,7 +237,8 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     refcount_read(&inode->i_count) > 0 &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
-- 
2.49.0


