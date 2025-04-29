Return-Path: <linux-ext4+bounces-7544-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B5DAA0F8C
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 16:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B0F3AB45B
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107C4156677;
	Tue, 29 Apr 2025 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hroiqGQo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601721BF37;
	Tue, 29 Apr 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938123; cv=none; b=XSspZQusnyz6N86PrkUgcWHbOplgePKj+TfcsNuJ/L8jwMvnuANPDC4V50SqKWqCTmU75e4zkRvuzCMlkvlN47rrZnFgQ8EfpvYnYKw5EGDjlXDsz8/m4HEudm8wZAA2pJMVDPNcE6tADQgArRTGOc/2g46b5s25KfhUjiy5d8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938123; c=relaxed/simple;
	bh=2li+pG4xWjvoh5hk5Z470gKd/rrpN/Ym3/G+Y2snvFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxOpIFb5YM15SypAIpsthd7FHUqX+eQ0p/XK+1FpvKXxaNoA95zfV+oaERpONAOo1XNf5SzpQwG1wzmk+dXghQzrjEJSrzFcJCRPbWJFY5ZQb2Kc3bfkX6dSVT37yIpA6Wd6s3vZuOW5jt8AQIUbA3MF1JPZ64/PAIjDOLNp3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hroiqGQo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7376dd56eccso6490410b3a.0;
        Tue, 29 Apr 2025 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745938120; x=1746542920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=930PJI09Qq1lKsA2QjAv28oAp9sjlL/yYLXf00Mt0Y0=;
        b=hroiqGQo9PoVaU/SwciUdTvDADYhVGhzeEUslLVqO9XJfzak8L6GSzoDYlTl0U11rh
         OHPoGocY/cg8sJUWiqai3mAY3fC+6oCK6E4ys3goZSz16qhnJB6UnqINlLh94tblekNK
         XY/zXZblnDmmXYF92RK/vEODhS9uW0sgL+nnW+XWbU3pf0mHMJmh2VD0pHgFVBXfrSq+
         bA/bW3PQAWAYRmVrT+wAFxlSKti5AF+h0SwI4nza8K+WyB73+TG/+VFgXjkCJvyTIoWh
         2m68Taxax8Jw0sa3W3fTfTZqwwF/COK3Y0uB0JYpQ1RS4Ho6Rw56uHpWQW2o8hfAeN/y
         q9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938120; x=1746542920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=930PJI09Qq1lKsA2QjAv28oAp9sjlL/yYLXf00Mt0Y0=;
        b=ogC4sgX4tD/Np8gIAr+MPomTLsjPxGmUGU56F10Cl62E1QfV1ujwdwGiJvXKyxowS4
         bDwXjQpjttL9bXAFjJBdaD7sjuWHOMBcahcKC5tRR4YbeNnBUvL+9qLjm7KpCMkZaQOq
         T2MgqwDea4VekXL/kwnMOuPWoBy958MllS/2sYmSf9vQ10o245peF1lIRG79yTfhg9Ix
         vKntsi80/yziq6VG07Xt1e1rU8rytIKyBDiRT6lqbZMrfc0unCjlPLUfvJUNfJJWA3MK
         2ndi3TFE2kGbyCkzJzfL1s84mhQSRvF7TC7tFtBWrKYhPRokWDVFEnMCaoRd3tj/d6Ui
         Xhww==
X-Forwarded-Encrypted: i=1; AJvYcCVQR/KCeAkkblEXKCEKZVyqnyeRe2BjG2voaE8Mezz/JNkr5lkNLQ9AgaZ7WxclTvS+tBMXpCrY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5C7ftbkJeV+k9mZAdcxPXLwts1QqkpXHDBUnmKR8PJjdhq6eP
	Sk5ZVjDZNODMQQlqtkt4pkqBTm8ls0kHY3yEvW6REeUpvbOtzRBZGG2D+Q==
X-Gm-Gg: ASbGncsFYX6KoY5HIV8dMLEitapd7a/uXVNV0jlcvMnDhU7HXqwdaOhaLxDaO/L/DYz
	B27ybsPIYxzZ5cdHAqFKjbczbfz0dR7VY1BTNF1FYEHUpFpXWHkzVmWiigyxJrCfS+MqftNriB3
	CDRJLuA+lNoCSlqw6bHGmtSD57RSfRoSt5gEwWJT2j5l4Shocjb5bcqUFIoUsMQhw1WkYmRYYUy
	Dvs0MajSSM/0f2dLnywDbvjxPrN0/1uWJ8EjSN8oULaOXIY+E4jQePWg0Zj6zIRgxXlQYdbPJD4
	yWqesERmdV9UCX83e8yXIWrEC+bOI/7k6PY2DSwNzBaZfQdMo2OyhlQwUXkM73f3rilk/tX5fJ4
	coERqkqYaVjsjKnihiRxegOjTOggt
X-Google-Smtp-Source: AGHT+IEZd63J22dKQINTXD10WExEEM0ROT0NSMjXnBdM/AY0O7BUHc3SjfpwqJvBnEKh7qPkspaGmA==
X-Received: by 2002:a05:6a00:2446:b0:736:73ad:365b with SMTP id d2e1a72fcca58-7402716b4f7mr5421706b3a.14.1745938120124;
        Tue, 29 Apr 2025 07:48:40 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9fd26sm9954222b3a.151.2025.04.29.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:48:39 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	hch@infradead.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v3 0/1] xfs: Fail remount with noattr2 on a v5 xfs with v4 enabled kernel.
Date: Tue, 29 Apr 2025 20:17:58 +0530
Message-ID: <cover.1745937794.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue where remount with noattr2 doesn't fail explicitly
on v5 xfs with CONFIG_XFS_SUPPORT_V4=y. Details are there in the commit message
of the patch.

Related discussion in [1].

[v2] --> v3
 - Mostly some coding style related changes.

[v1] https://lore.kernel.org/all/7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com/
[v2] https://lore.kernel.org/all/cover.1745916682.git.nirjhar.roy.lists@gmail.com/
[1] https://lore.kernel.org/all/Z65o6nWxT00MaUrW@dread.disaster.area/

Nirjhar Roy (IBM) (1):
  xfs: Fail remount with noattr2 on a v5 with v4 enabled

 fs/xfs/xfs_super.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--
2.43.5


