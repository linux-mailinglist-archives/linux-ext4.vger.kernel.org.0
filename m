Return-Path: <linux-ext4+bounces-10244-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2100DB86557
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 19:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63343ACEBB
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B1284888;
	Thu, 18 Sep 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5aUatVN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2B283FD6
	for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218207; cv=none; b=qwJza+mguBypW48YFgzhQWQvNpRESAXkhQdGYYT6818Box3JpB767nza51+iCIw9UJ7VqbAFaCt95P68DNmOY19uAvoCE2rxeHRfbgRB0s4Lzh6ggfIWqwNSrUTm0jnYPJWClN/AAbOuofOB4DrzEqBAJ3AqGU7ZOBBjVHkOtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218207; c=relaxed/simple;
	bh=U8iHdE1DU42lSzhiPs8MNTQ6En/hzji2xtgp/3h/Nak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PyAkCIGoSkkMqd13WDEyS7LNnjqfR2un4HPgjghy3npv24CqzYWIoRXhUimixDK+z4OCPgLa6NJ/qgRsB1Eec86CSWTMwuKyju7bOtBHUxErqq8W2sTbA7NnTkdT65T0CFeE6YPU9mf2gp/RBFgRKFe1QpU183WaeCqFHqy+tW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5aUatVN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so11233015e9.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218204; x=1758823004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdvxtgG+W0bP4h9lSXAZ6eBdnNjpx+XRSyEW/uzBUNU=;
        b=Z5aUatVNbXaEGRGtBpVop6/YYuJH6Xv/hHN262iv+e/E8ktbggZ/1FDXDqNUaxhPnS
         +q6HY5x1KOxC0Uqt8j8LrZEQE4O292RRD0QsRjSsVQzhQxrusWMed8u/xN1oovzZQfCZ
         djA+DoVnjYZzZCr3O0kGrKPJ51cFtLT/n8X/mAApErXYPmI/hquVF1NtodKit+M2/3om
         HoDJpJWT3ZfQmJi2DcO87kQFEJwqiPoYMRQTnieQT3ZdfmG60x7AQPfC9f1W+GLfIHFx
         8PeRUbhH2GSeMyFyu2MSTMS0ypjDpzViRvny2TE9cb2/rEy0vHfO7Tf+3NqiNGf0ASjR
         S+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218204; x=1758823004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdvxtgG+W0bP4h9lSXAZ6eBdnNjpx+XRSyEW/uzBUNU=;
        b=BhZTr3S6YxC0ZbTawT1QG75pxWPe/TknKlJDouuEUveXA46tmcYUWaORIgIDMuY+Uz
         ZZYSKEl40x7G92FuM1QKfHOwBNW8P6Ng+oIcNnP5F7aAeZVLDw3iKDw/8Mr9zhgPBw0m
         tv5b8MhdTuXdAVyZ3GTObEh+ivmNfRItpB6Y2fndSEy4znTMU3Dtu7Y3C6G9NaDq+E85
         f8XznEW6w5ZoecCJK7F87UvXY7J/2njAygZgdKZWVYEhlHWU4g9xQ0FmNsjezal6KvY1
         1agDrq4iegWjPnx2GkZ1HUQn0ZqVGRRofW9qVQNRTa8FpnBw04QirA3Gk1OkkfFDbwKv
         9E5A==
X-Gm-Message-State: AOJu0Ywl2c3fKw11kqCsuay2fJAbdFDiYDKXr3kctomJJFrJxOMTNhGZ
	ac/Ykm+vSqoPQUWCL71AtUABjlngMmuRECWH3pUvMfMUynctO7hHt9Ph
X-Gm-Gg: ASbGnct/xm7644R+NhJ82WwFNMUSeNm9L3AQ4/wedV5nMTtAhBsYg0cOx7E31dr/+dN
	+FEFzQGYkgio0yzG/XNAQGDVlzZEwvuC8wIr1OKvdBrw0dVMuLjeWdxuGLABGDPVnaAuBoHhiu1
	9jNRnQZWgrUnIbjmj6J9UWVCU23grh0s54Gs/tWQVPGtF03I33Tt1cLiRBE/7j/ATjpzCeclaNP
	mQfFgc84+5QfVGk1HHMGPf2F8Bi8rFDX4F0uNAr9II5m0KsK/nwfwzZCD1BbexvsffM9MRlSU7i
	y1koNNrOSVuoEed8uZhLmZpo3ZAL2Lm/ZZzjiHYRVFU34vPunfHqPs+xYXHdTTNxhkUvp2PQ4/z
	wNZC7uKjCKoLf2bD6ur+gZgZAbAUZykUJcswHpbn2L4oy
X-Google-Smtp-Source: AGHT+IG+LlafBp1zHMJXHSQ3atVCRalq4bFvAwyFj+H8A+XPdD7ZEb4MccJq0WgSxA9gQ0ZMkg+RYQ==
X-Received: by 2002:a05:6000:1885:b0:3d1:c805:81e with SMTP id ffacd0b85a97d-3ee7c925550mr136862f8f.4.1758218203390;
        Thu, 18 Sep 2025 10:56:43 -0700 (PDT)
Received: from eray-kasa.local ([88.233.220.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7300sm4369752f8f.34.2025.09.18.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:56:43 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [PATCH] Fix: ext4: guard against EA inode refcount underflow in xattr update 
Date: Thu, 18 Sep 2025 20:55:46 +0300
Message-Id: <20250918175545.48297-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

syzkaller found a path where ext4_xattr_inode_update_ref() reads an EA
inode refcount that is already <= 0 and then applies ref_change (often
-1). That lets the refcount underflow and we proceed with a bogus value,
triggering errors like:

  EXT4-fs error: EA inode <n> ref underflow: ref_count=-1 ref_change=-1
  EXT4-fs warning: ea_inode dec ref err=-117

Make the invariant explicit: if the current refcount is non-positive,
treat this as on-disk corruption, emit EXT4_ERROR_INODE(), and fail the
operation with -EFSCORRUPTED instead of updating the refcount. Delete the
WARN_ONCE() as negative refcounts are now impossible; keep error reporting
in ext4_error_inode().

This prevents the underflow and the follow-on orphan/cleanup churn.

Fixes: https://syzbot.org/bug?extid=0be4f339a8218d2a5bb1
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/ext4/xattr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..a056f98579c3 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1030,6 +1030,13 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 
 	ref_count = ext4_xattr_inode_get_ref(ea_inode);
 	ref_count += ref_change;
+	if (ref_count < 0) {
+		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
+				"EA inode %lu ref underflow: ref_count=%lld ref_change=%d",
+				ea_inode->i_ino, ref_count, ref_change);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	ext4_xattr_inode_set_ref(ea_inode, ref_count);
 
 	if (ref_change > 0) {
@@ -1044,9 +1051,6 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
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


