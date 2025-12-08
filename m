Return-Path: <linux-ext4+bounces-12222-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6EACAC40A
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 08:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE963045A77
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBEF2206A7;
	Mon,  8 Dec 2025 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gGrSwklf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC218DB1F
	for <linux-ext4@vger.kernel.org>; Mon,  8 Dec 2025 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765177126; cv=none; b=hjGxuEhgOTbjmv5avXYPRn5/ym4pNU1Y0i1qiebne/dPdCG5jvPKnLkwwqELj9mvcpmg9kmdFhNvQT3mrd62AeQww18b2HIwF5mG4ORzGGcvpH25CpMnUGF/2L5Vtn4Au91nNd1zzwcagpk+CLIAaMhh3SuhsXA1cZ8BdzRExxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765177126; c=relaxed/simple;
	bh=ieKrIgEtNqQ3YTHK+GruyteXMaL+agKxdOGGZEczaNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCGUpoDW1Fhf+v1Tq1jQNdyNxaGTu0wdIQMbiuP+S21PqEbrl7KoBcnD5nLsMKtI6iEg0bq2/m9sIHRJD1Qbhu3slg77SH1Sv8GHIIRMEMgf7CO0SVo58Bj89xZvKcDyi6w5nIaIQAwS+zGXV7jByskP6UPi/qWqGD7Uio6jjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gGrSwklf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477aa218f20so25594025e9.0
        for <linux-ext4@vger.kernel.org>; Sun, 07 Dec 2025 22:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765177122; x=1765781922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlwFHkB70ycxa7hk9am0TK0PSJjwUc7CdofuXet6SVI=;
        b=gGrSwklfBF1lhh87wgX2KQbws7nhKPXoXRzWTGq7MtlpksSSICDYfjiReJzpKXiGW6
         a+CrRpQfA/917NcpsP7Zl5ytigoBHPsfVyze5lcGXkPK+6418JxRCGI3WycAY8nMAY/x
         aBHxWvx6t5pLhXrtq6wMpI+VOwNcF0aU0yPcw+LZ3khs8hWiAh/WaDicxs3XpRe8n22L
         VJSGUPMig4vDqOwQdARwSo4HqbnNNeiViguaLaTY4a2BqiEDGHmvDmJu1CqAemqmSsXf
         1usrXGzvRxg+6F6nLPDygYJ/QPA33YqdWdwlxpWJ9QjtXf36GX3VJlirqqUdYUXdGHPD
         yrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765177122; x=1765781922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlwFHkB70ycxa7hk9am0TK0PSJjwUc7CdofuXet6SVI=;
        b=cC4Vj7oxdguXMaBfKDSchqHVRGMpYNITO/Vp7NVR4N3RcTaNsCNPenMlg7Dj3t2Y1Z
         u7YYWk7UR/BWJK1dCiUW7cUx6cTrrZvGLDEzzDMM+9rqFg++LUgSOT7B9gkP+NDl7tdv
         te1ENVBzfup8GjaiAazRIgZAdeBPt0lc++eqJOEqmla+W+ISyzQNwL1XZDYdbLZGiT+V
         JBMRMq86HrOhaumdhXiJaX/Af6PNnMpvKGDcwusI+2X9ljPOd+UzoElwrUezRE1NE7UD
         c+gZEL54GlQ4++pNOSSEFIowsyh770oqZnwncl/jwyi6hIhTg3Q7+BfyIZTMIp4zZLWr
         SF7A==
X-Forwarded-Encrypted: i=1; AJvYcCWV30gOs3tLxGvL3rDd8IuujLiQawW9356UdQaPGJ0B0ZhTq0TE5PIAgMHnEhWRHy2Ha2U1NcN8kJXr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn0RMkdV3p0CXqPwmDtjW8j/IzH7yKI7DBza/o14Jrussd4Vh4
	aK1wt9scDosz2I0bU5n6ZI6YhH+dz04x7B3SDfs1GgUlGReqR7XY9XXR//TnEqZe5bM=
X-Gm-Gg: ASbGnctL3Gd/+ywD12ntvYXza6poEKuCx5XknLHQRcdRSCxqzQcAIp+AOuczlf4cX/R
	IjaxMvAL3eyThoSSY3gmwu53MYT3ZJfGTbSUiS0WfAqU85ViQ9d6olzx2vilNnwxPs1GqrByFab
	gSyHtQLxyO1CRsRzLjKraSFBAOJqILIstQ80YV7+fKFIoHzF+fb3/4dLgneBSlooqdarjeFqLv/
	uLyxiY6SC06WGGlLebJjL1J0RV47CyOmku59quCDZj8kylEWGHewNG9jRfkRikMZaiSjtrrxsAZ
	kG+NcVfxXydHBQSaT8KRRI/9FVXq75E5UgVcIlNd6iQ6cnmH1SaOCBtVJZyn4hmDQr6A+Geus1X
	pO7q/78Y+vreJXd80/q/FeL3ipuaCLSOBRlK+foCdwzWCHgLsLH8I+bwrqGao+R9OGbWI+dI4E1
	/C6xBeSLjJPINg1CgowW+A
