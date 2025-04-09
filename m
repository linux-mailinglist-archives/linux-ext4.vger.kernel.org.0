Return-Path: <linux-ext4+bounces-7157-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0EAA81DC1
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 09:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1117A4C2FC5
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5321421A95D;
	Wed,  9 Apr 2025 07:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STPJetic"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE8219A9B;
	Wed,  9 Apr 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182122; cv=none; b=mcg8rbWWHLEwel5IyxLGR+VW6/0xVbCadmwbmCpk31unCk9jcDX8fpzVdl0e9eseNrzux8q7J8CGu1IzqSNulbUaWUx9osQU2fDhJ3Gs+2L2qeKkUEUcPBnvXy2G9UC4e+7eBjwcsmpkw2A6gP917nXqp3JCtk3vj5vvY7eVe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182122; c=relaxed/simple;
	bh=Zfz+3GQSUx55Fql1HqhFv5XdXMjkvfseM7DgBQeZuI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JPDdVHI8guO1jZvyWjvKLXb8SxAdy5Aupf3c84J2eEkOzmoHUYg4FIKcIyDPuHhQALLp5j90DgiWhNVBkyJ00MiuYtRh3K1zBeghRsRS8LGA1RotrQ9obTnWyPKR6vtmLCh4cJpzxoH+xdTOa38/3ujCpyN7ejZuiYvV9jNcUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STPJetic; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22a976f3131so37485285ad.3;
        Wed, 09 Apr 2025 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744182117; x=1744786917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NcmqWxmZelBCo9/5Sxwzv6mON4DviBmxND7KxmMmmJ8=;
        b=STPJetic86GymVDaN92rcToJSJF9i6v2SeQJff/0EBbfqvTHmxTb48YTgys/g+t4N5
         jc2bTcLIUzXGwnnx8CkFwOJkiZl9KbETqGPx8LBUWSjFS5UDaEIpJcgfTlaOtETTylYr
         fYVHROe+0ySjMwX2Z27jbe8LjtYja1NVhwND77eAsIjZ/VF8b0oFc5poYBsHtHJk1mak
         xmQr/49dUsTfWx0/1p+8HNI5aERaksYNFU1/Z35M9GIZX4CijyNxfePjO/oOFJxxDA1q
         yOGgBLTTsuPeXkRZNa0U/zse5JKHnt6sT9CrkBu7keLauwd0BkJ3vS1FF+HAgKUXsUoJ
         0LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182117; x=1744786917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcmqWxmZelBCo9/5Sxwzv6mON4DviBmxND7KxmMmmJ8=;
        b=Koz+tbdHLmiHkbJSkIl6ftGrhoLFTy5F+bPHBKLIjT+26+tfw7gozKLN7BFhYvJwBd
         GvjIf7sKW4eQev9A3iU8xcTAdi3qdWG5tygry4Ykost1uTBJSj+myQu/nheGlzuFx7mt
         oRBZJ1P+h0DYy3juKO4bMGS6wENhXSd0qwyYI829Y/jsTJYQ5bnHShK+VEhXEMMiUG2v
         0BGnJ5lVOxWh7Rs2U2OjIOORa4Y6UU4FojRIED49z7W5hBOZM1zO4V/O+ZrlVXCnl4n0
         edpPiDQY/Z9ZSnMBaFaMfEw8EimewVt5YzN8fDaV7KAeJ7mGP/okYEI3oQ2BTzXNiNbp
         HXTg==
X-Forwarded-Encrypted: i=1; AJvYcCWfkzRgQFfuK3egKf+IgejjQ5ih/ZofiFwoSmChHCsrsYdP7O6Yi6Ijh8B057n1a0hQlNrIb8sf05k=@vger.kernel.org
X-Gm-Message-State: AOJu0YznmayWi5okVufqLyi7uh+OAyBnXcCnQ6LPfbT4kGdgegSPgHVW
	QjQVW9DVGKI76sgerjPaS9pFhmWblsXx214vh/zatn++I2+P0RdK+jq3hQ==
X-Gm-Gg: ASbGncvx2nIFLxUuy75B/A8xEILbjzp7Ckj71YgvpveV3EjK+j8dfpI0XuLO/8FysCQ
	0ub9NNJIK9Wj4+uteRIhpfxEh7X5hycokY+smAo9q934wyZX/izYkQJqS94epdUqgrnwAv4Jdwb
	7Y14CqrfBiVxIn5zROWkcZrJpa49is+tyqOSjU+fHaatjp7rV212k34lt+uBt7jMiFY7phmQVEP
	/LANitQoGjg/KhiAm6D7h9Gowd5jVP+Z1DDjL9vQEKMqezPVYGZnR5QkmKpL4wJe4J20WIppEIu
	3BJSQtgS52xMrbXp/So5G1snn31T9+B5JpHFFc4HDOWY
X-Google-Smtp-Source: AGHT+IE3Im/mxkuLYznSvBBlgg6VTKUMGbzeKUcY/MHtp7VK63y0OaauU8eXQCuNSB7L2TeAcZ9fpQ==
X-Received: by 2002:a17:902:c944:b0:224:162:a3e0 with SMTP id d9443c01a7336-22ac2c2f25cmr25823925ad.49.1744182117010;
        Wed, 09 Apr 2025 00:01:57 -0700 (PDT)
Received: from citest-1.. ([122.164.80.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c939a3sm4491985ad.117.2025.04.09.00.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:01:56 -0700 (PDT)
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
Subject: [PATCH v4 0/6] Minor cleanups in common/
Date: Wed,  9 Apr 2025 07:00:46 +0000
Message-Id: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series removes some unnecessary sourcing of common/rc
and decouples the call to init_rc() from the sourcing of common/rc.
This is proposed in [1] and [2]. It also removes direct usage of exit command
with a _exit wrapper. The individual patches have the details.

[v3] --> v4
 1. Added R.Bs from Zorro and Ritesh in patch 2 of [v3]
 2. Updated the definition of _exit() - explicitly set the value "status" only if it is passed.
 3. Updated the description comment for _exit().

[1] https://lore.kernel.org/all/20250206155251.GA21787@frogsfrogsfrogs/
[2] https://lore.kernel.org/all/20250210142322.tptpphdntglsz4eq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
[3] https://lore.kernel.org/all/Z-xcne3f5Klvuxcq@dread.disaster.area/

[v1] https://lore.kernel.org/all/cover.1741248214.git.nirjhar.roy.lists@gmail.com/
[v2] https://lore.kernel.org/all/cover.1743487913.git.nirjhar.roy.lists@gmail.com/
[v3] https://lore.kernel.org/all/cover.1744090313.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (6):
  generic/749: Remove redundant sourcing of common/rc
  generic/367: Remove redundant sourcing of common/config
  check: Remove redundant _test_mount in check
  check,common{rc,preamble}: Decouple init_rc() call from sourcing
    common/rc
  common/config: Introduce _exit wrapper around exit command
  common: exit --> _exit

 check             |  10 ++---
 common/btrfs      |   6 +--
 common/ceph       |   2 +-
 common/config     |  16 +++++--
 common/dump       |  11 +++--
 common/ext4       |   2 +-
 common/populate   |   2 +-
 common/preamble   |   3 +-
 common/punch      |  13 +++---
 common/rc         | 107 ++++++++++++++++++++++------------------------
 common/repair     |   4 +-
 common/xfs        |   8 ++--
 tests/generic/367 |   1 -
 tests/generic/749 |   1 -
 14 files changed, 92 insertions(+), 94 deletions(-)

--
2.34.1


