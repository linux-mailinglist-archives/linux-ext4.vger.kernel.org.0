Return-Path: <linux-ext4+bounces-6418-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9AA3260A
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 13:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A781C1888FC9
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C1A20CCC2;
	Wed, 12 Feb 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd++t8Uu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E4F4FA;
	Wed, 12 Feb 2025 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364144; cv=none; b=KXzNTUafju/3dz97R+6D8kZ7mGNiFtyQOTSxZAb4g7JHFEr/8WfC6iv3dcH6b5UfXqS4Eupg1/EyG9Y67zB7CsYTZBgCo6kjy0Rwj6WdKHkmu4QrJ8/3TWE++a0NCqfQ6zeAmNQTlYSDY9F0jAP6xaoIuEghEXXug0ZLhm3v6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364144; c=relaxed/simple;
	bh=c4LVZDb8JVr8gzjdz7Z5FYQBjgYEm1csVXr4bPtjWAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EUQXJHpmoYdZRHHAtd0rkVFusj1iGizZotQ/cJmllwmvaC38CZigTH7c22qMtLViMLOWl8IWl49n5C2iJGxC0/hvJVtTJpEhL6iMjH6CvAYr+lpq4VmK7awB8SEiVxZEJCZDxyFgv2T7SpP+1K1y1Ar0696Z9OhOKR+ZBcUrTO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd++t8Uu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21fa56e1583so51136085ad.3;
        Wed, 12 Feb 2025 04:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739364142; x=1739968942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILSZ2TlqgYiobcvK/I9xuSSgxNUMr42iC2d9uSuSt7I=;
        b=Qd++t8UuYk1DT9SlqbY8qOYmtSTrvJ1Uloz7WKEuGqBoixX2ETIDahwAjIir76Woaf
         TRk2z7dribKBeo0dGEaJJSDJewhuVbpitJrQi7+oPkASDarvjbKsS2/eBvMQFie3CdoF
         64aOMlRk0O3qRqBG/IQLMhtLKLJNS1bwQ1/WoNJgUf6hmeQxqPjI4pJ/adyy7T+xkNnU
         Sq20Bfesu7Ej0TGDe2+9rrx4gfEevD4Q0G7tlhcz7w4MdeSsBxqdBi7zukd0Q6gfjRY/
         UY4XBIs2Zim0M1YV3HJaRDcpyrLQHvFWok0C7FLkienPaDQkn1AnuwJdnxMdFlrYBIjF
         wp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364142; x=1739968942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILSZ2TlqgYiobcvK/I9xuSSgxNUMr42iC2d9uSuSt7I=;
        b=wQZ6qUElP0rnKG9f6qAEdudNff7g8lJZHT6vF/YGVp7o123Ux45fnT8qSLGnwwim71
         J6O5v7F7QS8+v/QX568ZBsoqtBGJ02FeIYAXaR3XxaZS+AYngnRM0TMFNN6hXUSaNXyb
         U1Joy67k/ImOvdmMGkjLADqwAsdDA4PenqW+c1kZ9B37rVA9AJTc1REWCnRNtZz4C1HS
         xiEnhdPRoKVu9IAYDx+zgMm9q0oB1/J80ULHVINEpRbO6yRpCFfYLUXrdncsVt31umj4
         qo+CeZP4RVOzjv4+7qbUMXUKC+XivoITxC9RqcUaIgbhJdrRd3pD3PBw3At5cUjUGPf7
         p32Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQXKjKxuLntvufFNfA+3VvvG4PYCJIXN3cyIOXy6j2u5uU0AooBNXs8CwMQUxQhYPp5Pq0UEUdYQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaktHbq1T+Xtnf/4BwLMGZP5PQYbzQNGn7dbce+ix6TBBHoCie
	cvmg9IYq6n4vemNLZmPtSn71t3HJmqRbXRsan0E+Mkm41Tjgctet7oGEOg==
