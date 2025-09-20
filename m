Return-Path: <linux-ext4+bounces-10309-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55BDB8BD3D
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3DCA081BA
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECF41FC104;
	Sat, 20 Sep 2025 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKhK2MM/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1C175D53
	for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758334501; cv=none; b=oXMJAtBGE4tc0MFiTA2bO7uqp8XLRNVKhmfkBpqSA0qm7APZEKkAU51RBO8gTIKSbVmQvybtsVISU3jy7nYq9cCfS0zPpIH3t5yFl8uGrpRgTUfZ4G00uhDNq49jKKcxW8H05pgdapdUbl/UQ+B0W+NEcZnCZ1tjOFfWp+PkGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758334501; c=relaxed/simple;
	bh=ykMmZX/GsJ/6DyXx3grIBwo6rpshmg1Ox7MNKxJafK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BPW3Kg7kYSwW/v+szkWT17uorcUF5zg4IyuVDRM58iGUNWT9EDfQBlucQxQXfRG1JBYTzt8pJ/5OmIanRtQyHFp16Uj+h6Th5Fj0PPd7kC1xu1YFU30o0bzc0X9+Zb68X7T2aHT5ekhVON2YjpNiTI2RAB44kykUJkhmnmEom1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKhK2MM/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4694ac46ae0so10760195e9.0
        for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 19:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758334498; x=1758939298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csYrUvAzDCYJqYNrdN4YvyCsNUDoKkP+xrNFQhD1gA0=;
        b=nKhK2MM/te9RpcZd90uSLku3lyHOP4sYp+BTAgfyc8mqloycSC4d/0mWsRK92/g3R0
         YUKtCAyEf9cUdUm+0d+EvfMXhUCPzHDySZbeiDBCJncglvz3X2cl+idjeBUgFUxlVndJ
         OakYWUKIsqDZ+DFALWEYuPI3aVPlwhviQBtfyNumsUW4XBZEJ/wW+eO4KvjxNTql15ns
         v0XaTUC5rika7qYyajO8MLvgilcqHqkehQsHG1TVEuOaQ3DUJzSTY+tEeulQzQFjf9GQ
         OjRdVnB2K7buBIDnSPxgkXWdmaeiA1mXbIVC+Cv6rxgIyDNhnHw8HRlLYQdc/0rRopVM
         fIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758334498; x=1758939298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csYrUvAzDCYJqYNrdN4YvyCsNUDoKkP+xrNFQhD1gA0=;
        b=DECD6hoLxDqIM8VmwxxS5b+Os7GE0BgRBSBFeBGSkhdX7jB5UsYHTLUE6dTR2xEF8m
         V/eh5gihjVckPAXoI3NYlQrfucs+K1RYznxtceESfWZETSH5vvKdpKwaKXHP2+7kQflr
         3RGRgJMBpDuW7n6tSyCkkzTS4/WoVZULE1TDSGHZA0YgLfetNCAnnlwCYrTHBcjrm0OG
         ZiobhA7tQruSDfCQ48HbMDU2ybI+NSq3PD4XSGxQRAiiIIZpudcSmKgq78W1qHwAmh9m
         f/c6n5tq89THC+kiUkPypVdOsEIRC5emhZ3XZKwVWJ7XXsGE4ZT0CNT9L1n1VRaqsf2f
         NCkw==
X-Gm-Message-State: AOJu0YzkLGqkWfBgTSEWLeYf4of4yxqAWdgXxLUfw/kZs8hOWQ5M3VN0
	q/IEkE6v5rdBh8Z2ecnm+jzHTGHY6zF1HcSom/FSoGiWagT/crcSCRZT
X-Gm-Gg: ASbGncvtQp9u8CwG+06WA2MG622VXW8/sWKnD7lidv6EdFgi6bvcgCkY8MDU7QqXJRL
	Al+w2EfDu+HMIt292drOHb8kaagtPYn4kMswHbb8nw7Cc1iRdRvyd4ePClIKwgOgmmXqtBO0Fwi
	feignWxpM7lJpECQ5wsHf1zRCNukyFEfnNaDnfcuTzixvMKtfOsiMbkEEgr/HuEAs3XYj1dG+09
	6zEGsLvj1Cdqim1WgpQGiibas1cEx3QJ4x58l0o+aCOJISL0uUpKY2lKIch/fn23az1ufin/R2e
	ec42S2KFoM0amaAxbXDghW36B2cgIIVtxk4QYtFqITFtphpJQq9H8IKZ+l6KRTrRzlVWitve8a0
	ASs1kCwIr8Y5GFEhpNPtmkyqhDh7DEzbfLDh7
