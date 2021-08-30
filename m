Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D423FB391
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Aug 2021 12:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhH3KGY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 06:06:24 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43627 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbhH3KGY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 06:06:24 -0400
Received: by mail-qt1-f172.google.com with SMTP id s15so7774977qta.10;
        Mon, 30 Aug 2021 03:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=amZ51+cAPYqcNlwWC9J0wRvXw3ShsXJZxpepHqJ1tLY=;
        b=KX2TogN4Ziw+SAvoOUhL+Hqk6Ghv4au5wg84AM4QHhHT64BJn2M5er7K6ckz6jr4CL
         dtBkeJWAeB+bRZqLHwrCgDEE270X1xbm/dDRy1TiibsfOPBj9nfJl/OuUSiI9MGLh6X7
         fHj37rRIeZcymKhM/f+jH8CdMU0tC1y1QuxRF+DXEcGvrVxv5geIC00OClwG84dmUH2e
         9dDcXd0II17y2QwEVym7uvxUX9+SW+SVXLq7zG3Lcy6XgBaqg1NcmZ+z/K1+xWLw50LS
         L/jiTO1SgeAlKlkhohRzDjSS5RBcNl/YEnTfKRdYf7byr6S4xSkTiqCw7mInJO8WT5tv
         ysFA==
X-Gm-Message-State: AOAM531Mj/BcyCnP3QtbWi9DhNMODLnvPAi4ulYxuxRqcHJTEqmmOXxC
        zFWhrBccy7d+lTWnurwZditEvfNs0T5v2g==
X-Google-Smtp-Source: ABdhPJwYwc3Ga5LmHPWFTfyoJhqH4MStboEdPraERN+q1LMbog5jgT9xi4ekFMHhgVR6/s5aBg654w==
X-Received: by 2002:ac8:7391:: with SMTP id t17mr19777559qtp.0.1630317930377;
        Mon, 30 Aug 2021 03:05:30 -0700 (PDT)
Received: from purple.ru.oracle.com (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.googlemail.com with ESMTPSA id w6sm10744622qkw.91.2021.08.30.03.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:05:29 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH] ext4: change EXT4_IOC_GETSTATE ioctl to _IOR
Date:   Mon, 30 Aug 2021 13:05:08 +0300
Message-Id: <20210830100508.56004-1-efremov@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

EXT4_IOC_GETSTATE is only used to read the state flags from the kernel.

Fixes: 1ad3ea6e0a69 ("ext4: add a new ioctl EXT4_IOC_GETSTATE")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 fs/ext4/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3c51e243450d..244b4dd193d3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -718,7 +718,7 @@ enum {
 #define EXT4_IOC_PRECACHE_EXTENTS	_IO('f', 18)
 /* ioctl codes 19--39 are reserved for fscrypt */
 #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
-#define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
+#define EXT4_IOC_GETSTATE		_IOR('f', 41, __u32)
 #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
 #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
 
-- 
2.31.1

