Return-Path: <linux-ext4+bounces-9649-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 755FEB36E65
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335B9461BE1
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9595436298A;
	Tue, 26 Aug 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ATwT5TzG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625535E4EE
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222887; cv=none; b=mGz+n/tMp25QsvUtzBD3IVq+Y+eB4k+nan7OyuU3bsRUiUmMSppqJkERKrj7M5WSqcZAl/u1dno0yokh7bhFKUhjOjZH/tbaxZWd9ChqFero7KIry35AMnyAed5vS2XS80WIRTwUJDyUSO/MI5kX0Y2nvfRfIc9wgGSMa02xgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222887; c=relaxed/simple;
	bh=BcsxwfXtk0iNo1/SL2s/ecZqZhvAJgKGVc1u5U8/F38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKXDUbCudTvrmAW/4cGK5MOUoQFqpnN/kS4kdufaMnLBhb8gcvDfFbxStsyVruM1GsvnSgHExf4J6RCViyiVCzr+6Ub/nPHM+9QxG1Kw9FLqCDlDRKTaU6AfE47cvbSS3dEE+FG4wZagdc/ibCxr6LJ5yIZzJ/pk4BStXl05d6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ATwT5TzG; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96d8722c6eso1481189276.3
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222884; x=1756827684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pj/q5LV/Zjj+RGaDytTI7HVb3/yBVl27+fEybeIP2II=;
        b=ATwT5TzGHoxrj7PHJUbtByIbeBESmWp6ty18jiEYudGN9FBVYPOqTdTOeEIY7YBhMI
         Rppdv+reft/PaddOUc2vqF66FppCm1CPyfvy1sQTNikiO2Qh7sB3tNfGqxJEK3OtbFcH
         oRaoVl2QtV6cfmLBwh2BBH0pWG2UmsD2YQx7GmhIEPcGxSQp8VeHsaUi44XoEf+wNa1u
         WjUOHyXIsLfggsqbewQ58u/GrhjICly1+nVh+BIGyIk+ry1i0hbHCkGr8LYFiZrrT+xP
         wgQiL4bmSOyWHTw1tmPcJZku8ay62pA6qadRvIs1P31XbhS5ltysvtAmXNcOwko7cLFX
         N8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222884; x=1756827684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj/q5LV/Zjj+RGaDytTI7HVb3/yBVl27+fEybeIP2II=;
        b=mTIuLBMTzwLY8u6B+TlEa/YhiCG1+LvZ9aOBv8Ir6H/X1C7uvTXtDE5gJs3lIvU2bl
         qZCwuPLsayCsbjzM1/cGkWOddBO5pmgAQMzi5FV6r1EH0d+g7VPbPbRl2miUgUhxFqj1
         11aZbSP0CW8WIGGF1YAGRBLUU+B8mi0ae6TYPW9iATi5OK+3kc2M+O86cZ7eRg2GBXSC
         YNvtEouNCkjxYT37J9u/GwDW/NaUI+16iMgnAwr8IalFq9AAHcRAi+qs0zNh7CFRD294
         Xn/gE+/omYrkm5vCgbrLnHN9Ko9Zn286Zi4pbD7OEoUcVRbH5tNkSCuGUqLppKdPBfmX
         BSbA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ3Hfd0EZA+IUMsP5f16NEajh2Cu91ajv82h2YRuKTHVyhMt4Aa1p6lktWSbn9aLBMd3eh5OviKcRD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvg/Bdh9XSgsWfmXW8bkEbyR99bvBLvip0hqFX6KZHOvbXaeFW
	TyWfmo0XmbTDJoPuc4YczBOGygxx1O3O6c+T/negVUeNtr+XHI3kDl5MedQaOIN8pc4=
X-Gm-Gg: ASbGncvbU28E3abYLtgXjRcqqzzifpvCsf2812Sp39o77iGX3mtJoVmjsr4x1Gu4dd4
	wTgfENztO9oWA38WcoqtiV0LNzafBSApeY7rioDjSK2JkIqEqIBWoWA1b9AL12AJPgh/Dvxh3nB
	nxJgpMKaYH9CIMymWT5LbdG/aI0m5hXRlBKnCu6ZUa0tzvotKebQWOThfirFiEizOkNIVpxtxja
	wU3mejXLRVPRu5NVQ52cOd5XWydSsqRnFPI4/RZbqQv0SaXqlFT7svWEtcfzhIRKSgdwMgQgl1W
	yuMOVAQ+jvPrTP7ir/nKF0UQkbc6NvPcNp0S2swEFPAMCscr4zxZPh3PCymWldDmcaZa2gRM57g
	OwE44lFXQXZ3k4TyCEIYMg8EO6HMIAmyPhtAx6iMTsFJpNlt+yldNYVFl1jo=
X-Google-Smtp-Source: AGHT+IFo3Ri8M1iGHczh+0kLy567c+XsPWYnjC+DbxsArk1jOqV22kRgMeMJMzsFpnNj7TQiFIR5Rg==
X-Received: by 2002:a05:6902:120e:b0:e96:c67d:c61c with SMTP id 3f1490d57ef6-e96c67dcbafmr6156328276.8.1756222883548;
        Tue, 26 Aug 2025 08:41:23 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96d661d1basm1058955276.13.2025.08.26.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 24/54] fs: use inode_tryget in find_inode*
Date: Tue, 26 Aug 2025 11:39:24 -0400
Message-ID: <ea152e1b05ea305c0bb8fcd066a0e1e57e680de4.1756222465.git.josef@toxicpanda.com>
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

Now that we never drop the i_count to 0 for valid objects, rework the
logic in the find_inode* helpers to use inode_tryget() to see if they
have a live inode.  If this fails we can wait for the inode to be freed
as we know it's currently being evicted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 66402786cf8f..4ed2e8ff5334 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1093,6 +1093,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 }
 
 static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
+
 /*
  * Called with the inode lock held.
  */
@@ -1116,16 +1117,15 @@ static struct inode *find_inode(struct super_block *sb,
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
-			goto repeat;
-		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
-		__iget(inode);
+		if (!inode_tryget(inode)) {
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			goto repeat;
+		}
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
@@ -1158,16 +1158,15 @@ static struct inode *find_inode_fast(struct super_block *sb,
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode, is_inode_hash_locked);
-			goto repeat;
-		}
 		if (unlikely(inode->i_state & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
 			return ERR_PTR(-ESTALE);
 		}
-		__iget(inode);
+		if (!inode_tryget(inode)) {
+			__wait_on_freeing_inode(inode, is_inode_hash_locked);
+			goto repeat;
+		}
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
-- 
2.49.0


