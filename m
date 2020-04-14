Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6551AA92B
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636317AbgDONzM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633760AbgDONzI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 09:55:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4632AC061A0C
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 06:55:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so12364077wrg.11
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYcapwzeMColCF8KnFlRv/qYBOctw6ROjcF5rd7fgio=;
        b=L4NZs9TE/Sq/IuYG9by7tqgcKwdDZdhyJYlHEM763vaPLeIuLZi68v7mE3GoFIO9bU
         5y0P8Gt1FxloMsNujyLbNe3MvWXIPGFLIIpjVmzVcoeqSMGJ3XbT5JNot1Jf03jZOcxx
         ZNyseQcX2GTac6GGMQFitlkiUD69SgsJapwfaVp5KUjdwEBt+vDfLWOm7UYm+wohOK0Q
         J8/TULf4OVVPQjD5OWihd9J4hkyRyf4voJYnRuxmmX71XCImL5l+FFwHAdeBG0f4Urdn
         1J7rLfs9gNjtTMhzLFO2zX+BU2KTkVlehZmvq7XCD67gmz2zDmMGXedl2DOHmBZMSWNX
         EEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYcapwzeMColCF8KnFlRv/qYBOctw6ROjcF5rd7fgio=;
        b=aFpyfPDCcPmoypdM7yIB4Hs9H3RNRO/cCE2FxEbA2nuhSwk6QHpqtFdAVWFg63TlY7
         lohY9AlP1m6Qefhl025pBp0rRVhcf/Q9cnlzTMK+JqoTcYG5tYbpnNIIf7YwsQx/J1NG
         UjvjHKcpFa38ohcCaN/M7vTpRsqDuOwUpBGWLCsPMlCi/xFrnofzNvCPFBHJEQ39zdVQ
         jGOGfUt4lamkNu1Ye0HaD5NjzfroA7dioK903lFcG8kQ4it/swKoIP++l+1W7+iB50j3
         RMrnJ3stVckoqcdFctM1/Tu3c5lmqGwF337XOPPEnP+++eAUXpHnW5QA5vsK/iyEzPsh
         CEEw==
X-Gm-Message-State: AGi0PubXCyPi0Xt64aNzOcA0YyO0zSHUOVLPUfAHBfuGGah4Lnp2QJhx
        2ALo5tVkyUdPpVHVlXpaf1k=
X-Google-Smtp-Source: APiQypJ1G4ip7RLXdF+cSQkH/3D1z069r3IsOYYYZnDC3ADJ70r5dRymqDfitFhc+W38P4Sk4g+/VQ==
X-Received: by 2002:adf:cc88:: with SMTP id p8mr17308861wrj.21.1586958906826;
        Wed, 15 Apr 2020 06:55:06 -0700 (PDT)
Received: from localhost.localdomain ([31.4.236.56])
        by smtp.gmail.com with ESMTPSA id x23sm15346676wmj.6.2020.04.15.06.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:55:06 -0700 (PDT)
From:   root <carlosteniswarrior@gmail.com>
X-Google-Original-From: root <root@localhost.localdomain>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.orfg,
        =?UTF-8?q?Carlos=20Guerrero=20=C3=81lvarez?= 
        <carlosteniswarrior@gmail.com>
Subject: [PATCH] EXT4: acl: Fix a style issue
Date:   Wed, 15 Apr 2020 00:51:47 +0200
Message-Id: <20200414225147.69942-1-root@localhost.localdomain>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>

Fixed an if statement where braces were not needed.

Signed-off-by: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>
---
 fs/ext4/acl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 8c7bbf3e566d..b3eba92f38f5 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -215,9 +215,8 @@ __ext4_set_acl(handle_t *handle, struct inode *inode, int type,
 				      value, size, xattr_flags);
 
 	kfree(value);
-	if (!error) {
+	if (!error)
 		set_cached_acl(inode, type, acl);
-	}
 
 	return error;
 }
-- 
2.25.2

