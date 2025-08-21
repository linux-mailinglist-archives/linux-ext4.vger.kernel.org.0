Return-Path: <linux-ext4+bounces-9522-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24706B3066B
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B02A04939
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F189738D7C9;
	Thu, 21 Aug 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZLEFp0wq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01038CFBD
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807649; cv=none; b=qwH5P9BLbX5jQMDpJU4CC+Iy8eoq4yb++//a3B/2sesO/YO2EDjIwsHK8A5xndPrMGFOpH+FLqocEJL0OeB3ZJSqcvySY5hjOZGutrLtoP5EIZKFgbc0PrVaOxHcrc65hHEDi4hWsaX/YkM+B846OkUOw0+7xNdnknUXibbE0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807649; c=relaxed/simple;
	bh=Gf9FXWH/ZuDKdX9P5hjdB0UsAEHdKMkPPDHtB9Z/EOo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5SpiLBioqq58Dcof9J+Y2Gi5XfJ00Q+0sOd7AEw6BgIewK9N6Kh8chFzXtfAB5mZYaim3bHbvnzOppPzL19zxxcxdzA5DHcTSo+oDg9Z9LUkzN0Jbs6eP0jYJoSAcIU/0+EZyFLxJG6xrGbFTGcaKM9NF7kilYMSYcXdaTsayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZLEFp0wq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d71bcac45so12460957b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807647; x=1756412447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sCFvMGDmyS2XnSODd2kQroHz5FYCPO0RxulE1s8HM4=;
        b=ZLEFp0wqUir0tqufugAgtS97c6K/pFtoZFtWPo0/UVLVX6ddoJ5OWx7iCXXBY4UKgX
         wHovCKtKsGEvdso+S/WilRQa9Qp2h6ZPB2JYevPsLvQxF8A974fYCp+2vECRp85qbEUb
         Xe2o1o958MSM1Rhn6y0GxC7qBeAZg/UTXMTUpzEek9FB4isMKT7DmCVl1PHUq475LYDt
         EA89KOJ+vsL7Q9VbCRaZ5hLAEVd3yZV56BMXbYUMxX0BWaQIF50sqLRlSXCPikWI71tW
         vvQfuE05ZWewp4dCO7imo5eowY3TWeHFIzIluIs3/zFrG1VLZreqehno4Cu4Kfwprsss
         LKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807647; x=1756412447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sCFvMGDmyS2XnSODd2kQroHz5FYCPO0RxulE1s8HM4=;
        b=PhHcgdYm4DGk1Ithb9I2FRZul6PlYdFVJKAzzEG6IAAdKn7j+DCsejc4Ld6f7eQ2vT
         UICtsi9xXcxwiZMauRCmhmpGuAaulf3lZ6AMUDRvIhUXQGQMP8tayIV3riZ/NsAqPJRY
         z2Qa04WMgXSKi07In/SqRRgZFTmUeEERBJvHAjZvV+Ggj5P1Dm8NJTmUf7U8wlzFjL6M
         m70OnYbKiSSq9Yj+a/S2km1RDgxBf4g1s+WMdJTNcUIw1tesmyXAsuTP1F6gXdd4hv/G
         Pu1tAFh1KyTJYXWvUOiGaERtZB8EhFmmypM1iBbzbL0Fy+RsFIsCm2UkJy6GyP2Fx05k
         41aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVECfbLwS0D322emiPCviqOey6AsbUMFY5ISxB5aEX6/qwcAgnXYXL7r//E0YDTIg4ZA0Q4yOrg7K/V@vger.kernel.org
X-Gm-Message-State: AOJu0YyEuJkRH6LPxiMKbZC3EmDhwaY+dHhienYc4RmzO7y1XAQJc4Nw
	4w9Mp51fKHSOV9xIEG9poQMBz6lF498IyAV8xMHwm/31hLKcOyVQSuT+amiq13EUnPc=
