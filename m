Return-Path: <linux-ext4+bounces-9394-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41611B2C41A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Aug 2025 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA281BA5C4A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Aug 2025 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6232A3ED;
	Tue, 19 Aug 2025 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHQwHGF/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46E322A22;
	Tue, 19 Aug 2025 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607571; cv=none; b=DWHrd0Z0bhgiH1Z4PyzDbWmPLwq8hpehJJm/ywHQPIbW9RRQqXV/+M2RXY9ZbZZx20RXf3xr8Db+5qbM6PwlGQ/jZqle0WBdF4XkQwUJqbnmmnhIiAiP7tljZkflNVCORVGRcMYKa/6CkTNP+5MP8UCeyDYdv9NtXcwUKGvdzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607571; c=relaxed/simple;
	bh=pG2DqksVXTDv8BiEOMDJb+cN6yI4T+1iuVCpREYgMk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJ0laGKuucDQTLgFMUdsesqc4Cy9o5xhTd9QdvUm4vfbHAh4ZcPXp3AR2IbaWbve3T0sox36QrscV2O2urpS8Vki37qXasVANROgDUydJqydN+/h6dQaQLXveMRoh51lXqOCA5NFkuO8odALcgPXxJq6WbNWafloAk1RD/iCZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHQwHGF/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55ce521f77bso5310762e87.1;
        Tue, 19 Aug 2025 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755607568; x=1756212368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7LOzMVNNMA/KN/2H97VViAKJUt9B2Qu2D9DsKhv2Fc=;
        b=NHQwHGF/HKLBQBuJXPwRDmeLdQvQO/8zsq2F+yxN0GUfs6CTH0v/3wkulMVGf19a9P
         JDOScJHY5RlWSlLBmtjhmZqv93mCQoGhuuAnLgxBBHUqxT48LSLIWidsfR9oNUMWQmEl
         DPEK57PMqAj/LK/ANn5V+wzsMPGT69kcMSeKL5ygCXxEK6Ogf8gqPQBEUG3Wb1vqbpEs
         R7imUYskt8vJh+ajMpipQZq78q86ekMg7AnVN95uR2jvvDFIZJJMomGAgfK1l7q1trca
         dbSLt7khzotCOY9ZiJEl/6GX9GBjYxpIaPhvbJw+5v6gSp7sr6y8B9yggVlK/h4NrIbO
         elYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755607568; x=1756212368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7LOzMVNNMA/KN/2H97VViAKJUt9B2Qu2D9DsKhv2Fc=;
        b=D9HbWlT1pnRgQUwuV4oB5AEh6Ux+vVSEs5xOp7P5hHNQFMUY7vLsKvg5S0MHwS1zQp
         YRHVtd4h4To2Wp3zA2DtubVjdXvMNVpQyqYThWLsS8EE2ZqHBlH5/XgPprfq2zOr8qc1
         IqTl2DDWUoIcRvy8PZ01kMW2h2OZ+D+TU5uO9nBOiT1OEMgE5c6r+oSmfVwvNmDp1+JF
         LGLWhk+sDuAdRJD8BqPMIMYHX7k9w7QPKCmi0ihlHfLdHXmgLD0T31LEIyvY8Q0HkEPv
         MpeRKj2NMIfLKsVNLmkYEbywJjRwdw6HwQH4gta00iOpD70+ThCMpnmO6Kz9mc6NOEI5
         DQqw==
X-Forwarded-Encrypted: i=1; AJvYcCUfU+AuM3iTw6NytEMLAh5ctWAhR3hgP0AC3pxNWSV904/oB6+14YYyUbSPTU77+cRCuQy6fwAPbMalKmjo@vger.kernel.org, AJvYcCVGDN2LnAfVqtiRt9ZhHdwBUEElBrSBggeAp5QdaVUDgwV/dhitK6b299tChv7waa0/lGM1ZsmPdz0p3w==@vger.kernel.org, AJvYcCW0hL7glSZKfWNJIwTEhlGuEF+YyZ0qWfyuDKFcBDkBOr6f8xD4ZKx/aH0erppBp0zHg7rcNtLXHo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07hYALWH/ftKe44S0eB2cjIFtAtnqwBXl9hkDdGmRcm0UdkUI
	yTvwCa7oukgb725rXlYJP/ZCgPJZEJ9Tdr/E7joaXD8JjwRGHjJE5x3u
