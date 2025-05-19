Return-Path: <linux-ext4+bounces-7963-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD74ABB4F1
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 08:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903CF1893994
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 06:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1F6244672;
	Mon, 19 May 2025 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQKYst6M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12968243374;
	Mon, 19 May 2025 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635433; cv=none; b=sLOzyEJ+y7+EiomPdtsd55zqoP5ZOUE1ZdRwhJ9Em+Rlo1mZXDlTOWnUMUHEMfnHDuh/nK2zso3GRhrlsp/eGgASJ0SLKCg2ZJWrl8moRZ2oHVk1hH7aXvXXZ15A1WPiXWPCyyxilBZpWbYST5hP6m78Dm6L1xgPk8YGMwgKxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635433; c=relaxed/simple;
	bh=d7dO60/1wbgHIvcSIPVvbisu9fIWON9zoH+EUQNB9u0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZpcumK5u19U41gRKHMKJjQBqDL+MUikarHL3ALzITg14nRLXXCRLP8JUjEzZrNTdGPQ9/gIisBT3NihdRovN+8lrvYRMY3I+BwIyFcrKzA/HBgmuQrUMB23tfVG1H2W9ghoYmIWMxmQCg0nFJCGBtPfqIwea3umdPrmLrB8J0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQKYst6M; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b200047a6a5so4461435a12.0;
        Sun, 18 May 2025 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747635431; x=1748240231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xegv/gF/tQ6fF9VYglXwKgNt6/H0qj0lf6CHPVMVv/k=;
        b=eQKYst6McBtc6boXw1j7HxH7mn6QqYGwBlo82/SgNF/K6nYsFtU3z6JwClAu9ubYn5
         H4Pc6hFJgVF2F+33xUDywfm4WQZ1wfeBM+vvRGHcKchnHgm6Q8fUizalim3EgUomgPRj
         LesyJZRSsFj1DsKNAL/CyQ07kpZmooZxVL8vEyxOVBHn3tDAjJaj4W0xzUzCQj7G9I/z
         qQUS1h6JfUafkvsqAWiQtT6KbrFkgFp7ePBmyuGIuA6mcvHUr+jenYXktNRSTJR6P/j3
         TcLrE+WtMiY4Dc4HQRdP42khmjeg5++HQPV2Pm54NwZJEFxQ8k5Z2q6wv0P5gpzscZ+Q
         fK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747635431; x=1748240231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xegv/gF/tQ6fF9VYglXwKgNt6/H0qj0lf6CHPVMVv/k=;
        b=OxoO0cNk++Thkdjbz6Bjuh7goj53AIqQWD9fvGnefw9hWpYWVBBVr7xnSJrI2IQRPc
         bSvAampPr0e6jZIfXHPW/SY9jrnPmpdZ6jxn12YJt/ISomTHn7GCxMF3CwM91IAi05b1
         w/444yimMHFJ51MQ4KGaWbeR4e5K6MYKcOwZTc+8GpapdR2IM5wXRIWGDZj2iHpq3NeJ
         SislJu+w6SfBq8maV5pdLa4ETkQIKDvwpoB+vDCvz9+jryOhJ6339LROGie79hsE2FFE
         AwzJWpl3OGQd8G5/tBfiyEhettfsKsLo2dcTQqjFsBricJnPuil00i9ffjkdsLjDEm+l
         t/2g==
X-Forwarded-Encrypted: i=1; AJvYcCW7LD4Vujw5dz6LpFmo+kap3N9bvrcBG5ilGjKNV+hY8PZX6pZwlZw1SPgKp05DgBaAfTooDKceTvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJ4s08kz8p1Fk7Dvtm7F4V7cOCWxo/A7pqMjPkxJ9da6lVgHN
	8m+1/FfABSLexUfjasWkor78Rq4tcEnHr4bWDRjKtlUQ06JdCnE4RwugN/PWeQ==
X-Gm-Gg: ASbGncv4MPHib8z8ksS4O9v4dG7PS+5VLFL8rLx1brzxtSBt01kRI4DZvHBeMn8vYdU
	PTmZSjDPd7nOrho3kq8gZsBHkCEldTlYHMv3GZYZBoxOgaxmCshCJnmullLCENH1bM9BurFLelj
	zOkbW5QrKSjlWe/jHzqMEopnXMvZ1L6qc6oQ+9wItTzqZ1a7P3EbDO5pPvVbEoqxrtU/AGAxQtg
	xy/dgEhjjyGF1UuVdTCV/KoEEtkfDjgwFtSvssEY97W6ISqSiaiX/vJoYptd+TSoLCmV2HPPsRx
	5yp2fLYf82ziWBqzJ8wY6kXOR+mPEnmZWt5HGdH281kovPhxAsbbWg0=
X-Google-Smtp-Source: AGHT+IEl/K+LaezsJu2M/Nn8u3QAE77OIRh207aXSnzOEm0MMpg2FT/4mb2I10s4LG4mFzyAC5XvUg==
X-Received: by 2002:a17:902:e5d1:b0:224:7a4:b31 with SMTP id d9443c01a7336-231d4b05b02mr116589025ad.6.1747635430576;
        Sun, 18 May 2025 23:17:10 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2325251da10sm6939385ad.42.2025.05.18.23.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 23:17:10 -0700 (PDT)
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
Subject: [PATCH v3 0/2] new: Improvements to new script
Date: Mon, 19 May 2025 06:16:40 +0000
Message-Id: <cover.1747635261.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a couple of improvements to the "new" script.
Patch-1/2 - Adds an optional name/email id parameter prompt to the new script while creating
 a new test file using the "new" file.
Patch 2/2 - Replace "status=0;exit 0" with _exit 0 in the skeleton file in "new".

[v2] -> v3
 - Modified the commit message to remove "email-id" from it (patch 1).

[v1] -> [v2]
 - Added RB of Zorro in patch 2 of [v1]
 - Modified the prompt message for entering the author name (patch 1 of [v1])
 - Removed patch 3 (Suggested by Zorro) of [v1]

[v1] https://lore.kernel.org/all/cover.1747123422.git.nirjhar.roy.lists@gmail.com/
[v2] https://lore.kernel.org/all/cover.1747306604.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (2):
  new: Add a new parameter (name) in the "new" script
  new: Replace "status=0; exit 0" with _exit 0

 new | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--
2.34.1


