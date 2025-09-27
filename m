Return-Path: <linux-ext4+bounces-10455-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364BBA5695
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 02:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C352A83C2
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 00:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659111D8A10;
	Sat, 27 Sep 2025 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4rjcdoe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A991D5CC7
	for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932369; cv=none; b=FaG0ZTl/DrSS886Q3yIq1vYlk/NtHF7bVzPHqG7b1BOiYaCOs1X+W302v3QEW+fb11Cbj0c0d1cOPf1wILa+fk2sfgpuZkeKYYNWk4IQD2YGALYwYQlt3QL/NuHz3/Px6OnhQaS01YXiuWMwYUsBPT9M0YWJpqvsXtY4PelqaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932369; c=relaxed/simple;
	bh=OCMM1i+marxjh6pUkwTDhMRBuqlU+02sLHnJrahSSHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQxsuVOvV94VS0MYy3OL9HQe//fkRHGICIAoSEaIMjSAS7gbbVqeiHiJ6lets4fRwzrAK5GttejUpIQSAJXpJF5TzHLswyh7AONP23I822uSvfNYHzlLzl44XkwrgjkA4nEP29QZcRCuimYijwN/cVREb/7InkBdNPHxot8MCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4rjcdoe; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77db1bcf4d3so2034891b3a.1
        for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758932367; x=1759537167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoCdX6M4UpRUuPuNk8r9g0MkweOF1WQ1ahjsQ+1be2I=;
        b=S4rjcdoeIs9jU0BTqiLrlyb6a/8aqICebB31RSHLaiZRy03SFga1DOK5U/bMvY6U+G
         VLwVFGDTM43+zcEV3sczCU31T3QEAg6fjwU0PbkNWMi7utPrfZGV6RX7g1CM/F08C3PY
         QP4Gf5j0K/EJmJppZuYcUgUiB3KBmtC6wo1bD+4e7tvXNpx16kovq9/Mk0YKmsjjilTG
         m2BUmmySeUd1d3mMhQddIMJnDYt8DPyEcbsL3zNOA+rBBlLcya/r1stbTtdE2AYQtQCq
         2Wa68STwkT2auO/NFIPq5XXAT53WWXM4x2O2Pl9/WGhSZd0ohgYd0+rqkEQLSLwdkM2y
         Z/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758932367; x=1759537167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoCdX6M4UpRUuPuNk8r9g0MkweOF1WQ1ahjsQ+1be2I=;
        b=bQc1AgEvHH53EwhmZpAyyS5DLI9rl2VUQU8PzMd9U2MuSc/peKuim7+ARcoMPnCuFz
         AIZerXCKHi68NF5ZQ+yLxcfu/l5Kg7lR3R6U0HiStvWw9X9GoaUCxFJI4X+lxa1Zrjz7
         vW0p7zgYxiiiqlOMbYNhZtbOvYxO8qU5THhcFlK4mmucGcN47eaVToZw0ejJfrmmJM1H
         of2utok3z19rkv8cAseEPhL6wE0pywJL3lBIukA2Zi9NPGd8Wk/+LGTwcdWFIkulghUH
         fb+cWk1LPbejc6bjRMKrMQSGmx5kxyzCPMFVDSJi4cMfTHc2kPjzRddADEkVWhEOLWJL
         0PRw==
X-Gm-Message-State: AOJu0YxGcpuA2WxQtaLt8s1hnHE2B2qtt6T2eB1i9+iWFBpHIhfGvqu/
	1IA1lCxWhI37+slwB0rSsid0IAglE8gb0McgmthHG6mzXjzwM7d94OQo
X-Gm-Gg: ASbGncvjmRrUzoS0lZ1SHNpag2X2Ty3UFmYi8pn96e950n2MQ1OY358P8o8kWbCL/UN
	Tq8pWFAA6E0DrR6ds+ojQWUvm7ew83K5vXfF220/0xcawYUJn7QTH5Yz3idOtQAk7nW/ct97iqL
	+FT2l1NAhiMkzYIahTrKPdQjqZ56T64hL+OoV1tfhDNGN73Y/0UQi+fn4LdYB3HrRjHRiHysBSr
	2Qf5IwU8rqBChRoRDgu1Zr2x6UBYinB+RYCnJ6K1NLzORkfBrWx70mwjqgoLIAqSUMg+8p7xJAv
	dGNVHXAznZ4n43jN3Rcwvab+5y/S3WEPYG9H2LBlz279JlmJ1NLGSpNicFjVo4Arhgv1TBYbssJ
	Aj8rDAZDyk9wa6Ob5GQLoQPTpLk3Wn2Jin9CjhwKZDOiuy8sG5QAZ/KWvCEDb1QiQmS9a9Oan2y
	rS1SV9zLrsViZx
X-Google-Smtp-Source: AGHT+IEGXz9nq0dyTCKbVTjjCxNnClX5GvwmdbGRHAf5pY+Z3ZHeyoRmROyP6uUGmVc5qJYOutyh/g==
X-Received: by 2002:a05:6a20:3d85:b0:2b6:3182:be22 with SMTP id adf61e73a8af0-2e7cf2bee47mr12013101637.31.1758932366792;
        Fri, 26 Sep 2025 17:19:26 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9584:386:9d60:7b43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c26d4sm5454319b3a.37.2025.09.26.17.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:19:26 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: adilger.kernel@dilger.ca,
	tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Sat, 27 Sep 2025 05:49:21 +0530
Message-ID: <20250927001921.16747-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andreas,

Thank you for the detailed analysis of the tradeoffs.

Looking at the syzbot report (https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d), 
this WARNING appears 4 times, so while not frequent, it's a real issue that occurs 
under memory pressure conditions.

Your -EAGAIN suggestion makes sense. The approach would be:
1. During memory reclaim, use GFP_NOFS without __GFP_NOFAIL
2. If allocation fails, return -EAGAIN to let reclaim skip this inode
3. Preallocation cleanup happens later when memory is available

I understand this requires modifying the function signature and updating all call 
sites. I'm willing to do this work and properly test each caller's error handling. 

Questions on implementation:
- Should callers like ext4_clear_inode() ignore -EAGAIN (leave cleanup for later)?
- Should callers like ext4_truncate() retry or also defer?
- For the unused "int needed" parameter you mentioned - should I remove it in the 
  same patch or separately?

I'd like to implement this fix properly rather than leaving the WARNING unaddressed. 
Could you provide guidance on the preferred error handling for the different caller 
contexts?

Best regards,
Deepanshu

