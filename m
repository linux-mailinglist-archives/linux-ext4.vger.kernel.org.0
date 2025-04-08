Return-Path: <linux-ext4+bounces-7103-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413EBA7F434
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 07:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB153B34E5
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 05:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6C7212B2D;
	Tue,  8 Apr 2025 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emosP2so"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6715204583;
	Tue,  8 Apr 2025 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090710; cv=none; b=Ai+2H5YXnTnFxEadjcdPgxim1cTxm95GVoYcfrq9jIXiMfwOfo4e6VTpmozL1BQSMpPq3ouoDXExrPCJqXp2juRwwafNWUENN6Z9wr7pu8+2wR+BO2fd6FIG8eVItWMBGf5aKBO6x07par1qXI25gkr9AY4HzJYxsVLyx0eukLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090710; c=relaxed/simple;
	bh=TWdPHeuud7suoMCDOb9OWG736dAEjvAxw5kmHQpa3c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZKniLTrr07TmHZikXbwxwxX1EnVJhYcsQfjmvEs+Qq4MHjWTNiHvqj412w+KRI/D3+iLCw1zqcHlTTITWyQRW/NlMzCnVxScbKS5qEAMpqHr1VtwjZwNq9lhBTw4PXHpmSzLJxeSPeJZtMzIj0pGFb439kwwJ1tzPB8KXzmzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emosP2so; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22401f4d35aso56331115ad.2;
        Mon, 07 Apr 2025 22:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744090707; x=1744695507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z17aILtgCgmnHX0DWNUySq8DP/gonqEjDq7fqvlJBGw=;
        b=emosP2so2y5nlFGsC47O2fRcPx8wVLKXikbde4TdgIMW2y03S2c6Ee0Rhca2LEXxKe
         DWs/abSP/vu9yCutqFKl47cc3nDD4FlKaJVnqO7pJqhw5MdDRqGnMtJF4bWwXe6fZJ8/
         6EstTJN9Um0B/jbpbloxnMQu84xFGmSy7OOtBAVVMbqHJ/ZAAjmcNL27aiujfD+NiAXI
         yPqa9KIZX2OpAsoo4ENocti7pGLg9MxaUNmPABHmDJExmSVvqzxlnFDxJalYVhXLn0Qh
         Z+PhBrVfjCaGTWfvAM8fS0Loxq7MioN4XFZxnvz944iXGjOJq7aQYkvf+3L8SI6VjOsy
         9SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090707; x=1744695507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z17aILtgCgmnHX0DWNUySq8DP/gonqEjDq7fqvlJBGw=;
        b=jk/brJoHQ54KzJXi+hRAf8TseV7HhULfHct02d5ZPcNsS7Gpdl/VoHWwClsOVeMSxd
         AQcT8byeSoEyXgDmPepSM9e5vjkFYiahZ6nIbPdGfdXbn2HD/6GJyZ09KXCGQiVeA3yb
         N2WkQQW+S0QKzjCAt5tvhZeCQYmHYDl7/zjhje87pUxpo8xxBToRc+Mg3Raec2NcSrZe
         5AwLc68CO8PCpvCdv+ilDRUdj8C6KrGtCXbttN0hPP5VI1ECYNVXVDLDBguYHkaXHj9q
         Hpb2TOx4CMzzAdpDrFIU8vtMXuck4IPEIzsFHRlCVJzu/5nqf6rhcRyeU+ZVQddfOHn0
         VV4w==
X-Forwarded-Encrypted: i=1; AJvYcCVJb0C5OAYr9IxEloI+WDRA70VRYRgLcLMsirJgdAT7KOgm2fEnWoDy6at2hsynH4Qcz7v4BGLuazw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztRqTJSgs2PUnfc1lwO9JxavCprrReg8yoPbvXtIXmsC4SS/7V
	VRI08cJh0v4eAlHrzwcjcnrcw6sZMFnXvmxU1BiQktANuNUs4hyaRgAPsw==
X-Gm-Gg: ASbGncuRLYEDhl9MhLO31d3m6BnkrXEG/O1A7wEfuonrq6wP6CIZ1ev7yAifPUC0FAa
	kmG83Z4darOCCznPlg0/CcHOrvm55IiFda55Jcr92B9228wsBY00lyZkKhKy7bgz8jVJ7sZel+3
	KznelJqK1r49qZUHIqdRk5nOiJK8pYiwv61WaY9wbkNDrxCVa1Og7WYr8wg9Dgyyug86RfErbLH
	QWQ5r3dpCzsrbYHWm8gZZMCHwr0EVAk4Z1eaLHfS8UQOSif+OY+uNY5SYcDIzyvt4QqriNcHpL/
	FpqpDazlyBlrsdb0xr8ilQEh4ShXbCDMwMhxDPpglpReylEv
X-Google-Smtp-Source: AGHT+IGOLQIHzGLrHe+DbGhs/kmAXFI18qKfAA1C4q1BXUC971evRaP0wj/fvH+Ddlm4g32QtCBO5g==
X-Received: by 2002:a17:902:ef01:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-22a9545fd23mr158307895ad.0.1744090707065;
        Mon, 07 Apr 2025 22:38:27 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229786600b1sm91154875ad.109.2025.04.07.22.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 22:38:26 -0700 (PDT)
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
Subject: [PATCH v3 2/6] generic/367: Remove redundant sourcing if common/config
Date: Tue,  8 Apr 2025 05:37:18 +0000
Message-Id: <ffefbe485f71206dd2a0a27256d1101d2b0c7a64.1744090313.git.nirjhar.roy.lists@gmail.com>
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

common/config will be source by _begin_fstest

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/367 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/367 b/tests/generic/367
index ed371a02..567db557 100755
--- a/tests/generic/367
+++ b/tests/generic/367
@@ -11,7 +11,6 @@
 # check if the extsize value and the xflag bit actually got reflected after
 # setting/re-setting the extsize value.
 
-. ./common/config
 . ./common/filter
 . ./common/preamble
 
-- 
2.34.1