X-Gm-Gg: ASbGncupQ++u37E4zfICiOjVg8k/8jsnKFkwIVcH6f8udOsnrTPrM7jguDgvhnwIhyc
	FgyjRcXPumtXnkYTvFaznvTZIAObKa13Lr8BCeBnQ9K1rP15aBK4OFKWVL5XrXMqGIqQI20ik8/
	0Mdb0iotznBYLXJzu/39B9aDB859pa9vLAmdXNCDXYwuDOn1BrHK7BDnjdi2Y2e+UIjHfNec0zK
	HWqyD+qolPqjZw9GmW8Vg2hsilojaWRNZ4gDGYx5iyRdRK9HszW8t+cuOiQSfVD0cn2HPi6prgK
	5hENC8CoZUsD3XNt2SU=
X-Google-Smtp-Source: AGHT+IGM+SqfUDe3ENV6cVog26MQlu4xZNnjizXEHulc8DtoyP5PpHxCk/S5BgUAPlSSD+TthibbSg==
X-Received: by 2002:a05:6a21:6d97:b0:1ed:a4e2:89cf with SMTP id adf61e73a8af0-1ee5c7dbec0mr5369352637.27.1739364142385;
        Wed, 12 Feb 2025 04:42:22 -0800 (PST)
Received: from citest-1.. ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53d0c0c19sm6468484a12.57.2025.02.12.04.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:42:22 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v1 3/3] xfs: Add a testcase to check remount with noattr2 on a v5 xfs
Date: Wed, 12 Feb 2025 12:39:58 +0000
Message-Id: <de61a54dcf5f7240d971150cb51faf0038d3d835.1739363803.git.nirjhar.roy.lists@gmail.com>
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

This testcase reproduces the following bug:
Bug:
mount -o remount,noattr2 <device> <mount_point> succeeds
unexpectedly on a v5 xfs when CONFIG_XFS_SUPPORT_V4 is set.

Ideally the above mount command should always fail with a v5 xfs
filesystem irrespective of whether CONFIG_XFS_SUPPORT_V4 is set
or not.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/xfs/634     | 35 +++++++++++++++++++++++++++++++++++
 tests/xfs/634.out |  3 +++
 2 files changed, 38 insertions(+)
 create mode 100755 tests/xfs/634
 create mode 100644 tests/xfs/634.out

diff --git a/tests/xfs/634 b/tests/xfs/634
new file mode 100755
index 00000000..dc153047
--- /dev/null
+++ b/tests/xfs/634
@@ -0,0 +1,35 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>.  All Rights Reserved.
+#
+# FS QA Test 634
+#
+# This test checks that mounting and remounting a v5 xfs filesystem with
+# noattr2 fails. Currently, this test will pass with CONFIG_XFS_SUPPORT_V4=n but
+# with CONFIG_XFS_SUPPORT_V4=y, this will fail i.e, mount -o remount,noattr2
+# command succeeds incorrectly.
+#
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest auto quick mount
+_require_scratch
+# Import common functions.
+
+_fixed_by_kernel_commit xxxx \
+	""
+_require_scratch_xfs_v5
+_scratch_mkfs -m crc=1 > $seqres.full 2>&1 ||
+	_notrun "need an xfs v5 filesystem"
+_scratch_mount "-o noattr2" |& grep -iq "fail" && \
+	echo "mount failed successfully"
+_scratch_mount
+! _scratch_remount noattr2 >> $seqres.full 2>&1 && \
+	echo "remount failed successfully"
+_scratch_unmount
+
+# success, all done
+status=0
+exit
+status=0
+exit
diff --git a/tests/xfs/634.out b/tests/xfs/634.out
new file mode 100644
index 00000000..8a98c05c
--- /dev/null
+++ b/tests/xfs/634.out
@@ -0,0 +1,3 @@
+QA output created by 634
+mount failed successfully
+remount failed successfully
-- 
2.34.1


