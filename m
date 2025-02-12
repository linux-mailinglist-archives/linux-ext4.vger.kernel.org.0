Return-Path: <linux-ext4+bounces-6415-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4E9A325FD
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 13:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E00188916F
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398120C49F;
	Wed, 12 Feb 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPXZCXyX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C52AF4FA;
	Wed, 12 Feb 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364032; cv=none; b=BgfcnLIe+nWekzVhK1+Q11VjSxSQmN1NhdRfWE44fON43rELDl8i7M7x1dRcrjVfJjhUtRKJuvxCfy5kqELKLN1of6n6nszxMS+DXiyMbV7d5u3aB9wzxItjSjYjqXNn9DoM0Z6k1x64Z0sEM+i8mAyGkd+L9Ag+9YR+uFpU154=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364032; c=relaxed/simple;
	bh=Bq4+zZztcIQcI/ndMfJ5zJTOs0V5iHKYPY51pgd6qsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ultY7PUUAgeRxnG5o9sllS1yIlCXHuXdIch+E6HSKrzJlYVrSZuZNJq2Ad6cjODLkXHuzdtNEk3tJGj6P0xW30t/LyWp61gi2rtRevEvsy5lpv8meO8riEaCLCuVEfb41rDU8/rZ1eKx3zw+4tByl7Uq5C8FFWTnIQsoVKeNeFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPXZCXyX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f62cc4088so83165535ad.3;
        Wed, 12 Feb 2025 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739364029; x=1739968829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ltKXuenJlaM28vIR5+u1MVdMUSKPqW7I7Vq78XmxXpg=;
        b=XPXZCXyXdvpscbVKywlv2sjrbxIs++Eg2/YUg2a7y1qwlG7tWeQMqpjRuXdyeZjn/c
         EqJx+qHP602E6QJeNyhrVTuWST/v0EiGfIzL4G94isFoAw3lVDDBtDFNktSyHWN/MxJB
         rJoILrLoLocb/gRpAVSNjciJpPVkN0tTHLQRxYdQFhGmHTHfyf7UJfJtmPru4UxBoQl1
         StfDOOWCQ4KSxgZI6Pq6bmEKceiMudiEvcPzzP/mqOI9fcDG48ZttFU9tSBC/k6MRkVI
         NY3q/dam3qJJ2V3sMe6W170hqRBrB9MTH9tb4h4MHuJxn0OQ42S2ofS0L9xADJ2GOPck
         +Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739364029; x=1739968829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltKXuenJlaM28vIR5+u1MVdMUSKPqW7I7Vq78XmxXpg=;
        b=FesLG6WZwJpZwdjJfB9XB5POw4yLzSaZCjyNmQScCm4x6taFcoNdxvkseFnqtL2TS8
         gd0L1DtA+orD+e5IgEZ346HgPmivKn88CrrkjRWe2zvChiBuM/23GrvMtGu0SxS3Xc4p
         7lnwEvlnF8MczTJtsIZscGR7qdwLo7alQkUa8i+6GIHopRz9mdyDfEUJwvAKpKDFkxTB
         v0PQnEc8hf2EurfFVFpKV3LEDRTiYFYw4YVIuaExBLJ9MjgvIdG+rnhurfwug/R/pyX+
         lecwd7WitXmJrEjbC30/yPHw9YcFkt5BTwb1rsntXV+j4jmRWIgMtWfiFFzfGtIaKsYX
         4mLg==
X-Forwarded-Encrypted: i=1; AJvYcCW+SHDdaI/dZmF8RnXA1Qn+SoiK+FuN3XK8miC56CoDCzmrt/IbVcAPinPLiSNPrvOSsiPbtd4Kx3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcYL4MiBfhVtW022FLrwM8IXug3I1AaZ77oxLUSsqrqKd71lP
	Ylhy8OxqPKVSV6w8GeZ9bfLBlCwXy7sXWSsdPRPPiyHmcIrPl0+kWhH/8g==
X-Gm-Gg: ASbGncspRo0Hyq/QeCCu7UGPdvxkDJJQDxvalGaRJsNpMz9tJWcX32G2i6D+8yypmDd
	OdlwbgRkZEwBPe1/ziIMQyy5umVBkSjR0bAMl53ZON08ElYwOYe+QH/mG1Q4ksxIHDYAno/o2Yp
	FywggRZqYXkTq8mo0qZor5ABSYe6+TKTfhah7wlWQWjqmGgAjzU3EhqzX5c+5UpYKg2fdKPoBk2
	BLhd6ActaLGFuuQLgRHAbXAT9A70jGzzAC2VsABJyxT0V7awMVA8YPeZ2V09VEGm0sCUb5XzuNe
	ja9d9msdO3t1ZviQ6fs=
X-Google-Smtp-Source: AGHT+IHqWkfPA6IVICXaIamAI+n7gujbghUv3jo300TeaPgC7dpYCs1FGJIRPc99aZG4aQzg3gea7A==
X-Received: by 2002:a05:6a21:328e:b0:1ed:a6c6:7206 with SMTP id adf61e73a8af0-1ee5c732f18mr4967757637.8.1739364029511;
        Wed, 12 Feb 2025 04:40:29 -0800 (PST)
Received: from citest-1.. ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53d0c0c19sm6468484a12.57.2025.02.12.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 04:40:29 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v1 0/3] Add mount and remount related tests
Date: Wed, 12 Feb 2025 12:39:55 +0000
Message-Id: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies an existing test (xfs/539), adds a new xfs specific helper
function and adds a new mount/remount test. The individual patches have the
details.

Nirjhar Roy (IBM) (3):
  xfs/539: Skip noattr2 remount option on v5 filesystems
  common/xfs: Add a new helper function to check v5 XFS
  xfs: Add a testcase to check remount with noattr2 on a v5 xfs

 common/xfs        | 13 +++++++++++++
 tests/xfs/539     | 10 ++++++++--
 tests/xfs/634     | 35 +++++++++++++++++++++++++++++++++++
 tests/xfs/634.out |  3 +++
 4 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100755 tests/xfs/634
 create mode 100644 tests/xfs/634.out

--
2.34.1


