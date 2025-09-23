Return-Path: <linux-ext4+bounces-10375-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47685B96052
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 084967B0BAF
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09F6327A22;
	Tue, 23 Sep 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwnl+GsQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E4327A1D
	for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634375; cv=none; b=X+fZBo/oy4owm4O0BCF5ey1DfHlhoOy4ZyO6WDUOVGgUKCGPZeTIVsapgnRiIJqDosbaVQSLHUOpOto/5J7fVnH+ZE43Sz6x+uBj9gHFMun5UxJq3yBE9By9PD/wemVg0UvzAA9cO+rg6PxnEc+TvmYwrxYwCh6pKwYJ/EoaFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634375; c=relaxed/simple;
	bh=0F8N30aDt+Ip9ck/9yn6rnpd6B3yfaEXU9Mdo+Q7ceY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P45wu5hbjO7hOgp7jAOa+o/qzD4ecK4PkmALuK1mSoaagLpx+4aF8qZaFxXCGMlaPSYJBpD+oSw79Cqh9xu215X+/Pu+7ks5gKk6Ke4oBY6PQq/QHDqIznuu2Tsw9NggYJX0f8Nt9SVUoNZWZJmehhMhoC/VQC63WWghRjDosjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwnl+GsQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26983b5411aso39661675ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758634373; x=1759239173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xSpZuIXT8IPaVfu+hEn4+A5NlUoETUpDfjWE4MNCG4=;
        b=bwnl+GsQCv44gk7g28aAIDK/UQCwRuBTk/ydS2HS8N5seFgDuj8P4lP4g5vtu04LPo
         nQdKwJY2nXVljOi8lkEoBhDJ48R5P6YP/Ou+lZtZnVO+JhZy9jr8FUv8XbW/zimR0bI7
         t18CAlC9Megue/WIKV6jBh8JQx2WjxX0SSWu0OimdvjXAS/3w+Nu6ihZKxyP/87taX9c
         +lfIzAG+/lb9M4ZpafB+ukJBopuzySk93ETOU4pNg5JouF7yJS90NnK9VxB34V9dzZX7
         4DdxDlSt6dF7lAti7CQnMxPqN19T1eC1Jz4sAeqKuNfuIDLokjRPcoZ+bRmY2wusLDmh
         7ZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634373; x=1759239173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xSpZuIXT8IPaVfu+hEn4+A5NlUoETUpDfjWE4MNCG4=;
        b=djeXmN8PiFln8iojPy7kQxXQHcZvk0rauC8azn444PQsahay1cl/Vpn34wVY8rIqqH
         1Uj+l4O19OEeDnAsgqzanW8kwccbgYYQhfhzTXSikWz/gH6w1VGNmYoiOyZYRpm/ohh/
         P0/Xt9DAEuOEMhDrJiJt0sxtkge9jcJhQYLW48hI4udI10ifcQQgr3wf9OWEZBeoHepE
         EkVDE1J68HlbZjiJBu1/XT1uigQHnKyz1PVIvy5NX3/7n22qM1ggkjBb7+nq2xIWqcOo
         b+cCl7OzJfx11v8d0Ob3eA3NghtaFRt6X5yJVh78gt6o1yhxunAhY9/gRlEqmrkaSkk/
         2MMg==
X-Forwarded-Encrypted: i=1; AJvYcCUbvJcBR0PtnURYSGWODMjZg6vdSimWh4+CRTycJHHDKIDXm986Ta8N1tn7TFLkF/vh+1uREQsVtYbR@vger.kernel.org
X-Gm-Message-State: AOJu0YzToreQXakIEf5XH/VBHgPGy+Qy9DFRgJkl+bfA30bXifpEehUj
	oLN7HytmuRV5z9S7uN68uz+aAivStJRfrqbA9DD4lHU/NkPIPfUMSV36
X-Gm-Gg: ASbGncsV3vHRFgcaQTreWJhjb/sMLU+RRO5jp0Adlili7mpkzRHegqCTbTeNVazWqjc
	C5VSv5zKcz4mcsiFNB0dfcngCARKT7YlNyGrJZnzzlWIgpX+HO7HM8JSB40Q4DT9jJWgoGotj9i
	ud4FJuXVS/KPK4j1nsCEP7KIGDuWFLFqIm0fHVoJcuwjRtGHuRhNmXNJHRKwv4DQvgCtt1/V+k+
	EsUex9EfmoyVu2cX6bdI7iqwzXFZ0L1RUTqNVduyQyGnPTflcoLelcf/99IhjUUP7b0neCnTq8h
	/K1fdOwOFOOydsll3n1QbugiAQN9ZP1n8AUFusZWt2uJFRNIbSDw2ZKZQG6nfwfsVD2h7gSBwgB
	D1wi37y2DLBFQdaGEhOo10FAuZ9VCeaLTieKkHbCtmJJ47dkcVUAZq3pYBwozwBGnHbiSui02Z4
	lmTcw=
X-Google-Smtp-Source: AGHT+IESpR/eL4ucXZsJRBLa8ofI+j2C8Dox1vR6EjVmyZeEFa5+hb3Y874B7sJx52CTms2hn2ZeAg==
X-Received: by 2002:a17:903:3550:b0:246:a543:199 with SMTP id d9443c01a7336-27cc836c35emr35903835ad.54.1758634373173;
        Tue, 23 Sep 2025 06:32:53 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:8149:fd18:c8eb:ab78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980366b2asm163463505ad.148.2025.09.23.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:32:52 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Subject: [PATCH v2] ext4: validate ea_ino and size in check_xattrs
Date: Tue, 23 Sep 2025 19:02:45 +0530
Message-ID: <20250923133245.1091761-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During xattr block validation, check_xattrs() processes xattr entries
without validating that entries claiming to use EA inodes have non-zero
sizes. Corrupted filesystems may contain xattr entries where e_value_size
is zero but e_value_inum is non-zero, indicating invalid xattr data.

Add validation in check_xattrs() to detect this corruption pattern early
and return -EFSCORRUPTED, preventing invalid xattr entries from causing
issues throughout the ext4 codebase.

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
---
Changes in v2:
- Moved validation from ext4_xattr_move_to_block() to check_xattrs() as suggested by Theodore Ts'o
- This provides broader coverage and may address other similar syzbot reports

 fs/ext4/xattr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..d621e77c8c4d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -251,6 +251,10 @@ check_xattrs(struct inode *inode, struct buffer_head *bh,
 			err_str = "invalid ea_ino";
 			goto errout;
 		}
+		if (ea_ino && !size) {
+			err_str = "invalid size in ea xattr";
+			goto errout;
+		}
 		if (size > EXT4_XATTR_SIZE_MAX) {
 			err_str = "e_value size too large";
 			goto errout;
-- 
2.43.0


