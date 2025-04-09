Return-Path: <linux-ext4+bounces-7158-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E42A81DBE
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 09:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5261A1BA593C
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 07:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7053D22A7FA;
	Wed,  9 Apr 2025 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC9T5tvp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9822256A;
	Wed,  9 Apr 2025 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182165; cv=none; b=POHZ7rR84vw3WpSDMkmeuqXPSQP6XmuyRRMY7HYqG/ffDf4zPGxxn+LPPhqT27HpZravxINGqi+AIuMeh1HE4lpV6dducghjegHZP2dUWiR890xO4UQCOdc5AlDgw0b8T5twjln/L43FDzHtuYX5aDcr+SpzgjuUWzKAWA1AYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182165; c=relaxed/simple;
	bh=4VaCDEgeA0Rd4f7KfqUGsFouFa4h9tI2QZy9Csley8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e0r4rP2yCYIPjXX0vES2HDAAsE2CuRBnQB75gbhcwSY/FNwZG7KmHaLPwFlbrz8VVEwA3ZFzgCiTi1FjpO1p6dbkUuECFuISp2YQ1DBaKxSX+k4Bx/KT04xodrCu18FR8z7KdUVyba6TXg6qkkALkEjEVicxbIjbtIfy3s9j7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC9T5tvp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22435603572so62339985ad.1;
        Wed, 09 Apr 2025 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744182162; x=1744786962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8ERU5g7D2gDuRDnp7J1MdvgJ9zmzGpnA9/o9Hz+OBo=;
        b=lC9T5tvpaDqG8YLWEG51hqNJWwm6wL/Vb97WO48GBmD+xDDsHgi91D4Mtw+o94Jzki
         QjAS0mlfxnQfiNdcBY9zU79rssvFUXiRK1wICSTJIEQjJ/JbvSc/phr0x+qn7niuj5W1
         twAqyfF820YN390G3HUVPX0W6NZK30WGwPSUyXRXC9VOx04KM4IeBHHD+x5R11OLth3C
         4dVyqLIt+O25E8IeBdYXPhTbPmRukENNiqm50VMLvlDz/9o5YM5+76RsyY8btaWXTT9L
         iLlJvxwcQmNSRunRfjPhjKfrGwlVMXyDlBwoUqyPQuPWj24U/gQe9ZzBRbSq2aDQNxah
         nxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182162; x=1744786962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8ERU5g7D2gDuRDnp7J1MdvgJ9zmzGpnA9/o9Hz+OBo=;
        b=d/xru4jH356LCCVyXep3fNBH9ffjEE81yN0akn1VWr5yEPp9hApaES4QbZ3gF4HVui
         C9CBTnRl8OxnV3dbGoKtuX4wkG0DTqsb7H+5k/EXa7Zp51xtRB0rf0n8hVm9dcANGpBD
         rwGgmAIXUqmcyqwL7CaMwDjjyZZwcTbSdUjyUidGiTFJv07zMqu44k9KICkusEUSyWkz
         wc3Uk92oFQq0JCEFu86bT5SqSb8U7rIzaesiP6D6OAbxgOnQuZ+hrhFOUA/aL5sGyyjI
         s9lM8TX98kqA7YCu7FCmNWbyYh3MvxTanin4Mh+RtZ0FMH++pc7+M+EQxi/9wyGDrGNW
         oCYw==
X-Forwarded-Encrypted: i=1; AJvYcCVzhDrnINHH7J4zWHq47aLwHmlqwA3fJBTMe7fXNrDTkAWYJuzK70BrGMTC7WOfuGAbSShvkPM7qBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WFhVNGDidjCNpPriwYImdy5H82fm3DTZvXpnbPUtClUXca4U
	gDOTo+TlQY2rQ8KJ/guvtayi2lh2G5AgEO0H0F1i4HfOfi86D2+hjPZzIuyP
X-Gm-Gg: ASbGncspFcZ2TudtZBl7SW6baXsI5+8C4aTKnaVW1UxrHh0LUMpHM5fx/DNohzU1Thy
	4uCoDJNSmuNZAWGCENqexYbqMC/BMuCGYSfWpCXkJPlioKAcMvjtBz2PFyJ5dbBCEDn1wkuQxKc
	F6WIKsFbXh1wwKI3Nf3o9PCWoVSRTdydjZSq0JJU126lrKUyoNVeAI6jLkAWYlGCulaehdktdlK
	/6r7qdy7UfDf9qWt8RAH3ussuJcvJE/mTFp1Ick/tvGVqTOCOjSjRbepfH0FAf5KnLEPWi1Z/UQ
	FXe1lDT2wsDx16dNhScPvKl/CtfAhPNXT4r+2WkkW9pjIGghay3BLqI=
X-Google-Smtp-Source: AGHT+IFRj7GyzXlB1hbWuISU+i+6Q24YJZebqp3zTvyb7HGcl1ZRWHLzmm/e1gePbeAOvgOvZD6Kjw==
X-Received: by 2002:a17:903:2f45:b0:220:e63c:5b13 with SMTP id d9443c01a7336-22ac2a2dbfbmr25794595ad.46.1744182162087;
        Wed, 09 Apr 2025 00:02:42 -0700 (PDT)
Received: from citest-1.. ([122.164.80.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c939a3sm4491985ad.117.2025.04.09.00.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:02:41 -0700 (PDT)
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
Subject: [PATCH v4 1/6] generic/749: Remove redundant sourcing of common/rc
Date: Wed,  9 Apr 2025 07:00:47 +0000
Message-Id: <959d5f63e0343683f534da09d902138a927fdfb2.1744181682.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
References: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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


