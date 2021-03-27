Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1535534B62C
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 11:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhC0Kcx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Mar 2021 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhC0Kcu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Mar 2021 06:32:50 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBC0C0613B1;
        Sat, 27 Mar 2021 03:32:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x16so4247783qvk.3;
        Sat, 27 Mar 2021 03:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sE6tIiAsht6MikQNk/MBO3N6jlznliJICBoRTqpbABk=;
        b=pjI9CIj80Xf28ziI1w0WfZcsxlEAqOhZ/eOEM0GXue7kH1gHL7hPUoYFCHUdCiOkVy
         Ow87nXHtXsKOe943L9gM7HMBXBdlkgHFYGbbPvAWeKsaZ0pTwm3UOooa4V7J7HQR9kjh
         s0uOevZzwMVfmdTrDUzDHfexNMjlI7CGg3vQwWVYR5GDgCXmg2bUwvZ4R4PbKEPb8mJ3
         W88+7Nho0Pon4cCOP3IO/MeOQVdV7XwZI3Gu3tbIiv3mzRmXdHzwV7tacEPAAAOe+aNk
         WmC0gIuIZEAdHcbyf9QMBVXgIwHBVdxcWq50TdbwX/FCFW3w/qm3jmgKkCz2ngpBwR9K
         DVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sE6tIiAsht6MikQNk/MBO3N6jlznliJICBoRTqpbABk=;
        b=a/vUCLL3xnZyIHE1BiutRtBu1i7JrGwuSw89fuVLaXAEqxp7IThvpqRAkOFTglvspS
         uMA/5wXgRfsGkoklwnqC9BfjVmRciqYsZayWvSEs051cgNUp6abjo+F4ROXwzRLdJ9fh
         Mbd3qjtJq4EQWKE0gN+V5EXBD4fip0ZhUalz2R9X1NeXEJ57w9rjkuhhDNyY9Jo+UKxZ
         q6mpjZzTOKNe5uRUNZLXSZHairmJ6dnR8yQ0G8COnWxlRKchRAILauwQpHgDHRYn5l+H
         D/tqqGnAtjudcKsPYzxVVhqWN6IOjhXImAEcdcCXfwfBkg6QHvywUfUT8kuAODKwK8R9
         XaIA==
X-Gm-Message-State: AOAM532AVj2cVVnvQmIvHQzCCyU55em2rrMAuZimeP3hr0sWN4f2ISao
        cJGWbh6+k1EyzsCiGPC7mB5O9cmKK6caLyKF
X-Google-Smtp-Source: ABdhPJw7bKc/zX9LabFfI+NOtNO+cVLHV0Jgv2HQlA5cnpv3zdzGbSymK82+LPEpLyjMy790FK0l4w==
X-Received: by 2002:a05:6214:12ec:: with SMTP id w12mr16676803qvv.54.1616841169607;
        Sat, 27 Mar 2021 03:32:49 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.35])
        by smtp.gmail.com with ESMTPSA id a14sm7292364qtw.80.2021.03.27.03.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 03:32:49 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-ext4@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] EXT4: namei.c: Fixed a typo
Date:   Sat, 27 Mar 2021 16:00:06 +0530
Message-Id: <3929edc17e96d5d89334c8ee3072f9e939d6dc3b.1616840203.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616840203.git.unixbhaskar@gmail.com>
References: <cover.1616840203.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

s/contiuation/continuation/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/ext4/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 883e2a7cd4ab..3eb07053ca3c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -956,7 +956,7 @@ static int ext4_htree_next_block(struct inode *dir, __u32 hash,
 	 * If the hash is 1, then continue only if the next page has a
 	 * continuation hash of any value.  This is used for readdir
 	 * handling.  Otherwise, check to see if the hash matches the
-	 * desired contiuation hash.  If it doesn't, return since
+	 * desired continuation hash.  If it doesn't, return since
 	 * there's no point to read in the successive index pages.
 	 */
 	bhash = dx_get_hash(p->at);
--
2.26.2