X-Gm-Gg: ASbGncseoKH8teZLhzecuh7jdt4szgvRb4zPSoeeFo+6QCYBG8+cg75v+O29cYTvqc+
	H9xb8Wduy76G9azKI5QkbkEZix5/IbCKoCMoDUZq0H+Zo+If93sptVolLKgkhh1vHIMi5wc224C
	5aEEasYZBYyVEdSeJqNu8F8Q+nB+fLZHTESuNhLlJbMfshMnIpmwPEkdTtUOOArka4qVt0TSjCA
	CoRXb8BaJgG7fjiGX1DYyijC/arHY9pclugxdnjZko4l5HcjVeF4K8+EKrEG9N4xv/aitU1+76Y
	NkHFdBTjF5QjomDBaGkmLkvAivbl3Plb/MvDi37EjIh3Su2TNRt6q94WhxLJf/Zpqtj2PW20HJB
	Q7ni5me2ez6DpXcR5Z8DVT1dohcLZY+CpCOgrgcMHZD7TKJDarmu+TKtacNiqKrmt9DqO46egrV
	3nfox4ENDDEY/YnC+xkS19MWGe81wgOMfvAXRMMfcYiMXLAX6okabdLQ==
X-Google-Smtp-Source: AGHT+IGuGWV7U/oDcYBoO/dSE1FpDen5x0o2bX2DtOCb/orjQtQT2rTj0HKcoTgezUHktREn8UG7FA==
X-Received: by 2002:a05:6512:2399:b0:55b:57e8:16c4 with SMTP id 2adb3069b0e04-55e0082cab2mr663991e87.30.1755607567254;
        Tue, 19 Aug 2025 05:46:07 -0700 (PDT)
Received: from ip-172-31-45-110.eu-north-1.compute.internal (ec2-16-170-211-41.eu-north-1.compute.amazonaws.com. [16.170.211.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3ccb38sm2136038e87.97.2025.08.19.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:46:06 -0700 (PDT)
From: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	corbet@lwn.net,
	linux-ext4@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
Subject: [PATCH] docs: fix spelling and grammar in atomic_writes
Date: Tue, 19 Aug 2025 12:46:04 +0000
Message-ID: <20250819124604.8995-1-mallikarjunst09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix minor spelling and grammatical issues in the ext4 atomic_writes
documentation.

Signed-off-by: Mallikarjun Thammanavar <mallikarjunst09@gmail.com>
---
 Documentation/filesystems/ext4/atomic_writes.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
index f65767df3620..b614b5ffe76b 100644
--- a/Documentation/filesystems/ext4/atomic_writes.rst
+++ b/Documentation/filesystems/ext4/atomic_writes.rst
@@ -14,7 +14,7 @@ I/O) on regular files with extents, provided the underlying storage device
 supports hardware atomic writes. This is supported in the following two ways:
 
 1. **Single-fsblock Atomic Writes**:
-   EXT4's supports atomic write operations with a single filesystem block since
+   EXT4 supports atomic write operations with a single filesystem block since
    v6.13. In this the atomic write unit minimum and maximum sizes are both set
    to filesystem blocksize.
    e.g. doing atomic write of 16KB with 16KB filesystem blocksize on 64KB
@@ -50,7 +50,7 @@ Multi-fsblock Implementation Details
 
 The bigalloc feature changes ext4 to allocate in units of multiple filesystem
 blocks, also known as clusters. With bigalloc each bit within block bitmap
-represents cluster (power of 2 number of blocks) rather than individual
+represents a cluster (power of 2 number of blocks) rather than individual
 filesystem blocks.
 EXT4 supports multi-fsblock atomic writes with bigalloc, subject to the
 following constraints. The minimum atomic write size is the larger of the fs
@@ -189,7 +189,7 @@ The write must be aligned to the filesystem's block size and not exceed the
 filesystem's maximum atomic write unit size.
 See ``generic_atomic_write_valid()`` for more details.
 
-``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provides following
+``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provide following
 details:
 
  * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
-- 
2.43.0


