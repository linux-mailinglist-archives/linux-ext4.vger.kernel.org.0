Return-Path: <linux-ext4+bounces-9897-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655FB5184D
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 15:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7A31BC0FEE
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130C3218AAD;
	Wed, 10 Sep 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYOJzMV+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC97081A
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512320; cv=none; b=ulF41gBoyGhryJWPstmBsPnfu+IsIha1UkxuTtG1PAAK+/NXAl2sFXc0C/vwur3oXWmMiczyYf/sLZ7iSGrCPchT5r7lBDAb7fwHw4iB5ZvMJRXHV2hRQyewLYc2M8OYrCXZIX9UIcXidLoKoX6fX41WhTZwCJzKJrZHN5UEe5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512320; c=relaxed/simple;
	bh=2STTAvauX7fQERl5SCAPer0d2icq1EtGIjT3dfw/hR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QGS0barAczlcRgDGfKmHRdkNvz65ysApsg4aU7TkIco+PpZQ/IB+5rjnLc3Jw1niC1UKMTTvL284X8rt3ZXYJfSi6AFauqS44Cbu2Q0Q+i+vKoP7xttaLfg18Kp4NuZ3PYiXHJ2uB4sO9IP5jLewZTyfMZFL31sUDqzHzuaPTX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bYOJzMV+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70fa947a7acso20351926d6.2
        for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757512318; x=1758117118; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wd6JiZJGvnBinzrnYkrwSSu7SsGH1PKPgVnKbOlzro=;
        b=bYOJzMV+zswRJPaUz57FuIz0cYfPjbtMnfVhP0NqgfFWvYWAQ7nQs6K7dJhpgPrYPm
         yehLsnIa53y57zfP5Zw9sCE8KJ8iTQ1c0KH+/YrePgdxj51vgWYlp77ye2HdAzVDZRHo
         gqRJu1xGO6bJTCcdIT0FhQcID1fTs7SdZOyFj/AY5h3b1gQh6SbOTzBnNosCVldiZURx
         HIXrnpKARtMSbZEgkHtchVIWzKcr1VJMP0bzL7pYPhCDQryyQNmu88wEJVKvseGANTbJ
         /815lE5Zolu5MKE4G5559eN0O9xU944bCxNhDW6N7LHLglpdPCuQGr1t9pk35sfupnUZ
         A9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512318; x=1758117118;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Wd6JiZJGvnBinzrnYkrwSSu7SsGH1PKPgVnKbOlzro=;
        b=xIsJEYC8n22YBw2kMzVZbwbFqFNit322ousbDqQfC1+Tk9x5zznX/wc8MvgMqrwDup
         Ig4Fsj6gPMF6BWenJDJkDg9vSWSxUmEDncq8uAmbSTnd0IfUHePfk5ElYC4xapjRRUpn
         3XPK0o4naAOCbquj6fRaDbnSe/Ok8fhjVL1yrvFTbaumCXnp96GtuhGSdpP/InVKafr4
         GHDRQMHUrK6AyuH4jKXGhtLr3sbePE3F8bbaxuhfQsJQZSsl8iABkjovZ65r5NdmUMXe
         SJf6XxCfni1XkEr6CFq26ZOqx6oqSqo3DhqcCdG397Q18H4ms/fl26HQZzkFil4Bswm8
         EEKw==
X-Gm-Message-State: AOJu0Yy1JaHKtaqv7ZlyfKxxNkkJNdXp0FRGZIzrjpDrR+L6+snf2a9y
	B2RAQikUTqs3QTZeNUdLjmWiavQETUWfZInn6ppiM3HYfCs9INnzU78/TT3SecZY4uM=
X-Gm-Gg: ASbGncucKDwLtGlHjSVSmBWS5kamAasL8GL6SwfwfbZ7FnTBd+MHsPyljeO2r2CZGl+
	+S4k2jMPR/TD+nkhIFP+BUYDgjPnKPiN9PhaLNiIuSHblXkfvV1/PNqSygiKqOs6z30XzP9P/bY
	vA63ciQmuPYUgDT/DmJh38b359KfGTgmH71df/GRYZhAR6YAoIF1APSJPVbfQZt4oLO8WjiGwpA
	Qv17l7K9TzFotTAI0mP5PQPdwPfoTF0GnsHPIaoy4XiACDcnZHGQakQhWMFJKnV0/lheKtKo5gH
	/GENH+mmuF+PJv05L3F4SUIZkHodNz2iqQVdZNZzda4Df6wKg7f2VcgL3oyeOmZEFc/GJryV5PB
	rVoM0HfUgjXYdSJcC4A0WN2pd2vqm9YX7ff0bvQAow9Fw1jUUyGLQbZRI2oQ=
X-Google-Smtp-Source: AGHT+IFabN7VLL271sk2nVxBsmzX82xCBcsGQHGQ3ogjpUabo1H4GpFuZd90jgzur7PuRAMaodpWPg==
X-Received: by 2002:a05:6214:2627:b0:70d:e83a:4b86 with SMTP id 6a1803df08f44-73924e24a38mr166149206d6.17.1757512317791;
        Wed, 10 Sep 2025 06:51:57 -0700 (PDT)
Received: from maple.netwinder.org ([184.147.192.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7252d6ad05asm137500176d6.62.2025.09.10.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:51:57 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH v2 0/4] mke2fs: small doc and features
Date: Wed, 10 Sep 2025 09:51:44 -0400
Message-Id: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCCwWgC/32NQQ6CQAxFr2K6tmaogoMr72FYVCjQCIyZGqIh3
 N2RA7h8/+f9v4BJVDG47BaIMqtpmBLQfgd1z1MnqE1iIEe5K12J40OoNbSRhwFbfYth0ZzY1Uf
 2Z59BEp9RtiJ5typxr/YK8bN9zNkv/Ts3Z+iwLu5MPifPLV0HnTiGQ4gdVOu6fgHLk9I6tQAAA
 A==
X-Change-ID: 20250909-mke2fs-small-fixes-6d4a0c3a8781
To: linux-ext4@vger.kernel.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-56183

Four independent fixes for mke2fs:

1) document the hash_seed option
2) support multiple '-E' arguments 
3) add extended option for setting root inode security context
4) minor indentation fix in man page

For the third one, the main use case is when generating empty
filesystems for use when SELinux is enabled.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- multiple '-E' options are now supported
- added 4th patch to fix man page formatting
- Link to v1: https://lore.kernel.org/r/20250909-mke2fs-small-fixes-v1-0-c6ba28528af2@linaro.org

---
Ralph Siemsen (4):
      mke2fs: document the hash_seed option
      mke2fs: support multiple '-E' options
      mke2fs: add root_selinux option for root inode label
      mke2fs: fix missing .TP in man page

 misc/mke2fs.8.in              | 19 ++++++++++++-
 misc/mke2fs.c                 | 63 ++++++++++++++++++++++++++++++++++++++++---
 tests/m_root_selinux/expect.1 | 57 +++++++++++++++++++++++++++++++++++++++
 tests/m_root_selinux/script   |  4 +++
 4 files changed, 138 insertions(+), 5 deletions(-)
---
base-commit: 4b02eb164221c079b428566499343af2766c2ec3
change-id: 20250909-mke2fs-small-fixes-6d4a0c3a8781

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>


