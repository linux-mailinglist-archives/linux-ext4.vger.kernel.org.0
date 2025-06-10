Return-Path: <linux-ext4+bounces-8342-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D04AD3173
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81634171D2D
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C928A722;
	Tue, 10 Jun 2025 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkbQI51S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D091A8401;
	Tue, 10 Jun 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546768; cv=none; b=ki5YwdmzHvp5yVTSRYkbTh+lRV0nczzyqYqdYeTc8cXz38RF7Rud1KUkxh9wGVwnsIBkmcF2cbfLiqwoei/v4bPdCQs4mFl1oFfCcPGTYe9U1DIbqHClUkVsEjfDuyIRiQyWUt4O7Xn8nFkkeanBFEqd1QCM7EvHONmdW16ywmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546768; c=relaxed/simple;
	bh=OR/imTMEP6wki17zJDm3lVoxKLLBt0KHX1yafOzssZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAdiE3GUIF19+KriI/lyAqpIgX5PN+mr2Z07bijiq6fhO9O2ivxvTKrPSmcjm/F5gmVzNT2CvUgglBlfrAqrQHgtT+mhYyryloJZwMfQdLaLMBJw7Ewgpsu7D0vclxr2Z+lMjMSNrNuAeGaIEPEquRAZ0ypVIi1SnbfNU9ADCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkbQI51S; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso6155458b3a.2;
        Tue, 10 Jun 2025 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749546766; x=1750151566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4JKKVn0UseeRyMqFuDxbVuEyJNqH2YzoGutyU6v/+0=;
        b=GkbQI51STz2hEhKNGeHVlQ+TiuinDqiYIU+4LbZ1WsM4crJO/ZUOAmnQ9Hm0h1wz1a
         G3YTCc1utAfCh0E97g5KO5i+/7zXByYY1xKMOWUV9WvJQKVXf7f3XnM4ladoj6nz5Wk/
         n6XUD9COIsF5JCMEPtxb5q2ZxWaUfp3A4LFDVtjHmQERlXOYP8r+LBPql/+nQdvyF9A2
         0enb7TiuHsvR92iVVkg/fI40XYBgIDswB7/Qbid8KSDSAxQdxiewA95gWl9SK2JpLbcx
         BcCJ2x1aK7JOeJos5e0MN1NRW9hyF3SZqUgSA9xzYacO4XAC1wdV+WfYlf0VYOd7HS/A
         ICSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749546766; x=1750151566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4JKKVn0UseeRyMqFuDxbVuEyJNqH2YzoGutyU6v/+0=;
        b=cIAvSp8mvL7LEkEJqixgfgOcCoYUQtfmIJqWc7G+p2/n3BFtEHIM2k4Avvp+eS7XHj
         b+8KgpUXpNdY39BNr7eTSYQRErwMAHcoVZpiiKEqD03/ehmVsv9qralgVfRdQ0e9UR7/
         BJ0BMfSawjP6T5rHhmKNOn36maAMl6j1ezP57HzN9gx80rf33iJKNnUxqWyx6kumB55c
         NyDdLaG9lvwj/Czk1Mb0i7KUsEm1RDgLVmkLPMhTHpI/epfzRmX81JzUrVT/7JplRlfs
         DHDQY/HdJYf1Dt+F099SngA3oPUUUwqlDGZjNBsAafdQImSE5Re2Bn8UyIBZ3pY5jdky
         ON5A==
X-Forwarded-Encrypted: i=1; AJvYcCWnzB+KcVXkL4K6MaAKpma+CuWgPDQHug/KZN/xfxLAJ/tVtFzIN7mxyZ50r6/nxnv7goaqjLYpgmYThQ==@vger.kernel.org, AJvYcCXzRHsAcywpSGLZUtNFyuGvRCeSzjhmTx+xKYAHpbxIWxT/3pzLLLtjQDD727YflsKvZeyj2r/PZzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9wBtM1P2bUck/HBEPdwzB6Sr09tlminWaQMZjeHsqAtpZXEB
	YYtwssIXKIyy+DFQdcVIflXq+SoA+iwyp1guhlEwsKDM1hWNt5/kOYxp
