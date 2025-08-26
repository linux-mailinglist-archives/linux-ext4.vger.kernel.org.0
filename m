Return-Path: <linux-ext4+bounces-9657-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF800B36E8B
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F842A834C
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7CB369347;
	Tue, 26 Aug 2025 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zolhkLjL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84730369335
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222897; cv=none; b=G3bkqAGYaLgmzNRCLHF+qxNUNl7nU0U+pA+NsVfm7ijeFUjQBJ/ZvQibUrNIjdw+yxupZL4yHkC4vXO2BvVBYFRS9ij0AfblRB/YURHBBt2O9ImXpwnisac247fWVA1uFbVpBd03GccUC572Zz19+G4OVMi/ZAU+bnbt//s6rJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222897; c=relaxed/simple;
	bh=G1aMNZNoFlDJqDOwcnIWhE+hsa6d2Luem9buE1zdqp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qo1xN8+0+lCQrCacfJW2wSqYWk8rE05Hhbqa4SEBm/wX5NX9fsG5GZ76i2f7c9F5wK0kMTz4z1xcAM/MkIKjz7h6pcPBKVsd0wXipVeYjsVq4PDgr18So2RC24RXamj2oVUqanAXZPd0UPYZE+Z4+bVZkrApmfs4Ot02Ohc75pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zolhkLjL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e96eb999262so150985276.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222895; x=1756827695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8Pc8K7etH/ssaBOvhPppI+emHRcMCSy0sOBGONM6UY=;
        b=zolhkLjL4uPpQwgP0XbbIbRpbEVe3mlgpIZOJGifgLtwi197982ES22x2P7/Hppai5
         LMDylOyo6qBBgahg325iQ3IRwVIUfApE3nXkxlsb738isdDtPpaCZ8KdxxRDixjvXkCk
         hwU89wL0UvfUaGUEb+ZbKRgjzq1zL1Hwx8WjyfOQjekEUjNrE4BZqbsSJhsS+oYRebmz
         zCtHONbssV77ez2SAvEIxY1v4yOHuzDZjQGnLQm3SSB/XQTdEenCkTE9z7xHhr6DXsoN
         i1sII54P4yoD6tlpNfUA1okSZ0SRwRlrmNNP1nYhTIiJbGkKyWHEVszTGwEQNlorKM6E
         RBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222895; x=1756827695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8Pc8K7etH/ssaBOvhPppI+emHRcMCSy0sOBGONM6UY=;
        b=tb8tIqJcCu83vkngXtZ7O4z3l7pIrAc5nay8LsV3cgWJoJNSq/DlTxJ7ShQzTrdQ8B
         qvkM7Ce4XnqB3ivmLg4tWSB+wBBNnCg8EFTgxGGjAxN9JrNdGCby8QEwRANFBiOHbcz1
         Ioz7Z2CtirZ6u4ttOPHQvoupLEI8vk0n/BC4qrxPcTnjPyotGNzZGCeABkAOzjlyuDbo
         4gz2ViNwMWPus5coCDQi8Fj2W9626gavBQrAgnSroUov6gON0teXLMDkl3XjQ/n7Pa2J
         Wgt24n7Uh7Ay1CE/9HRdyZXj+yYiNAJ+BPeTvnqnduVAk3OHXTGbqbeFWWxQVWUaPJ8T
         BB8g==
X-Forwarded-Encrypted: i=1; AJvYcCXScyym+OBj7G4LfAiP+1Ex9/TF/J0DGrScsMv/TWUzEhmBVEMCN9ODMaNVSdaPe4ddDAoOQwO2d/dj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+aCwHurlsigTIxZ2xSY1Wzv8kEwB8qxALNhRs1DG2vCC08a0o
	qG+Qld/neQ7Y6PaNwThMGNMCDcyTFPFUTJDiAlmMWCOOGnw7WO96ZNUCF1GnA3n1jfI=
X-Gm-Gg: ASbGnctfIX5cLeNWjKkbSSSr5SgjiCslkzpjPjssHWweYlKPojIxjH6RI3fZ3PafhV5
	/qZvkMcZEmPBTclJeR2J6vfoiArnnVySfttn9N42/xueAYV9sw7PPAHdGsz1NjdNGBod3UR+5+a
	tHBz3zm+04XBGh0hNH/lSmT2eDhJRNIf3DecCCB8Qoj7E6rWZ7rK0JSc82nbc0oGOq6VSceE7qh
	cXySp3JlqzcY9liFnmwWOlJWIZrTULZ4qHxejw+WryD0yItehkWVzmCYfzhDsiLIW0e05NRDuXT
	KHUfToUBzbF7ALX7j0tUSLXhp+lmYFg3i2YvG3jiOTrUUoM+Z/j5lTh4cNQQL6jf0ZM1pKIQLPy
	rDcim+Wt4qf+SdxtnZHTKvTHmibgOOQfp3ESi/fnD0gLJNy3IneOx72fwY2iay3U21OPJMw==
X-Google-Smtp-Source: AGHT+IECWyUq5Swkb2LX4gAl0du30jLU3PMPKdvHwQvNIMFfmHVt+qIGh58VpZfE89ckqB90q+RBwQ==
X-Received: by 2002:a05:6902:220e:b0:e93:3d4b:632d with SMTP id 3f1490d57ef6-e951c2bf0d0mr16715139276.40.1756222895451;
        Tue, 26 Aug 2025 08:41:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96d59a5ba3sm1098948276.31.2025.08.26.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 32/54] bcachefs: use the refcount instead of I_WILL_FREE|I_FREEING
Date: Tue, 26 Aug 2025 11:39:32 -0400
Message-ID: <03228d047baf5100b48174b36af9b59db941cf55.1756222465.git.josef@toxicpanda.com>
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

We can use the refcount to decide if the inode is alive instead of these
flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/bcachefs/fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 687af0eea0c2..7244c5a4b4cb 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
+		if (!icount_read(inode)) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
@@ -2225,7 +2225,6 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 			continue;
 
 		if (!(inode->v.i_state & I_DONTCACHE) &&
-		    !(inode->v.i_state & I_FREEING) &&
 		    igrab(&inode->v)) {
 			this_pass_clean = false;
 
-- 
2.49.0


