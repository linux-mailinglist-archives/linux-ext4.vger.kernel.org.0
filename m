Return-Path: <linux-ext4+bounces-9651-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E5B36E47
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390A47A552C
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4BA362983;
	Tue, 26 Aug 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FMXg1hfO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133236206A
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222889; cv=none; b=sDSooHj6RcX2v3jjdwqVfYiiTON0RnoADCjrAttbJFE8DROevKgKGwWrh9wCf1Zq34QtxLPYletTLx1xu0IK4Tp8IlBGxEZJqgPURsG3QXmZa6FlMX3ChrDNmAmHzClBhoCQ95q2LSc/3cgAMiDy8wp/m6azZKqsdKrNhUj74PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222889; c=relaxed/simple;
	bh=sYrjuPeM7K3KQcnfVGtJT+79EiV+VMuzvrHu44CUk/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M577QPU3SMx4WR6Io6ZeITM0YhHpTehq1ppC9UA2JIfQc5HpQ3WenOf8LvRjgSy5+d2kdO152/FirVsuuHWk2jVgBwXLyGkjM59MfN4hZ2B15CAoyUZIzBiP1cQECZHPjKPGC0lJn3/7Rwhb+sEAvkAni3K7D2G149OU0Iax5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FMXg1hfO; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e96b9022f51so2645713276.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222886; x=1756827686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/GIckRLBTNo3hmisGAgyU/jYzDZFB7c7b11ZSMovQU=;
        b=FMXg1hfO5kyhbRx15TvhAKipxc646eFXX8N09dcQ0ZrvOlDtdiOZ6QBzaLeUD8Uqh1
         KYWzUTEJYqFUsITnNmSSE3j1aIgG/elk5hEmVTUz/O79Kk5fhV8Dgn6wZT4o47/amYo8
         24mI6kBbZsr+r2ThCZMbzrdLMDZ7kAtoAV3rBSqPCmI5o5hvA8GLifnHjBRZIT2oPgFZ
         UiR6aeTruvxazjljb+zrNd1ctBDo0tRbkc9nS6nQFX4Tf0Wd1nDmujc+YPWXRj5THaAt
         PdjMydNOkgHNptcQ06eQdclHxccA11SsBPowZs7mfbzE2glCsSdGesS3oqHEcP5YsOJS
         p40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222886; x=1756827686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/GIckRLBTNo3hmisGAgyU/jYzDZFB7c7b11ZSMovQU=;
        b=YtntOVjQivsvqXfa0WWP/iiB4+VFGUoztjGoxmJnO4j5jvkiZuHUyNi14tKSyDZuoM
         9jdZ0UrqSAVsyH/FvI7ns2QLW9gU+EwBqLkAjqDkr6sMFPOloGxFMCszwlHhVc9iRDJ/
         CDok1NN46q/bRVCtqYeqRo28DrPJnkdvzXdT13mgSUmjDHl5LU4QKh4PVWVrfmaEXdMT
         FiH/iF/9727GaGduxlBKIw0S6YWdmM8AcUNXbQKeiSxm3usXeNRd3WvtBf61ray7PrZs
         O4XbyYH27OQAUG3yrfOm+GUlZeDZ93HgnS2DhSxbbPbIiPUyRfP/Vm2mhd527kw1cSQZ
         lMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZM36EaWIyjvOtt5RsH0GlCLEZpv/0l00FzVDFMVWNIh6Pv47NP6FSHv4Gjcs7/VCARbcAjNiQcL4@vger.kernel.org
X-Gm-Message-State: AOJu0YzSropoDHGr7FEXwddQFAQELImyLMvmcI1NUH5T+eMIoqLBL+Ao
	guaTzb43R2x75ujzHB6TmvwAFTRKV/tRgqzNSsmtWf52XGscqwkJZ19arvMpvvE4cRjyXy8/aBA
	4VDw5
X-Gm-Gg: ASbGncsLhHzqdDco2Vj5Ia5B8g3YwMfTr8b8Qk04vQSMuYu4sfLseHng0nxT2uD8Vy2
	0Guua2gMExwwN+2wajz/w/uU3YWu8e2A7BMU69ZOds5U5mi+T1LoxnIvLtXrkhaR1NZIIP8s8oh
	GvopFMx6/Hpo9qZ8xoivhQbzV+K5SiV6vNNZZ9nQIEfLDdXm9BU5vVsIn6EUb6Af5MCVFStGTqY
	BDtEOVRxAX3Lh//qtHrfMrt0N9GUBY6P2dPyyzTPxhzLmJQBrCE7WmTwfKBVuV93911cHUmXjRW
	eDbQIKq0YTMVteXL1RHybB21ndIaRZiW9hL1jyWWnPXgJOjH03Vz93fWug8McipUHQNAYTv80Qv
	l9174npdGTHctph2qjgRJ9njNotkS+ZBVsYwYQW7SZAJWHfnTFAi58YcDbx1wg2ke+5TYww==
X-Google-Smtp-Source: AGHT+IHMjqIN/cv/dNqZaUqk4AIfXq7CeGQ/chI33c+CxPNO4KaD5NOoKQBN/9sJT95k5O4DzOn2ug==
X-Received: by 2002:a05:690c:6d07:b0:71e:84d6:afc4 with SMTP id 00721157ae682-71fdc2e296emr178097767b3.14.1756222886438;
        Tue, 26 Aug 2025 08:41:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7213f47d0b0sm159287b3.72.2025.08.26.08.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 26/54] fs: use igrab in insert_inode_locked
Date: Tue, 26 Aug 2025 11:39:26 -0400
Message-ID: <8e31ead748e11697fff9e4dba0ffe29f082c7c7b.1756222465.git.josef@toxicpanda.com>
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

Follow the same pattern in find_inode*. Instead of checking for
I_WILL_FREE|I_FREEING simply call igrab() and if it succeeds we're done.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8ae9ed9605ef..d34da95a3295 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1883,11 +1883,8 @@ int insert_inode_locked(struct inode *inode)
 				continue;
 			if (old->i_sb != sb)
 				continue;
-			spin_lock(&old->i_lock);
-			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
-				spin_unlock(&old->i_lock);
+			if (!igrab(old))
 				continue;
-			}
 			break;
 		}
 		if (likely(!old)) {
@@ -1899,12 +1896,13 @@ int insert_inode_locked(struct inode *inode)
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
+		spin_lock(&old->i_lock);
 		if (unlikely(old->i_state & I_CREATING)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);
+			iput(old);
 			return -EBUSY;
 		}
-		__iget(old);
 		spin_unlock(&old->i_lock);
 		spin_unlock(&inode_hash_lock);
 		wait_on_inode(old);
-- 
2.49.0