X-Google-Smtp-Source: AGHT+IGjna9G8rbLI8f1p8ozs2UnOEWWsjZm+JN+lbA/9leR9ezES3BNOvOHDMHcEI46/rv3my60pw==
X-Received: by 2002:a05:600c:6288:b0:45f:2843:e76b with SMTP id 5b1f17b1804b1-467ec36a36cmr45656425e9.2.1758334497625;
        Fri, 19 Sep 2025 19:14:57 -0700 (PDT)
Received: from eray-kasa.local ([88.233.220.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e754140sm144975065e9.21.2025.09.19.19.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 19:14:57 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [PATCH v2] Fix: ext4: guard against EA inode refcount underflow in xattr update
Date: Sat, 20 Sep 2025 05:13:43 +0300
Message-Id: <20250920021342.45575-1-eraykrdg1@gmail.com>
In-Reply-To: <20250918175545.48297-1-eraykrdg1@gmail.com>
References: <20250918175545.48297-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller found a path where ext4_xattr_inode_update_ref() reads an EA
inode refcount that is already <= 0 and then applies ref_change (often
-1). That lets the refcount underflow and we proceed with a bogus value,
triggering errors like:

  EXT4-fs error: EA inode <n> ref underflow: ref_count=-1 ref_change=-1
  EXT4-fs warning: ea_inode dec ref err=-117

Make the invariant explicit: if the current refcount is non-positive,
treat this as on-disk corruption, emit ext4_error_inode(), and fail the
operation with -EFSCORRUPTED instead of updating the refcount. Delete the
WARN_ONCE() as negative refcounts are now impossible; keep error reporting
in ext4_error_inode().

This prevents the underflow and the follow-on orphan/cleanup churn.

Reported-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com
Fixes: https://syzbot.org/bug?extid=0be4f339a8218d2a5bb1
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
v2:
 - Move underflow guard before the update
 - Add overflow guard for the opposite case
 - Use u64 type instead s64, since ext4_xattr_inode_update_ref() returns u64 and ext4_xattr_inode_set_ref() expects u64.

---
 fs/ext4/xattr.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..a510693e04ac 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1019,7 +1019,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 				       int ref_change)
 {
 	struct ext4_iloc iloc;
-	s64 ref_count;
+	u64 ref_count;
 	int ret;
 
 	inode_lock_nested(ea_inode, I_MUTEX_XATTR);
@@ -1029,13 +1029,17 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 		goto out;
 
 	ref_count = ext4_xattr_inode_get_ref(ea_inode);
+	if ((ref_count == 0 && ref_change < 0) || (ref_count == U64_MAX && ref_change > 0)) {
+		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
+			"EA inode %lu ref wraparound: ref_count=%lld ref_change=%d",
+			ea_inode->i_ino, ref_count, ref_change);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	ref_count += ref_change;
 	ext4_xattr_inode_set_ref(ea_inode, ref_count);
 
 	if (ref_change > 0) {
-		WARN_ONCE(ref_count <= 0, "EA inode %lu ref_count=%lld",
-			  ea_inode->i_ino, ref_count);
-
 		if (ref_count == 1) {
 			WARN_ONCE(ea_inode->i_nlink, "EA inode %lu i_nlink=%u",
 				  ea_inode->i_ino, ea_inode->i_nlink);
@@ -1044,9 +1048,6 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 			ext4_orphan_del(handle, ea_inode);
 		}
 	} else {
-		WARN_ONCE(ref_count < 0, "EA inode %lu ref_count=%lld",
-			  ea_inode->i_ino, ref_count);
-
 		if (ref_count == 0) {
 			WARN_ONCE(ea_inode->i_nlink != 1,
 				  "EA inode %lu i_nlink=%u",
-- 
2.34.1


