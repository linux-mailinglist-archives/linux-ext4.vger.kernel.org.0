Return-Path: <linux-ext4+bounces-8874-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD3AFC049
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 04:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B208425D42
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 02:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022B20459A;
	Tue,  8 Jul 2025 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA1CZH4k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7B3594C;
	Tue,  8 Jul 2025 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940022; cv=none; b=Ebsfq2whyu6H0m08dpNLyLA5cPbKdLMtJDWe6Ag+UBY9cayoPOtRfObeTZc5Jj2LzjPqhM8CQ37ey1SN7UP1x0QDi2HTnBt/jMotEcHabYqMStejYZJcgcwYX4zWFETOKGJejsppGdR1hSQDQqOkFGJHrrd5QNF5zTu9ufEgLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940022; c=relaxed/simple;
	bh=91abYvKBk8rNjMKNpDDCVDQ8rk5QYUhAVLWwVW4Yryk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=can68wdqWK5n3gc0wZUsQrVoNLQjbYDzjUD0rg5QrTuf8cTR8jx2Exwyx8a9NkSEa0MW4kwJs3ofP6Io5t/plroSHsTLcyROuY3WJYM/1MLqHdE+BABDCwaZL803ylvt0VqfX2d9NCeexNVPViedWuTRTJBNNw4MVU6H0JSX/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RA1CZH4k; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747fba9f962so2967080b3a.0;
        Mon, 07 Jul 2025 19:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751940020; x=1752544820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEVd4c9rtKUA5heBsLe2UrTYnSXKGctkRZAQA/g8Z3I=;
        b=RA1CZH4kgAjrEwvqzkUrZOw8hy/qjg4Ci9yIC0LFWo1nTThRIWFcZzu/8o+eLN0Scs
         AB2aViVPWxaQha1NGf+D+UOs1RppcADct3+xQRZYx1WXAm5p8PbtQEFlipPnUWBfNOzS
         4B9TIPB+VAQnYE7TCbv1lBrkZTj7vtYN7m2faIMcHAkDzBLt3XCmnHLZ5alGMHB4oJRb
         qZxt2tk5yiVeRVLz9wG4rjkYVkYlKArlPxD0vgoPydZFHJb1v7bfltd0Cbiu2BeQe474
         BiDO+pNpurN/Lcmn4/4v4ovfQ8MJuLZfpx9omp29X/uKtbzDkZSB55TYbkf2WwomTVcM
         C9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751940020; x=1752544820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEVd4c9rtKUA5heBsLe2UrTYnSXKGctkRZAQA/g8Z3I=;
        b=cSHjaSZsDLNu4HbvCXxCF628v5Qag3wl0/HnW+iV+reqir+eOs00dndhlFIgBqjdD1
         tmqVdc04lYtdPLJF/TTrcElFPTFaz+HvHuD74LEzx9vMPFfbCCkzmxa8YxSIAMG2SXjQ
         cycPZpW0N4u4TakA3Z7Zc0ozmzMtoRlLl9F1iKcZjAk1ENg/hspzLEeij6Rq2HMnjeOA
         MU7x9xRnpba13d1pDv+PxsZztEyjVPlbNIyAhL59zHPW8/aOYY40HixET1TJFabsUKwD
         gbfp4MZbZya0a4QRmG8IY/JNY44K+FQlnjqnc5NcLMFFkFVHxu06VZguAEgc4zM7ootD
         Uj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCULJ7/FuoyRlrBXpU7Buh+hJUBaWS0ifrcyO/eE3CdRwYOeTMsQV0MzufeNDINBMikx1IbxaVXSfq7/SAlX@vger.kernel.org, AJvYcCWsPm0OiDxTHNX7HtVFiWc37wuDdAgY7s6O9fgVWWJnxvbVEmITjqVEPRmQGBYBZw5I8jgq6jYAKnhJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlwAfYPsPYoTQksU512GLyNhGZmQEDrUdnpxy9MfDVmInBN6n
	M+ZiAHhJuX5gLVvCH0xt7y2l2YsCu7SvHxMIGEvuYoQy2er9KWCv0tD1
X-Gm-Gg: ASbGncv1Rfm75sjtHMi1fheNej7kH84YjedKAjjE5p5ndz1zcJIpYAPVsjg4yuEiBMG
	EE+jVnby+iG58Dv6y/CUFXwv/cO/dWFh1ZPTjE9TP4T0iTpxf+/LYW7bwUHKG8OZiE8lPrfzD2W
	eQQuyAofgs0G48taBLyukTn4bErxChdhr0nVqgLY+RxFKQcywUO5jaLGep+2xc9a9jWuoHXAE1o
	I0h11ELWZhUoMLoKPhvI7zmsJHyyatKwiaRpuTboFPR3Y+r2+gMiuxN8ZDd97wXM6qCq5WkCVPl
	K7VpEiCjmi+joiXB6cK+RdYgrGtBqAEBkNQyGh0LLyP1dzIRS8Pn+TfER3uMyrEYiuGymCpVRVm
	krmcfKeSBV7mS5OuiZeE94c30eyw=
X-Google-Smtp-Source: AGHT+IFOjBA5PhOkJy9LEEIrkR4mzCKiTWeJaAPUPkpAaoNR1TA0Q4AS5fVgl8UdXlXeRkZHj6miSQ==
X-Received: by 2002:a05:6a00:4197:b0:746:2217:5863 with SMTP id d2e1a72fcca58-74d263830b1mr1265352b3a.6.1751940020044;
        Mon, 07 Jul 2025 19:00:20 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:6d05:8a3e:36e4:b104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d4f0esm10248049b3a.160.2025.07.07.19.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 19:00:19 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] ext4: Refactor breaking condition for xattr_find_entry()
Date: Tue,  8 Jul 2025 10:00:13 +0800
Message-ID: <20250708020013.175728-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the condition for breaking the loop within xattr_find_entry().
Elimate the usage of "<=" and take condition shortcut when "!cmp" is
true.

Originally, the condition was "(cmp <= 0 && (sorted || cmp == 0))", which
means after it knows "cmp <= 0" is true, it has to check the value of
"sorted" and "cmp". The checking of "cmp" here would be redundant since
it has already checked it.

Observing from the logic, when "cmp == 0" the branch is going to be true,
no need to check "cmp == 0" again, so we only need to take shortcut when
"cmp == 0", on the other hand, we'll check "sorted" when "cmp < 0".

The refactor can shrink the generated code size by 44 bytes. Numerous
instructions can be saved thus should also benefit execution efficiency
as well.

$ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-44 (-44)
Function                                     old     new   delta
xattr_find_entry                             300     256     -44
Total: Before=22989434, After=22989390, chg -0.00%

The test is done on kernel version 6.16 with x86_64 defconfig
and gcc 13.3.0.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 fs/ext4/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8d15acbacc20..1993622e3c74 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -338,7 +338,7 @@ xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
 			cmp = name_len - entry->e_name_len;
 		if (!cmp)
 			cmp = memcmp(name, entry->e_name, name_len);
-		if (cmp <= 0 && (sorted || cmp == 0))
+		if (!cmp || (cmp < 0 && sorted))
 			break;
 	}
 	*pentry = entry;
-- 
2.43.0


