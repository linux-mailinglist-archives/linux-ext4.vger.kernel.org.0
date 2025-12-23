Return-Path: <linux-ext4+bounces-12501-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46A2CDAB9B
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Dec 2025 22:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B6DD302C4F4
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Dec 2025 21:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CC531985C;
	Tue, 23 Dec 2025 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTKHtH/5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360F319617
	for <linux-ext4@vger.kernel.org>; Tue, 23 Dec 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766527155; cv=none; b=Gc21lr7grmvobmh2DSzGLlmxRKbBMPGvHPwRNMpdzRO1lOSV4SSTcEcCgkewlpif0DVM/qnf5UST4fbhXm1v368/I0/gvchPzkqKNjjfGcotsoyHqY23rtDMrIdzPl0lywFL2hX8xBApksts6sBraqHbgJh6y26F5DaJfIcQbCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766527155; c=relaxed/simple;
	bh=o5/d1n0tGoXesIT7xFEShhShec7ADyKFhy1sjeMZeao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VS0Vkfs7NnV3VQ1Jr7Z+X2jLiHhGnZ8VySksYbCD2Tu+nmbhjolzXos5Z6j1+9/W0iBVwncPAl92Sz7DkSsDWYFMyeFPfabwNltZBfungOcrlLCU7odEp06h13GJowEmm4hRZv7CpC1rCZ9F8FxBQHZ/vOxRe6UVkuhN5yVl+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTKHtH/5; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b7ffa421f1bso1106526166b.0
        for <linux-ext4@vger.kernel.org>; Tue, 23 Dec 2025 13:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766527152; x=1767131952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IUybjfCPuH4Iea4yG3y/BgalmWwW4QAXVnrciU7xwY8=;
        b=mTKHtH/5msRbaMcdlWJq78I5smKAL77SwjklqRNPJnAUIa8V1T1fzw0R5vDn3igI5y
         1hScXfDs5j2lBA+ztdscWUzAsbxzcRu1Q9Bey1sAeAjahZWLo0yZb8u/1kGC85JEWX8o
         aJylVj4qeKesFoDWzLye9rqgMEV1NG0UNSXVrpdNPZCbE3QA6oKbvujBPmQZWFLA8BBY
         +uaKFMvPUZpz63B1eKweB/cDG+k3nvTJ/QRt6Ekevc3AhT1gIULYJnKYa4+DDJM1JrLR
         XHLEOV9S7f48/9vkTqVELRWyku1CCTuY2qAzMnfN7gQ1qbQ4tBUvOVTk/8cI1+HDWugZ
         0vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766527152; x=1767131952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUybjfCPuH4Iea4yG3y/BgalmWwW4QAXVnrciU7xwY8=;
        b=Hw9OHfdte2m3//b6jRdGXfEl15A2yMseW9VAJEahBO4jIAhNrX8pUC/5GL9rexCHk/
         lAWNRXDz53UREER/fA5Y5GNfdWQPhF7uh9BEmbSb+24M/ruqcD4j0m0Kx+qHcy+RCVju
         jkoOnr5YhUMFbr89kSEiiPBpkFdQU+DUmL+E8XrczljAVlraWxOKPB/1biTRWzanIYC/
         w8SxSY19g4p39o63eRJ6F5wjgHenuanvcjpMbwsMg7X24gVGUmv2lerOVUHuYetLlbSv
         sFO+4JwOn0flV8K8pwZtBH398Y3dGhWUurBNMHB5PMLgDYXg4HJqDZ5eeaF6W3Baem/Q
         YoAg==
X-Forwarded-Encrypted: i=1; AJvYcCXsyNMiiXBUn6NZBPnEcgmu9uJRMqoHRLN6LULXDIfPcHOrSoHEtHeO7iXSjoMJKHxFmt3DwHN+qcgU@vger.kernel.org
X-Gm-Message-State: AOJu0YwauB5MTb6aeNpdwFxhVGyautQy1s/GyOZjAXt1wlW7SUVzkaIL
	Vj2FvpbWDThXuixVnlJD0OrS3GWQpMCPyoawquTTo06kOKRup8BTbwImdZ53E6Q4
X-Gm-Gg: AY/fxX57ZCuMW2eH/fFaNEjchIzC36BxJnqilf/uN/GqL2TVut0NOtbtYpfqgWcsBNJ
	xCvBX4nza1IuQXDu4UbfJZ0axExOiGdHQCOjRS8lQ2TgDCJmKRwrQoAgeWn74/W0Q+xraaAeo1F
	5cO1F9bIjQneYbVJ4Bu/wKnl3SRyWNR7rgtIVxO2ZpIGIyVaJDh65tNpafaRqIzDRqzwzka4dRU
	m5bcVGJo+sSqg11Boqln05hzL9dcq3UjVdrRW8Hp7bI71+lvsTXei4DG4GfFITnUJsPt7vJ0yft
	gjJaKr/4PKnGHcqYSpeXk45246rd9bvBw6YAeHQ4qbKrwVefSyOeE1SMDytwGubkShQ8y/3sDGn
	CiKaLJv+23y/SOc5W++5KDuZM73jL88neh4930gnAtmRxAbwz9Rt+gvQra0LlUdgPpTG21HHHmY
	HyYWG2pd/JYK0mSPhN5g+EXBkfTFXQv4Z6tLREI8EG0kn3/IwPlrMbyDv56NmVqdTUp9bQ8zNzD
	c5j5ytQlXVD6lFlIjFTk9VKLuT6deGOwtKvr6rskWQ=
X-Google-Smtp-Source: AGHT+IEeVPrStoOO63n58znMCh+CtUHUnz6eYZmVyzuIxpmSQdcD8/AU3tbM/KBMj8HL4qja3IyUfA==
X-Received: by 2002:a17:906:23e1:b0:b77:1b05:a082 with SMTP id a640c23a62f3a-b8020400379mr1461607466b.2.1766527151725;
        Tue, 23 Dec 2025 13:59:11 -0800 (PST)
Received: from localhost.localdomain (host194.safe-lock.net. [195.20.212.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ad1e6dsm1559098366b.21.2025.12.23.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:59:11 -0800 (PST)
From: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Bartlomiej Kubik <kubik.bartlomiej@gmail.com>,
	syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
Subject: [PATCH] fs/ext4: Initialize new folios before use
Date: Tue, 23 Dec 2025 22:58:55 +0100
Message-Id: <20251223215855.2486271-1-kubik.bartlomiej@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reports an uninitialized value in adiantum_crypt, created at
write_begin_get_folio(). New folios are allocated with the FGP_CREAT
flag and may be returned uninitialized. These uninitialized folios are
then used without proper initialization.

Fixes: b799474b9aeb ("mm/pagemap: add write_begin_get_folio() helper function")
Tested-by: syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
Reported-by: syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=703d8a2cd20971854b06

Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
---
 include/linux/pagemap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..31bbc8299e08 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -787,7 +787,8 @@ static inline struct folio *write_begin_get_folio(const struct kiocb *iocb,
                 fgp_flags |= FGP_DONTCACHE;

         return __filemap_get_folio(mapping, index, fgp_flags,
-                                   mapping_gfp_mask(mapping));
+				mapping_gfp_mask(mapping)|
+				__GFP_ZERO);
 }

 /**
--
2.39.5

