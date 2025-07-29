Return-Path: <linux-ext4+bounces-9210-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB06B1457B
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 02:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9EE63A7593
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 00:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B22186E40;
	Tue, 29 Jul 2025 00:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKBWBRJM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF42AE90;
	Tue, 29 Jul 2025 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753750611; cv=none; b=MklpNtGLjbocbXrouLzkLHLSk23YOCZPidMNIpJz456GcYagiq+/WziGkQ1z1aKzMk7NLrIj4am+WGe0rzMyvUOqy8JzDmOQzkQ2EV1TYz6jVC1m409MOPUQk0/zYYg/MAXpb4xtPtQ9F4lA5+6/7cZ1kpjx38tvVY++z/NIzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753750611; c=relaxed/simple;
	bh=ZRj0BA6FAuWiJdzSHX7Yi5bfqEmLROewvDuAP1PQ8QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjtIYfQgjxCXG78zgg3HQIZvmIukcZ8+Q+pJNBSYjd+TBcoTK0czn8EqJAT4k0CXtZzNUdD22g3FaDv7UUr48Wuct66GWqD0gUM1/Rc5S9GDNav2iIypEhkQCCg9gYh6qasv6RLZWadgsb30QXwxohxBNOKaFjJXRCB6fVHND10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKBWBRJM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2402774851fso17723005ad.1;
        Mon, 28 Jul 2025 17:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753750609; x=1754355409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84J/uTIpBTek7M7s8ekKOao4paiVT7+Ml3Zn33DutDY=;
        b=cKBWBRJMrZwTGH24ClOeDUPsZvOKt9ArYLrDxjTjUTJsepykgGscN+3GlAzozCdZPN
         D+TPqNTZaoRk6ep4yoQvjMx6tu3wSz+uBhlppnFQvl8btVB4nDG1q0lQR50JXYA4wAl9
         6fU/MK+4Rdu80/Gq7hlpAYtr0Ri83J67Zguur5Wp5cz3UGiLyohbJOlpnTOCpeeCng0N
         e97aNLj1NtkU0mkMB3vwhrsCTpRppwL5mNO1trS/8tKDnB9NG2EAoaACyq/v2IW8U5L5
         E09EXl+amJ+kLcH5eThidf/MKYy+9F3/vZJBxoTIOHhD8YuX8/ErDxiJquR9ph5LZ8+D
         PH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753750609; x=1754355409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84J/uTIpBTek7M7s8ekKOao4paiVT7+Ml3Zn33DutDY=;
        b=LzTgRm85R7+3fcgtFGe8nEVRMg8qo1sMOJhLswjSvsgdz77ldUWFJI/Z2+mspYaPtG
         2j555EJD8J0BdeB89Mf3HPnpj7QLHxDxpJwtBvlOwaiEsvjShzzvg34e4lDQL5ExAXy/
         NLajVYPPLjn1WoFLkUDzvGcbqmFgwNT/HMf166FYW8WZRwGh+r0um/Gf9roNcn/tmxia
         BguYjT4KBafYMjGnSkTexTyDu9NSy+dmhQM0YSJ6kYWu1ZHQWcoFIDW2ceqEVO1DCoYJ
         7UW8v7+aC27usODo/wnu4aJONlrvBw+kV2S52XSEUog/f4ogDkkYBmVMP/zZwk8In+7x
         rQdA==
X-Forwarded-Encrypted: i=1; AJvYcCUi4dDvV/XaOP+pjtljnbtxTPOQtXODBvVNl1jXsvY+LE+mMzuCJw2K9KE2fn4aTlH3uQ/Qx3YUPUEUKx2K@vger.kernel.org, AJvYcCV0QGMCafBKO2jxyh+6lXLe1kgJhqMf1YgbpjkwF34pvgJPhEC0hiXdA+pOGtN75vIA2d7pgmmw4JM=@vger.kernel.org, AJvYcCXBaG/uiRpQDQaYuzyqzmkujfvnltWdb7WoLdD6fO5lGPrm7+Rnt4A6own7oLpeau1KIHkT6JuMs/UjNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzutWcwFl39BtsJkvozFa/LVbdn0V3jB2Rvuwekl6mfes0yfcRW
	SH0fizTWhL9Qt7LPoTfG3JiZrkWiXwOE5VkmC9PLJsno3MnU+QZ+hrs2
X-Gm-Gg: ASbGncsBTyWvLWUgSF6bezrrUdCWdhpCgkrYfmGp3b/POFNboDDTANRG/ZkWpZu9UwW
	e1ebTdISPh2VIPXT8LHSCDzbMLdHbzdyjj+CH1L9T2a3PNkuvmBd/7Ce1r4hagNqe5hW9Ynad+J
	CGMoNBR8f51VHnAF3ZT4E2AUSvC84AhxUnMuffHQsTXyp4venGjGtW2dWAmq3Tksp+OvYcnqg0N
	jtMIVPLE0MNmVtxSwUZrPLaLgNkMX4vE8o0Q0BXoBQVx1/wOsDrwITxGaFgNHLpi8Tqfh8W0XKs
	mMnjSWE88V4cwQhUkMeUWBWdf+AntzOABSCoxkGrSY2d/FWWKxQz4izmBTnkaeTxNGKL7lVDDsW
	JcGc+/1U0AtoWWVFbZv40nhfFcPPNgSqcJHM=
X-Google-Smtp-Source: AGHT+IGJKFEVQoBw3Z8VAFR7xi9JSagw5fpw/hROPG/o9WSAO/0cKgapmoBHsdkdUpwtRR23/6iUow==
X-Received: by 2002:a17:903:1111:b0:234:d7b2:2ac3 with SMTP id d9443c01a7336-23fb3029b76mr171942425ad.20.1753750609133;
        Mon, 28 Jul 2025 17:56:49 -0700 (PDT)
Received: from alkaleus ([168.0.235.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff1dbec8esm48310715ad.194.2025.07.28.17.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 17:56:48 -0700 (PDT)
From: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	corbet@lwn.net,
	linux-ext4@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ext4: fix duplicate Sphinx labels in atomic_writes.rst
Date: Mon, 28 Jul 2025 21:56:28 -0300
Message-ID: <20250729005628.68795-1-andreluizrodriguescastro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Sphinx warnings about duplicate reference labels in
Documentation/filesystems/ext4/atomic_writes.rst.

Specifically, the label '.. _atomic_write_bdev_support:' was renamed to
'.. _atomic_write_bdev_support_section:' to ensure label uniqueness
within the document.

Signed-off-by: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
---
 Documentation/arch/powerpc/index.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
index 0560cbae5fa1..ce39b54b5a7d 100644
--- a/Documentation/arch/powerpc/index.rst
+++ b/Documentation/arch/powerpc/index.rst
@@ -6,7 +6,7 @@ powerpc
 
 .. toctree::
     :maxdepth: 1
-
+    
     associativity
     booting
     bootwrapper
@@ -20,6 +20,7 @@ powerpc
     elfnote
     firmware-assisted-dump
     hvcs
+    htm 
     imc
     isa-versions
     kaslr-booke32
-- 
2.50.1


