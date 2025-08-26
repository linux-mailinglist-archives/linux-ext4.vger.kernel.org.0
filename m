Return-Path: <linux-ext4+bounces-9630-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF8B36E14
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27FBC687B3E
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EEC350D54;
	Tue, 26 Aug 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="J1abHhTc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEFA2FE04F
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222858; cv=none; b=h1ewiug21AhrKjEJJEpxvxhD2rxdeQkg8rUwMICTeN3GeuOamzGchQ0kiethvX8JEFFHrlPBDz9m+zmX2h8Oh+tDrk1Gy8e9tSL62taJ3+MqlnQ42VjTT9somkg09PrYw9GzOSFa0SQs20mHYAKKBSC5gqp6qaFbcIaOrm7NDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222858; c=relaxed/simple;
	bh=v4+k47Nq015FWctgvCs9vsg/V/TA5kz2ykNqZmvSZkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUXMTH5EBzggu7Bem6s9uFG+oeBNb5XsGYSjaU1wagVrREGXVWMolygn2h+MPvupfVmlJFxx+Js0AJAtehavfA3nyRb1frLF+6d+oi1DYIWjqm2luBgpYcFtnzDaCdR0b+obnzHFYZKiOj/gAjbnSOHtQpC7byV1Wzion0nzAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=J1abHhTc; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e96c77b8ff5so1848456276.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222856; x=1756827656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DuEK+Kk5sFprszwTHehPZviexNLAjFi3s4jagEjiXI=;
        b=J1abHhTclwAwQu8lYot9DKOf/qKsH15+PFnfdRNUhoNOoj18/RMTkG4rzHRkO3TRgc
         pkPVxOXYql/DSGoIRaOyuI8SHTwF2kajtLGOP7VZHhA3nFFCMo80UcAJrhBtQzMY/mX7
         yXHoK/Kmp1vO0OyCYu3VvZBlSIEmhq6s6yGEIaMAX98eacvCjLc9j+mpWmIjKarcaDPz
         pzS4T0EYzm6SD0WVHSAIp6pxtcrPDL2AHacYY7WEn1Bc67OCZbiOxR110BRAYuuh2mqc
         9JoBiYeKIoLq7/lz8lCNUu2YXmt+uI8qPrTW5qbREQLWLccvYibIFImUV/Twco6fU/bV
         Sv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222856; x=1756827656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DuEK+Kk5sFprszwTHehPZviexNLAjFi3s4jagEjiXI=;
        b=Xsfw5pRYgJ5YSR6+FG26OXBbBFF7Ae2Y82r0b2JJIYfBjUuIZo2nxExx8S/AJNKZ5K
         bRcphGNhi3/RedML0jHxTM5QlKXZMVVT/cdReEtVNBWDR73f37lwHmDC65MfhRIGMn0k
         MNx13RhNurJinBAZKBZhe0iJuCygs+qd5Si8S1xVSw0sCuYqzDMdRLRAyRJB3/jjOZIt
         vq/z00so8vKDmI3zoOZZ95YJymH75O6T9piXN10tM2wAT2/OoZdHjbK6XZahf0UhjzU7
         cUtqBt+9ISIEoCHRJUQ23yVaVHjz5tULiT7kR7ofezpYvMdcZnNwSAvG0oe5tUNCsd9F
         flLg==
X-Forwarded-Encrypted: i=1; AJvYcCWzY1On8ShQ2dn8x9SaIVD/vlSdVWz7T/b2PU4C8vCsdOlPuc+a2tk3MGE7QHS51SCJ6xybyq1A6F3A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jH63X56F93k8TAWAPN9zQJpoptvu0jiLgBLemrMGm6UZDFO0
	Jty7rbmUH8y8ga64Y0k3AAkIzb33rjlsfqpvKZ3aMBofb+l1E1sqVGJFIEsDqUGmz8k=
X-Gm-Gg: ASbGncuEXg3PWT86Hp7BWj2PcTm5E4YbULkGjZYciyW3SNObX9AzcxRbUz6FNfZle0q
	hAW5ebraMr7+dPiYsOe5pdeJpOR7gaepJLWaV5zgtKJNm2yaKc0Iudva2uTeMgeV+1GkXta0GCq
	N66EmnIDsWBPod83tO9HwAz57V+gxDf9K4nrS5AcSp40V1GZzCb6JPOLp49cNx8ayO5Qb+pr9nE
	AfVS0WoZuVMVEALjFSO9/wmPGtPU7nSKp54hlZHuMvGVlgT1KUC3mH3ooYSWd4/Lyc0XbrCmm3e
	N7Gosp+/SXDaYrmzWQgUXKG0YX2L3iF3fNpxRsZ8D5N85w0QiR0aFtIFxg8PUVUdZggyx2a83HJ
	6UEXY12+gOOqNajBPyZl3CEntTbkmKFGMo0rhGRvgxuXe2HNQUZBlLRXSH6gcnCmJCFuCeA==
X-Google-Smtp-Source: AGHT+IF1MI08diNCyXnNMWWu/+8R5wdOAhVg7UNfF70XcvUlTFYcLCsm4IxLYoWA+0GC1XqTbbEzGA==
X-Received: by 2002:a05:690c:c0b:b0:720:631:e778 with SMTP id 00721157ae682-7200631f13bmr110723557b3.30.1756222855550;
        Tue, 26 Aug 2025 08:40:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18821e5sm25322837b3.44.2025.08.26.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 05/54] fs: hold an i_obj_count reference in wait_sb_inodes
Date: Tue, 26 Aug 2025 11:39:05 -0400
Message-ID: <94e7ea33eef40e407b2bef6a200c9474472bc778.1756222465.git.josef@toxicpanda.com>
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

In wait_sb_inodes we need to hold a reference for the inode while we're
waiting on writeback to complete, hold a reference on the inode object
during this operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b6768ef3daa6..acb229c194ac 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2704,6 +2704,7 @@ static void wait_sb_inodes(struct super_block *sb)
 			continue;
 		}
 		__iget(inode);
+		iobj_get(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 
@@ -2717,6 +2718,7 @@ static void wait_sb_inodes(struct super_block *sb)
 		cond_resched();
 
 		iput(inode);
+		iobj_put(inode);
 
 		rcu_read_lock();
 		spin_lock_irq(&sb->s_inode_wblist_lock);
-- 
2.49.0


