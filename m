Return-Path: <linux-ext4+bounces-9662-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E72B36EBF
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B89818F6
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ED434DCC1;
	Tue, 26 Aug 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="X5b7/iE/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199036C083
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222905; cv=none; b=L/5cWglbwz+AzRBJcm3WQNUTD4NA/2+I+6tyD05LYcX91v8VV4CCwb3AylEDyJYirScAf2HVNkT3DMGf4/lych3SAcDTnKobVplWrRg0WRU6JOdhhJugsWN3LgUyBEK+vN4/vAcjX9lRSarsa9X36nXUTcxj2oAZ1pt+2rxBK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222905; c=relaxed/simple;
	bh=EjkCEK6kE5UClp0WkFP7cfUOOM7V5cGG0Tj6wu7+1Xc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qj8rD8GyV1+vDVRPEY5/wyZA0vvsMn2oa+I8CeEwS+qj/U/dO8RMOC0hZ3/2AQIBNnHnIUMtYfCRsZcwOHFS5SSjoLRAnzF9Oa/lHUmsMM1BeS7CDStEjSP0Cam7/NhANTf2fxJLulgpKuVlty3zI7Q2mET0RM15/+pZH6E7wps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=X5b7/iE/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d601859f5so44113457b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222903; x=1756827703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uznZOy/1h/wT5GSYkYSEb9UzOQDeJfV2W64ZAmHqUc=;
        b=X5b7/iE/2K14YUH7PeyFM+hlrHlTPuNtXpJljaCCnhiczhXeZdBIUI4VLSP18OOghW
         d/rkspq4mlttQ45IOZG6OUSOJBQAjwHpyk/CJuxHa9SMcUOEWywnFfBvrttMmXkHpKV6
         Onk3rsZrDoYejKHaKx8DN4ntYAzva3/4qNasXN7+fW/f683wnSWQRwoCMe91qRoPripq
         VLjV2bmSzpZ9kEfZ4QPqJEBO56BEWR0JBKvosIoZ7k34hXd9JdaMksnhImh6Q6uOdjcL
         42FqOHI7x+jGg5OFltwrIm8vecjLXJkK57invvxFnqcJgESWk7fceZxDZsBAam6mtJDj
         4CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222903; x=1756827703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uznZOy/1h/wT5GSYkYSEb9UzOQDeJfV2W64ZAmHqUc=;
        b=LivDtfvj09RkrOmVmibePisqHPacychASWjg8KRfQ19bUkdX+z/widIHgJWHERV+BZ
         6/g1UqTr2KFuHWUWZZtS2eqtYhEcbp1+F2x4MdKONcu6JKdC5XbKIqfQUQ1GXKBzc9gm
         mJbowFY21ZNxzZD02+MSvwSzhXBYvAgpOF3RyQ7NDZCciR1SVQgWD2cRcdXqm89866iX
         1ny+2WlSPVs9V56zpTwlbSGtDc7etk+mKObZPkS/COIKYF9DO6DmYm6Kj1Bln/hXICwR
         cWgb82ankUXI/Ps3Zvhbf0s1+EKcnqVLZUyDk8egzO3+kV1XRoU0Wy6jwIRJAI+8bDzT
         SgAw==
X-Forwarded-Encrypted: i=1; AJvYcCULGeIDA5Xl+T/ERLoVSrpFrvVB/IP5j9Q7wA+dL2epDsZGW/DsUe7+IMGCuPi+CflRkZA46NwAWXDt@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ1vsIjoJiguV/SWyDSxpcc1+QVqUCmcqXthgZhCI0PLPedpE1
	KNjgcT9e1C8vP+wciZhyXloYLHEZ2lqdloVfplnpeijJjUHslT5RQQK7CpoxGeo/VV8=
X-Gm-Gg: ASbGncsJhZRgaClfQKwykGi2gV586e8JbYjeplRq482d6/6t3H8t/9EhK6hejD9gNjm
	y8XL5/L6faFULePo+6R4qtIC2YZD9xaDIIz6SPqrQvlJHG3mETIDiKK/kJALOkmhJuw9cIBO2zJ
	Mj1eeOUNMsgUYFNpV363wanlU9+l/PEuj14T9l066TE3kmWW9kB+tNV1dDfXQtAOSZG7kDPUzGf
	L9PADBCpxMMj7uIsgab7js/A8fxUOwLNXKf352abwt1/Q4HF1Tbi9CJATTCpGZ6BX+KdwwbKYm2
	iivfhcHXH1Fvkq1wY/RzshAQ08TJJ48V99WGk/fTB6XdJNHEu3vJ/wPdgcgiaQ0ycl5m0fJMtPY
	flJc6EKt8ykzK8zhftRhSuDwi7W6ZNSmxshhjmDKcOZo3ZUfAYRkCNcdJPiOXZhUo+mhSb6XVbg
	wp10Uw
X-Google-Smtp-Source: AGHT+IGRUh0MIzw9+HaUXGDPtHC/qNP13kIbSgotaqEEIB21rn75OwKtNgOCvvGpnYxS6qhksHlFXA==
X-Received: by 2002:a05:690c:6f04:b0:721:3bd0:d5c0 with SMTP id 00721157ae682-7213bd0d7c1mr11945837b3.9.1756222902914;
        Tue, 26 Aug 2025 08:41:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f65afbaf1esm2540079d50.9.2025.08.26.08.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 37/54] fs: remove I_WILL_FREE|I_FREEING from fs-writeback.c
Date: Tue, 26 Aug 2025 11:39:37 -0400
Message-ID: <92b6deb29f4abf314a7ad66cd54b499405d88722.1756222465.git.josef@toxicpanda.com>
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

