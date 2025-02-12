Return-Path: <linux-ext4+bounces-6417-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F1A32608
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 13:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBAD168F5F
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2210320CCC2;
	Wed, 12 Feb 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKHMv0zw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67080F4FA;
	Wed, 12 Feb 2025 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364116; cv=none; b=cJBteaOUCweD8yNiHFM1ypzshhDzEfyAQqPrIbcsiE+cr1zKIJDzDmlRkEQWwHDKxDzy3Z42o46ZkXd/od36hnuoYYI9R14w98jzr/NQ2m3ZfAiXfIMF2xb8kG0iABAj3so7HBo6Nr6xf5oFl8jGyoDsED6+t+GJQ1o8szpI6ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364116; c=relaxed/simple;
	bh=dmMyTcPvItDmcsV4jemz9/YRM8ubGmcT/laThGUZaGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0muInQrvQ2I6/8S3ITldkgKXyPfuY2KRj/ZvSgtEGMdBRvv0d0jPqat8GGBgXj1jZi6SbS0tB3cOfIAWRRVNGZS1nrCRDLaqZVYItdfzy3hxs6g7loXqee2SxllBC5xDxLkAibh8nLPdgQR+66FhMQvk/6/5vRuzIGPJ0YV9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKHMv0zw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f5660c2fdso99024165ad.2;
        Wed, 12 Feb 2025 04:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739364114; x=1739968914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dROWzQ4SbPmcVIZD9TSbMRy+qyrD3IEz7v6OotFBnJ4=;
        b=JKHMv0zwDHBR0/pYp0cA0GwASuw+d7HsfZ3TSq7jdw6x2yD1152h1hdXnxE5yiU8UY
         GEVBZYYCu0gyYDzDC2/59/MlhN/t6xBJqai9Aet6oWQVGFddCW4Zl32JN/Pae1kgIgDb
         BW70y/21eTcQhn4v34maqdhEuLBxeDcLzF3QiFsa5Ekx0xUebIusmj5ZUKzzd/EGT9HR
         YyC7ylGGoJ+Tt09RWvAUD3zLq/OQpgGLRkAuDbZTDLBI9D+jIoZ9kuY9ZwUsX4lplSE3
         /IgMBmwBuwzAUf+VE2XYPGhTrwE58oOWrJ8kPe0hb0JKspKsbc3+GnTeGEUT5t3x6IUH
         xfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364114; x=1739968914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dROWzQ4SbPmcVIZD9TSbMRy+qyrD3IEz7v6OotFBnJ4=;
        b=ej1WL8Qq6wnhNiAYBpSAKe4Z67nNaAJGQ1LeWq5fgvDCw6HPCJ+8exsslBAbcocy6u
         guGYW9bt3/mM6TJIXLwEYgAF1X5pxUHBBqXLpfsOyCu/jI0zXe4kQ+qRMXIjont0O9l4
         CZWV9ByP58qgfXbZBzOxDbtx3BsbIG/1qayhgEi7rijDly5q5plnFmfbgCqM+lm6WNFQ
         suig0s+vOtMfaYignj0yvD1WdOI7AmSpA23UpwbyansRaVibyS3az0Cz4z+oqVtQI3tM
         o74jngI2XnEwqovNsDAcO19abbR1HDXTS95sgpe5iTVV1B6g5whABHbDGK8Q6atrsOg3
         mDNA==
X-Forwarded-Encrypted: i=1; AJvYcCXTYn7Y3EqccVaCyK3/DEeWHAUDmsuNZ174xY1GxjDBC0Ltv+DDLfuvftVNIZ/ZYIoJtlA67YGsRn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywau6krVsgcZPYXalEFbp0LUUoMb/MDD+Zei+Vp/sB74ajC0dov
	i03Z4S7lx1Q9p2j0rRrK+/FY2GPYwRcOcnGM+nhO+kyiNzCTQOI56hqK/A==
X-Gm-Gg: ASbGncvzhXRbe6vZtIoaDv3VOKURZXR259UaYvqLYYPYGQwNTHgSHsh2O52mW9ivTpi
	k3GpDekJuZJOAtKzd/Nt5hNCFskJrCRowPZJm831iaZP74VkNZ+q5wW9T3ADWucAg+bQACLNBO9
	S4yAa/F0fAINWaNNSi9CQT/yX11WcpkIaYHkS7aWuGzoBY+B2FZ9Nl0wvSrhpWi/3DOBUv1GQ0l
	y2zgd8w/r8AllhSgHDvDyTJgvcS/CU7tUsUHdTc/4W0Po7iIiNUV5yerlXIxQPHMwDgV8vMvT1K
	eMc7SsYchx5sHZzOnm8=
X-Google-Smtp-Source: AGHT+IHDJcFSrfRQX/F5sM5+pwZD66U1m8HNykq/nH0asUrd8BlBh7en4tGxnJJDkFq5nrEFC1SK/Q==
X-Received: by 2002:a05:6a20:e613:b0:1e1:cd09:e08d with SMTP id adf61e73a8af0-1ee5c73983cmr5052739637.11.1739364114171;
        Wed, 12 Feb 2025 04:41:54 -0800 (PST)
Received: from citest-1.. ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53d0c0c19sm6468484a12.57.2025.02.12.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:41:53 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v1 2/3] common/xfs: Add a new helper function to check v5 XFS
Date: Wed, 12 Feb 2025 12:39:57 +0000
Message-Id: <61a7e3f25621548ec3ef795a3cd0724e32afb647.1739363803.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a new helper to function to check that we can
create a V5 XFS filesystem in the scratch device

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 common/xfs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/xfs b/common/xfs
index 0417a40a..cc0a62e4 100644
--- a/common/xfs
+++ b/common/xfs
@@ -468,6 +468,19 @@ _require_scratch_xfs_crc()
 	_scratch_unmount
 }
 
+# this test requires the xfs kernel support crc feature on scratch device
+#
+_require_scratch_xfs_v5()
+{
+	_require_scratch_xfs_crc
+	_scratch_mkfs_xfs -m crc=1 > $seqres.full 2>&1 ||
+		_notrun "v5 filesystem isn't supported by the kernel"
+	_try_scratch_mount >/dev/null 2>&1
+	ret="$?"
+	_scratch_unmount
+	[[ "$ret" != "0" ]] && _notrun "couldn't mount a V5 xfs filesystem"
+}
+
 # this test requires the finobt feature to be available in mkfs.xfs
 #
 _require_xfs_mkfs_finobt()
-- 
2.34.1


