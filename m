Return-Path: <linux-ext4+bounces-4034-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFDD96B561
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 10:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0317B1F214EA
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB611CC8B4;
	Wed,  4 Sep 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOwYj95M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331815746B;
	Wed,  4 Sep 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439627; cv=none; b=dgPPcL/2TBq+jA1zfmWN5VKVnqAzzmYo/aug+FREMOa2RKG4ThWEYJiM5ipCX8Mi7OPYn6LwsHjvXI4otbCrccJWiBbN7JSdbHB/bFcPZ1V8smOKpXSo/DaGPeY9l9BZiwcT16yoQWgWwEDJtwWpl+FgCwdQAtXvNDvFIDQ27NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439627; c=relaxed/simple;
	bh=9eGsQm2a4gwir+w1EgwDbDPLYti+ZLQhfDkxbrw0E9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Buq1OlvrOaHilS7F/CObeV8uQYYu+lwtkl2GE+GPPzmpROuqPx/NWdv2aTlhWsh8SlCHB+2mibR7IFW2HH/HZNbuguNDXx+8Yveiv/R7o8nUPqdnq+UiAJOlJfRLbAcroJo/q5UmMbwpCD506H0Fww9bssTN9rFIgDalpwQOiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOwYj95M; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37747c1d928so402297f8f.1;
        Wed, 04 Sep 2024 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725439624; x=1726044424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9y7HQ5IcfB4zTdOLLj1/YXWbE4SBR+qun23XCtCS/U=;
        b=UOwYj95MR6il2ozEeHMQRacTQy/XKkb6eCidRbRbRPVrCcdm8OAx/LG6iE2doSDKh6
         1hTcvz+11FGi6JvW/9KJXIncs2aoS331JFVMvOVZsyUVpRJUJGTWN7ygKubYI7IHaqNX
         hGHYw1XkBGHP3HYYk1POX3JxCuxFqZiJMCe9aJoBU6QRv2l32qdfZNf7/fePKGRyIx25
         lmcx+hgwpj4EUpI5Ndwb9Xtc99xT/RZrRNszurb2bexyFpV5O1Ha4aSsVpBqug4gx/Ij
         bkJK997XLxCI4FQfRKizV+qnHorz+xHR6TPyM97ZWi997lQkW9D87GBnGeyVNViQnqDL
         dY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439624; x=1726044424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9y7HQ5IcfB4zTdOLLj1/YXWbE4SBR+qun23XCtCS/U=;
        b=cneB5B1vcF9lSWa7Z7VyXS9utXD4p0xagMOieIF7viEKJaUhEElkDkMnvumOmzNpiC
         B1XCmoFczYpcUMEQlwUy5GAmVPdMBa8uSRunln7V+Hb5FnTgrDrd3mr7z4ggjPchrVLq
         +AlAuIwnlBRjlgx0yTbh43o+G3DWYK8Y80+RTCP5rJdIxhhkQqAXssD/bfXyWLJz4moM
         sKZx15BYl/fe5OHa3+9SkCe/+5H2EH8GHCbld53IRz2wt+Ee6xVEl+9RH2cOdBQwzmYf
         mliLRoR2jQsF8vtIE6h0T98FpCHO9zD7xKm/OiI1UrbdrUHE5HL/64uzbpeBVXWYMoRn
         w25Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRSRap400nXorjpxZUDVYvQneBYsU4amduvYqS83NUjeoo0bxuEEvvp/TOvpE5R7aPBiN6lucIzamAZg==@vger.kernel.org, AJvYcCW9EvbhtD8RIP6cFGIgffU1/KGAJ9aDR/q6BgZ7bT5TTN66roIZlUyTlTaj2LaSLekuJopuGsGh@vger.kernel.org
X-Gm-Message-State: AOJu0YypEFShCJPO0Mt6t3q0bRifC6nPhoEH/5FcAJ6wID6W7SxqhztI
	8ccABf8oMg/uXyN9Ki/8VzZUGhDU593VpJgfUWszXeifYQ189GFE
X-Google-Smtp-Source: AGHT+IE97wKzdXMiMN0infJRmn7n68q7SBA3jq7JK6X8HHzs3o2hV3pAnnFo6a4WzUgrMfJ8NqdW9g==
X-Received: by 2002:adf:e602:0:b0:371:9377:975f with SMTP id ffacd0b85a97d-374bf05d1d8mr8878790f8f.25.1725439623235;
        Wed, 04 Sep 2024 01:47:03 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba7f9f3esm123145695e9.0.2024.09.04.01.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:47:02 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Theodore Tso <tytso@mit.edu>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zorro Lang <zlang@kernel.org>,
	linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] ext4: return error on syncfs after shutdown
Date: Wed,  4 Sep 2024 10:46:57 +0200
Message-Id: <20240904084657.1062243-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the logic behavior and one that we would like to verify
using a generic fstest similar to xfs/546.

Link: https://lore.kernel.org/fstests/20240830152648.GE6216@frogsfrogsfrogs/
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Ted,

Please see the discussion about moving test xfs/546 to generic.

WDYT?

Thanks,
Amir.

 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..b9cf18819e11 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6279,7 +6279,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	if (unlikely(ext4_forced_shutdown(sb)))
-		return 0;
+		return -EIO;
 
 	trace_ext4_sync_fs(sb, wait);
 	flush_workqueue(sbi->rsv_conversion_wq);
-- 
2.34.1


