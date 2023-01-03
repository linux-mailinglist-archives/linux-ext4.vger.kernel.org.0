Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1C65B8FF
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 02:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjACBpJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 20:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjACBpH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 20:45:07 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE862C4
        for <linux-ext4@vger.kernel.org>; Mon,  2 Jan 2023 17:45:07 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y19so12059845plb.2
        for <linux-ext4@vger.kernel.org>; Mon, 02 Jan 2023 17:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHFNPClZL6YqqHgH05AOCgftoZUseEmSrgezOmi2yxk=;
        b=O8xlIsglgdhduJo7+bHnIGvWYXQKrSsJOgHp4hqykudZgbPYD6sxab2YtDecPhe5ZZ
         z71fr2qP20MdKzggYU1OjqwHfnIJvKMDEH5uSYiZj3H9xMni/yxQhq2wDNwNsuTMdTni
         yrFzz7N0iLXSRnRlOiNqjrPASvWyEp9DnJ7DjLi+h4OR0sca6ACpauSN884KUHrSJOC2
         Q2TnCuYgoO2EZLnd60QVwr+GyfVJJUTNA8SlA/6+ysEFV4IQpqOeeKlx67MZrTstBpzL
         qr+djEBY08eU1tO0guKoya9+UA6d+xuTqABpBZ5Kkk95ZS5ZaX9erG8Fcr77jTEZckmN
         GRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHFNPClZL6YqqHgH05AOCgftoZUseEmSrgezOmi2yxk=;
        b=lF5ACt2sFXP5BxiDkSSZhZjzHbNK7wRNVniRyMbfrk+xx5dRil+Z7dZ2pmQhjBjLGY
         QGZSwWN00YliuG5YmV3PzipUbkvZ5LnHNy3S8DeXbg1W+diCQNgVrQPINUdskg9liUqA
         pY9nVKQmtQLfbri6T9pulHj/i2fqV8nwtrxFqnf1uff5ai4PnSWXQHuypomaYyDS26Tf
         V7I85MwmKqrm7Ebg1030MfMmm7u2nzJDMtcUm27EdG9aY9sZ1I+fjYr9AHjmE3PG9VtR
         Xh4gFdw9lv12no2pqW/R9uVC6jIKpsmAOn3uU07GUZM3/uaZ6uOfoMrxTbdq0Ny2i+dT
         YUIg==
X-Gm-Message-State: AFqh2kp5DAnHWlDzSQv6GKLLgshyrUmmnr4cG0Nvrhmr4wcPk73LXNKX
        R0YN40Xbo1pAgtufzhPvfHWuiQ==
X-Google-Smtp-Source: AMrXdXuCB+HjiuEKN3LL/KtS1LyAdfDKnaHcNh0fjGf9u6qf+6of2IgCpsKc3N7jkuSwHU4etbw15g==
X-Received: by 2002:a17:902:cf41:b0:192:82d4:f9b2 with SMTP id e1-20020a170902cf4100b0019282d4f9b2mr28859244plg.7.1672710306715;
        Mon, 02 Jan 2023 17:45:06 -0800 (PST)
Received: from niej-dt-7B47.. (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ab8f00b001769206a766sm20588895plr.307.2023.01.02.17.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 17:45:06 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tudor.ambarus@linaro.org
Subject: [PATCH v2 2/2] ext4: refuse to create ea block when umounted
Date:   Tue,  3 Jan 2023 09:45:17 +0800
Message-Id: <20230103014517.495275-3-jun.nie@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103014517.495275-1-jun.nie@linaro.org>
References: <20230103014517.495275-1-jun.nie@linaro.org>
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
 fs/ext4/xattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 235a517d9c17..b350510b798c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1422,6 +1422,13 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
 	uid_t owner[2] = { i_uid_read(inode), i_gid_read(inode) };
 	int err;
 
+	if (inode->i_sb->s_root == NULL) {
+		ext4_warning(inode->i_sb,
+			     "refuse to create EA inode when umounting");
+		WARN_ON(1);
+		return ERR_PTR(-EINVAL);
+	}
+
 	/*
 	 * Let the next inode be the goal, so we try and allocate the EA inode
 	 * in the same group, or nearby one.
-- 
2.34.1

