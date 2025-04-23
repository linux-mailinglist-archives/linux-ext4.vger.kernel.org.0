Return-Path: <linux-ext4+bounces-7400-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06720A97F6B
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 08:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1952189B145
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A3266F15;
	Wed, 23 Apr 2025 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGbgoaUF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD9262D0C;
	Wed, 23 Apr 2025 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390519; cv=none; b=bBsw7/iM+Ae1E0Uo2GSACk8uzTHgY3NlQzpY7UA5Cm3z2OcVZG60maxKOs2l9UCDjhLebrTIK7VyJdMeFdt0mo1BG4hvFJoryYpNZi4doEKSTu12a7KThjF9X9CfjdxVbkPHwcrZU6CREHUHWl3M4UcQp9z//5+jNGwRil0H/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390519; c=relaxed/simple;
	bh=gNnP9UhDoNvjN2vWRsFmLuixRxnsgSvaMRUyEkE8tkc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OBtBrBMaRuuSryPavcnl+C+cgqKVcDUPw5TKgqHw9QphGPq7/OTJ22/nP7MdSMbL4rjlokBA5aLLGt32AGM7RKLIbnbLu1B5UbuRwJqxJutcZJpQekFtcHC64ecZKZNH/9u8INM1iwdLv+LgxOdxfU57LZmD1CiGjcnb9zw26og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGbgoaUF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so85906325ad.3;
        Tue, 22 Apr 2025 23:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745390517; x=1745995317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r/cQteNQi23cybMuFz80bYUiA8SIMrSkJ3aImTZDb9c=;
        b=QGbgoaUFM0wfA9ECGIK0Nb9UgwawHyacJFp1bvK3E6Bh+BS12dYVG8pTgT18dbSsV1
         PPmZ8AZSkzrYcYSF+2qzjY1WBzN2IC12OqEu06IpQxpBzsUpExu3M5UYBMgSKhyx6R4J
         r5Je0WgPlfQdwcX6fpUxyX5p/dZa0JwZrN34cqnGACdhYPnJF9kNd7zv+ifdjr1y5wuB
         /kN/3k2zmJ0tmAdQjMt06F1nLPp2W6iY133eX/hC+b7gt7HJ1KGDlh+yWy3t5g9jyi9p
         r8I3HVsi2hmbeSiCYdkp7DDUluwBhlsitEnqZz0EnSQvHUer/1OAeZQEwg+oQ/ZuE+nW
         K3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745390517; x=1745995317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/cQteNQi23cybMuFz80bYUiA8SIMrSkJ3aImTZDb9c=;
        b=KxUah35Y9+lKNHP9Tl5CmKH6gC6Jw+yQxUGrrm5BjfjAEgohF3cssz+4KtFwMBDxUJ
         BeFhjUWPX/wG3DhpZDODFc3TWYD3bCcTJ8Th7Pxd9M5lLafgrEzxaXvmWYIxPjw1JzXZ
         jZ0ODecNKzh/8QAkvRDrG64QKv5joxIJSH5xX58tt+G8gDFJ19ci0h4UPbdP0rFhaxEL
         Yk8D4VasGtocieV8yGZqkiarqbOjiGQ/0ilE+lPYQIbEuayQmPB97E5nP3fvNmjYjcxM
         ZmPkZt55CXAVdDQ1UZKNN3Mv30dPJ0oNGHxyfhkxYR+MCz3ORDqwXkJ28103209dAGjG
         pFJA==
X-Forwarded-Encrypted: i=1; AJvYcCXAVsUwFcH3mKmLQtmnoDcR8J33cPMGv2iHRvGX+S+th5MIxN332Vq2/IIffWfZC2FcmTBBIgV2L8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi/bdp2WsmXLqvJtMHSl9RfmN2rIEjQNUCjsemhicuLHeXkuNC
	dvSY8K78xtLxV1mP8oRQ0OENa2yelsXGHazpUfaUAzrTVZMqPgksnzv7rA==
X-Gm-Gg: ASbGnctN1jpw2VlSkrKjqN3SkWV3M32sIGzg9TdRMg6niIR64NlKbZj9+sjapVIS3Bk
	j25gOM2H12hU7FjyG/5DeSeY5hTNTwAHqJJjtunvtUrnJvqS7PVwzWlcmjr2xU47RSXnj+BHpm5
	nMXPkWUJ0ajtNUMP+0m9fP6aU+bOKvY22UNFfhY/ApgCOngS1iMg8MP5ECW/bQaz5x3z5ZInNgI
	rQITSQuBlNXyxaGmrVcyIYYuCw8g8/HCln7oIaupyNgYOM2Y+CBP5UFMCuos0v3WE+IJh4CIZCo
	Ao8ypylYNddA8v3VLLt0Hu9cByyQ5SyVKZN6xTb5kz+c
X-Google-Smtp-Source: AGHT+IG3VdjImyBbQpMT/Up/xIwasOkAPHU7VGZtC80fUJv1cFzjEhNbb0BQUj9CvwGaQF0GIMl3qw==
X-Received: by 2002:a17:903:2410:b0:220:be86:a421 with SMTP id d9443c01a7336-22c536050f6mr297150895ad.38.1745390516768;
        Tue, 22 Apr 2025 23:41:56 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9f051csm897705a91.4.2025.04.22.23.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 23:41:56 -0700 (PDT)
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
Subject: [PATCH v1 0/2] common: Move exit related functions to common/exit
Date: Wed, 23 Apr 2025 06:41:33 +0000
Message-Id: <cover.1745390030.git.nirjhar.roy.lists@gmail.com>
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

[1] https://lore.kernel.org/all/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
[2] https://lore.kernel.org/all/48dacdf636be19ae8bff66cc3852d27e28030613.1744181682.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (2):
  common: Move exit related functions to a common/exit
  check: Replace exit with _exit in check

 check           | 40 ++++++++++++++++-----------------------
 common/btrfs    |  2 +-
 common/ceph     |  2 ++
 common/config   | 17 +----------------
 common/dump     |  1 +
 common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 common/ext4     |  2 +-
 common/populate |  2 +-
 common/preamble |  1 +
 common/punch    |  6 +-----
 common/rc       | 29 +---------------------------
 common/repair   |  1 +
 common/xfs      |  1 +
 13 files changed, 78 insertions(+), 76 deletions(-)
 create mode 100644 common/exit

--
2.34.1


