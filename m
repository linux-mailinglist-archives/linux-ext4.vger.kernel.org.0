Return-Path: <linux-ext4+bounces-3957-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A2963F30
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 10:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C6D1C2455F
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692F18D647;
	Thu, 29 Aug 2024 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG8W4Uat"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520E18CC07;
	Thu, 29 Aug 2024 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921660; cv=none; b=WIIzvrCOCWuBm2G1Es2gbav3WvBpHU07VLADcNn540hWGTfttbeVpfyhvxA/addAvLzgW3i0HUu9O9xGUERiwm0FtAf1Bktun9uRb1R7SNTW6x+gqOFbHG5WJQFyCBYgqvX4QqsFeDUAxESycGvVMGgNLAHIWnuT/pPObG+F/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921660; c=relaxed/simple;
	bh=6XiBtafcBfHuc5CvCtkN6JBmB8IQp6F7Zddbcr5whYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6yLQNV3uyuT+lUo1rodsO+S+5hAFHvrPx/IvOW/+Jv1iAWJ8WgHcdJRBmB454N1/yxzHAr20qiGNSvbaPWGGwEMumEogoroDAnkjHdGz43HeOrkAjORyguGDQzoxKZL6aMDzwF9larfvKJVKaV608U2S5T+QXlVrjhhFDCNVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG8W4Uat; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7142e002aceso357448b3a.2;
        Thu, 29 Aug 2024 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724921658; x=1725526458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2y2h22sjuX3FT24NPN6UEkGPizJkM4MPRvjCHf5W33I=;
        b=XG8W4UatilqD4rwx+6ccwLNBEBCPVUK675SV9/ybPhnnyLPfiQKn6+3pB4e9IawGdN
         6RonCvRErZ5j9scOoY9XL5H9jM+oA1VBeEfjlKcnxctM4gSWl+Nay2uxWIpJZP9vm+5l
         zscw6NA2eJgyHg3R+0ahf0u4EoJdHMuzx5bQxtpNEcGazOpVXMwinzqGoJqfaL3GqCPy
         1zJNgZYnAtQ838Rcy6wZ4pX9UpX7HRoFCk7i8jXz5GQDgMEfeQyF3g5Z/C/ml/YdgRgZ
         2Dd343qr8mkgco2XzF4Y2uMWE/psrIwww6Ywfk2MPJVeabX3NTCf13B0ncDlEq2qB/3k
         5ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921658; x=1725526458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2y2h22sjuX3FT24NPN6UEkGPizJkM4MPRvjCHf5W33I=;
        b=f8U1urQlNhlO3KW3ZbLmiIJauoxAJY3I9UKd0z+BP/A/lpiLGEnvJoBL2pXhVZtPuU
         +o4a0Fw03+6ePdpw4a6oDDAjXm6rEL/XHVVq5aYFVpOciEG8adaC3tU3dIpLE5VIErdu
         XcfbkpTytMLDAkrLIShoKNi2+ORrAA50F3wnNUNAMPo7Djbxbl5h5kY/bWMkJEdvXJVP
         ggXHavdp119NA7hUL/s8fqqXv/jhEoKrak7mP5Rhlm5RBZ4Uw0nSsD05wrn2autpjw7g
         x0UEfak+Fwam1BHOq2rziocGLcnQSKxpJ1cXNE0JBH/7uAALoNmhYrCQ6lrP92SDhYmw
         1T2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCb6Kb/278Wo7bU6vFkYLp9G6JREaD2P4FEu6Sz8ASDPfnM74SVag5ikPPU2oBAnC5hLftb+2A90Rk4yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIUpf+NsOQc48QHErMcm4+l663MIg930a5eRbtYVC0CpPIQsz
	UDQpcCRmF6vm3Fgw+XVNZYx7s5TXbwDt9tVhwee4BNkgux4a3KxH
X-Google-Smtp-Source: AGHT+IE8Td1j9GiDogs6nwg+qEdNiiAAiBUkU/awstx8v3us9osSvwOlzIIz7UpPdiZ97ypQDGPiAg==
X-Received: by 2002:a05:6a00:2395:b0:706:6c38:31f3 with SMTP id d2e1a72fcca58-715dfb10c5amr2312003b3a.8.1724921658079;
        Thu, 29 Aug 2024 01:54:18 -0700 (PDT)
Received: from localhost.localdomain ([163.53.18.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56e3f95sm708789b3a.176.2024.08.29.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:54:17 -0700 (PDT)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com,
	ebiggers@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers
Date: Thu, 29 Aug 2024 16:54:05 +0800
Message-Id: <20240829085407.3331490-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829085407.3331490-1-zhangshida@kylinos.cn>
References: <20240829085407.3331490-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

For new uptodate buffers we also need to call write_end_fn() to persist the
uptodate content, similarly as folio_zero_new_buffers() does it.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 941c1c0d5c6e..a0a55cb8db53 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1389,9 +1389,9 @@ static void ext4_journalled_zero_new_buffers(handle_t *handle,
 					size = min(to, block_end) - start;
 
 					folio_zero_range(folio, start, size);
-					write_end_fn(handle, inode, bh);
 				}
 				clear_buffer_new(bh);
+				write_end_fn(handle, inode, bh);
 			}
 		}
 		block_start = block_end;
-- 
2.33.0


