Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD65F24C9B3
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 03:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHUBzf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 21:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgHUBzb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Aug 2020 21:55:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE32CC061386
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id r11so280438pfl.11
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLrfZuGduAYWA2jp6qtqwHn+pLwwoUGpT0wZFHRYyEs=;
        b=gjMiezsJMU7tG5azk4wG5yZPISFdItw5n1Xeq8bXHNlbINrLyUc+3yVmZ5d4HpBvuH
         PihsXay7fBZauUtNcsIh7gFXKsarU6Yj8Rx0ooI1YZnVLRjO1fHsM9q2eULEUWSPIPhB
         VKDRUE7/ab94smI8GGKV/mNEk6eEbCI8K5TEXNiA9Ar2TkDH1i44rfF+AkcZh3zqKldc
         ZyTVNcY00gzrel8SS9IXQ6HUcVmr0GniAUZS5lPXLlxAEggEQanjLhnV7X/UTwLOU7I/
         JrXP7CUEkgv2OorwoletABMWRjHqsclOY9+x/30JiIfarcm6jB5F7z3cSF8i9peegnKi
         Lcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLrfZuGduAYWA2jp6qtqwHn+pLwwoUGpT0wZFHRYyEs=;
        b=cfCkLcdVaKxux1jl/JFbWC8U+5VakJ9F+TjqRUe27sOxC8NWJuTgcU/0/zpQ5GeHh6
         uElUaKiGdGDAiKO2nH7KTM2rQdE0QgmpbqJ5feBcBcxBEGQHwyhRYq0OS4f/yqy8CcLu
         drJLwDmmyifUfyOj6IpVnzkv5NvPvKw2fbxAcThEMYN9P0ac1Ng3VZOSwH29AmQHjmhB
         nLmosWXjuhyslRitA/hWQqhzfj4AmOIoyyHT+gpoHf9/dBX4a+i9Am475IAVBkEjz95b
         AW6TTUIOJzpdRtFpkLGWWXYx034gxXMYvIkEU2zwIQApHPOIiUEawL4gATwfCGYbbi8T
         lYSA==
X-Gm-Message-State: AOAM533UjbC9foXyAQVK+76K/pKdUBWM192hriTeDR9YhdW0rVTp5qBJ
        TQ6KoQcvhLaWJSzmSVAaJ4vN88z19FE=
X-Google-Smtp-Source: ABdhPJw22eDA/HQI6EmP5/wr9cXjegeeHoL2Xy2G7plv3WdOauoQZNiayYir2Yz63ePxc/lU4OXRPQ==
X-Received: by 2002:a62:1714:: with SMTP id 20mr577955pfx.133.1597974929774;
        Thu, 20 Aug 2020 18:55:29 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o15sm370191pfu.167.2020.08.20.18.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:55:28 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [RFC PATCH v2 1/9] ext4: add handling for extended mount options
Date:   Thu, 20 Aug 2020 18:55:15 -0700
Message-Id: <20200821015523.1698374-2-harshads@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821015523.1698374-1-harshads@google.com>
References: <20200821015523.1698374-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

We are running out of mount option bits. Add handling for using
s_mount_opt2. This patch was originally submitted as a part of fast
commit patch series. Resending it here with this patch series too.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/super.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 13bdddc081e0..656eccf6fc9b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1738,6 +1738,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
 #define MOPT_SKIP	0x0800
+#define MOPT_2		0x1000
 
 static const struct mount_opts {
 	int	token;
@@ -2207,10 +2208,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 			WARN_ON(1);
 			return -1;
 		}
-		if (arg != 0)
-			sbi->s_mount_opt |= m->mount_opt;
-		else
-			sbi->s_mount_opt &= ~m->mount_opt;
+		if (m->flags & MOPT_2) {
+			if (arg != 0)
+				sbi->s_mount_opt2 |= m->mount_opt;
+			else
+				sbi->s_mount_opt2 &= ~m->mount_opt;
+		} else {
+			if (arg != 0)
+				sbi->s_mount_opt |= m->mount_opt;
+			else
+				sbi->s_mount_opt &= ~m->mount_opt;
+		}
 	}
 	return 1;
 }
-- 
2.28.0.297.g1956fa8f8d-goog

