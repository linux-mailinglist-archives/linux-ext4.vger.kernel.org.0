Return-Path: <linux-ext4+bounces-7160-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC84A81DD3
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 09:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6FD7A2B28
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 07:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4422B586;
	Wed,  9 Apr 2025 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhtz7oPR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496222D790;
	Wed,  9 Apr 2025 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182187; cv=none; b=FMFC7n8+INQp/rJ/moTx5fY4l/eTbbqG84/bQVZJ+xBRWqqVqnSDFMOe6bH0Hs0jNp8Vk1mZWeAb3NLwllqVZJ7TLzqXhUMA4JCT4w5ki0LJSkUI38z8UI/VBiB34opHh/WOA4TE2HD9YtW3wYcNN14u901DfX1magS/1Kt2wpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182187; c=relaxed/simple;
	bh=ymkrppgv0g7XnTr5ZVxaHyGC4RhQUGO3HjQ4uZBTMYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVpUX9YosG39eQvgOJCpCxnBBtQ9lETPd+crYpvtkX0W+qo4Trs+bfPzcNanvFMKQA1rsQBJ/sByit1/splwh35wveF+42WITDZzAPAsZBIZ7iFgtxRsejn+nENhOKG0lXYISHPwgmofDexErk9MLUxFqm++IoJNW38f8LXvyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhtz7oPR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224171d6826so91018205ad.3;
        Wed, 09 Apr 2025 00:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744182185; x=1744786985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BMaHmSFaDv5TGbwfxSPV7jt5G6Yz0nXxQMjDs9iO6c=;
        b=fhtz7oPR0mflcKVXaNCHbDIuLl8UFj/JJh3tFKneg3xUsRNUAhlRVHPDQBomxN7VV6
         FCjZfbUBVs5J4iMYQvG2yJl/HxCSKXVg3qH1k2XpXdz0+/jwLWpqr8UNVD7NBcMGy9DG
         Pl329Y8ec6VnJJxAvuAWsBEi34iXov0xZdUyl/GS7BmbAeGpuinUjoQCqWFaNj5IgT9p
         k8K6ok6RTvR/0K6uBRZ6MtxzofIzK1tU0RoxwfP39JPY+x2xoBwF/6C+rR22YI6DEVda
         YrXftSP28a9JTDuzWD7BT1TgkHKfhASpMz4iz1y/Etggonz1ZVkVeabXPHJ9gtSLIWg6
         9TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182185; x=1744786985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BMaHmSFaDv5TGbwfxSPV7jt5G6Yz0nXxQMjDs9iO6c=;
        b=tjMPgGittUj+sONuWQCWqWzpcz2o6DR2gnA5yvNHaHL4Zp+4x9cVznHCnFCWBCglx8
         MyKPaWjJiCFI9NhaK0AovF6c2BPXeknxolcGsMRydNgq5X0EmJZDvUGp8qN9+3LYpz3i
         wncPz3pgHqeK95HHscirRd9c8hESs5/TuU398hoTbmswwtkd+Ce1IuaKHg6XX37hTBfF
         MfhMpN0edvxZYFrvqnh2IRspckTpbJFRIypJw03D+s19oYxFKKHrZirbCCyTalj0JvrW
         J6xqPJ0Q78gBUUu8IDsWrOhX53inPQJTuHq4MonAnQGnIbyrDC6dEqoGLe6h4lRm2PaD
         d6jA==
X-Forwarded-Encrypted: i=1; AJvYcCVi+M92mBrnBzXuwhV3z0Zye6IWGYhFlY0qWEiV03M/+XPZMyfzOpBvUZvt91xGGdEU9nzVC14kVi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpn02YsuXY57pgpAwFX6+u03OdWPGnhFxb3GTXKPm6eYN7Zvlo
	6zgE4uBgqrOZSf7yww0JtI/uEInH845KU8+jQ3UW0+6QoIiCGAxooGDmbmRz
X-Gm-Gg: ASbGncspXSFsa5lUP0GN9jDMqS/nqdIhBLGmHfh9SJEzvTUHlP4wPDlwwifeaKWBSZz
	dk3n87InRvWpkZ6cK9sBPoYRQGq0QVOCu5EUcOyDbGDRbT5Hs3DLxjrfL6Q5eLmIEL6HWYAEOwh
	VSn8/icEptx6QymSVTNoxx7TGWQxizMMrOKpjocUW2pwH5puwHFYEx1uyFuIrD0SnKjNjte9Fki
	Os8PoQRbIJozJSrvJ6tzHN6OhcjPKYoFzATPKPDme3wblw4GM8NJr6Fs7aQoryY+L3ZPNyS7vcN
	RaLJ/Fu60LECwHF8KssL3eR2U4PNgcf0iRx9Sl258yo6T2WSwYLUHxg=
X-Google-Smtp-Source: AGHT+IEb447HdMKW+LNKFh/utqMiz13P/k5UmbqXcFhFLYYuNTLTsy2ih0nJdeYJfBusNw6MPIimDg==
X-Received: by 2002:a17:903:1a67:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-22ac3f9a916mr17345195ad.26.1744182184882;
        Wed, 09 Apr 2025 00:03:04 -0700 (PDT)
Received: from citest-1.. ([122.164.80.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c939a3sm4491985ad.117.2025.04.09.00.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:03:04 -0700 (PDT)
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
Subject: [PATCH v4 3/6] check: Remove redundant _test_mount in check
Date: Wed,  9 Apr 2025 07:00:49 +0000
Message-Id: <a9c490ad00b6a441ec991306b22c2fd9d6565de3.1744181682.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
References: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
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


