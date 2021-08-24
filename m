Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F7F3F57C6
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Aug 2021 07:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhHXF4f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Aug 2021 01:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhHXF4e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Aug 2021 01:56:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F74C061575;
        Mon, 23 Aug 2021 22:55:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l3so15869503qtk.10;
        Mon, 23 Aug 2021 22:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FEEhbunvDteSPSEQiaiXD+V/tL/q7V9ooJr+nkkYsL0=;
        b=dievfyJ3/AgtuwGCikiR1DVKDR3Eb5JzHhx6gs4zw67YQCYeSH4/K0YUECOZvU62Vp
         Rd+c5DzS1CHhDXyLmLdh4RqgfiYFhtkRdDk92rUV/bNIqT4dY6OqWSvdlymeuOxim2an
         7A1f0b5ieYKYFAsxWmFhSNWQTnX/RtFOm/w0UdivjYW/vN+RPKfuXyW8eJvQ+eF+ZhRi
         itCJjxpQTMWfdCi6UGUsVXWllkbubv0iHt/iYhVroGQXxQMhklPoQfi5u5wnarutw9lr
         cUoV+47KVQPFAz4FHmagJZulFVoIjrIHN4h5/Janhhbqy4OkvBLz6ItSF3iV9PGfk0cA
         KScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FEEhbunvDteSPSEQiaiXD+V/tL/q7V9ooJr+nkkYsL0=;
        b=Och91O3/K/QRF1o7pxiSE+uQ4ot1jg2MZaTAg7iIEH6PEWlC0LQszRZrFInEH5ljlS
         ujjkV0/dEX69UQ3jozMYgODPdgCtd2uC6ddSVxiVmS08lKSVPP4/gIpy8PipNl6PafJp
         dNyw6k4AxlWzOoDsJPjSuxwa43K9HWBij+UaFsg7b+8O79G9EyVAmM54UGPQlqucc7qu
         uObaH1jw1Y8eNwWfqRSGU2MYvkL8NidiZr1JeFAecf1B3lE0+RNaBvPkjr+LbXKXvIpr
         iin7k3mZBukRijfK8f+HDTSV2ZgrfwI0Zrm4+cQxfHRP8POvjSbINHT4bhFCwCK2agTs
         F8fQ==
X-Gm-Message-State: AOAM530B0AtIdtpfUVdmZrfVLIG7Rgr9iX8x22o67vxaOOXowTuYHdpQ
        DTXdfU0MI1zi4DiXeTJv0PVLyxe7jFM=
X-Google-Smtp-Source: ABdhPJzfmobXqq9XUpJ/qPGOsxgImkN+WkNhzhfj6GgG52wKG3nrmWVU364LBTaUtdq7SXpnM+8ATw==
X-Received: by 2002:ac8:ec4:: with SMTP id w4mr33754148qti.30.1629784550320;
        Mon, 23 Aug 2021 22:55:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p123sm10307929qke.94.2021.08.23.22.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 22:55:49 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     tytso@mit.edu
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ext4:namei: fix boolreturn.cocci warnings
Date:   Mon, 23 Aug 2021 22:55:43 -0700
Message-Id: <20210824055543.58718-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

Return statements in functions returning bool should use true/false
instead of 1/0.

./fs/ext4/namei.c:1441:12-13:WARNING:return of 0/1 in function
'ext4_match' with return type bool

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index f3bbcd4..b5cb32d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1438,7 +1438,7 @@ static bool ext4_match(struct inode *parent,
 					fname->hinfo.minor_hash !=
 						EXT4_DIRENT_MINOR_HASH(de)) {
 
-					return 0;
+					return false;
 				}
 			}
 			return !ext4_ci_compare(parent, &cf, de->name,
-- 
1.8.3.1