X-Google-Smtp-Source: AGHT+IFjqtTAiebv7YLHwYZsg1Wir4kHA+DpQgzGh8yBvs546KXmJKyuoDXHrxBgpZdxeNhu3TMrRg==
X-Received: by 2002:a05:6000:220c:b0:429:d40e:fa40 with SMTP id ffacd0b85a97d-42f89f54ademr7676829f8f.45.1765177121688;
        Sun, 07 Dec 2025 22:58:41 -0800 (PST)
Received: from localhost.localdomain ([2605:52c0:2:27d1:8ca3:89ff:fe18:2252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm55341281c88.9.2025.12.07.22.58.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Dec 2025 22:58:40 -0800 (PST)
From: Su Yue <glass.su@suse.com>
To: fstests@vger.kernel.org
Cc: l@damenly.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	zlang@redhat.com,
	Su Yue <glass.su@suse.com>
Subject: [PATCH v2] generic: use _qmount_option and _qmount
Date: Mon,  8 Dec 2025 14:58:29 +0800
Message-ID: <20251208065829.35613-1-glass.su@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit touches generic tests call `_scratch_mount -o usrquota`
then chmod 777, quotacheck and quotaon. They can be simpilfied
to _qmount_option and _qmount. _qmount already calls quotacheck,
quota and chmod ugo+rwx. The conversions can save a few lines.

Signed-off-by: Su Yue <glass.su@suse.com>
---
Changelog:
v2:
  Only convert the tests calling chmod 777.
---
 tests/generic/231 | 6 ++----
 tests/generic/232 | 6 ++----
 tests/generic/233 | 6 ++----
 tests/generic/270 | 6 ++----
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/tests/generic/231 b/tests/generic/231
index ce7e62ea1886..02910523d0b5 100755
--- a/tests/generic/231
+++ b/tests/generic/231
@@ -47,10 +47,8 @@ _require_quota
 _require_user
 
 _scratch_mkfs >> $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
-chmod 777 $SCRATCH_MNT
-quotacheck -u -g $SCRATCH_MNT 2>/dev/null
-quotaon -u -g $SCRATCH_MNT 2>/dev/null
+_qmount_option "usrquota,grpquota"
+_qmount
 
 if ! _fsx 1; then
 	_scratch_unmount 2>/dev/null
diff --git a/tests/generic/232 b/tests/generic/232
index c903a5619045..21375809d299 100755
--- a/tests/generic/232
+++ b/tests/generic/232
@@ -44,10 +44,8 @@ _require_scratch
 _require_quota
 
 _scratch_mkfs > $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
-chmod 777 $SCRATCH_MNT
-quotacheck -u -g $SCRATCH_MNT 2>/dev/null
-quotaon -u -g $SCRATCH_MNT 2>/dev/null
+_qmount_option "usrquota,grpquota"
+_qmount
 
 _fsstress
 _check_quota_usage
diff --git a/tests/generic/233 b/tests/generic/233
index 3fc1b63abb24..4606f3bde2ab 100755
--- a/tests/generic/233
+++ b/tests/generic/233
@@ -59,10 +59,8 @@ _require_quota
 _require_user
 
 _scratch_mkfs > $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
-chmod 777 $SCRATCH_MNT
-quotacheck -u -g $SCRATCH_MNT 2>/dev/null
-quotaon -u -g $SCRATCH_MNT 2>/dev/null
+_qmount_option "usrquota,grpquota"
+_qmount
 setquota -u $qa_user 32000 32000 1000 1000 $SCRATCH_MNT 2>/dev/null
 
 _fsstress
diff --git a/tests/generic/270 b/tests/generic/270
index c3d5127a0b51..9ac829a7379f 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -62,10 +62,8 @@ _require_command "$SETCAP_PROG" setcap
 _require_attrs security
 
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
-chmod 777 $SCRATCH_MNT
-quotacheck -u -g $SCRATCH_MNT 2>/dev/null
-quotaon -u -g $SCRATCH_MNT 2>/dev/null
+_qmount_option "usrquota,grpquota"
+_qmount
 
 if ! _workout; then
 	_scratch_unmount 2>/dev/null
-- 
2.50.1 (Apple Git-155)


