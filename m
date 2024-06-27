Return-Path: <linux-ext4+bounces-2993-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A591A1F9
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B9B1C21249
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC91350FD;
	Thu, 27 Jun 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b="CHfv0biw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A1819
	for <linux-ext4@vger.kernel.org>; Thu, 27 Jun 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478591; cv=none; b=V+An4x8xUjw4ftDLaEIep3Ot3VKvUX4Kmq5ayCqezfJC0R8kwkDw2WBTMb84UeOWf/xM6LBQ6Z14EpXwu6A03glk9V1dmrwi5ZZNBdxEgvgv6N2HzXOIw/3xkjfvKEd9N9DzUwVBzBBn5PZYYpbOkUPyLWLu/ffBG4LSRW2zAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478591; c=relaxed/simple;
	bh=Ysmxb0bGLrJuE7schxnLNi16/OfZI0+kM9j6mL2nvpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2Ml4E46HM2lLpBZw5OHHsjEvbDk+r09UevvP8oMz3c/myfaViLxqOrhD/5DT/RnhkZPyxkG5ygw25tjTqkjSvH9VoSQxA1L30Ay5uAgKw3T450kvUXds/Rofuwrr4iXh4+HuMfjx8PhprVIOM05k3NUZ6JdYV1g0zAh//bSAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re; spf=pass smtp.mailfrom=mwa.re; dkim=pass (2048-bit key) header.d=mwa.re header.i=@mwa.re header.b=CHfv0biw; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mwa.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mwa.re
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d4ee2aaabso1493135a12.2
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jun 2024 01:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1719478587; x=1720083387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HvixEhQUFrS1HxDVCQfyFycypf+BTpTVP+IQrkb2So=;
        b=CHfv0biw4IyaI0C73GrsBwojgsCCfwt9hTsbChOZ/J2NSHuzH8+CqPFZesdmMgG7Xn
         XOa/g8xYf7EitoA8aec/eP7sIfS/GSoPuTOdy5cj7DAMnS4fS42wEHc85v0e6Xg4eUcn
         /0STr/j4Db/ROxHG+gwzoYhp4Kvss4xamMGRhCoopuUBR21YwamVAoyBbK1UjosJxQkX
         +5Y9zlFRtUjwT/o8q5zu6HT9ai9AbBry6BG7SjkPg/PwH+kRxXCnued/w65cfryuFACB
         T1zfpDbuSVbMRvqMHPqzdTzPz5rM0zqbQtcawDlqK+ATmP83JBToBSremvk2lYCaOAQ4
         ZBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719478587; x=1720083387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HvixEhQUFrS1HxDVCQfyFycypf+BTpTVP+IQrkb2So=;
        b=Sfp+jDkOPAlQw5pdXZTW+O9TzENJA7wV4HfuY5+J9ZohJy+Wkfu8V1afeuW4t/VfHl
         RIR+4DEc5mj47mB99CVHw931vD9VsOgCaC+gxeb1zRRHbfZKrOzshfPh+aBFmTQFeiW/
         R4RpSJurhhXrOpbIbX22z2RKopvSqrGOsf6A4yVjRU7CHVqxoJW6/BF1rFp8ggYX08Eb
         PpZQkDQj+zs1RDaB9bvkfSPZBopmUqsfkoN3daAD+tGAaRRSIcX9N6WFcpnq43bgTaMk
         SbGPrsUEY31a4LxcXrZFx8nGye7W7fHD7r0bqpHMyyEWqMfaor+JRE+I1SzvI1uFHEKt
         tsqQ==
X-Gm-Message-State: AOJu0YwWI/JX/qDGBm4zcwh3GPYAYPPpq6kdAGaI31gSqJBxeX7mJhP6
	3R1pewXUen0/s3M4f36ATU/E3LJEsA7JQDvAOvSH5uoz6YT+/PCe64JHiYtgAsg=
X-Google-Smtp-Source: AGHT+IE6uMbZoQTog5DVZt5hvrPJ0H5WQahBCj4S4MnHrE6UFTtU1ZUDTZGYKCugAXsTU28FP0GIWg==
X-Received: by 2002:a17:906:9c93:b0:a72:6375:5fa7 with SMTP id a640c23a62f3a-a7263756132mr718335566b.64.1719478587446;
        Thu, 27 Jun 2024 01:56:27 -0700 (PDT)
Received: from phobos.home.arpa (2001-4dd0-53c2-0-0-0-0-13af.ipv6dyn.netcologne.de. [2001:4dd0:53c2::13af])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a729d77964bsm38516166b.130.2024.06.27.01.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:56:26 -0700 (PDT)
From: Jan Henrik Weinstock <jan@mwa.re>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@mwa.re,
	simon@mwa.re,
	Jan Henrik Weinstock <jan@mwa.re>
Subject: [PATCH] ext4: fix kernel segfault after iterator overflow
Date: Thu, 27 Jun 2024 10:56:01 +0200
Message-ID: <20240627085601.24321-1-jan@mwa.re>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When search_buf gets placed at the end of the virtual address space
        de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
might overflow to zero and a subsequent loop iteration will crash.

Observed on a simulated riscv32 system using 2GB of memory and a rootfs
on MMC.

Signed-off-by: Jan Henrik Weinstock <jan@mwa.re>
---
 fs/ext4/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a630b27a4..030a11412 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1537,7 +1537,8 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 
 	de = (struct ext4_dir_entry_2 *)search_buf;
 	dlimit = search_buf + buf_size;
-	while ((char *) de < dlimit - EXT4_BASE_DIR_LEN) {
+	while ((char *) de < dlimit - EXT4_BASE_DIR_LEN &&
+	       (char *) de >= search_buf) {
 		/* this code is executed quadratically often */
 		/* do minimal checking `by hand' */
 		if (de->name + de->name_len <= dlimit &&
-- 
2.45.2


