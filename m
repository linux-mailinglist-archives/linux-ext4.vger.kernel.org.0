Return-Path: <linux-ext4+bounces-7823-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5FAAB4DC5
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 10:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4CE17FD60
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163591F5827;
	Tue, 13 May 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9wWmQ+9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D21F869E;
	Tue, 13 May 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124002; cv=none; b=MUBE3gAnDjLfi64PEVmsd6Tykp8TPAIyjISXh+pLPKDKruWZvGjqd227E+qRfgruoUXi73rYB63tMvKClhhU7j6Li+qK1UbFlMWSXzWMj7C5w1drPylpFAp64pkbr1Sh8lhpQHcbZpvNCM20tUzQ2QVqHbcQsLqjFYP/cgr+IS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124002; c=relaxed/simple;
	bh=0/eUX+FSeHd/iH68TwoOzkk+Ync3YK9gVWiSZgUvZEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PaqdBLYuv9Pin69+UO8uEWpHag+9f+pvWKzqtzrekmw9RQMRW1dvtZRSmwY7kb6AwL1L8vdV7QWrU+gTf0h1keenssVdcQ198OIQS/RvqJzWrYDgAhEjh1sTjhQKqiK5ioqc1P88OhQRCUXYYNAOthPm+FpYbIGpwSuOr6NmM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9wWmQ+9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22d95f0dda4so61921955ad.2;
        Tue, 13 May 2025 01:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747124000; x=1747728800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nUDgrjp8wqWi8/RX5Kuo+aXylPky1hxHPWJ4gVK680=;
        b=H9wWmQ+96ZF67E1+3tRJjH+9apNH+tfJEQi5XYM96VEg6YOf76Y/2jOdQEpHyeQB3K
         Uob5IyeZNFxIHeHA4xkmBv5h2DglV/CqB15DBbV+QmOaTSYYwz2RScwOYFmfzttrodY7
         QOPEDHRbfjmi6C4Oh1WBPUYsq+4tlnxS0c99KEQ0BBIAS6pLhJh76t2iSQT52EJU6lQJ
         H4slmqjn0Hme/CZMsy+0fLeeEhbLZ0fxzwI7AwXlOYZenfx2VfRujjhtv6kpw6IVkrpM
         ecHc5LnSi7Gosf2jTwp6+jYMKXWFOIiVn+c4awVRao9gYo28hsZQuHpoJEgoilLrrKya
         UQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747124000; x=1747728800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nUDgrjp8wqWi8/RX5Kuo+aXylPky1hxHPWJ4gVK680=;
        b=vIAcI3BhEO+mdlMk6HgQDshLnpzE9h+1lj7U9sEaY2mZbFqR1vQiX3LQtIbeKyJIkj
         tWCmKSiq9mAcU5eBIhgypHlol4+QbI7+lnioB4dkNI4T6xPQczQ3qgRajijOZGu8T5eL
         /ET8HJb/p3GeqgZxpP0bwbsbjA5oyBXx0Ksz46JrXrq3ka3KSempykUlFZb5/d12sZR6
         msX0b6RPPLfEyAxK9YujXAB/oDXlRk9mk91A2UMi+P/QdNCV7jrRxQBKqIWarTkhzuyV
         M1Z2mx3mubVt9Sr0lLZS1UoniG8Y2ZpTls0Y28sibM8JeRJXxSGzUk8MgUM9Vmyq7bqL
         o3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXLV9kx3td2kXp/Znl/yY+UFrJqffKSfuJ7u12xjdL0nrYQwXAKiRajlash/dtMX+FWL2n4Z8K5d2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOMSZiMjkf1B2+KUuHHjXVfeBpEU/E4uhI46kIUu/qrEGNaB2
	BqcAjPhNT5yYy/zRqj6RQwhTqB2fiGgrgt9V2zM2tNEYqnxTVqI5OWhOLQ==
X-Gm-Gg: ASbGncuJLXToLP0C9JheQD3TF48+wQZfoUJFhmpFiZntUqNo5wh0870CxdgjW11/XxT
	gCncDrpLz4GyRUyF7z0KxxIM6NXva4rQHe2Rj9XL0pVm/odQswiVgBbpAMCqu0Jkd9kvgue+7lp
	3cmUII+5PIr++ovsq4bGXy5Mf4SnDmdtihr0TQmzq68pdBke9wiRbwiIe+z1Dn0qZhSenotdKaE
	3VwHWzXyZjoNZLwdCW+r6s4TzR5Yjxu1GE0Dc4D/lyTIS1kX61ecHP+ceep/SYbbbjBuwyTeX0m
	mlSLj7t9EnzBG3oWVuUKcd8Mq4Nye3rlzYrY9+Qx+f6jL9I4kfjejFc=
X-Google-Smtp-Source: AGHT+IEtgg7Mb6MteVdS3mi/GEmwf4LWh4zATIbJ5CKXrRPgXOP+A+9Yz+gA5ZoDuwybCoIM5SYM7Q==
X-Received: by 2002:a17:902:dacd:b0:223:f408:c3dc with SMTP id d9443c01a7336-22fc8b00223mr192889725ad.9.1747123999657;
        Tue, 13 May 2025 01:13:19 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc75450b6sm75896585ad.49.2025.05.13.01.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:13:19 -0700 (PDT)
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
Subject: [PATCH v1 2/3] new: Replace "status=0; exit 0" with _exit 0
Date: Tue, 13 May 2025 08:10:11 +0000
Message-Id: <96ea8b7bb8dcaa397ade82611d56482d79f28598.1747123422.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should now start using _exit 0 for every new test
that we add.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 new | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/new b/new
index 139715bf..e55830ce 100755
--- a/new
+++ b/new
@@ -176,8 +176,7 @@ exit
 #echo "If failure, check \$seqres.full (this) and \$seqres.full.ok (reference)"
 
 # success, all done
-status=0
-exit
+_exit 0
 End-of-File
 
 sleep 2		# latency to read messages to this point
-- 
2.34.1


