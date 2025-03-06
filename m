Return-Path: <linux-ext4+bounces-6683-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619BA54488
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 09:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C95188864B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F41DE3D9;
	Thu,  6 Mar 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0OsXMbh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEE2E3386;
	Thu,  6 Mar 2025 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249171; cv=none; b=Tb51eUj5XqQ+hIFK2H/XG2RQv+NjvH/T55HliDmhtsnScJUT1Je4zdEc1fFB6dJ1uXBJp6mYrTNESy5c3Cn04PX8rNywZPo3eX5COvCOmKdQX2/cr7Jpwg0RYvKMtIn32JrBADhnoDumwoUeMMbwLeDT2wBhUlPzIEiBc7jikCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249171; c=relaxed/simple;
	bh=Nbml95h4OcLPLRz5GaeJiltYi/fOX876d8idQWbA/0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJJWJtG/1g/Xhcx7XDnNsYym28Yr/AhMDkBR3B0FnKvE/wSGIZXghbwl8/oL8O6Oa3LK8gQ3pmb7V+KdrZaSpiy+040BGBAGnuuv6+0xHd0MHQzENPcxeqg/AL0JQI6M7QD4ZLnGCt24MmJpYf3CJ3aPpwxY/0oAL5vH0WUpn8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0OsXMbh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fecba90cc3so858376a91.2;
        Thu, 06 Mar 2025 00:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741249169; x=1741853969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaA8JzrzyCG7sXss6K5EQ02BwoOhw2+huwCa68gFDUM=;
        b=c0OsXMbh9lHoyu4QkZhTXs8Vc95X5o0hv6Bqyhd2SDeKgv5lOCLepFVs1zyQFpi1bV
         6xEEGd0aytVtjdUhMbROZkGWMIf7i1Jzt6G4vhc3dhRPLUulUIPEGaymAvch3IQkqLfr
         tqitw4OfHmsWb0K0yHU5069ufvMqLfGTb0/rfVqgUlIM5/bXUshDxRsxaZvpe2hQ3aZ5
         IYCE8oqa6rGK2OTDD6JKnu5kQa4zCYgEv4eFXtPBL0LLAiaMzp6JwFro/YHupIGB3qaJ
         kEf7iCb0iwb5jfOFGBUR3QKnDXfEmOi2dzifjf1lUt+GwhLkQ48hvIIVVHoAURE/oW6/
         EILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249169; x=1741853969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaA8JzrzyCG7sXss6K5EQ02BwoOhw2+huwCa68gFDUM=;
        b=toKDqoOD9I/TS67r2q3xOAmy1MvFyEzXjK/G7Kpe3fe2upwsZXB6kXSmit/uHlyw80
         VPw21dzXYBE2oMsXEUZ4IT+xeCJrWvhfs1fz+jhEAhjOLsUSCDe4Xfz39ImmRD2vovhr
         5eKeSQf77ysRSYG/bs6TS+zzx4ILBx5CBkRJB0y/SJO+Irzyvf/72oBGaYT73bERTmEA
         rEvcgp+Ms+TH/3JJKwS9lo5MISSHZbd1sOnFA0sawAQYUjpyBSYfPfGt8WHu3pwfMcyc
         xXGclCVNML/sE/yDL2TNxD5d2rlm2hzKWrqhdE12Vfyzawk4x9anODL60q6YJxoCwdWN
         gW5w==
X-Forwarded-Encrypted: i=1; AJvYcCVGO5Q8NU4h8g23o3JTTEJmJW44IfWAJbELWJjkuIKCDUf24YOQQo7Acd0AkJRrc8BVY/dsTsxUhKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkf0z78TGJuYAQiLKAxFwdlOi95YNQCiAVXBGam3dVBIeliGi
	DyFEvYn/e3L3S5XgwtLkZECBW9QVE6xBki/t5nFRqfluKLa+1oewR6Utrg==
X-Gm-Gg: ASbGncutNH6hceTOWe7+dtNCi+XhiR7fHjWWdYHDajDFKOa5WiO7qrVOKUa2dCo+k0o
	2aeTUMbOeZx7wz5Im0PYy9/gd4Z4TbibGlywhw5NSboAtT8J3Z/nU52Rs7YpmOnO2mnXOk2J3Li
	dOoLJbgrTwKnSqmCuojqGY25M4oJVddm00BOwTihrM0bFdayV+0AC/fsAeIQKDBzMOrPUzx/doM
	K8sBv6LkIy8FcAVQmVQXoSQvWJsxy2TqNPH9FmGoQzMgn3NFQuLBqbpe1i5ECh5ZMg/8k7+ocDE
	RlilXJNquVaYHbywahUTmZGY0gaZjvZr6Gv7uWkH5HVEPg==
X-Google-Smtp-Source: AGHT+IHE0UQn0xFTOaxz3g/4dbCTV69zqlCPIA/7BkzgjWZ2LPMZWmLiNKZ1uZWjY2/0pf6ItrNaJw==
X-Received: by 2002:a05:6a21:4cc5:b0:1f0:e808:42ee with SMTP id adf61e73a8af0-1f3495bd878mr10431279637.42.1741249169268;
        Thu, 06 Mar 2025 00:19:29 -0800 (PST)
Received: from citest-1.. ([49.37.39.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810c6349sm660257a12.46.2025.03.06.00.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:19:28 -0800 (PST)
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
Subject: [PATCH v1 1/2] generic/749: Remove redundant sourcing of common/rc
Date: Thu,  6 Mar 2025 08:17:40 +0000
Message-Id: <149c6c0678803e07e7f31f23df4b3036f7daf17f.1741248214.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

common/rc is already sourced before the test starts running
in _begin_fstest() preamble.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/749 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/749 b/tests/generic/749
index fc747738..451f283e 100755
--- a/tests/generic/749
+++ b/tests/generic/749
@@ -15,7 +15,6 @@
 # boundary and ensures we get a SIGBUS if we write to data beyond the system
 # page size even if the block size is greater than the system page size.
 . ./common/preamble
-. ./common/rc
 _begin_fstest auto quick prealloc
 
 # Import common functions.
-- 
2.34.1


