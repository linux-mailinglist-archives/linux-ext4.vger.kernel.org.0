Return-Path: <linux-ext4+bounces-6045-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC03A0AA67
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Jan 2025 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695053A72BF
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Jan 2025 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BB81BBBD7;
	Sun, 12 Jan 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiSvvtP+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3422F56;
	Sun, 12 Jan 2025 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736695359; cv=none; b=Kk4CyfZAUppyK5AesQIUBg6nOg1azVGm0aFfCpXbcXP9pMo97ciD3JKrirqK/cXZQfJnTN2YXWspLTkgoTZYZN17QgdFtMt7MRM9wrqHw/Lu68Ulfqlb06GDCKBdjfbCWdjicbZrui007b5nVOLa2w7TMlNy5lWtTzcRUY833Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736695359; c=relaxed/simple;
	bh=2dW5q24W7TooPZd6yq5Efwjqv7J31keA3ztLRgCuz/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tzlFw4dpJ3MHEY/upvBHddrzpaVJXcORH60G1TmxsqEcAjcnR4QFcZVb5oarSeVOp96jL0P1VolyLAYJ0SpU6koRnlt4FNDOratuC/246zP9fqb1xLYEY1VHIzdo7WEHhV1AkQ7bUTqGO3+KKdbOUqVU2Ba+197muuMs9jVwndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiSvvtP+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21669fd5c7cso60329935ad.3;
        Sun, 12 Jan 2025 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736695357; x=1737300157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=445wBSZuG83p0w1DWBwIqxRgcg600gxv2iYJqDxp5Ew=;
        b=kiSvvtP+B8iOk4Iw83v+l5tIiBFnpusmMMlJydxS8SqYCLBtY5/vCgZRzBHW5xfKyz
         3JQNwoBLtoCQKxw2z0sO8FIjWqp4oIz8z0HAQtIOnigvD4hSShqRj4JVkCuns3h/uZ+Q
         7sJFppX3QSWZvWDEbl3nDGebbPNAI2aYc/4L2UI3Jg8NKy+aJMhYmkdX0wwBw6EQ3d/k
         DihQ3CuG0S1XECRZFJfTpWpI2obIjB/YWnz3F3YBxq2vLro88f2RO91ak7+1ZGOoRbkQ
         Z8ygDJowjZzkDhyaknT3eSOqs74M8IbF4l/KItL04qx9XrXpn3r74xL+SU7AjXJnA0is
         +ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736695357; x=1737300157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=445wBSZuG83p0w1DWBwIqxRgcg600gxv2iYJqDxp5Ew=;
        b=GCqAie7TeE+mF9Pv70hU3dolMgOJnjrjAI8KiXW7iTnMhBfID2UiUEWOdRgpRBhv2U
         8syXQWYYf8J7OKqJO94TBp/f+nUghUc8wxLyjRCfAQ1hlQv4VUnOape53+1GxiouOk5+
         0YNf2IIT7lmZDHEZsg2/3JCy13gv9zYdvBiKMONgCFc58AgO67rhgjZrnPE4wrAT5ahv
         1ZN4WTp8stg/H2zeyJV6ptSaERx9eKx/EtV9QbMbWueCjo340dpU2QaJrpEmSGKHHNt8
         09KbgZGlXDiRb2DtunmPjIgcUj/bHBmVIY5nqd3BseuHM7AWhkCVvC/VHojXO1dWEs65
         dOLw==
X-Forwarded-Encrypted: i=1; AJvYcCWnT3Uj0uNxWcstzq9wjrYsjad4HDU2PmD75VljNmxsBro+gAyQEdE6jJ8sSuGRRMDPl8YR+AVcieQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2hg9PCcJFUCW1CItzCTaHnQLMGbJAi2CpYfDltqIPhmniazLH
	IcH7R6r+puRWf8IDVp4e57pi6q7dIoK3Sg11nwe2Zp/iEZ4T+1l3pLmMYufm
X-Gm-Gg: ASbGncsmtxLULZScJ1W5a7tTqS2GTqCV+o5fb5cde52eXHCIMldHT92RG/pjTHbqcLx
	/+O9FHEdlmuGtw3+rIpYFeDCZr43W7UbdgA3lFcycM2l2zvCs8YxtGRP9lJKc6nSmBEM5GD2OMY
	f3M3W+Epv0Y5RN34yhItOTISlOr6ExEEKGvaV/8n57KsTh/1c8g2/RqFyupvQRYp2u3Bqc3HsSY
	G7XqcPYP4WnByO4l/oerlIudSmIME1w4LSt5ITMwZiRkI+/A+P+U2AS9iUw
X-Google-Smtp-Source: AGHT+IFaY9RwP2VIpVjJKDK0iS5qDQj8NxgTtOyIkMG7uxV54pcBVZEcpI/Mo9qaMx9XUHU1eIViOQ==
X-Received: by 2002:a17:90b:534b:b0:2ee:9d57:243 with SMTP id 98e67ed59e1d1-2f548e9a473mr23446631a91.1.1736695357311;
        Sun, 12 Jan 2025 07:22:37 -0800 (PST)
Received: from citest-1.. ([49.205.38.219])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad279sm8564608a91.25.2025.01.12.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 07:22:36 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
Date: Sun, 12 Jan 2025 15:21:51 +0000
Message-Id: <f49a72d9ee4cfb621c7f3516dc388b4c80457115.1736695253.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug Description:

_test_mount function is failing with the following error:
./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
check: failed to mount /dev/loop0 on /mnt1/test

when the second section in local.config file is xfs and the first section
is non-xfs.

It can be easily reproduced with the following local.config file

[s2]
export FSTYP=ext4
export TEST_DEV=/dev/loop0
export TEST_DIR=/mnt1/test
export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=/mnt1/scratch

[s1]
export FSTYP=xfs
export TEST_DEV=/dev/loop0
export TEST_DIR=/mnt1/test
export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=/mnt1/scratch

./check selftest/001

Root cause:
When _test_mount() is executed for the second section, the FSTYPE has
already changed but the new fs specific common/$FSTYP has not yet
been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
the test run fails.

Fix:
call _source_specific_fs $FSTYP at the correct call site of  _test_mount()

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 check | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check b/check
index 607d2456..8cdbb68f 100755
--- a/check
+++ b/check
@@ -776,6 +776,7 @@ function run_section()
 	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
 		echo "RECREATING    -- $FSTYP on $TEST_DEV"
 		_test_unmount 2> /dev/null
+		[[ "$OLD_FSTYP" != "$FSTYP" ]] && _source_specific_fs $FSTYP
 		if ! _test_mkfs >$tmp.err 2>&1
 		then
 			echo "our local _test_mkfs routine ..."
-- 
2.34.1


