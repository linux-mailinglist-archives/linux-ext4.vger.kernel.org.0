Return-Path: <linux-ext4+bounces-3537-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6C9421E4
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 22:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16951C23282
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7EF18E022;
	Tue, 30 Jul 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Gr8wkIca"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98018CBFA
	for <linux-ext4@vger.kernel.org>; Tue, 30 Jul 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373073; cv=none; b=PkWRq09PRG0npfcCQ2C3afIefylorT9Ap54GchzZzlev08ShAMcPpNapPxcM7AYQnhenbnpi+E/TlCnRmfIoD9DXDnhLNlVPF52/241KFnO4GX20S2j6d3wMNWN8KV8MVGgK1kBdGPB/ojcoN/Qrpe8nblvBdMRz4bMYeexdC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373073; c=relaxed/simple;
	bh=UZFioN48C+LMU6bnsXcw2rpATfhSP3Md7LINlbLSdyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kX01GMn9mzSROJGFGy1f+Ya3Jk/3niwO1lW82MDs7MAa/Wj2M/OQ3+0Q3yPwdUtI8ioayg9X4iaRm2OnR8le4x2jyW8UrJhmAmGln9YYs0CXXHBvrEfZw2f63phoIgU+1yu9FpldkNq5myShh+5CBbMSIglCBRymIL6IRHrlVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Gr8wkIca; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f025b94e07so66509711fa.0
        for <linux-ext4@vger.kernel.org>; Tue, 30 Jul 2024 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722373069; x=1722977869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPxJ/YjE+pYwHZd7W0h0eHbps73SI/HtbDFZ2gy9/OI=;
        b=Gr8wkIcaLpeJqscLsXsqh3LH3h8gfKnos6InjG9Lo2WXps2bOLRiAANZqmqoxGmd4l
         l6uIPWj5NkrpePQkk3bQQQGjWDS0yFEcFfbwQZy5vCaxt897Nc8b8u9M7ZQubHVpvz8s
         jwaF11Oa0NlproLgMcjaqk94XQDMpBt98K9P9Y+R2jEvxqogOEW5JrLeBkjf1kndYDA/
         h6WfhxLktE2m0mo7YqAFRc+2hyKpv0FhA72QwBC9/360eHckXFWg25Ntdwf45nCm6806
         w+oc7fc30FGwxIEv1YlsmHl1OhgUy5NMU0PwHEZOL0sYZ2u8EZz1GVdgQnLmLQAgV7EM
         +cjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722373069; x=1722977869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPxJ/YjE+pYwHZd7W0h0eHbps73SI/HtbDFZ2gy9/OI=;
        b=TY9/A9LiZtjvI7j+HH6YENh8r5W/PtuF2oMYM9opJ/+WKWwCl6Vqi1Zs0IrykX6eFh
         lcnbGpgVDzVFxVdUirY2d0Q67pFkpOUCSr71QSdmYyZEqZFybttgfQgX0hZqJ4UFT2pX
         9NkelLMnE07j6a+lC65ZFLktqHwMPCBDwmIDT9Uxmoq1urmjeOvgmZgiOmGak3PXdmPY
         eXsVrOLRLib0vhLjoCO7QpKDMQylAoWQ48SiVhYGYZM2LhvdoCuRgChNA/9OKWvnaDv/
         MSOC4HS2fP3ljrEOVJLNIFiIK8T5Xb3mPub7XCyq70DFlrY4viMy5j3wNuZ7CGpr7ros
         UR8g==
X-Gm-Message-State: AOJu0YzvsyykZ/V33UST98FVBewIqLW3lAbAEKyUt6MANECauOEc2Qx/
	s66PTB2cDQ+zA33jyPXf/cxA6GheGKPU4/dSqNmpbPdgw3VaVDUDKXSoYbmszr8=
