Return-Path: <linux-ext4+bounces-7101-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F745A7F430
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 07:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8A91894EA6
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 05:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD520C48D;
	Tue,  8 Apr 2025 05:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj++b6bC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34A92AE74;
	Tue,  8 Apr 2025 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090664; cv=none; b=qX4KTLs1ZSA8eJjWFkFxnJ5C95HVCCfXAWBQiPgC9AW4V6W2K37b+YiGRsdh4wXv/EcRgKLvu1emfxETHG8EfNfK8FA3SS8mPNI5jbWeZOGWs34EqCbAGX5iw33shcgsI4OHlGFeotK1JM/NvJrv+8i7+xJzr1pV99+DhNBhWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090664; c=relaxed/simple;
	bh=J7Uut9eb5RNdnOseynq8XEhDxuUkzVmdZiInC5lBQ0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5nmSLrQ36BFxeemvtPF2n69Z6HZlhIVTaVcNXD//AaeqRxX+Sxqg1zWg2RqT4fZtZdnVFRBeu1nbP/fu7B2DDaBqIbax4IpvKTNyvm/pdEhOZaLGVZUiFUfvBSsvLL9D6v0HhCS9BZfblQpwlLLVTwnSG3N6k1q1z+ueKk6SSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj++b6bC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22a976f3131so23247135ad.3;
        Mon, 07 Apr 2025 22:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744090660; x=1744695460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hWnL4CbQF/pZbigv1jehXQXfRuNE2TjC/QITmRcYh0=;
        b=aj++b6bCyDqzbGzEvQtV0iMgljSeUSM99niMQMdNetI9P5N8RBkpDplQZe2RaTCNWd
         lhpJEaqbeF5ZSI+kP9QoUT2XpZupIldIRuxDuyYjQz3J/5NopL3hlvyxZLPk+nwtCaqa
         Y5wkTEsJyO3nJFbB7KETJsWzalynvXgazCUKBT2VWRH9cLc8uCIWPWNpbQm+W/5PSzAb
         U+2jb/4smT0BqXXLIVnloc3qRmOShUSF4mc3qk5s0Prt/LCgdF5C+T9Ywvu7K0UGUlst
         5f0/Ak98J5bf+gWqcWRe0+z/LfTTuvk6wB72es9r/keivvh3LPq2vzsd3Jfi/yHBR6UR
         1V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090660; x=1744695460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hWnL4CbQF/pZbigv1jehXQXfRuNE2TjC/QITmRcYh0=;
        b=stgFOpYMSXIKzoKC77n9HTU4yrXdFjYEOAP7oD/9XonbkQgK8rb1ZrH4OFSq1epi4G
         xUyciqaxV9/+m583c6jxT6pUdGMJEkYNH5oEnNxk+BdfQKiZN3F81cHFfgEZb6yOc267
         pq01G6aRaIh+IXlN7j9mLYT+GmWDQtBRyLPTi0/CC0ZXgQ1kWH2eg4LCHIQIZf4nCxYM
         DYSygoI/6MqS5Wmb5BBhhHOD8nA7f0VbJMmIL23nP7gszSt6I5J1ZbEdlPGGhu2Uskaf
         +B4M6vInxJS2/YpN7ijlOfDMuS4rS75+AjJbx5PJ4UFGsOvWBE1ti2X8qqwdZ5Zbywdx
         r2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpCDGmRliA6zCYNqfrxCuTzkhWPdilOiNmECmgiExPvPsGOOy6B74xlzGOS0uHbD/tBM+BeBfuL30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ3ac2CrjnKFI38Purh86Ya/lCzJoKVp6EnmbXy+LwrSjYKuvI
	H4Xf6+KnT2NCddFdo/ARUvqyxb1CMBhNkp6Jbc2KmN57QJm6lah/a8a7Xw==
X-Gm-Gg: ASbGncumdpb43DYFrfGocXyOW5/V8gQqt1C2lFjD29tWKQwY6Vcf9HhojT8bXiWaGwM
	I+PJ61osbyJVZJbE5RIbnOhnEnmVaR8W4c2YhZeZl/Ct9sfGEMvnoHEPNJiG6ffFxSKIKo9ylQS
	5kkxU7Ypuyf4bRVzunNpzXl25kKP0hp6N4ZbvDZx8sGU+v9B+YcC5cAmxFmpamACDjdcS+2WC62
	c20MgQOecHRcpc22yi9pPSEyBK0VtCt4Yquzmx0M/sworYIhUgfoQh7Bucg74fOK5jRbIeQ7c0Z
	Ym5ptcr2X2kkqWpMCXxcXY3vnWWirb+vHwUcdQS911LV+xb4
X-Google-Smtp-Source: AGHT+IFpHvQDnDuiGdwO/O32nL/o1WJFKOZL4d30HMHkE5T15gsvnnrcuOp0LYKExOJAg8ykibrzdg==
X-Received: by 2002:a17:903:1948:b0:224:a74:28cd with SMTP id d9443c01a7336-22a8a87d03fmr210393125ad.31.1744090659537;
        Mon, 07 Apr 2025 22:37:39 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229786600b1sm91154875ad.109.2025.04.07.22.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 22:37:39 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Minor cleanups in common/
Date: Tue,  8 Apr 2025 05:37:16 +0000
Message-Id: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series removes some unnecessary sourcing of common/rc
and decouples the call to init_rc() from the sourcing of common/rc.
This is proposed in [1] and [2]. It also removes direct usage of exit command
with a _exit wrapper. The individual patches have the details.

[v2] --> [v3]
 1. Added R.Bs from Dave[3] and Ritesh in all the patches of [v2]
 2. Replaced status=1;exit with "_exit 1"  in some of the functions I missed in [v2]
 3. Added some comments in the check script(suggested by Ritesh)
 4. Added a new patch (patch 2) that removes redundant sourcing of common/config in generic/367
 5. As of now, I didn't change the definition of _exit() function.

[1] https://lore.kernel.org/all/20250206155251.GA21787@frogsfrogsfrogs/
[2] https://lore.kernel.org/all/20250210142322.tptpphdntglsz4eq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
[3] https://lore.kernel.org/all/Z-xcne3f5Klvuxcq@dread.disaster.area/

[v1] https://lore.kernel.org/all/cover.1741248214.git.nirjhar.roy.lists@gmail.com/
[v2] https://lore.kernel.org/all/cover.1743487913.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (6):
  generic/749: Remove redundant sourcing of common/rc
  generic/367: Remove redundant sourcing if common/config
  check: Remove redundant _test_mount in check
  check,common{rc,preamble}: Decouple init_rc() call from sourcing
    common/rc
  common/config: Introduce _exit wrapper around exit command
  common: exit --> _exit

 check             |  10 ++---
 common/btrfs      |   6 +--
 common/ceph       |   2 +-
 common/config     |  15 +++++--
 common/dump       |  11 +++--
 common/ext4       |   2 +-
 common/populate   |   2 +-
 common/preamble   |   3 +-
 common/punch      |  13 +++---
 common/rc         | 107 ++++++++++++++++++++++------------------------
 common/repair     |   4 +-
 common/xfs        |   8 ++--
 tests/generic/367 |   1 -
 tests/generic/749 |   1 -
 14 files changed, 91 insertions(+), 94 deletions(-)

--
2.34.1


