Return-Path: <linux-ext4+bounces-7025-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D905A774A9
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 08:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99BDD7A2A16
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 06:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA61E51E7;
	Tue,  1 Apr 2025 06:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ0r13/m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD21DF73B;
	Tue,  1 Apr 2025 06:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489878; cv=none; b=oi9oMTyOZkuElANOIRp3ukegKs+ZwyQsg8vIpnSOVR4hpy8+KTpQZbHfTO2YLRb/IPWX4zuJFyRlgRuxvERG1KTiJ2FlzoMgHPF1shmdZiUMxbFw4sl4tx+699E2ThR8LzvA3VhTenXPJst0NfBS6QJwfrIvIOjMwi8ImO3/Uy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489878; c=relaxed/simple;
	bh=Zc2lEsr27B0s6xfSJ9zT2sLdqBUheLY4WYlW6feyMCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qeqI67OlLi9WsaxGUFCNJQo3/Er7KmVA4aoHn6Zduq1TYHiZjXhh5LdkPw/MSSgmYEl1nFdLguJq8aMO4bwqRW8l0HjQv+Nd1IO9BADorR7qtwwU2ykF8dMegy6o1w87+s3C5b5pOU0NN1mjT/LeQ1UlBe4qJNLVqnMoVFBrN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZ0r13/m; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2254e0b4b79so134188615ad.2;
        Mon, 31 Mar 2025 23:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743489876; x=1744094676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc5zDzVBybYJrZbMg8VUhGDJ6JU0cBSoCKd7IYNgcso=;
        b=aZ0r13/mzG9BEgyvbx4ZV28AIoPFUWeVZCgTxHjwTPb2Q9nCi9qPigX+oYs9dii9O5
         gZjQmVKEr772tccgdg2N+jaVGteJ4Dk8/ghRjKw9GB7SBB69GHwi3Uz7i83LrSHBGmTN
         MVWl5S7PachKCkIRU77bIEYoVws4x2XgF7SpYdmgYFxWyJRbPnBTdlVvdXl+XkdnKDsw
         V91wP3Rt17M7fXq73emRgXmcOzzVd0IJ0Wo4NrAAwA+OK3yRPVNUSszT5GHLfjpo82Ib
         Gl33XG2qCMuOteVQx+0EMtCqv09jjWfPJ+F4GdB34K9aqIZjA4KU27iWJDiITu7y3SwV
         3iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743489876; x=1744094676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rc5zDzVBybYJrZbMg8VUhGDJ6JU0cBSoCKd7IYNgcso=;
        b=HlGaWNTstmcslxLb2BnJA7IGyrHO7KBvA3QobWzV/zg/O48DbXsIkIyLO3MHEaBRgF
         KztQJITYOPveHB7HVc2q6bdofBr7qhquz+5NkNOvXEHkUcz+MqdJ1sivBZi0BzoT/gwq
         /gVIugXxuxf/LHtGgWs9P/WugIIvys6BmclV7jq914cpiogaVfHqaogOX0iYRw4q8+0O
         zwX1z/j8RUuBJk+vJlMklnpULOvPM6aDVPoFKEwCGJmJI17liY9lnvK3qTQbjdmhyBMB
         6pIajwEk7WSXDWFvV/98K4HI2qV5ttZ2ABPyntjgd4S4BDoF087FJJj5c2nkqKQ7M79+
         UAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj5EmnRuBCvvZX5/Poympx09qDMztzR1G51gfJcsKGxrRadi5VzYrVLUsj5IPRNYUHbUhHMBizsIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuE2H0pVtje8JK50HaKco1VSLsukK4lewMDPGNdVJb6BoO5YBo
	0OZoMutdg+Yg31fd42lN+I4imrewH8+heM7mGsWG40j1dvs+otKMvHUGdMO7
X-Gm-Gg: ASbGncusoLxzaniPpfve7Lk2eh+IjV3+ROYFqFyglm9ihhhx823nOTRwWeURDO6FSFq
	JKsLzgqgCtllNkODk8R9wEjIvGPcFPP+tYNgSO+hbZf4TwfqspQPmsPnF7R5vI5/Bes9KdSm4+2
	nmTayGkXjD5fn07xy31GlWhCGOIqY25/WnMKKh8VvtEFvib0vi9P1Pw+qPvtwtZ7peTi92sMwVt
	hm1V0Xx9PGyl0rx4BL1lX9UXvNBwjP9GdrfBv7gQVNxeT90jCpHMIUU++zuiqc530IeLfqr0LhD
	5wrfecDnhfwmgYfSSNLrWS7ZKyP++icq9SP4S6Zfok+aI8Dg
X-Google-Smtp-Source: AGHT+IF95FmwcX+babgcTjOMfwHmkuCGnrRxZM+DU3T6zWwpJLWT21a+j7O79gbPY3KGl3BfLneP3w==
X-Received: by 2002:a05:6a00:b8c:b0:732:a24:7354 with SMTP id d2e1a72fcca58-7398033f3ecmr18547208b3a.4.1743489875995;
        Mon, 31 Mar 2025 23:44:35 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106ae4asm8135092b3a.110.2025.03.31.23.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 23:44:35 -0700 (PDT)
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
Subject: [PATCH v2 1/5] generic/749: Remove redundant sourcing of common/rc
Date: Tue,  1 Apr 2025 06:43:56 +0000
Message-Id: <b44393e0f3d6fce937058525bf5726421f7ca576.1743487913.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
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


