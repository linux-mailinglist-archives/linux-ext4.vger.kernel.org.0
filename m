Return-Path: <linux-ext4+bounces-8171-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E4BAC041F
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 07:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CCD9E6721
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD501A5BA4;
	Thu, 22 May 2025 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDrwXr8P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B22EC5;
	Thu, 22 May 2025 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747892653; cv=none; b=tRjAC1pkyrt2kuFqVZKh3Zf+DrxFzcaOl1Oj7xTtP22/VL3y6pTdPBHOnu6PktTSH+KFyKfUx7PNMY6tersxOCDHu+emWIsF+nlushzxDYfRPmKzV3hFqIvbRDS26gfPKkEa/zhwnD0GYFX49Z6FljgL7k0XQwK9LzJP3Dlk2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747892653; c=relaxed/simple;
	bh=3XpY0ZlsIVRU56Tn9W4nnsg8OC+h32YPM4jVP0G+chw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Svb8mknvpKbqsdEEaazwQpQdXbB5+iTBhugnq/P+Dc4Qc1dk2YTAbsFH4oyD5EY7X8GluZ+o/dEhthhcTJsqDAv7GA5k4XYuxvMAjYtKyuwudt0+GwXHHrDq314QS1ysShy0QQoqlIcXU2XoWlIYZzyVJ2cCo/o+FKCRj/K7OPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDrwXr8P; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2322bace4ceso40676955ad.2;
        Wed, 21 May 2025 22:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747892651; x=1748497451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPye9n3UPjJ29C3qHU3phMh1Bw64R82CmKYG4JYogwU=;
        b=TDrwXr8PLeVpDfIb/nl/+BsjxOc49amSejSYRoAhvtjOcJpH6ldYDishnoEq1PdP5D
         lpb7QMfkRe/L8bbTAVZ+RC2Ogp9D2LawDjV7nCUamEjhftNI/edofelXQTWEqT66+eol
         l4xAh09sffkrjL0DFQ0aUpla2/+Q/C6oXarCMCx5zt3bfU8bT1kmeIbWOnlud8K8gM/A
         nby25iUODng+5+eheDo9J8ITGJECtJPlgACiDtFAIJS+wujjOooAYwgv64VCV7Aomlc1
         P4qG4j1Bu4u0mnhSU9241Ax22cRvePDLevRJbCB0jOlIdyoc93OBaS04ZDnouBpuXCgI
         I5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747892651; x=1748497451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPye9n3UPjJ29C3qHU3phMh1Bw64R82CmKYG4JYogwU=;
        b=N/bgmoujZ31I5uF4ZAVNtt/ncXlmfBXM9vS6al/A6O92WF1g/5Nl+fbjNp+LQfl11s
         DUhqJtrJj6Zc43iVUNxQT8+xr7Tf+hfuaoKRij6rynxyBzUV7EfcJDkEf7F1ZPUA4B5/
         6jSh306YvV8ZQjM1urqWrq9oQXjrE8kU+mUQi9KEOXT/Ia9ql7wzr9W4C2eqEgGLThiy
         1jBoZVAklQ6fAdY3/2nnYoyuEU9FBtMNuhHfNWwXBiJi9H32dzbdEuDZ0btmzbiND5XT
         ksFYfpyEz+/fzUvpWQJVlHEv3NtghIbahCn+dlagtK6i8CvK74dyIMKUaZ7r3LxjqWrG
         0XJg==
X-Forwarded-Encrypted: i=1; AJvYcCUMoVg0/3JWMLhAxVUNdsVDzKIDI7i4IQ2+sLKauJl3WFDdPWN31pS81RwuXKLe8XmXShrHODa+mYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlL7WNf5/0wTbWPpxON5lwUKBtUaSaREj+fkAZhQoL0vEbBQ0k
	RlbWybayi2OHgq9wKvZd7NBJzj8riWR6HUjViZbiFAWIZLCOoQTXDXnMoEFItA==
X-Gm-Gg: ASbGncvF2dzDP6u+fTfmhGAbkF1R3DiTYbek/UTPNwE2519PnRkhesMZryqBY95Nc6/
	W+tFKOOcnosHnn3FYgK5Dcu6Wb/wDjiRthZnh+qUUhNHEx80l6bg2a85RG3eu4nWExXUWdFQUo6
	3DW1R6Zh3E/cWc/T7QTveCGYLsq+GF8mTGiOUk3/LgUAMiUBa4JFCyDqdlYCjR7NJ60MswkHWzY
	BovJwEHQP+ZnoSV5QGMMfp3a/pqpsKL9CDW/MvRD4T93HFD2M7OUE2UKuNGEUht2bhy5Rn/yCcA
	kTYYwRDr88R217GqRHWUWNrMfSbuVNCyO7RgQQjI/BvqTkeCY0rOXfA=
X-Google-Smtp-Source: AGHT+IEUR0jut8KyLXq4OP6SBbpNtXMqz/EfE2OZON0Er/BFNuGZpuXVcKSIIEwv75YoUFTiupW9kA==
X-Received: by 2002:a17:903:19c4:b0:231:d0a8:5179 with SMTP id d9443c01a7336-231d43bdb7dmr366865995ad.23.1747892650750;
        Wed, 21 May 2025 22:44:10 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adb73esm101577865ad.59.2025.05.21.22.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 22:44:10 -0700 (PDT)
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
Subject: [PATCH v4 1/2] new: Add a new parameter (copyright-owner) in the "new" script
Date: Thu, 22 May 2025 05:41:34 +0000
Message-Id: <72c4879ec3f037db0478bdf0c64c1fbc6585cea7.1747892223.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747892223.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747892223.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch another optional interactive prompt to enter the
copyright-owner for each new test file that is created using
the "new" file.

The sample output looks like something like the following:

./new selftest
Next test id is 007
Append a name to the ID? Test name will be 007-$name. y,[n]:
Creating test file '007'
Add to group(s) [auto] (separate by space, ? for list): selftest quick
Enter <copyright owner>: IBM Corporation
Creating skeletal script for you to edit ...
 done.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 new | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/new b/new
index 6b50ffed..a7ad7135 100755
--- a/new
+++ b/new
@@ -136,6 +136,9 @@ else
 	check_groups "${new_groups[@]}" || exit 1
 fi
 
+read -p "Enter <copyright owner>: " -r
+copyright_owner="${REPLY:=YOUR NAME HERE}"
+
 echo -n "Creating skeletal script for you to edit ..."
 
 year=`date +%Y`
@@ -143,7 +146,7 @@ year=`date +%Y`
 cat <<End-of-File >$tdir/$id
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
+# Copyright (c) $year $copyright_owner.  All Rights Reserved.
 #
 # FS QA Test $id
 #
-- 
2.34.1