Now that we have the reference count to indicate live inodes, we can
remove all of the uses of I_WILL_FREE and I_FREEING in fs-writeback.c
and use the appropriate reference count checks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index dbcb317e7113..1594cb09be72 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -129,7 +129,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(!icount_read(inode));
 
 	if (list_empty(&inode->i_io_list))
 		iobj_get(inode);
@@ -314,7 +314,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(!icount_read(inode));
 
 	inode->i_state &= ~I_SYNC_QUEUED;
 	if (wb != &wb->bdi->wb)
@@ -415,10 +415,10 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	xa_lock_irq(&mapping->i_pages);
 
 	/*
-	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
-	 * path owns the inode and we shouldn't modify ->i_io_list.
+	 * Once the refcount is 0, the eviction path owns the inode and we
+	 * shouldn't modify ->i_io_list.
 	 */
-	if (unlikely(inode->i_state & (I_FREEING | I_WILL_FREE)))
+	if (unlikely(!icount_read(inode)))
 		goto skip_switch;
 
 	trace_inode_switch_wbs(inode, old_wb, new_wb);
@@ -570,13 +570,16 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||
-	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
+	    inode->i_state & I_WB_SWITCH ||
 	    inode_to_wb(inode) == new_wb) {
 		spin_unlock(&inode->i_lock);
 		return false;
 	}
+	if (!inode_tryget(inode)) {
+		spin_unlock(&inode->i_lock);
+		return false;
+	}
 	inode->i_state |= I_WB_SWITCH;
-	__iget(inode);
 	spin_unlock(&inode->i_lock);
 
 	return true;
@@ -1207,7 +1210,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 {
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
-	WARN_ON_ONCE(inode->i_state & I_FREEING);
+	WARN_ON_ONCE(!icount_read(inode));
 
 	inode->i_state &= ~I_SYNC_QUEUED;
 	inode_delete_from_io_list(inode);
@@ -1405,7 +1408,7 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 	 * tracking. Flush worker will ignore this inode anyway and it will
 	 * trigger assertions in inode_io_list_move_locked().
 	 */
-	if (inode->i_state & I_FREEING) {
+	if (!icount_read(inode)) {
 		inode_delete_from_io_list(inode);
 		wb_io_lists_depopulated(wb);
 		return;
@@ -1621,7 +1624,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
 			  struct writeback_control *wbc,
 			  unsigned long dirtied_before)
 {
-	if (inode->i_state & I_FREEING)
+	if (!icount_read(inode))
 		return;
 
 	/*
@@ -1787,7 +1790,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
  * whether it is a data-integrity sync (%WB_SYNC_ALL) or not (%WB_SYNC_NONE).
  *
  * To prevent the inode from going away, either the caller must have a reference
- * to the inode, or the inode must have I_WILL_FREE or I_FREEING set.
+ * to the inode, or the inode must have a zero refcount.
  */
 static int writeback_single_inode(struct inode *inode,
 				  struct writeback_control *wbc)
@@ -1797,9 +1800,7 @@ static int writeback_single_inode(struct inode *inode,
 
 	spin_lock(&inode->i_lock);
 	if (!icount_read(inode))
-		WARN_ON(!(inode->i_state & (I_WILL_FREE|I_FREEING)));
-	else
-		WARN_ON(inode->i_state & I_WILL_FREE);
+		WARN_ON(inode->i_state & I_NEW);
 
 	if (inode->i_state & I_SYNC) {
 		/*
@@ -1837,7 +1838,7 @@ static int writeback_single_inode(struct inode *inode,
 	 * If the inode is freeing, its i_io_list shoudn't be updated
 	 * as it can be finally deleted at this moment.
 	 */
-	if (!(inode->i_state & I_FREEING)) {
+	if (icount_read(inode)) {
 		/*
 		 * If the inode is now fully clean, then it can be safely
 		 * removed from its writeback list (if any). Otherwise the
@@ -1957,7 +1958,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		 * kind writeout is handled by the freer.
 		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+		if ((inode->i_state & I_NEW) || !icount_read(inode)) {
 			redirty_tail_locked(inode, wb);
 			spin_unlock(&inode->i_lock);
 			continue;
@@ -2615,7 +2616,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 			if (inode_unhashed(inode))
 				goto out_unlock;
 		}
-		if (inode->i_state & I_FREEING)
+		if (!icount_read(inode))
 			goto out_unlock;
 
 		/*
@@ -2729,13 +2730,17 @@ static void wait_sb_inodes(struct super_block *sb)
 		spin_unlock_irq(&sb->s_inode_wblist_lock);
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode->i_state & I_NEW) {
+			spin_unlock(&inode->i_lock);
+			spin_lock_irq(&sb->s_inode_wblist_lock);
+			continue;
+		}
+
+		if (!inode_tryget(inode)) {
 			spin_unlock(&inode->i_lock);
-
 			spin_lock_irq(&sb->s_inode_wblist_lock);
 			continue;
 		}
-		__iget(inode);
 
 		/*
 		 * We could have potentially ended up on the cached LRU list, so
@@ -2886,7 +2891,7 @@ EXPORT_SYMBOL(sync_inodes_sb);
  * This function commits an inode to disk immediately if it is dirty. This is
  * primarily needed by knfsd.
  *
- * The caller must either have a ref on the inode or must have set I_WILL_FREE.
+ * The caller must either have a ref on the inode or the inode must have a zero refcount.
  */
 int write_inode_now(struct inode *inode, int sync)
 {
-- 
2.49.0