X-Gm-Gg: ASbGnctHNs9CrBVqLgHS7kVl3bF0QiEzq71LkuD/OFWhjFxlTXj7QJpdtNk10AstCnN
	9GWGXSd9xtuHlrBNiyTgJJrIgvHvM+A8UjTQTN4ofN7XLYcGZ4zZE0rsIF6gxi/pGHXHf0L5YNh
	fLFM02r9psyOn3cS2aEanULgNFoodlM6BByCLvujcLsV1UW8Rl3NRjsBvcHqVA8kkkHeYQ9kblt
	2yQkP345KLVf222FVyHEwmweT9hTcH2i8Ysb/FMMAgKmG/y7WMDCAweNo5Xipzj/m0wVfhrxsGl
	c3IGqPmESxNe30x+oACnJtLZrMtaZlLeq/f0BDIePVnE77RjTW/Tju2ezOG2xx0Gy/NRmfMARs1
	vR0OdNKcq9jS71rq5yuXpOVjzaXcjihfT02WRUs0XCXCEvGhhitr4kXpm7iCpcubZsyK/+vv45S
	T4xY+x
X-Google-Smtp-Source: AGHT+IH/Kqtl5y7NrOIljy8lwdRA1ZWPETykkqyOgtZcCa4Z4HsdEla8lVbkS8DKZqObYHSv5QA+8Q==
X-Received: by 2002:a05:690c:4d88:b0:71f:b944:102c with SMTP id 00721157ae682-71fdc539758mr6887097b3.53.1755807646748;
        Thu, 21 Aug 2025 13:20:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71f96ec62cfsm24518727b3.22.2025.08.21.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 21/50] fs: use refcount_inc_not_zero in igrab
Date: Thu, 21 Aug 2025 16:18:32 -0400
Message-ID: <27904789c7dc983dce3f65be80c76919dd1765bf.1755806649.git.josef@toxicpanda.com>
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

We are going to use igrab everywhere we want to acquire a live inode.
Update it to do a refcount_inc_not_zero on the i_count, and if
successful grab an reference to i_obj_count. Add a comment explaining
why we do this and the safety.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c         | 26 +++++++++++++-------------
 include/linux/fs.h | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 28d197731914..b9122c1eee1d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1648,20 +1648,20 @@ EXPORT_SYMBOL(iunique);
 
 struct inode *igrab(struct inode *inode)
 {
+	lockdep_assert_not_held(&inode->i_lock);
+
+	inode = inode_tryget(inode);
+	if (!inode)
+		return NULL;
+
+	/*
+	 * If this inode is on the LRU, take it off so that we can re-run the
+	 * LRU logic on the next iput().
+	 */
 	spin_lock(&inode->i_lock);
-	if (!(inode->i_state & (I_FREEING|I_WILL_FREE))) {
-		__iget(inode);
-		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
-	} else {
-		spin_unlock(&inode->i_lock);
-		/*
-		 * Handle the case where s_op->clear_inode is not been
-		 * called yet, and somebody is calling igrab
-		 * while the inode is getting freed.
-		 */
-		inode = NULL;
-	}
+	inode_lru_list_del(inode);
+	spin_unlock(&inode->i_lock);
+
 	return inode;
 }
 EXPORT_SYMBOL(igrab);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 34fb40ba8a94..b731224708be 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3393,6 +3393,33 @@ static inline void iobj_get(struct inode *inode)
 	refcount_inc(&inode->i_obj_count);
 }
 
+static inline struct inode *inode_tryget(struct inode *inode)
+{
+	/*
+	 * We are using inode_tryget() because we're interested in getting a
+	 * live reference to the inode, which is ->i_count. Normally we would
+	 * grab i_obj_count first, as it is the highe priority reference.
+	 * However we're only interested in making sure we have a live inode,
+	 * and we know that if we get a reference for i_count then we can safely
+	 * acquire i_obj_count because we always drop i_obj_count after dropping
+	 * an i_count reference.
+	 *
+	 * This is meant to be used either in a place where we have an existing
+	 * i_obj_count reference on the inode, or under rcu_read_lock() so we
+	 * know we're safe in accessing this inode still.
+	 */
+	if (!refcount_inc_not_zero(&inode->i_count)) {
+		/*
+		 * If we failed to increment the reference count, then the
+		 * inode is being freed or has been freed.  We return NULL
+		 * in this case.
+		 */
+		return NULL;
+	}
+	iobj_get(inode);
+	return inode;
+}
+
 /*
  * inode->i_lock must be held
  */
-- 
2.49.0


