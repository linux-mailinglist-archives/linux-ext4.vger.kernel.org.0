Return-Path: <linux-ext4+bounces-7044-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43DA79F00
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 11:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6F87A5B00
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962724336D;
	Thu,  3 Apr 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5Vp7EzH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C772459C2;
	Thu,  3 Apr 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670749; cv=none; b=gx6PvdappNmvrPABh/iLblJ5wi7VfcXk1tfalZrrP/CNUJPE4oSvALU3QsmIIqjcAD7cAeQbdyOKl/6KxITF84B2eGXadhqRZGlzA5Ip2NdJxQ2tX0dFj+veeulWQj1xNdCAzfTVGbIq6Rfb/GYplqkJqetyxHaYbMDOKlMFEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670749; c=relaxed/simple;
	bh=quOSX+dukN8bp5qyLFWL/jkZsrmomvQkWn1v4f4g+cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEteFuBRqPZrJLYg04mV4wEVAp7C9AJAH3VKgqlaahUcbSvaKk/KrB9ZUy05xxN/jbqlWALwn6lNK5s+mhSXGtttSIwqNA3cQgIhQcingEOCbdFv6wEvbdpEnbXlRVRt1QHSavl/aciD05SYH6/ygflxglfsKYtzorDEm88fUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5Vp7EzH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22409077c06so9949345ad.1;
        Thu, 03 Apr 2025 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743670746; x=1744275546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+oisU0LaLd3zUsHySudAGJLRXcJ0NxAaiTaaIJXLlI=;
        b=f5Vp7EzHEHZuVkwWi1K9PEk7KS789KPNwKolW5eq407O/94IbFmMwdYS0hzXixDZRe
         fUbtGP4bsCnO8Pv08i9HUbp8p9CObtH5QmvL3Sux0lPoX9PfuP3dZm8vcRgrPQtzlAcU
         8YRiNHWPzecPKKInw3KGkDBE1kwRe2nj+aMZTqAuHdYQz+LRNcj2ioeYYDH1g0MwFGFR
         ERkLf8h7WcQOWoEJuNQwVHqGTYoQPem4zI/fZSA/FbzRs3ZtBQKS9qW4+5YXBFH+0VpV
         RC0eyxud60ZVrVSYnv4lq+Bjqhmme2Y4QG/OnPHAx6qhoZrq185bs1OJuuZKT7XzZY41
         HlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670746; x=1744275546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+oisU0LaLd3zUsHySudAGJLRXcJ0NxAaiTaaIJXLlI=;
        b=DH2T40NsgXZx5eRFcLEhILVR7tVKbu1XlkDMSPKCffucelTCEachVocaC2xDDiUHJu
         huOlZ8UBhLSX++ZYWgnNa9KMdBDQWEuDP5VMYGx+3mQaOXVsuCsRDU5pI/uAptZY/6zr
         n2m/mvhQNKz0Uw0MMTCdS3l38+j/dznHs9db41hrBbuSbqVPp9dd0YOXR17sr2CZ+GGb
         fXksyzwxOBSdy8DWofO8D5j24nBcertq04vC6kjBYWYEts4sWS/k81OR7wrx8v3v4tOs
         Zb3/e9Qt65KJAXsE+u4NA+Sep0Uk1j2sjcP20enWCIMcJWh4SxMI3kaHxdcYLa7zVlpl
         ICZw==
X-Forwarded-Encrypted: i=1; AJvYcCVT4lRBJqMwl1YNPijOQG914xA1JaI9xVzDOVwslXquuJp79jhvMCoTkDKimvzevRESy8DQRM/Vrlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4T5vwL7PtgrCTWlzBRtyrOPYJ/id/sjq0ryBdadff0HKkPFk3
	QlsM+KHn4/2YqxDpbnfzNq+biBK0cpFaumowEFe+QKMZeDZJenLpe0l3hw==
X-Gm-Gg: ASbGnctgaXaapOxVSAFPWDGDejQMqMyclurcvnewbGaO8sLwpVuEYEwXJKn2K0kCPIP
	3fRjvHjwpxhn7ZGBANnToKLQcsfp4i4lKJNu0lJzpRFp+IukhKZbNMtcscSxBPosnmFBZkHbWB2
	ZogMT/+tS/Of24I5fwpvi69xNDMUtAFW7t73PNbcb9CSmfm5N37zEZGWyHe24YvskO0p0i6lkOr
	ylIRaGx4x2Xtv6yrc2nKLy9cs/dK9zGRO1nZ1IazdZoh/ZVVEqlGPHzcOBYlIObzGKTIiU6YO1q
	JMFv5VBei2DhjO3yoDmgoSqYp3Q5XHQsyCJa95Ab9CvrUUvsEv1AFEFD8zg=
X-Google-Smtp-Source: AGHT+IHOUVV2Xe5N2hUS8UaAQ41GettknD29OhlQoehrC9qAx5fHmhc6a5hq821xyo+/A2Cf6zYCKw==
X-Received: by 2002:a17:902:e805:b0:224:192a:9154 with SMTP id d9443c01a7336-2292f97a6aemr296988875ad.26.1743670746126;
        Thu, 03 Apr 2025 01:59:06 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c01cdsm9535715ad.99.2025.04.03.01.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:59:05 -0700 (PDT)
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
Subject: [PATCH v2 1/3] tests/selftest: Add a new pseudo flaky test.
Date: Thu,  3 Apr 2025 08:58:18 +0000
Message-Id: <176a3c6b995fde1390e152bc430689a39796dc76.1743670253.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
References: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test is to simulate the behavior of a flaky test. This will be required
when we will make some modifications to the pass/fail metric calculation of
the test infrastructure where we will need a test with non-zero pass
and non-zero failure rate.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/selftest/007     | 21 +++++++++++++++++++++
 tests/selftest/007.out |  2 ++
 2 files changed, 23 insertions(+)
 create mode 100755 tests/selftest/007
 create mode 100644 tests/selftest/007.out

diff --git a/tests/selftest/007 b/tests/selftest/007
new file mode 100755
index 00000000..f100ec5f
--- /dev/null
+++ b/tests/selftest/007
@@ -0,0 +1,21 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 IBM Corporation.  All Rights Reserved.
+# Author: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
+#
+# FS QA Test 007
+#
+# This test is to simulate the behavior of a flakey test.
+#
+
+. ./common/preamble
+_begin_fstest selftest
+
+if (($RANDOM % 2)); then
+    echo "Silence is golden"
+else
+    echo "Silence is flakey"
+fi
+
+status=0
+exit
diff --git a/tests/selftest/007.out b/tests/selftest/007.out
new file mode 100644
index 00000000..fd3590e6
--- /dev/null
+++ b/tests/selftest/007.out
@@ -0,0 +1,2 @@
+QA output created by 007
+Silence is golden
-- 
2.34.1