X-Gm-Gg: ASbGncupDl3ERwYzhd+sO20jroxlJi/D2KBPHSQdH+H6RmTD9GlKWBk2PsnddLXIhu2
	tdaScxEhFIYC1zLxVzWETAED65fBZaBMvA01kTnLU9rwJKjMY6Qg+Mhm7ESZ7ajD9g/7IRwz7UZ
	Uk7Rzk2/vUVEwvpfe41pEJV89Wk9fMdhp7C/Lx+Tkh4THT3nzPmzlqV9sDnx0HRW4a+fPvblphs
	EGP7m2mynpR4dNW+MEh9/1ieFk2fyOMIltvjXW2EVzy5EaBBgP62Xnm0ttnNNbA1GdGRxttYoos
	v+UcDCrzErKWdbk1dQ2iQUgPMlTh5MnqqWO7AK4uaCATfwpxR/PDHZO5srSM3A==
X-Google-Smtp-Source: AGHT+IGl9UAZ4ea/hY5sYQpehfVFdynOV2tKfnv3vX/urwSJK5OM4lRhwLTk70aoj+nzOiUw1n7deA==
X-Received: by 2002:a05:6a00:4fd5:b0:746:227c:a808 with SMTP id d2e1a72fcca58-748618d84a5mr2664429b3a.24.1749546761337;
        Tue, 10 Jun 2025 02:12:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0c082csm7006778b3a.121.2025.06.10.02.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:12:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A16924209E8C; Tue, 10 Jun 2025 16:12:38 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: ext4: atomic_writes: Remove cross-reference labels
Date: Tue, 10 Jun 2025 16:11:59 +0700
Message-ID: <20250610091200.54075-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=bagasdotme@gmail.com; h=from:subject; bh=OR/imTMEP6wki17zJDm3lVoxKLLBt0KHX1yafOzssZs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnuX5XvWjkKFT7aM3kRf9WaOR1LBZW8n3zgrXW2fag+f 9v8e7O8OkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARB3dGhm2tfLyCQv37zqev 5cw4MtHWNSa9zF5r9QenJeHPv75t0mL4w9eRHDfPqHfzI4f7MuYW5XEnDXcppu1z/x++WLRy8gZ 7PgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports htmldocs warnings on ext4 atomic block writes docs:

Documentation/filesystems/ext4/atomic_writes.rst:5: WARNING: duplicate label atomic_writes, other instance in Documentation/filesystems/ext4/atomic_writes.rst
Documentation/filesystems/ext4/atomic_writes.rst:207: WARNING: duplicate label atomic_write_bdev_support, other instance in Documentation/filesystems/ext4/atomic_writes.rst

These warnings reference duplicated cross-reference labels to themselves in
the same doc, which are because atomic_writes.rst is transcluded in
overview.rst via include:: directive, thus the culprit docs get processed
twice.

Remove the labels to fix the warnings.

Fixes: 0bf1f51e34c4 ("ext4: Add atomic block write documentation")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/ext4/atomic_writes.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
index f65767df3620d5..f1a086aa026b1b 100644
--- a/Documentation/filesystems/ext4/atomic_writes.rst
+++ b/Documentation/filesystems/ext4/atomic_writes.rst
@@ -1,5 +1,4 @@
 .. SPDX-License-Identifier: GPL-2.0
-.. _atomic_writes:
 
 Atomic Block Writes
 -------------------------
@@ -154,7 +153,7 @@ Creating Filesystems with Atomic Write Support
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 First check the atomic write units supported by block device.
-See :ref:`atomic_write_bdev_support` for more details.
+See "Hardware Support" section below for more details.
 
 For single-fsblock atomic writes with a larger block size
 (on systems with block size < page size):
@@ -201,7 +200,6 @@ details:
 The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
 writes are supported.
 
-.. _atomic_write_bdev_support:
 
 Hardware Support
 ----------------

base-commit: d3f825032091fc14c7d5e34bcd54317ae4246903
-- 
An old man doll... just what I always wanted! - Clara


