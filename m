Return-Path: <linux-ext4+bounces-7102-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9039EA7F432
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 07:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE20174D33
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 05:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACD211A0E;
	Tue,  8 Apr 2025 05:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtHu0483"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68ED2AE74;
	Tue,  8 Apr 2025 05:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090688; cv=none; b=N9584jCt4GWL4/FWpPAMow6kKZegBWM6HYHkBQiRc1eeKNEZqcJSKwlGXIEWsDGtRRj0cVtwlgtL1wGnED0WNs6gC88NEdOxcLIJr91AqEBz6pCag08/YKcS5qWhVXd5EkSugpliIMezrxpDcltxmXUlr0v6x8XYeUeLUixovnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090688; c=relaxed/simple;
	bh=4VaCDEgeA0Rd4f7KfqUGsFouFa4h9tI2QZy9Csley8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KYO1KhrpxAfhZnPL7FCLB07qlkB0X7ctIAIXyI8FysR6nDnn/yNL6WWt/B7AfYpnvPiSS6RZXBJ+zLbvH1fE8DSjBmd0r/EhBoNYPzNoYYcJUROSgbKCjr27WgnmbNz72G0hyrD3cCK+DWBOEdWiy+MyOK5buMsptcuV/RUFunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtHu0483; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22548a28d0cso71415335ad.3;
        Mon, 07 Apr 2025 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744090686; x=1744695486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8ERU5g7D2gDuRDnp7J1MdvgJ9zmzGpnA9/o9Hz+OBo=;
        b=WtHu0483/FKRPF502kQgfx3UFpZ/5kBF7+A0JJ6DfwSTo8yGNnP2G2b/C+Iu0PGvh3
         gpWp2dlhzMoSWSkqsH8S2HQXAHnjN4QJAdCDD9JzFxGJ0L40fi+MnZvyKZtiN5Clqiji
         L6qjGFuSLAuA0aDBv5OrLxFVerABZRRaZHvhEP34Q+gNLALgUiCWJLY2ku2oNXi8qVjL
         054myk5IPxS0zbbsrhe6R2soCQ9giyukzoUH/wCV05RS6XiR5CRvuEenMuYV5X2zHEAK
         2fl+TL3W4m0PHXkVQTYzCear31dYD+K8qjJ5Cb5mH0KZ6+IsSs7uj0/ci9ovkqvLm7Ar
         /U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090686; x=1744695486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8ERU5g7D2gDuRDnp7J1MdvgJ9zmzGpnA9/o9Hz+OBo=;
        b=oLceOjO7cjj4NqwTqhZBfqm/ZTX8p1+adiwA50sqEv7rmCwN5/jFuo7wHiDDBbOKMM
         LXT7taEWDtvPLvBE54uyCLcNdcFKDnSAR5PLR1OqNTn2MQw7z/6XsbBZQZNC1caHn+K6
         Mi/+zKBu+jYibUy4jO6snpK+adfXVqstLt1Z/sGZAW4u/vcyXciucsxKkcfgafFujlNM
         yerBNnnP5x1UAfNn3ewN0QVxOtqlyGh9eGAKmULW81DDp9rjkgHcMWdFTdwFY6to8sXz
         eDdzRcI5sku1ms+NoalnDQjfjtfBpRr2CJt9gIGO5LrLoxMteTsE3vdO1uLm8BV8Myj0
         Uyjw==
X-Forwarded-Encrypted: i=1; AJvYcCVsHI0bD9MQCIf/t9/lI1N2lZoBfxmzX96MnNX2aYdDDPoHw4cxcyDcqpkZYCharI0zrFWZ1qzPN88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTw0pANXgCow/bQX5SmyaO6xvnPTuPWKIBNCMi2nlL9LqeMr6
	ChzsBAIBDJrq04nym0y3nj7w9Y88fSRMOSWBvzkIsi1UWyL6gRftpQF1+Q==
X-Gm-Gg: ASbGnct1hoIPYMMlAn8B/p2UHm9XZpfsnmjUn54ULMAXKLK6GVWDwbFRtOKKgYOJMGf
	NADSx0SVTv8gnSt6xRpdFBSbiXDRG4E4o99iWIcsyxTian0IKxQlhHY2HNoZVweVAafUAF+FKpy
	fk81Mdq9i7INUWoKrROU55y6t3aOqpHdws22wfo1HavZntBxy2MxuYbzOniGW+AhZvV6X47/reH
	Li1fdcwU+rWk7XX+iIHVw9rkjyOMT7V98S3Jf1v7ShEC9z0Qo5UgxijHs95MgBQ4y0e/T7Hbjzb
	ckJOqvDL4JSj1lbFC6OWKDPSSYAOHWSDAQCNmXn05SycigCzaB8DOmtfYZ4=
X-Google-Smtp-Source: AGHT+IHUSUbzrJ0DglrcKxYwJy//Jkr0KGk4P1+pDjgTgHwnpa7cgfi2qlHDb3ryfWFzO+ehX2YQmg==
X-Received: by 2002:a17:902:cec2:b0:223:2aab:4626 with SMTP id d9443c01a7336-22a8a84ea52mr185770005ad.11.1744090685608;
        Mon, 07 Apr 2025 22:38:05 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229786600b1sm91154875ad.109.2025.04.07.22.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 22:38:05 -0700 (PDT)
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
Subject: [PATCH v3 1/6] generic/749: Remove redundant sourcing of common/rc
Date: Tue,  8 Apr 2025 05:37:17 +0000
Message-Id: <959d5f63e0343683f534da09d902138a927fdfb2.1744090313.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
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


