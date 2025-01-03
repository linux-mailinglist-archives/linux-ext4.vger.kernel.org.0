Return-Path: <linux-ext4+bounces-5887-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26126A0111E
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Jan 2025 00:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC75F1641FB
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 23:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F21C07ED;
	Fri,  3 Jan 2025 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eWHAw9aQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023C180A80
	for <linux-ext4@vger.kernel.org>; Fri,  3 Jan 2025 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735948249; cv=none; b=bNwStPd+Kd0l+tfeZlzaPqG+644v+M9rY6rAPV6/sHyEA+6Xg/P/HCh/oamR/hS/dCPEisJFATgzsFCSm9Dt9k+QzA5d/cTGlUpsF3QLlrCOcFz3o0z7Em1BZM6J9ZpyWMj2AVFOqZDDxNrs7/YiDPB1as59F+WezYs9GcIy2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735948249; c=relaxed/simple;
	bh=FeLwtSyzWoJfGUNkS77ZjXSr/CZJynDPuZqdeOsIjUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSTHlNX5AwWWw6cCIsYwZ5FxYUMlqet2O/67EglDapFhcQENRPWzJ/4OLQS8bZsAyqsAeQ4Y/fwlMHV8NvUbe678g+3XCpb7E83+93YLc8CP8nnxDJDRpz4m9H2RTMnUuUQkERTfvlg3kiEwaARs/wVY9pKf94Dvryc9NC4+I/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eWHAw9aQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216401de828so167043165ad.3
        for <linux-ext4@vger.kernel.org>; Fri, 03 Jan 2025 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1735948247; x=1736553047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2vTMMpJxTmzPhWkoBFkeY7b6bjObGGZ050UDYHhk1Q=;
        b=eWHAw9aQo0Gn8Gx4Tr8a7pJ0s3l+6ERAwsPRZQMrwf6CbGivDEeYZYWZ0hQXjDBfiz
         kBUlRQ7/EzH7rN5infjTtvfOjLZjAH8ExAIvbdSPvfXysM2jKPpO0rAAgd9q55u27Ix8
         ZVLx7QuebKFOGQGs+qIxhrRl0txQqZSacA5kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735948247; x=1736553047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2vTMMpJxTmzPhWkoBFkeY7b6bjObGGZ050UDYHhk1Q=;
        b=uJJ9gwygV0zV5adEoIAGWOBygCGGi4Pb8ozrPxt22KPIknh6Ja71qLLhJVtn8EvfgV
         ujuv0lyfjGBjD1zPa94pGDztPvRaxpho4ChZ22Uj9ai0tMl6qlVlHI/2RY4zTcRituaI
         c3Sm5l9MKa3KREuv3f3aceon+5/iWDZcRxwxCLx8lEMa7ZS01h9bh6ktjXwLOE+unoZ2
         8sa06R9tGLAtC2KpSvPlChNj15JhX8cwBCq/Y2cEcGtVMa2n/xAQxuvz5F2zDFYFpnk5
         ZBOgRC8FVtnh2R5h6gRTiIuwcPfjojb6pyM6+vyWvW51AEHWmVOWtQB8+rc5o2LZjNh9
         n4BA==
X-Forwarded-Encrypted: i=1; AJvYcCU+mJ5VlttXtBsPcfL5GdvcrWO5fa33hJy/P3+BKRjbJfzwuD8pxLgKp3AQ+MRG9qZYQQTSicHje9sk@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4jR+oF0dCSJu+NECL6rJSa0D50gQ+Xtn+vNZZB3AyYi6CczX
	kAHCXJb8hxCXCH3uhoXmvOG7RhLIF5Xhp52381SknIJSV+dLNzQ6fxP8K+PNHA==
X-Gm-Gg: ASbGnctCdcFvPXgipOcJIgxurMQH/GbCel+BDGqTzKb9SbZTeaykN1ecIH/+RzgbMdg
	51CuEUxthaBc+yT0nJEOPFbn5i7NTZV0QCZ88cxK+4XwlQD02pFfN6Fiz90woNMgdAskiFvgbNw
	Z6w/UDSfbXzbaODGToYtMtgKH/pBNJ5xnStPDKEsNtOcltiLuqqo4skWA3AO5yOTFjd8U/ftGSN
	FQdWjqd7YPrdNA3MRnPB/cBME/ovxpizDoimFQ4+fW75yZA80AIpC1u
X-Google-Smtp-Source: AGHT+IFtimyqL2suSVv9iHnWQ0VN3GE9/yTUXUhe8PzNbWP7AdMDjTGZ7gPZKEZM6vFZMxKjuEea2g==
X-Received: by 2002:a05:6a21:2d05:b0:1e1:b883:3c56 with SMTP id adf61e73a8af0-1e5e049f2c6mr77668162637.23.1735948247266;
        Fri, 03 Jan 2025 15:50:47 -0800 (PST)
Received: from localhost ([100.107.238.250])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-842aba72f39sm20835016a12.5.2025.01.03.15.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 15:50:46 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
To: jack@suse.cz
Cc: gwendal@chromium.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	uekawa@chromium.org
Subject: [PATCH v2] tune2fs: do not update quota when not needed
Date: Fri,  3 Jan 2025 15:50:42 -0800
Message-ID: <20250103235042.4029197-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20240912091558.jbmwtnvfxrymjch2@quack3>
References: <20240912091558.jbmwtnvfxrymjch2@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling quota is expensive: All inodes in the filesystem are scanned.
Only do it when the requested quota configuration does not match the
existing configuration.

Test:
Add a tiny patch to print out when core of function
handle_quota_options() is triggered.
Issue commands:
truncate -s 1G unused ; mkfs.ext4 unused

| commands                                                | trigger |
comments
+---------------------------------------------------------+---------+---------
| tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | Y       |
                  Quota not set at formatting.
| tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | N       |
                  Already set just above
| tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | Y       |
                  Disabling a quota
| tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | N       |
                  No change from previous line.
| tune2fs -Qusrquota,grpquota -O quota unused             | N       |
                  No change from previous line.
| tune2fs -Qusrquota,^grpquota -O quota unused            | Y       |
                  Disabling a quota
| tune2fs -Qusrquota -O quota unused                      | N       |
                  No change from previous line.
| tune2fs -O ^quota unused                                | Y       |
                  Remove quota
| tune2fs -O quota unused                                 | Y       |
                  Re-enable quota, default values
                  (-Qusrquota,grpquota) used.
| tune2fs -O quota -Qusrquota unused                      | N       |
                  Already set just above

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

---
Changes in v2:
Logic has been simplified, based on jack@suse.cz feedback.

 misc/tune2fs.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 2548a766..3db57632 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -1799,11 +1799,27 @@ static int handle_quota_options(ext2_filsys fs)
 		return 1;
 	}
 
+	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
+		if (quota_enable[qtype] == QOPT_ENABLE &&
+		    *quota_sb_inump(fs->super, qtype) == 0) {
+			/* Some work needed to match the configuration. */
+			break;
+		}
+		if (quota_enable[qtype] == QOPT_DISABLE &&
+		    *quota_sb_inump(fs->super, qtype)) {
+			/* Some work needed to match the configuration. */
+			break;
+		}
+	}
+	if (qtype == MAXQUOTAS) {
+		/* Nothing to do. */
+		return 0;
+	}
+
 	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
 		if (quota_enable[qtype] == QOPT_ENABLE)
 			qtype_bits |= 1 << qtype;
 	}
-
 	retval = quota_init_context(&qctx, fs, qtype_bits);
 	if (retval) {
 		com_err(program_name, retval,
-- 
2.47.1.613.gc27f4b7a9f-goog


