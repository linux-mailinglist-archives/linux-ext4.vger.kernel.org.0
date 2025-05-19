Return-Path: <linux-ext4+bounces-7965-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 397A8ABB4FB
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 08:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928CB1893EE1
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 06:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228BA24466B;
	Mon, 19 May 2025 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze/QGsmK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3E224889;
	Mon, 19 May 2025 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635472; cv=none; b=p/upf0hytY1kvmEymp/It4dWt4uoavp8oeZwASSHfptotyZEOPMbjbS4TbHMVZ4Jt4F+yrbanIMSa7d0/lEwd6RfrisjwtT4Y4EC3OzybVIykL6OMNLh36TDxhn4kCrSPFXs+vtmdX88L4d+kJ3uisGRvys2NxdhMspVrxRcAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635472; c=relaxed/simple;
	bh=+8AVc4xBsScUHkSpZGN34MNv4fFhsUznRQJ7OkNQkoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVaXv373IElMCqGcvF+V73eWBhvJgMeZFJ6AVQ4VrwMBbSv2Pk/v+K+5LxqFI5HDZvfESRXVermvSTd5XdKfbUhcdP9w2iwJyWSXBvjDYyrcqFxO7w2Fht2O1UftkuMapxE60SW6DgmV2V0wQUKPU7zYLdoCLTTS0FW1HitA4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze/QGsmK; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2322f8afe02so5047475ad.2;
        Sun, 18 May 2025 23:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747635470; x=1748240270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdV4gbTUexVZokxTBi5R5goXt94Qpff5aqsyKfGYy0k=;
        b=Ze/QGsmKMii5xnUycbuds156uM3c78azrk8/i2WmdR9RD4cO+qpfihkVpdTJR8VIsg
         hyjrNq6w1NvJO2m3XtEJU9qSkJ8roN0jVg6e+s93fjjhBJfocnW9Ura19Kc7yD+e+ipf
         kKd++r5zUPmfbDrgibLlfHguxKNoR98/cRRmJL7Dv+e6GRsL0M1ItSCNSADJJzM0ceXF
         7TSNNhNgiYjtJDatmcfOthxVHTHRvMk4VYMcS8yVRDqaUgFwL5Ug4xDG9swaNwJp4SlV
         zxDbicDiKwds2ULAFLQbLp6NK9nxvEHaChYmn47PS+e1t8YBoBxmfRLdOwoYeEc0Bmw2
         gsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747635470; x=1748240270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdV4gbTUexVZokxTBi5R5goXt94Qpff5aqsyKfGYy0k=;
        b=WsgxMqnLjZ+z+JGJXQ1EIwGh16LWxawFyYUab9nmNehpxvorwd1Y5CejI5YPJYQuQX
         D466wdVxXKkb4+PJFtzkZXxVAPwb7Z3HDw/WyifVa2j9LMYcJRkeTyygvFgcqyKPRfyd
         3h5piRua2ztxMFi+UzFxWrNw4cDzKQCrqLj5RVOB34BBYpazT5lFkUdeEUV0tcSNf4MY
         qQ/I0EerOrpfmUeQxF7yM0aeoJf98vNXhulhWZ4Ccc57ds47aq4qPXuMfvks9Kmvt8//
         3/Ur+JgA/Tkia9w2IL050HM6pnmeaOGNYWCIIrMw2OAupLpDaAkLCpBAdJxoxNFKl04n
         SRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV76ArP0O+NhUoU6+CpEb6ztGDtA70ZuWQjEfG3uPqYOHYCwsvIPbpk5+IJZF4E8oQJ/+VShkmRZ7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfV20bmtqnzLeMVlZ57M5poHjiYlfSMrc5u3/4zuD6vGTOycL
	4uUC0J4vDoXA53hLJvZJB2i+dqxIqoCwQQtxZQxsVb2j6UnR1661qpYW8kMdeA==
X-Gm-Gg: ASbGncuQ332LLg6uK3b+UzvHahrv/3hVPkUHd2m9sjOxKs0dMN3PActxfhMcdxdRW4P
	NceWqRvVeYtmVjKBwh+4tjSz+AXpp2Ue6Ju1Qg28U/2tVJEjdM6NaPBphTtlvJP3ckgnkpAU4ml
	TP+OfIW0X7z2TXmo278vUrZAQSkRpWrZTQz6HMdqS6oB3sm2iqe7lFQGP0vR4abgSrT6uOVeoi6
	FFx03cnV7zW8JAIOLSv9/6sZWPGRtifavP2NHgPg8X+R6iiuoTEUeM8Z06MzML2N6Y3QCPEGg81
	LWf1ZaUBlI2vwc/TY9ktVn/c+/SeUqpE1GOp8957Q7lRqUgoyOn61j4=
X-Google-Smtp-Source: AGHT+IFazCX0uazRleXaKjvUHQPuHjW0i0WMUTTfgmCfhF+oosNfGje7o4lsj7TnTEvFDIKHVWWLCQ==
X-Received: by 2002:a17:902:f790:b0:223:325c:89f6 with SMTP id d9443c01a7336-231d43d9ba7mr212322935ad.10.1747635470173;
        Sun, 18 May 2025 23:17:50 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2325251da10sm6939385ad.42.2025.05.18.23.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 23:17:49 -0700 (PDT)
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
Subject: [PATCH v3 2/2] new: Replace "status=0; exit 0" with _exit 0
Date: Mon, 19 May 2025 06:16:42 +0000
Message-Id: <921be57a1a6ada795f5df3af042c10904cd4823b.1747635261.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747635261.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747635261.git.nirjhar.roy.lists@gmail.com>
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
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 new | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/new b/new
index 636648e2..dff69265 100755
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