X-Google-Smtp-Source: AGHT+IHzJtr5q5xSTOQZVFeHBzvGrYkdr2BxlIJK77NCkkzfZzn1C7QUQedTZgZbk/bUkOQzMVxrkA==
X-Received: by 2002:a2e:8007:0:b0:2ef:1ecc:cf5a with SMTP id 38308e7fff4ca-2f12edd6ccamr86539441fa.26.1722373068570;
        Tue, 30 Jul 2024 13:57:48 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6377e06fsm7801393a12.28.2024.07.30.13.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:57:48 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v3] ext4: Annotate struct ext4_xattr_inode_array with __counted_by()
Date: Tue, 30 Jul 2024 22:55:11 +0200
Message-ID: <20240730205509.323320-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Remove the now obsolete comment on the count field.

Refactor ext4_expand_inode_array() by assigning count before copying any
data using memcpy().

Use struct_size() instead of offsetof() and remove the local variable
count.

Increment count before adding a new inode to the inodes array.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. Silva
- Use struct_size() and struct_size_t() instead of offsetof()
- Link to v1: https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum@toblux.com/

Changes in v3:
- Use struct_size() instead of struct_size_t() as suggested by Kees Cook
- Remove the local variable count as suggested by Gustavo A. R. Silva
- Increment count before adding a new inode as suggested by Gustavo
- Link to v2: https://lore.kernel.org/linux-kernel/20240730172301.231867-4-thorsten.blum@toblux.com/
---
 fs/ext4/xattr.c | 24 +++++++++++-------------
 fs/ext4/xattr.h |  4 ++--
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..4e20ef7cc502 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2879,33 +2879,31 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
 	if (*ea_inode_array == NULL) {
 		/*
 		 * Start with 15 inodes, so it fits into a power-of-two size.
-		 * If *ea_inode_array is NULL, this is essentially offsetof()
 		 */
-		(*ea_inode_array) =
-			kmalloc(offsetof(struct ext4_xattr_inode_array,
-					 inodes[EIA_MASK]),
-				GFP_NOFS);
+		(*ea_inode_array) = kmalloc(
+			struct_size(*ea_inode_array, inodes, EIA_MASK),
+			GFP_NOFS);
 		if (*ea_inode_array == NULL)
 			return -ENOMEM;
 		(*ea_inode_array)->count = 0;
 	} else if (((*ea_inode_array)->count & EIA_MASK) == EIA_MASK) {
 		/* expand the array once all 15 + n * 16 slots are full */
 		struct ext4_xattr_inode_array *new_array = NULL;
-		int count = (*ea_inode_array)->count;
 
-		/* if new_array is NULL, this is essentially offsetof() */
 		new_array = kmalloc(
-				offsetof(struct ext4_xattr_inode_array,
-					 inodes[count + EIA_INCR]),
-				GFP_NOFS);
+			struct_size(*ea_inode_array, inodes,
+				    (*ea_inode_array)->count + EIA_INCR),
+			GFP_NOFS);
 		if (new_array == NULL)
 			return -ENOMEM;
-		memcpy(new_array, *ea_inode_array,
-		       offsetof(struct ext4_xattr_inode_array, inodes[count]));
+		new_array->count = (*ea_inode_array)->count;
+		memcpy(new_array, *ea_inode_array,
+		       struct_size(new_array, inodes, new_array->count));
 		kfree(*ea_inode_array);
 		*ea_inode_array = new_array;
 	}
-	(*ea_inode_array)->inodes[(*ea_inode_array)->count++] = inode;
+	(*ea_inode_array)->count++;
+	(*ea_inode_array)->inodes[(*ea_inode_array)->count - 1] = inode;
 	return 0;
 }
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index bd97c4aa8177..e14fb19dc912 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
 };
 
 struct ext4_xattr_inode_array {
-	unsigned int count;		/* # of used items in the array */
-	struct inode *inodes[];
+	unsigned int count;
+	struct inode *inodes[] __counted_by(count);
 };
 
 extern const struct xattr_handler ext4_xattr_user_handler;
-- 
2.45.2


