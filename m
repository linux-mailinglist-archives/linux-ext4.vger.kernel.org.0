Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339BC47EC57
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Dec 2021 07:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351657AbhLXG5n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Dec 2021 01:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351653AbhLXG5n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Dec 2021 01:57:43 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C0C061757
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 22:57:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so7730278pjp.0
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 22:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+Om8CUBFbbiGYcwD1vEJMNJB8KZwFnP8OoPGSPB78A=;
        b=AxjTX43BGCBHkubVDj4xJFjp3veZ8CeoSJVzBvVndcchGGSW43PcoSkkDP+0Qn3BVF
         dtISfUCWP7zPHO8LuraVWIOvMV5YWtjIg6fmpBymkxFpwfWG8CrUrVNa1nf7vVevPwx1
         85IyFU/kxLEm8XCC97PTG639k2OI9NL5s06tEDzHhKJmEHwmIQN5q25S604r1gzPPqYE
         jRdvcM7+7yH/ZsJnEgKWWeStJaCbbqCkKCeERpOsgnYfNV5DsuR0g8mulN0LBgYzmZNv
         ZFaCZOMRuKk0QLyxmKwo0qv/1tjxr/xbMOYu1BbSRLmEASZfgiY5Fy/3EozW2ZG282nL
         VJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+Om8CUBFbbiGYcwD1vEJMNJB8KZwFnP8OoPGSPB78A=;
        b=081Fe9PyDt9fl9GCDPR8gX+5EEcDWXk4eeujch8UVGn60oJnThtcNzRMjPcdAxFUFQ
         LPrNpfwWoTo2XBidrgSfmHyU3nloCAVkutmsO+uQGVghZ9vKuNRUJge7Nax7pQLYu8VE
         dplYM348coAhCVQVSYY4l/IX1WNPgLjkO9TJ9igkcz7ZER03iiUgBcMQ9OXONqOVrGN+
         IKuaVQYKOXJ4/Uvj3FkTLFAfCQ4XXdh2ARlOKwOxDsVDhJSkuhrB+BPSfM/jzqYXRVmD
         hBndDbvcuht9lghynzoIulvgxBeJo3fqmYXgyk//8s1VCqD8rNL6HIMMkKhVpalx0N2S
         GfiQ==
X-Gm-Message-State: AOAM532vAwNJ3EauN3K/PmwtMEKdSDvCQtpWV1j+d5hcnDO3S5KnIuXZ
        gVton1HZc1KC8AOhchq3NP3bvQ==
X-Google-Smtp-Source: ABdhPJwo1+lGB/2cwbm1vE2CWTqK5ITZii/N97FqtQGMsQtVKTYXDyBjyw24JGib+W8sxRvnJuUCGg==
X-Received: by 2002:a17:90b:3a8c:: with SMTP id om12mr6709434pjb.232.1640329062678;
        Thu, 23 Dec 2021 22:57:42 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id h19sm5154089pfh.112.2021.12.23.22.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 22:57:42 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH RESEND] ext4:fix different behavior of fsync when use fast commit
Date:   Fri, 24 Dec 2021 14:57:28 +0800
Message-Id: <20211224065728.5820-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For the follow test example:
-mkdir test/
-create&write test/a.txt
-fsync test/a.txt
-crash (before a full commit)

If fast commit is used then "a.txt" will lost, while the normal
journaling can recover it.

We should keep behavior of fsync unchanged when use fast commit.

other report: https://www.spinics.net/lists/linux-ext4/msg80514.html

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/fast_commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3deb97b22ca4..4b843648ffe5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -423,7 +423,7 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 	args.op = EXT4_FC_TAG_CREAT;
 
 	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
-					(void *)&args, 0);
+					(void *)&args, 1);
 	trace_ext4_fc_track_create(inode, dentry, ret);
 }
 
-- 
2.20.1

