Return-Path: <linux-ext4+bounces-8645-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB27AE901D
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 23:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1D34A408B
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF5213E94;
	Wed, 25 Jun 2025 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azj26jP9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1D20F098;
	Wed, 25 Jun 2025 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750886434; cv=none; b=ItZFLUXeeSs0CNGDe0V23A0bPx7LhJBijafXLMfmbzrNyjW056CHYRG2ekxwLPraAFpczCzMVJYC3NLWGro8opT5kI8NF2UANc5WTgpXx0Zx0Dw18ruSK0pA9bCpXgIe23VlzT7JZLYCvQA+Quj18Iph0xf2GQ4v+JI1b12V40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750886434; c=relaxed/simple;
	bh=lYEbVtIZ5apraP5Qn9iZLzQoxaPaWKjXLNkMLeJFy+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CI1MnXncY7IBls5cYkZoqlF1e8W/R+43RqHl6XsI02cT2Zsxru4BVu1qZgnBW95tJqNWqD8/gs625GULbAbOF1we/kyMJx7zJGTsb88HDD4fLk+tAIoKa+mYMFziCLr47sOPhRR/yC0OR7UqA+Wi4SgrkL4eAFjfqWvmBlEoFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azj26jP9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23649faf69fso3401565ad.0;
        Wed, 25 Jun 2025 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750886432; x=1751491232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iW6u+Sgg1vD8cAHzEXN3xoQ0okqnfAinfVypYDAO4WA=;
        b=azj26jP92fuelxyrjBcmsnNZM2f+Dg0qjH1jjDiQsg34JImjM3NRnFp98iwZyRIREk
         OmlfOCNnLWsoLMV1sVVHMtF49ObxVm+7bk+nJQhyfyE0mQ3QaDQ4HjpfYcmglHUVozTZ
         rEEGtus+b7zvwCLRHDVfStbZjwLQZjNM9p+88NR8m318rLErurrI3aBM0+kq6GaPIrna
         z1okVdOCQZsWN9D5qL8jb905YEmqT2+LZTvQ5I7joAN0yao/kE1lhn1x5z2qa4tZwT6y
         iZZbzEf8uSjrVHaBp0Q2cliYxlUt77tCVKdN7AIZM8N51tGBVIhwNa+SlBkjYbppS9SB
         maFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750886432; x=1751491232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iW6u+Sgg1vD8cAHzEXN3xoQ0okqnfAinfVypYDAO4WA=;
        b=LqK160Pf2jYDfLj4teXVriYAt3gtXE0VqcSRMXQjmlUoHvszuX9D7h4FH9/xZMSCLl
         bhdZ5HFxS38A9/LRSVimlkm2E5MS7fVogXWCh2rCeSseaxFWrB0Ai3cQSRg6Qi4jD0Fr
         ytH/pswrWdc/Tqwig6BbwBoTFmXErTFnBB96gZYXBtdT6u6Tf3vJAkJ5MIvg2R4rXfCc
         FueeX6lfsFpXgqrikeklZ/OWKDXBf+QPzLZENcH9mfyhc7Luflo7cXfOKG3TDELnc+Cw
         IDRvJ0iRJA16GpmmgnQq99pd8+Zrrmfu9p8d0BH2GVYN1Q4wETPwbHHQJtE377QBggAZ
         pYMA==
X-Gm-Message-State: AOJu0YzEYnWwuly3H/qjViIdRhTlLiCkdUhp4CSwvvQFuN1BW5lWLQiE
	UUoC+22a3AoP0IKuG4h6gVbkuzgGunFbYmSf6yaFitppCH3RZkqcw5+FfQ4xig==
