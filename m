Return-Path: <linux-ext4+bounces-6029-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D0A08AF8
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 10:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD433A89D8
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 09:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFD6209691;
	Fri, 10 Jan 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDyU3h8g"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213B1ADFE4;
	Fri, 10 Jan 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500333; cv=none; b=nalTxnwipPzt6HN3tCS53uKXJaZN0BnAWtSbAPZ+Hupjg3KVkmcqU+EEjc6XrCmQx4jxb6LHSikVcUJxFuRz9MPjB1sTeRYAi3qTYwIERUmiquNMoanmVNypHkaLKoh17GQTjIllu/TYEKWW6su1LIDiUJoJOnB8qShJaO1XwUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500333; c=relaxed/simple;
	bh=SguCOjP6z/+FgHUYSN3G1shA7kbiBLimwKmytp5P90g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZHEjJPo3EEnew/fHWu/ukB+8ylj3BavhNYN0dUVEfwM1W2VDMJUlOPc9SmDvU/93yU20qSooMv3MOSxgT75jBPu1Wp2sqrdZyA70SqlyHCN6m+4lEy9L4kKn/QhwVqU6yU4IwHMcIdgEfvxGWaolyR4KUXSkrCj02R8MN6tfrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDyU3h8g; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163b0c09afso30816525ad.0;
        Fri, 10 Jan 2025 01:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736500331; x=1737105131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtH7dHpk2xqNXJcdg5awcc4LiW3ChxFkh539kBF/I5I=;
        b=GDyU3h8gcsJY+fnOM0uvy3KCf3B+YLOWvJQ/H74p3Cj2SgHhlLZVXKKjCT/PzrwArn
         YeUweuQnY49PBT6oQqxnBkuOS6i9e8AeyBRnyp/jcuFpmZlWswSalKQFLqeHkh3NBlUo
         d3TAgfce8drGvg1wa/2Nq3/198IUnZvMG5d0259EgBlQmrebsQIDpZVFIucsIgMJnoC3
         hkYQd6X7oOfSEmImzZ6FtTrMTS5hYh2KxEEPRSmVmS2UUUmq2+pCMv0v4Rn2N3BUoUXt
         N/R8Ci0BWKneiIDlFBbbs03Kbv1AMYi8qxzXz/6OHYUE6UgfsVNu3jYSFPLbf8VycOfR
         LQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500331; x=1737105131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtH7dHpk2xqNXJcdg5awcc4LiW3ChxFkh539kBF/I5I=;
        b=AVuugZhLQQeihGESbcEfScevnQXtiHT90DNg7e3l3K41BNnFYxi9sr5YKa3yzou7U2
         1aq2AiXaTQLwYYGLM1vYqofWt3gCZMDfmvOStIQCi6ka3lc4tQ8Euil7YXTgCguGo8KK
         iDQmlBXhXEf/Zj+DcyBEZLhk+Qs+f9WblMxFqyzeQDbaiLqBPWk3gCSNqf4B97DpW+mt
         qOedmachsnjObyZ5LR5gJdUYvJQQ5UxH+Otgv9KGLaR1snJ1ODCXkdGzWk4IBg/0m2UP
         nzJDzTc0IXNbvz2WiXYy3IUll/yDD0Kexiq1doTlUIJs2UK6/6NesujEPm22OrUzCGyJ
         qLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiG5iDJPWdvhuwiQ6fwttLWWoPazu4Ya2MLIIMvIrHXfuh5KfZNBQ2N3u603o1Ss1H/xnlpS3vuVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+1Uj+KGXJQ81kPVYBSRiVk28s8sUYCuIH7st2kAbIY3JpuZd
	kB36TAgGMu5lDhvDLMnNEf2dg3xmAIOsO6DXDkru8MWJvKwh59aYiJOJCApX
X-Gm-Gg: ASbGncs2NOX2SqtXro1h2npzgDTydikv+Fboaba88oj4Ko0vnwc3HjNJ63ja0Xu0s5q
	wLOitVuu6YjrtiDbkDkBnmwhLiAK1K9pHtyhA7xes7o4BK4q73eO8ZJ+N68JnJkQEMQAOmGxyt9
	wtomhCakXjmDKlRmdbhuTLc0qHtqZiqPk5dq+tvANtdvoTZ8C/E+Et/TDVoiDLRk66OWTeLw381
	7Nufx3zf7M/bZkxIuFrueXQrApursqB3p8xtmmuLa/DZwdbaudeQhbAIJGd
X-Google-Smtp-Source: AGHT+IFIrz3yln/sn6M4mR7oJa+B/nO6UiFxlTqaczM/WleL0UpwLrpkuywYRnyGnr91zqs+fdKwlA==
X-Received: by 2002:a17:902:ecc5:b0:215:7dbf:f3de with SMTP id d9443c01a7336-21a83f5e4e5mr149319395ad.28.1736500330913;
        Fri, 10 Jan 2025 01:12:10 -0800 (PST)
Received: from citest-1.. ([49.205.38.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219a94sm10166485ad.129.2025.01.10.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:12:10 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [RFC 1/5] tests/selftest: Add a new pseudo flaky test.
Date: Fri, 10 Jan 2025 09:10:25 +0000
Message-Id: <03ba6c154c9e2cf3d68131b3af2ca12b96663d25.1736496620.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
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


