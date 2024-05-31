Return-Path: <linux-ext4+bounces-2725-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E908D5FD8
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2024 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC46328501E
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2024 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38669156649;
	Fri, 31 May 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="glcQAAKI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB481749
	for <linux-ext4@vger.kernel.org>; Fri, 31 May 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152152; cv=none; b=eGm5hRf+2eFfuIHftqEEiStj2TfTq5uE4gmYSNGmRkQgwBLdjE7aClfXSNLDKz0RPKB5vR/3B53sKLc2VolWThHwocKO10HLVSMDcdfUTXb3+r5INX0GYi3m/EQbDEwysGvsfiLZnuZRkrbfs1mineVHrn1kn3Hw0pbjaKPWXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152152; c=relaxed/simple;
	bh=n1UFMEc2a+ip6lozAo9tSQX9hcHUWAUFc4VcwZzCngA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLTkBCv4kX/fyEBJvc8Tn0/4oaRI4tfPGG8qQM/sIoLeVURl4wO+dsnqqqFojlFs4quqAT0KevfZgrN7av949zN75iaJ+OR+HR9xfN4yaC0RuW39jFvRAR4ruU0ZW4wgNPlbcJ4XnLDWH2Nwt0S513fVGm9R6E1OHBcra+EYoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=glcQAAKI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a352bbd9so300841366b.1
        for <linux-ext4@vger.kernel.org>; Fri, 31 May 2024 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717152148; x=1717756948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISXVPcsrr94mEq5TpN2s7NC6skzoD4RhjRGS9Vh3EGg=;
        b=glcQAAKIPtevmkols0ptwp4vXUnTq3ggGXUGqJGp4nmRWxebORGuR83u5oXlEoDxZa
         NizX4UyS/K2CE+lFON78HZCBlJTCph2h+bYARnf7hae7dGyw0NW4X/5TReS0Ot+aqmq9
         0JFSl+js4NVKl2jETpdzswaxnJq9cSVsM1QQVzajWYHhZp9y4lkNLYEhOZpPssUJ5qVI
         SuqKvY9ociPSHEtT9kSW2tLV2Df5I/ephmISdUXSGrg06DKNS3jShkisJHt1yP1OpfCv
         4ouZEyXYNNF3NYhtRqUzDqdWSAPWR/bz84/Y3zBhtOzmMZG6esYkw+vFLdxlqS+IvIe4
         XdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717152148; x=1717756948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISXVPcsrr94mEq5TpN2s7NC6skzoD4RhjRGS9Vh3EGg=;
        b=AxJVJYLpjAouI0FgvS8C+uU66TePaIXNy4uK2xZT/CujDPtKRynGkKXSs3wISDHlBM
         bqRGQCriBthwsU2eDxnCyIZ4BT7qng0vzgkwyXcpV0vVeH/tBe9ux/OodzE70VdrlNar
         uZ/Vbo+B+FkxkKNOgVAFMHaKX+33xMiCqpMfBTzXknf3UWEJ+oo+5o3snx7tYPdUpjic
         x+dTnJAHKu+iQWZ3sPQ8iEifHIBOpSrwNavN93fqwYB5Y+WFCgQAc+d5pv38dsqZdDoB
         CA7vISKcWxqLEJxTBWkMmTRHw+dmo2f/wVRX0ag1IIDbmDuJf/f1uMCVXtPjmqT7uYN1
         4DUA==
X-Gm-Message-State: AOJu0Yz4aTm35sqxk9U5VV2CjUuruHDJ14DeSpJ+yEOpDlricrZl6V9c
	dnC2dOWZwPwk8wHGEVSvauf351PAKxlLckVJFIBMx3fyRlzrrH3zxJ60LsDpkQI=
X-Google-Smtp-Source: AGHT+IGzX4FmK/DHUc3XXLdjOJ6iZO10jtCcTWxg7hbg8WBqNvQwsHc++hdIf+MCsZ/hgXwzq8um4w==
X-Received: by 2002:a17:907:bb84:b0:a62:5094:817 with SMTP id a640c23a62f3a-a65f093f6admr348929266b.11.1717152148161;
        Fri, 31 May 2024 03:42:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-160.dynamic.mnet-online.de. [82.135.80.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c9bc0asm866578a12.79.2024.05.31.03.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:42:27 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] jbd2: Use str_plural() to fix Coccinelle warning
Date: Fri, 31 May 2024 12:42:00 +0200
Message-ID: <20240531104159.564605-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use str_plural() to fix the following Coccinelle/coccicheck warning
reported by string_choices.cocci:

	opportunity for str_plural(dropped)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/jbd2/recovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1f7664984d6e..af930c3d0d97 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/crc32.h>
 #include <linux/blkdev.h>
+#include <linux/string_choices.h>
 #endif
 
 /*
@@ -374,7 +375,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 			be32_to_cpu(journal->j_superblock->s_sequence);
 		jbd2_debug(1,
 			  "JBD2: ignoring %d transaction%s from the journal.\n",
-			  dropped, (dropped == 1) ? "" : "s");
+			  dropped, str_plural(dropped));
 #endif
 		journal->j_transaction_sequence = ++info.end_transaction;
 		journal->j_head = info.head_block;
-- 
2.45.1


