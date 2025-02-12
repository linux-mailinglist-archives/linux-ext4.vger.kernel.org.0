Return-Path: <linux-ext4+bounces-6416-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8E1A32605
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 13:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D78168F53
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEAF20DD5C;
	Wed, 12 Feb 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbprxR9Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420020D4EB;
	Wed, 12 Feb 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364082; cv=none; b=ns1sDsGvFEdrPPZzUQYFfDxxAT8LMBmRTbvb5izuATl7e9+4KRcOsBC49QLdjfCjjLC64FaSUI25EaMm8jdxid97KAmYkuAfUZKxGzT1sjYy/9a+lPs0vMAgsCTmqFh3N5i9QaIk3GEekN+pKXnygBiatmC9sJzTqfWwkW+14M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364082; c=relaxed/simple;
	bh=FVl4qpsBCkiQ7iHptGe/shLh+kBwZqvCeA+Pp1t994g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgpbz+HEXkbvxd4TuwGm24DFu2OEJZGLvNo43RbpQcRKuE70g91/HaFKKeGkH3sm37MBdgyP8jQvT6vOUDUpyOtM8l6yQ6VPnnW4jN6Or6wGS+BY2lXpGJwl+5PBV1GEENANPKEZXm1MAvv6RsH2Fo4DwdtlrSsdB1D+mQLdr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbprxR9Y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f3c119fe6so152794775ad.0;
        Wed, 12 Feb 2025 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739364080; x=1739968880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=635i2LjtKF98CAjAFkvRnIfK/JaseJw09BT2iYnqAmY=;
        b=dbprxR9YWFbXBRhAlWo1JcKhOSHnvJPl3K+7jyZs7g8Yaeiv5zfPHN2+feAFbPKse3
         TxWFVEz+bLWaMeMiHwo7fvCq3FkjOxW2fiHkvQYHobX3yRLelzq7NxwYbXTqMRZHdrUZ
         eaAbp8xH0vfUzffrsckNfiftulXtvuyYTohGVk+FiLUxd0yHtWlAVU3mopZH+UFTXtec
         EQigrNCMe8FALf2nymfINB+T4Zp7wyHzNTVxvISu0XBv3ryI6GsmatKTL1v881LGuIRT
         R3eB4OBW8FIVqJs3WzT+vD7MQ1GX0z0Y/TaGzNHFmEpsWbIEcSJ8k0NCmnq1L9mYVTyA
         /UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364080; x=1739968880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=635i2LjtKF98CAjAFkvRnIfK/JaseJw09BT2iYnqAmY=;
        b=jv7UOlOxYKk0LEHckUL1xXTqlZM4x8QMzwYAZtJA4lNQ7UCuRqlA8PY84CuaKEdAes
         25VtFFENXgG0GJTXLDMh0YQoXT1UyxFjznoD51l9jAqKEybKfvbUfU1WEfPf/4X+b/ta
         DjKXENM7SH1Hm8fKEjSF7z57eTHScZSADcwLaHbV65Mh4rxMKyi9nAi+XFIAz+RfDlv5
         3eLQsA2abEEPl4HelScrypCEoXX+fvQLNQa8Py6bA3Nc7AsRlczJmq+hVNxO/2aurh/L
         LQ3O0wQ1ObEbwSydrwIa8CFMlzrE/D2IjD2Egr56NLOEntCd3I8WxeIe2fGpLK6HYlv4
         LyBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlN3eQshlCqLveH7MclU+M0E0aNWkxUZY7ZWJ/vxKJO28iU+oXmVBj5tx9QXmek2mnDQF9287sCmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhx8JLB2CrwzBJhnw6/ELpJgR2pQD/leLO+Sz16ypRQczNaQC
	Bu8QzbTS+r4cvUfNm8go2WZpc6Vdj/VTwLwgkAEJ8eTRu70g3N07HCEmQw==
X-Gm-Gg: ASbGncuG0cEbcssQgImG5OFuQWU5pCEZx2tzT1Pu2+QB0URMAiN12rsU0hPtNzBDydp
	Uc6UFdcl45x+KaISJuTazFCLVpX+Tp4Cw9yPFh0WdKTd0Fno5Hmnoruj3PwzozM6oxjn+9j5v/5
	9YL3OGvbGaiY3tbgXO4+BphJzav+8VRmw1r9DCZ//tfQ5aGgC5jjPUGOYZ2zlp5zyL2TGnMbq6W
	+MEHaxJ7WnmT/67t5Hqy/Dd7+8mABwCkUHnMooE5Cv+SRdN7MVlMSf60vFYALd4wQGs2Fm20Q5Z
	YTCrLvAuv/Zy1WD/uY8=
X-Google-Smtp-Source: AGHT+IHjSJ8Sejv0NZYIjBtjTsad9dx9PaLh31VKugeJwIXn8Jaq60Lm663gUnEQ5eFcbBCaMf5XFA==
X-Received: by 2002:a05:6a00:a90:b0:732:2850:b184 with SMTP id d2e1a72fcca58-7322c3f6c9dmr4146333b3a.18.1739364079522;
        Wed, 12 Feb 2025 04:41:19 -0800 (PST)
Received: from citest-1.. ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53d0c0c19sm6468484a12.57.2025.02.12.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:41:19 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v1 1/3] xfs/539: Skip noattr2 remount option on v5 filesystems
Date: Wed, 12 Feb 2025 12:39:56 +0000
Message-Id: <8704e5bd46d9f8dc37cec2781104704fa7213aa3.1739363803.git.nirjhar.roy.lists@gmail.com>
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

This test is to verify that repeated warnings are not printed
for default options (attr2, noikeep) and warnings are
printed for non default options (noattr2, ikeep). Remount
with noattr2 fails on a v5 filesystem, so skip the mount option.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/xfs/539 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/539 b/tests/xfs/539
index b9bb7cc1..58eead67 100755
--- a/tests/xfs/539
+++ b/tests/xfs/539
@@ -42,7 +42,8 @@ echo "Silence is golden."
 
 # Skip old kernels that did not print the warning yet
 log_tag
-_scratch_mkfs > $seqres.full 2>&1
+is_v5=true
+_scratch_mkfs |& grep -q "crc=0" && is_v5=false >> $seqres.full 2>&1
 _scratch_mount -o attr2
 _scratch_unmount
 check_dmesg_for_since_tag "XFS: attr2 mount option is deprecated" || \
@@ -60,8 +61,13 @@ for VAR in {attr2,noikeep}; do
 		echo "Should not be able to find deprecation warning for $VAR"
 done
 for VAR in {noattr2,ikeep}; do
+	if [[ "$VAR" == "noattr2" ]] && $is_v5; then
+		echo "remount with noattr2 will fail in v5 filesystem. Skip" \
+			>> $seqres.full
+		continue
+	fi
 	log_tag
-	_scratch_remount $VAR
+    _scratch_remount $VAR >> $seqres.full 2>&1
 	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
 		echo "Could not find deprecation warning for $VAR"
 done
-- 
2.34.1


