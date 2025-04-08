Return-Path: <linux-ext4+bounces-7104-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFEAA7F43F
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 07:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D184417B266
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 05:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC2212B2D;
	Tue,  8 Apr 2025 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhIqrWE5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A32AE74;
	Tue,  8 Apr 2025 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090731; cv=none; b=g/g/6iC1Da2ATKw5VNXJbQ0CKUOVJXQiRwDL1AFgrrolpsn8dK9IYGT8khzyl5Lo7zQSLl/VTY/jU6KORSY6Fr8/ADUZyeVNTlNPmvtigAh04wvcLmnbX/T1HWzaG1UJtFG/f/xEtIjIKyXUAAksa4z5sj65l66ATHWw8ei5Bxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090731; c=relaxed/simple;
	bh=ymkrppgv0g7XnTr5ZVxaHyGC4RhQUGO3HjQ4uZBTMYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umOnFiPnxLgz1zWuuZxeq7DrD5nKpywJSYfUkGBuvZJB4t/Hdgftao8vM9s9HpGizMcqakxpJkia7nprUiojBqGXimmvWHqd6+z9CKU4Yd44HLhZDRF5WlnmcFLsgbJo+QwRd17vXFFQ70xn+629CuNZH1Wq4liGVR8hp/nmoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhIqrWE5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22435603572so48709455ad.1;
        Mon, 07 Apr 2025 22:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744090729; x=1744695529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BMaHmSFaDv5TGbwfxSPV7jt5G6Yz0nXxQMjDs9iO6c=;
        b=QhIqrWE5qZun+ikrB9ds/0y1x57lI/ZgHOBgdzJ8pDmYPMHAMUvDLtrrYrowxNoHy9
         i0as6SrZ3ShiOunohvdI8h7tm0IAq0PTkyB0gh2RbhhezmLnLbU0tU83wWpF29TYUfAW
         jiBryKQ9e0drJRJvwqZYc1CTPo/LNlFiH5ZdbL6aV5A7R/CUW7Ueb/aFnA3IJ3x0UnEV
         9t+9SlYhXAQSvpbBt/pKM3vDyvstQfWUekAmyL19fmCuM5vkxnCgmO5+jDo5/R8Dd+26
         oK3No2pVEn4LvUWolKbIBDPzhqw/e+J9f2TS0dVSZ6X2hjuELp54LBdkyF2VD17tIClz
         5XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090729; x=1744695529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BMaHmSFaDv5TGbwfxSPV7jt5G6Yz0nXxQMjDs9iO6c=;
        b=rfhB2ujMViydss0sRvQiw6IMbEnPYeLJnVwBS0frbwM+32Hg/O6QAR2PkA//6b7Nof
         lh1RhITsLHbQh+WQO4JQD/K7067BMtRbIlm6sNBQXdDHboMw2ldT5PbF01kxfJ2SooHn
         NakCglTKpHtNU1XrCIo5ftPlTzQ2ImJl7TQ1cP8WBAukX2jmH5dPywSeAau7OEEmujQr
         b5NTd5Hh141vDGaMrgBatx27x3ymT346zOmHlZKOwqBmrhK5ZVMRkkNoUqDO+mtCKpJg
         V84KL5Ahl7n3jxs0rXtWkzb3MRY0BuNlkk/z/emJg5FA3KuYPzkXT/s+ix1WummpyC8J
         oV7w==
X-Forwarded-Encrypted: i=1; AJvYcCVvHenW2+1WnbDbMEUHoG2ahu4tXAD6dDcU6/NrW5kny0+IwkCEyu9uBkEYTKNnseR3jgabW7ZJh0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrCzhAu5TwgNgYWTK5J4UM8NvBe5TgFBTqNjlKjVwHc8lYz+L
	mjhg48KOWd5xRNtXK1/fAVEjSdMEVHynPkBzi3qh5w+PB4qSwjo4yQPtwA==
X-Gm-Gg: ASbGncut2A/jFxtaqQWt2GMIFqfyiktStg4y63A8z/DTg8gzdKOTCEfCZyuBQ98so8R
	CUeSFKRpYlvzVz9G4r/XYMiKBQfcEde50//OW0pCO0egku+UzrHyQ7K3VQ5ZhUKm3NKKS59TXM+
	4SRWvUneCvPcdOBwWRFtnm0oQZ7Eof2I4a1Y/Fbr3TR4ZN27IkJ6Dxcb+KITVJTgJwHMENt0GyG
	16+w1yOgwwA2HXoBWmYaz2DOtRFtWFfMxQP5QXA6xcpiEVtJd8S/OTDNd9Jabba8eylYMIwpu9y
	LMux1rtHnZku+dwZW9tEGPVTKei4xp0GHZu3FoIr1dAI7nTv
X-Google-Smtp-Source: AGHT+IFEjZBShtTMaFMyHxX6WHf6or7Hx4i0eSG2I0AHMuSaLbi4AqcN4RoMIQdaN0H2LibBTzzI8A==
X-Received: by 2002:a17:902:db07:b0:223:4d7e:e523 with SMTP id d9443c01a7336-22a8a8e45a0mr184600575ad.50.1744090728677;
        Mon, 07 Apr 2025 22:38:48 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229786600b1sm91154875ad.109.2025.04.07.22.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 22:38:48 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v3 3/6] check: Remove redundant _test_mount in check
Date: Tue,  8 Apr 2025 05:37:19 +0000
Message-Id: <fa1bfd04d6b592f4d812a90039c643a02d7e1033.1744090313.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_rc already does a _test_mount. Hence removing the additional
_test_mount call when OLD_TEST_FS_MOUNT_OPTS != TEST_FS_MOUNT_OPTS.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 check | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/check b/check
index 32890470..3d621210 100755
--- a/check
+++ b/check
@@ -791,13 +791,9 @@ function run_section()
 		. common/rc
 		_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
+		# Unmount TEST_DEV to apply the updated mount options.
+		# It will be mounted again by init_rc(), called shortly after.
 		_test_unmount 2> /dev/null
-		if ! _test_mount
-		then
-			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
-			status=1
-			exit
-		fi
 	fi
 
 	init_rc
-- 
2.34.1