X-Gm-Gg: ASbGnctMD9oVR73/SshA5oYcd271KcA0f340vWurfPxievCBoLssL795zvwcI/CZKTl
	BtTq1c3gXfxC4trhQqpCoeA/uSFCvfjEIWswfniatxoJ50XFYJhTQ6o5NujMrz9D3lFfzix9LFr
	+YAj6Tuc7CDcQWTKjRRm0aitzkRGS5xDGcaZdNpQmwlTRjVtbRBzHbnFEhUa/oaCHFHjnigR+yf
	/kwP8cCpLtiIuBNb6PXFlXHqV64QxCZrLdBIK/+51h+6pwHfar7WOTjhB4lX3ufYttyexyN64IH
	fwN2rXIxlbR9bfmlBL6vz7scPA9xF4Ga+B2SFqYgjEnel9oVLb5sU5K83bm4gtNohsH3fNh5/VG
	J7LMnU7k5+KYF
X-Google-Smtp-Source: AGHT+IFa3gFYAsnMShe/zZk3DUlD3AXAnrw/EtOC3S2vrUTtvf4XtwCpZ8TX/wG2lHHeeV3C+84bcQ==
X-Received: by 2002:a17:902:dacf:b0:234:8c52:1f9b with SMTP id d9443c01a7336-2382406e8abmr74882745ad.43.1750886431819;
        Wed, 25 Jun 2025 14:20:31 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:3d0c:1f2c:9cf:9054])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d869b89bsm141128035ad.188.2025.06.25.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 14:20:31 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v2] common/rc: add repair fsck flag -f for ext4
Date: Wed, 25 Jun 2025 14:20:22 -0700
Message-ID: <20250625212022.35111-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a descrepancy between the fsck flags for ext4 during
filesystem repair and filesystem checking which causes occasional test
failures. In particular, _check_generic_filesystems uses -f for force
checking, but _repair_scratch_fs does not. In some tests, such as
generic/441, we sometimes exit fsck repair early with the filesystem
being deemed "clean" but then _check_generic_filesystems finds issues
during the forced full check. Bringing these flags in sync fixes the
flakes.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---

v2: update to fix for ext2/3 as well

 common/rc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index daf62c92..ddced1b7 100644
--- a/common/rc
+++ b/common/rc
@@ -1496,19 +1496,24 @@ _repair_scratch_fs()
 	_check_scratch_fs
 	;;
     *)
 	local dev=$SCRATCH_DEV
 	local fstyp=$FSTYP
+	local fsopts=
 	if [ $FSTYP = "overlay" -a -n "$OVL_BASE_SCRATCH_DEV" ]; then
 		_repair_overlay_scratch_fs
 		# Fall through to repair base fs
 		dev=$OVL_BASE_SCRATCH_DEV
 		fstyp=$OVL_BASE_FSTYP
 		_unmount $OVL_BASE_SCRATCH_MNT
 	fi
+	if [ $FSTYP = "ext4" ] || [ $FSTYP = "ext3" ] || [ $FSTYP = "ext2" ]; then
+		fsopts="-f"
+	fi
+
 	# Let's hope fsck -y suffices...
-	fsck -t $fstyp -y $dev 2>&1
+	fsck -t $fstyp -y ${fsopts} $dev 2>&1
 	local res=$?
 	case $res in
 	$FSCK_OK|$FSCK_NONDESTRUCT|$FSCK_REBOOT)
 		res=0
 		;;
@@ -1548,12 +1553,16 @@ _repair_test_fs()
 	yes | $BTRFS_UTIL_PROG check --repair --force "$TEST_DEV" >> \
 								$tmp.repair 2>&1
 		res=$?
 		;;
 	*)
+		local fsopts=
+		if [ $FSTYP = "ext4" ] || [ $FSTYP = "ext3" ] || [ $FSTYP = "ext2" ]; then
+			fsopts="-f"
+		fi
 		# Let's hope fsck -y suffices...
-		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
+		fsck -t $FSTYP -y ${fsopts} $TEST_DEV >$tmp.repair 2>&1
 		res=$?
 		if test "$res" -lt 4 ; then
 			res=0
 		fi
 		;;
-- 
2.50.0.727.gbf7dc18ff4-goog


