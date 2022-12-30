Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EAD659779
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Dec 2022 12:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiL3LAF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Dec 2022 06:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiL3LAC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Dec 2022 06:00:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0910F1A3B4
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 03:00:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ge16so18272279pjb.5
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 03:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahkStRU6mZ/j+Lj49hs0SrtIZtOi4h+JM4lKoZJx6Y0=;
        b=e3HEINbnqThpfVCwEBmANE9t6wazfU0CqSlTPViHpaoGjovSAYUApwjFm3t8bmC8l6
         msnEcLQsf9yJERT6yLriiVMPvG/rqyHdhMf7Oc4EVeTnLUlny2erObvsxbvgWLc94I0I
         Hfp398jakVZquSf0v2Q9BHn1P6pKwBQHP5I/dLz8yzRL9RQxcpX34Zxq9OvNceDdZeyw
         SzgJQgzUYuE2KS+7/VcVwbRdxLh6rmG4s8b1YGed1CLJSkOoRtVcy4imn6UJsTICbBWQ
         /pEPtUxYaFybK7GN6cWXHifeJEDCzReTOMtohU/fvz18qaMAUIZZH5Gnwn+xEAQ/wB/2
         eufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahkStRU6mZ/j+Lj49hs0SrtIZtOi4h+JM4lKoZJx6Y0=;
        b=mCCuL/51K8RnWeKTWNY5Z40nVGnpeorRy26MOpOZPywqAVkPXArGPllIultdzrNdSE
         kaB2MAyn9DlV39daNrYiW/VuUE1roYPO34L+FqTfkq0iClFsSO8SuWyWQ2h+nEs6hAl/
         ZTzWiUbJGSfq1F4AACZbJ1b5SUonjrVqKmMlzaaKdjFzQio2b6iuh/dK4tq6tusHoGzY
         yVEi0JZciJwSXbIshkjgZk96TQD3jhGX/VpO6jaBmHL9WjLZNjBx6Jmwml6nFkUqqDmr
         3WSZb5fXnPLYYrJufg99OQP2CfpvylgeJ+DCEKriWUFjp5jAfnuo2Xh2gfKLa9RtgsZ1
         Jk9A==
X-Gm-Message-State: AFqh2kr35nYOgm9xp2+Jb45BG/JLeJB/N5h/pCPJbm2ShTpVOwMQh9lo
        6EjfI8yGrU6hEx1LWtBGjHiSZp/ck+lE+FQi
X-Google-Smtp-Source: AMrXdXsyQDUkLuk1pPCTuqvSh6hUujgj2sq5fk5LduCCvyPo3tu6i7R7rVxBV7hT5ru5hZfHl2QdfQ==
X-Received: by 2002:a17:902:848d:b0:189:5f5c:da1d with SMTP id c13-20020a170902848d00b001895f5cda1dmr31017474plo.18.1672398001764;
        Fri, 30 Dec 2022 03:00:01 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b00186a437f4d7sm14662525plh.147.2022.12.30.02.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 03:00:01 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tudor.ambarus@linaro.org
Subject: [PATCH 2/2] ext4: refuse to create ea block when umounted
Date:   Fri, 30 Dec 2022 19:00:16 +0800
Message-Id: <20221230110016.476621-2-jun.nie@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230110016.476621-1-jun.nie@linaro.org>
References: <20221230110016.476621-1-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ea block expansion need to access s_root while it is
already set as NULL when umount is triggered. Refuse this
request to avoid panic.

Reported-by: syzbot+2dacb8f015bf1420155f@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=3613786cb88c93aa1c6a279b1df6a7b201347d08
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 fs/ext4/xattr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 235a517d9c17..ac58494e49b6 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1422,6 +1422,12 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
 	uid_t owner[2] = { i_uid_read(inode), i_gid_read(inode) };
 	int err;
 
+	if (inode->i_sb->s_root == NULL) {
+		ext4_error(inode->i_sb,
+			   "refuse to create EA inode when umounting");
+		return ERR_PTR(-EINVAL);
+	}
+
 	/*
 	 * Let the next inode be the goal, so we try and allocate the EA inode
 	 * in the same group, or nearby one.
-- 
2.34.1

