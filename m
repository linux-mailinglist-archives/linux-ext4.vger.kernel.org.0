Return-Path: <linux-ext4+bounces-7629-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A47AA78BD
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 19:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CCB1C06E89
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941B4255E30;
	Fri,  2 May 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqJ5OnEf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1581A3174
	for <linux-ext4@vger.kernel.org>; Fri,  2 May 2025 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746207620; cv=none; b=d5YAxOmmspBffhezRZ7NYbbcaJv6z0tSSGKT5fAg5aM3NxdsQ35P3JhB7OopRlIa/F2XcAEbml6gDbKFYr5sXAj1I6jpK9R1ZB+mE7+R9R06iBUVZMo5Y5VOnP91wHj8b/Et1Kyw5h0yH8nU7XnZ7Qv2MciKUzP9jN9Wd9XQIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746207620; c=relaxed/simple;
	bh=OQf5DBNzrjZZveLFbCLTW1PYqaxmpDmD+UYMeLSo6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4wBwj+WKrPDTlS4wguNaIigFuVQgVts5tJ60T5Ua2lS1gEa0Dyva0Gjq2bwfG6aq60YZK/vdjLTJJ7I48zxKgOr6iKcVFylKuQqrZ3SqfbDsH6cJivWv81W7VohJ4lX8of4fPKtSghbcA9567ZNSREvDJZ05ICzU9gh2gqJ3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqJ5OnEf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399838db7fso2625428b3a.0
        for <linux-ext4@vger.kernel.org>; Fri, 02 May 2025 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746207617; x=1746812417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5MqQORpDGnb6rW9RxtQi+w24ATaTq1lRSf11YHJPJA=;
        b=AqJ5OnEf/lWQhltyJNQWf/bdNXxxEE4oM56Q6kyPFTYy/hWse88PSKM+0SsAgqnqHq
         o50oIH4TEHYV1KW4wQPBccVFE9+IMdUq/A0yGH3oHJD0Wq2Rl1819rmEcCCLLuMvyXE8
         BGfObSH/slU9Bn4Ejy7k26PvJGuds8qKFfXE+Qt+ADQspo8NNpsRlX7/+gyLUA5R/gby
         M0XMOwIAzfrxEFB4je7w0kg+SNuAuqt1Yc2t4VWUcmDHcT/94w478C0ozs7c5JyTkF+O
         7cnI3mDbBBxHYzVy2SqQrEtZlKyOp3cVFO7Wi2+3m29GWsAU/5gPaGkY9sSk7v4/I47n
         zEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746207617; x=1746812417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5MqQORpDGnb6rW9RxtQi+w24ATaTq1lRSf11YHJPJA=;
        b=ql8U0hP1c86h5MdT5fsiuxUiSXGJ7z5LLPS16XGL2V1JJHojWKXOXSTpf3qhB5wZSW
         yMXGyFdTxTd9Wqluw6xo694OVz/yrT41xBFbsa84d7vng+8qmhS7WPbz1oEBAQXjc9tY
         76VUoro/bNEz9X9MXMWku0cXPeeqKWnMxt4YQzqkmT8a+lMXF43I1WDlf8hok6jAOLT2
         8B4rPXu1bB3s196VPHSvYlkkJMaLafuJb44gfGsGy/2aGUipsz2NNOQOxxki1dYcCIZa
         VSH8u8H5vdJQUYiqPH5gs9HyrvPZVEEV5C93qYsDrXcTGsmbJV3lPjf1yTtNPJeGSIP6
         QL4g==
X-Gm-Message-State: AOJu0YwDh0TtmdeG43uPgweKxB2FdP+6e+6E8Ks6GF7w5gCvnBH0Rqx8
	e2lNsor1eK77EtQfX7Iz/pp7Uj9RKROWh6QuOiMQxEM2Z0wGsW4V846DSpkF
X-Gm-Gg: ASbGncuaQ4NYco5O0HrxafKrmVRTmvF3vHNGLBDjSYxgDnkeUlvvmq22/YPEOBEINEq
	j2i6fdOTFV6xfnCviNyWOpErwjEKCRGlbFoo/PIziwIFv5tCVuGhrKOlihS5R+oYMDsOKNSRNLA
	4nP0sh+OiVNFYQkdPrjmcmRS4JqlIjWLsHM5SxZj32JzqY1T6t4oKhRrJC7Jn5ZN0BiOQmWU0Ww
	MZthTztN4Kcqon9GP80YGVlo6ua8KZwxvNe84DwCZktQ4bxKLrVoRtm763k1081jVnbAGYHAoNL
	m79FPtF3Pt0aNmLVp6GtNZbZImJwkRAvLndyDbITYW6DTgHA+cCmKszQ0pAXlIbukTU=
X-Google-Smtp-Source: AGHT+IFdErCrnOv3CTaNOF98V8WE+Aot2SM00LNHN6dV7x6sWWfcwtc0sSa1Md8gIHdmDtq+GE617g==
X-Received: by 2002:a05:6a00:8c01:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-74057afb16amr6108355b3a.3.1746207617001;
        Fri, 02 May 2025 10:40:17 -0700 (PDT)
Received: from virt1.. (67-61-129-104.cpe.sparklight.net. [67.61.129.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405909c883sm1858067b3a.165.2025.05.02.10.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 10:40:16 -0700 (PDT)
From: Nicolas Bretz <bretznic@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	adilger.kernel@dilger.ca,
	Nicolas Bretz <bretznic@gmail.com>
Subject: [PATCH] ext4: added missing kfree
Date: Fri,  2 May 2025 10:40:12 -0700
Message-ID: <20250502174012.18597-1-bretznic@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added one missing kfree to fsmap.c

Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
 fs/ext4/fsmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index b232c2767534..d41210abea0c 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -304,6 +304,7 @@ static inline int ext4_getfsmap_fill(struct list_head *meta_list,
 	fsm->fmr_length = len;
 	list_add_tail(&fsm->fmr_list, meta_list);
 
+	kfree(fsm);
 	return 0;
 }
 
-- 
2.43.0


