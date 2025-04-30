Return-Path: <linux-ext4+bounces-7579-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B563BAA4B81
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B31E4C0E07
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3324425A633;
	Wed, 30 Apr 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi1ssARG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8C20E313;
	Wed, 30 Apr 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017154; cv=none; b=I4C1clrayhhcZzf9aL41N7D7veRVpk5i1iJF0hxedrDfACQtcXyqz2USQUxgIPW5GPV3mxpsmpEtXRg5YoAbBV3KFm8qYDZmp4wNsE/rxP3owAwhAhBv6fLfAQUKIHvJ1IUu4hoJ3SZKUI0ZmTAg//wsTCrhF1mt9YetmoG4Cd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017154; c=relaxed/simple;
	bh=NVsE7hVO1uf/H77ZqlptvdKDlPPMyRDz00KnnlFwi10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aj5WG8nCdCQ55x8RE+DOLtzh3b9nMkhLTdLSDogorG0+xnPsOyolrQW6KyJKpdHaO2SZUMm2u23z3H8M+EXSQvbeHzPX88a63GBp7EfvbX99v5ZvKgdRE2WGpx+DRZduRW2/q6rCORv0S5qKuZvz1zx/0GLyPJyhITeMtTOKFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi1ssARG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33e5013aso84745015ad.0;
        Wed, 30 Apr 2025 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746017152; x=1746621952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pphjIsaRNNTibmTJwncIJ2OEg6A9gFCoZbB7xdVwvQI=;
        b=Wi1ssARGr1tkPWwxYXoW3MCIdDMAEf1GzhfbiHRbiT3aL9p5O/vSmG6GDLlZYrwsuS
         OMViw5jm/Lq3vJ2pZ6Ih80XBTuNGU0LIKAl+1bRQ13fr7ZMVcqE5IPH0Tjixet71jQqQ
         a0cMsvPVkhBk9+YpABfoQ2nueGfi1EKmtXEj3elnTsBbFaqagbaUYTVBQy8Ev9f+SIlD
         1cqKWFAksrv0i3sCEy4j7pqoGydxZKoZpVz29QDtAZcbc9hA9nwOmeHSjlnJ0vv0dned
         Woq400dnI8KAFqKMPMCpVR9vsHfad+Cjr4Z+KE1BP/co1qffqMEV86CsUC/1U1WpECrf
         iMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746017152; x=1746621952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pphjIsaRNNTibmTJwncIJ2OEg6A9gFCoZbB7xdVwvQI=;
        b=B+Qc+Nwv22ouDZuzAy/auo83uR6F2AuuFNEc9kTAgZO3lDtIdtgFZz5VVI2ajTuBUl
         HUmXKOlGaZx4ANy7kUAhOpck8Oa+Vnp4MXwRKrWpzrLmgrYIv2E8qkKUKdjp9UqobOCG
         jJDbVjWKaq2D81VfQDRZxrADrpUPlnlrqibN838TlXINZ/gzwEAcGqakiTWDxo05Hjty
         nxfZmiIxRXmOzEDetkoWtZpwvmHigek6ixKprGMxEGN+7A4tsWq2CyauFK+GdxOfdxW2
         W2drqAgb5n3TV7AM2JEpFbQm1SZRvw9FHQE3YN/kzkvVTpRfZpxP0ZtjJz7f61yF8O7e
         R7aw==
X-Forwarded-Encrypted: i=1; AJvYcCU/nq8njHbz6iL/oLy/Hy4AN0KLJbwMNJ6xKonBgs2fmM1esfVDxoJ76bYriEzFoKzI/A6s+PSrKoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiPbZ247ggLPhq7reUTcBxUbJS5jd2RnaX5EWF5+ro0Sep9Az
	dF3rb7gzbGkuJTYs/tk7J9jQsnvtQSWYz5GxKdKKMqXC9O0LhUcXeP7bcw==
X-Gm-Gg: ASbGncsXE9c41lVSgJX/IDC2uw1UsdnaPokwPbCGNQ33kEh3+4rTeGpuR/w8RV4DE+M
	RRvrRnrpyU+ECbTKlSqbhgkgequbfWSS65hFj3+YH69kRF/9ON8G+MMKkQShxXjUD7M9nuPUsfO
	vkdYXvJqQVcuVUQ+UP+7Ael7F+gRdhNzEvK+fJdebwLHsYqsfmxAwhXvmMDZP8tTSXzBfpLp6jc
	wwdx8AKACRxGMxuzYzOK/cxKrJQ4YxSVYcuMvCBhb5nhNRpPdRjs5r68B0TXWbOjqcFNtZJAGGD
	p56KEBiwX/gQSQLx5u6ITdM6VyIkTj9eetUMMXP4GTeE
X-Google-Smtp-Source: AGHT+IG+OALfSwEuAsoPaGzdpFstbT4tZat7x2pcrASYiRCK1bcsaEGCg6Kk9RaUyGo2hqtB3Xj0VA==
X-Received: by 2002:a17:90b:4ad2:b0:2ff:5e4e:864 with SMTP id 98e67ed59e1d1-30a34464a19mr3708560a91.25.1746017152041;
        Wed, 30 Apr 2025 05:45:52 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a349e4a40sm1476540a91.6.2025.04.30.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:45:51 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	hch@infradead.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v3 0/2] common: Move exit related functions to common/exit
Date: Wed, 30 Apr 2025 12:45:21 +0000
Message-Id: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series moves all the exit related functions to a separate file -
common/exit. This will remove the dependency to source non-related files to use
these exit related functions. Thanks to Dave for suggesting this[1]. The second
patch replaces exit with _exit in check file - I missed replacing them in [2].

[v2] -> v3
 Addressed Dave's feedbacks.
 In patch [1/2]
  - Removed _die() and die_now() from common/exit
  - Replaced die_now() with _fatal in common/punch
  - Removed sourcing of common/exit and common/test_names from common/config
    and moved them to the beginning of check.
  - Added sourcing of common/test_names in _begin_fstest() since common/config
    is no more sourcing common/test_names.
  - Added a blank line in _begin_fstest() after sourcing common/{exit,test_names}
 In patch [2/2]
  - Replaced "_exit 1" with _fatal and "echo <error message>; _exit 1" with
   _fatal <error message>.
  - Reverted to "exit \$status" in the trap handler registration in check - just
    to make it more obvious to the reader that we are capturing $status as the
    final exit value.

[v1] https://lore.kernel.org/all/cover.1745390030.git.nirjhar.roy.lists@gmail.com/
[v2] https://lore.kernel.org/all/cover.1745908976.git.nirjhar.roy.lists@gmail.com/
[1] https://lore.kernel.org/all/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
[2] https://lore.kernel.org/all/48dacdf636be19ae8bff66cc3852d27e28030613.1744181682.git.nirjhar.roy.lists@gmail.com/


Nirjhar Roy (IBM) (2):
  common: Move exit related functions to a common/exit
  check: Replace exit with _fatal and _exit in check

 check           | 54 ++++++++++++++++++-------------------------------
 common/config   | 17 ----------------
 common/exit     | 39 +++++++++++++++++++++++++++++++++++
 common/preamble |  3 +++
 common/punch    | 39 ++++++++++++++++-------------------
 common/rc       | 28 -------------------------
 6 files changed, 79 insertions(+), 101 deletions(-)
 create mode 100644 common/exit

--
2.34.1


