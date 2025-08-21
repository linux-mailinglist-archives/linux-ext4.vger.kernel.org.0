Return-Path: <linux-ext4+bounces-9534-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE154B306B3
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A258FB00CB3
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44270390956;
	Thu, 21 Aug 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ia90qBLf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E138E767
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807668; cv=none; b=HYshLJwBLGfQ1wOLOF8eFkdz0Ik5Ek+YdmWJGH2cKMWC+RWK2sBrW94DT/np983iIk9TkLkudZU0X6wlsx2I1kSnweze66HKDYcPO1ZhBLB/yQonCHclyPH4b5IKjNwdEzM57Tr2DfyPjvimWk0MNS2wHc61c6aoOiWbMR8bqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807668; c=relaxed/simple;
	bh=9pmJgOu567RA5Ek8MFIOT/ON1k/r/cyEM9dNKAJxRKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRuDvkf5QeAW8QT76hadH9b3aowc43AqsLm+/vdEtQ7NS3Ri6Vlks+HvfMY1b+Tk8GOBwIs1GCvtrdp+kt8XUChOxeiYfrdsSQchPafpDvKB0KERvY7uxsRxnfbyiMXNXQrc3JBRFfm8kyZE8p+GmYIL5+xPsNroxtP0lGT0PeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ia90qBLf; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e950257b9b9so1428118276.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807666; x=1756412466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTp3cGLbO59j3lKKBRw8ISQooTk63pePlY3kcn/TIF4=;
        b=ia90qBLfu1VH0QSFY8tATZlNB2UdQpu+I9379MS+KMkVo58JC66crqh+KatrZURjdR
         SZEASlhf9yQo9qPQpw8BWmkFNLUX6Jo2Vl6nNJ5YLSVRzASYmLtOoh320NDdVptTVisK
         ipNlM8uY5Uigt3/g/OHDxVStb0Be/8GfGQ47/hQwo35qIVuVF5RiPQNCuvBjcJwgsptt
         aKkHLiJHKJzjARPrdT7W6/9WFJU2ymDgBGUUO6Xqdq4a4zt4VcWnITPEshQu/VHx2KLM
         I32P/yrysOMQF/FNwdUr2t7AALO2NJt0nn7jZGj5cJ8pnT6zBEUWxuuAUr4UoHoHihdI
         HiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807666; x=1756412466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTp3cGLbO59j3lKKBRw8ISQooTk63pePlY3kcn/TIF4=;
        b=wpqNU652DYoMUtM/OHZh2rIm2d2Hws6+7dxk8stdy5JES6/hjTlVgSQy+a2MKGlwWx
         RRTrqHd2mJ4lxZ6BsOr+M08I5exWFO3yjmQqY6vxVpmwX0K+C8g9MeRJu8ZHk4tyq5WQ
         75zMBYdYNJmYk1ti8Vc7V1J2X6Wc0qggIb3N3FGoOjs9g31UM4JW75qaqUGmfeOXc2rO
         jyj50tyZAUASzJbfuQbf0LsJZqv3maWO4GOUWfff/wQT9M8mI59LEvSJ8Wkdfw6BOdWL
         F+hM0tIhTUgQsxaYVXSmSsuf6eXbCim3F/yNYef3Agknb9gvTaHEEXMX521S3dR0MzJ+
         vUIw==
X-Forwarded-Encrypted: i=1; AJvYcCUFTrXIsJVduYNkkSoGYvaWXWyxcdx1m/T58U9brrdzTcHZzmrmjW1RTAUhKY3A6QEDjR/yz/miN6Tw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NBSPRTwWUQWAKDpU99XhHtO1kEyK+lRvr1hy4QQH81cbpP7Q
	yvecBTCxGGMPi6GKcnPCA6xr+UQUKM+j5sHNtTBXmwosD3cT5PNgaAWdnEg1jVMBUKw=
X-Gm-Gg: ASbGnct5jUrsVBkinsSCf5L4TrzdrHYGm3FrNA02EnlQihXc9QrUb+7vGuIPkAQky37
	LzFqys1nrtZsdrfFgI8yPdD8YrbvjgBbIkocuiQBrofUne3vX8kDhIZ8SLea6FPtWcsyCMb59bU
	gjT5Q+akgB/yh5dU3CXt/dohYF2g9nK3sjlOwkgRZukph4eabEjeVDbAIKuPMfaLP+IwyQU3VBZ
	op0akHmh8QMIJ8blLNDaWxoNBiDGRGxuBgSdTqA5vqac/0DWo+chuhcwkANEFJpwFJbBnmKkC8w
	Ni1JFiI94Qj94cnQ1jhzrybGiAkrMkR6Q0Xt5Fd+q+NEAaHP19tQNMiZs24hzfvo6uywNXQoWCg
	0+fuclbk/1vAdmvG8D9baIW2Uxoey/6h1hGXnt4r5uEcYbx4L/DQDajSZNTM=
X-Google-Smtp-Source: AGHT+IG3QjFoZbQu6hg8VFuaebRzzPXkxgod3PhB2rVk9DI3MJfu/348HPHSDjgQnN+TBDXaLYfVew==
X-Received: by 2002:a05:6902:2082:b0:e93:2e8c:36b5 with SMTP id 3f1490d57ef6-e951c401816mr828431276.42.1755807666169;
        Thu, 21 Aug 2025 13:21:06 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94e85ab0e9sm2809223276.37.2025.08.21.13.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 33/50] fs: stop checking I_FREEING in d_find_alias_rcu
Date: Thu, 21 Aug 2025 16:18:44 -0400
Message-ID: <782ee9ead6eddc1f96a0ab91b97dea577d20779f.1755806649.git.josef@toxicpanda.com>
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

Instead of checking for I_FREEING, check the refcount of the inode to
see if it is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..fa72a7922517 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1072,8 +1072,8 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 
 	spin_lock(&inode->i_lock);
 	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
-	// used without having I_FREEING set, which means no aliases left
-	if (likely(!(inode->i_state & I_FREEING) && !hlist_empty(l))) {
+	// used without having an i_count reference, which means no aliases left
+	if (likely(refcount_read(&inode->i_count) && !hlist_empty(l))) {
 		if (S_ISDIR(inode->i_mode)) {
 			de = hlist_entry(l->first, struct dentry, d_u.d_alias);
 		} else {
-- 
2.49.0


