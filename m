Return-Path: <linux-ext4+bounces-8170-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C516DAC041C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 07:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 081BB7A2B71
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 05:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2C01A5B99;
	Thu, 22 May 2025 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSfcwQc8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFEEC5;
	Thu, 22 May 2025 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747892637; cv=none; b=WJULnHvsd69HgWvzt8DgwFtxeYcraJlJpCdYKSnxU0EGpQdMgAi3Xejl8m5BLS3wSgkKKgxLgp1O9SNTlnzksWIjyuv3DhLvwQrdiXrub86dkpTRR0xGa1wXmLuZT+U5T1vfBjhxD62fw4I2CmHT7/9NIY0Cm/UYgIDKV/1dB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747892637; c=relaxed/simple;
	bh=nksCx2JfS9V5Fy3DGK43Fm4FO+o5hURRPGXxJl463w8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nNYZ6dIcTMHo+Sf+4mMhqeKL1GsgCALGwP4SK26PeDaz1C7Qfy0FqgGLx826FxjHaMvvaPTWo0wxdxl5TJP2cLGGevIzoEk5FhJUj0diM+CNMlezFWWRpGDaU9PuSj4woMnuFgS5YRy1stUEyhEbJ2dlUO0nmn2e4+5m9E12xQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSfcwQc8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af548cb1f83so6549455a12.3;
        Wed, 21 May 2025 22:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747892634; x=1748497434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=loqmhv43lJ9dk8Zh08+A6fcRZq/o0qPZYP3D6MWZIUI=;
        b=iSfcwQc8VMCDfs02AtV58GAr2tVmq77Wp/iXo/GjRqG6Ol1Na0Jt9iAYL/Y4UwYMQo
         Bers+aWl9FkL/pZmyf1lofR6B243FljV1DzxaVOp1/4IspEls9YAic7X2R/T1cPhCnfB
         Dc9RJ9zyi6S4NyKPg1thnK5E/YXuImhdMwDRk3a1KurfMnKKeo9OeAWSkBlrabjrcePF
         uo0J7cbWVPPsRDA0Rzj8y+UDybqxOprvK/Mrcp+C2xKjQcmADHZQ69hE1ETK5Pzo4K1Q
         iICW8XEgc8E9QSqWxCACaqe1Zz2IAF3tRtqETYJXR9xXC/cnfmyW2wZyE82D2vlAOiFz
         rDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747892634; x=1748497434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loqmhv43lJ9dk8Zh08+A6fcRZq/o0qPZYP3D6MWZIUI=;
        b=FWYQ3eyhSaU9gpsX1uAmXwUqZKaR53fl4JlIuSALziKPjDrp3PUT/KXUgm7oowrbo2
         Aa2aAKHnapE83YSZKYOE/H3gDBcxX2oRoJ5jObWfuGzQMNkNDhPXH8dRdS1wFYV6P328
         ohUYqqcA+aNyDK6CTLhDLTWRES23Lf9TL3shU/Wc/qX9lRTnWBgDHV6Hfh0kkoJ9mzge
         XV0GN6dj52Abhd8tQ2eb+DA+1PpkJFKg7PDmjcB68dOVKwY6LxrfJ7kGTri7rmxUv2NF
         whYeD+Ikgw+dtvbdUj9MfpQ1TYsQDelmp/EH8LirbOZ2om4ZDwqBcc3P+YBLmGQOS/vJ
         OPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFY9Tssdk7nSN6SFuswWZ7wwqVQsRia7r0keCmb2OUPkJ44K1dgMXnXAWSv3cGSV06TVQIOeHkfD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGcbL6+IZ1294ZTioJ4qw3u1rDpLCFvtPk4kQeiwSYiJTIitI
	RcC42/jE5CenJiv3wVF3/8s0S2q5VB+Be9n0mYzYzONl2BMSvDn7ceyGucr8LQ==
X-Gm-Gg: ASbGncuKgheVAlSOD/iIFRLanDI45q4XODFQA5V6dcmkPIFXQQnVI2/RTZJ8PST647W
	5s9F0imG/t7dlMgnT/ZhLOyr58pbvLjYhOncz90cQ71UDVn60hW8FIq8Pzbq4wG1Z71WgSOWJby
	dU36jDrGC+zJuTO4dV+iaxKm38eIAkrC69o+ss1AOTTeJll2PebKhe5e6JvJNdaeXh8Yebvra9s
	Ha45r9bn1/PrA8cPBcNsqkGZvIo8Vnt78V71xT91+Y/p6Hu35OgxTEzleNEnvqeBc6rX1kW7ThF
	ctVibt9mRt9GcqFnoDyj6cP8+6wcM5cYBTv+sBfsRcmcNIA0mKeysg4=
X-Google-Smtp-Source: AGHT+IFHLooeuM+j//+AOEHkUO7ROgKbe1RcU54BaaFG2Ire3KR3wRRAkRpuUpegVaYPxGda7mVpaA==
X-Received: by 2002:a17:902:ecd2:b0:231:d143:745c with SMTP id d9443c01a7336-231de35f0f8mr285713365ad.13.1747892634089;
        Wed, 21 May 2025 22:43:54 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adb73esm101577865ad.59.2025.05.21.22.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 22:43:53 -0700 (PDT)
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
Subject: [PATCH v4 0/2] new: Improvements to new script
Date: Thu, 22 May 2025 05:41:33 +0000
Message-Id: <cover.1747892223.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a couple of improvements to the "new" script.
Patch-1/2 - Adds an optional copyright-owner parameter prompt to the new script while creating
 a new test file using the "new" file.
Patch 2/2 - Replace "status=0;exit 0" with _exit 0 in the skeleton file in "new".

[v3] -> v4
 - Modified the prompt message to "Enter <copyright owner>: " (Suggested by Dave)

[v2] -> v3
 - Modified the commit message to remove "email-id" from it (patch 1).

[v1] -> [v2]
 - Added RB of Zorro in patch 2 of [v1]
 - Modified the prompt message for entering the author name (patch 1 of [v1])
 - Removed patch 3 (Suggested by Zorro) of [v1]

[v1] https://lore.kernel.org/all/cover.1747123422.git.nirjhar.roy.lists@gmail.com/
[v2] https://lore.kernel.org/all/cover.1747306604.git.nirjhar.roy.lists@gmail.com/
[v3] https://lore.kernel.org/all/cover.1747635261.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (2):
  new: Add a new parameter (copyright-owner) in the "new" script
  new: Replace "status=0; exit 0" with _exit 0

 new | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--
2.34.1


