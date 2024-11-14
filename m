Return-Path: <linux-ext4+bounces-5183-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4584D9C9518
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 23:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA59B27D88
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF971AF0D5;
	Thu, 14 Nov 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4W90GCw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FE1E4A9
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622440; cv=none; b=Dd4o4Amumj2Bqy1Tmr5u50ZLz6o1jTl4hCQEp/j/onC5UBchV0FdIsa85JeQt7zr77i2drQlGYGugcwuP+gODExZhAS4rFIFIceXBErlGtcezz7FqGILMwyIT2okB4DrmOvvH2X2Yel6Zg/HNAL26USBYrUvJwxIzHlto/5DG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622440; c=relaxed/simple;
	bh=4HyK30fXj8jmmWqbOQWkXLt3uhY5uVrPZrm/l/RsMg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOrL4bhQjTC8U5KkAWURMT169OMqmJjUy5yV2vsIDKNGkaqQHk4FVXkVgPR5VJfsFkEF0oamsMKfaVdFax01cp9m31H73slI99rD75YYO1yiQcYMJegDtLxvqwqAUqzVCKwoPIAS0d9Gnx4i/T+T51+NYgSSTT9/pxnpeVlP3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4W90GCw; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e619057165so590244b6e.1
        for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731622438; x=1732227238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wAMDty2lGXMF6kT5UaoWL6sYMpJK5FPZx76CJefODNQ=;
        b=j4W90GCwjPQ97EixSzzmv54eiTb5nCSLAqd3w2Y93o21LviSADaYRcxaMHzb3/rp72
         whNV6+bv9yNB9iAJ8j3qpps4iYg6t4FS0kRRFHGaq5gCmJdNbuHdrWHkgX3Ac/6uZg+j
         Y5b/awU0TjtYlsOTXF0IYAEhzgO5TmCc002UY5IkV+aJMG9Q1vh2b95IeVgKrheskhTG
         bU1ftOgbAgfeMdYY0YLZcjxdnXP6v2kBQzfty5wyGVPlKYABMnrwpraLEztEHiARYpgI
         iB+w8zRm+vZoIhc9p+MEAjvUX2riVwTbanaMg6m4N1RdzosAwI+jES0nxMEpgryUrtw0
         vDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622438; x=1732227238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAMDty2lGXMF6kT5UaoWL6sYMpJK5FPZx76CJefODNQ=;
        b=b9LnuwvaIQNW7UP7HN9uNYD8NHVd8vICZZilvA4reXvwrITUqUQ/zhho3D08RNGlcI
         G8rmNghzjGqhcITpqktzj4vLH8/KqmM2Jj1ZfefegqDuz6mabXMmm32bbQ07T29U9nCA
         Z/PHSN+4dInDpi2vNipUHAlMrRkhXtYMMJcXGh7sNlo08inD/NH/Ww+CZBt7I5aePxQE
         gVJHbbpitSvZImZyyUIaPEy5FmrEpuzT5tHy+CHRhS9rqtZuONuNZixQO6+i1OQOhq3Y
         8N7Do3SjpqKjW9k5/YT5EoE5qQsTMFxQSAaIbZ1kWDu8jWr++ShtbwGY7IeizjNKbr05
         mlPQ==
X-Gm-Message-State: AOJu0Yw1s/pwkyIVO0HLLBiwTTL3mpMzhGegTTrNjueLhW72sqBq8FC2
	YZbUvZQcKw2Nk6N6h3/ThD4nG4dTTlGDJl/e70g6xfid+PXQppPH
X-Google-Smtp-Source: AGHT+IEI9PLVtnAQE4g5b7XPOE9yufeFizKcSukMPbE2UTwKscaHx9wMw83Zpk6xZ/z++c0eJLMQ/w==
X-Received: by 2002:a05:6808:1995:b0:3e6:2956:9104 with SMTP id 5614622812f47-3e7bc86abdamr621175b6e.35.1731622438211;
        Thu, 14 Nov 2024 14:13:58 -0800 (PST)
Received: from debianLT.lan (67-61-67-61-39-107.cpe.sparklight.net. [67.61.39.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c3c1d1sm98230a12.34.2024.11.14.14.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:13:57 -0800 (PST)
From: Nicolas Bretz <bretznic@gmail.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>
Subject: [PATCH] ext4: log rorw on remount only when state changes
Date: Thu, 14 Nov 2024 15:13:54 -0700
Message-Id: <20241114221354.23754-1-bretznic@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

it logs ro/rw on remount only when state changes
removes "Quota mode" as it is obsolete

Implemented the suggested solutions in:
https://bugzilla.kernel.org/show_bug.cgi?id=219132

Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
 fs/ext4/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a09f4621b10d..0067184aa599 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6760,6 +6760,7 @@ static int ext4_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	int ret;
+	bool old_ro = sb_rdonly(sb);
 
 	fc->s_fs_info = EXT4_SB(sb);
 
@@ -6771,9 +6772,9 @@ static int ext4_reconfigure(struct fs_context *fc)
 	if (ret < 0)
 		return ret;
 
-	ext4_msg(sb, KERN_INFO, "re-mounted %pU %s. Quota mode: %s.",
-		 &sb->s_uuid, sb_rdonly(sb) ? "ro" : "r/w",
-		 ext4_quota_mode(sb));
+	ext4_msg(sb, KERN_INFO, "re-mounted %pU%s.",
+		 &sb->s_uuid,
+		 (old_ro != sb_rdonly(sb)) ? (sb_rdonly(sb) ? " ro" : " r/w") : "");
 
 	return 0;
 }
-- 
2.39.5


