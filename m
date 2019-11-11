Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46B88F6CA3
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2019 03:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfKKCZd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Nov 2019 21:25:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38006 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKKCZc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Nov 2019 21:25:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id a14so10194648oid.5
        for <linux-ext4@vger.kernel.org>; Sun, 10 Nov 2019 18:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HCu3swpM3JCV50k6ZcWSUdcyGBcr8prizowXxNin5Yo=;
        b=1c81wXFNSIu/f5fEVf9F9KjN7P15qofCc6uZH0bEYDARWq6otCYYqxViEA7zn/GuTt
         fBRIKGe1PL57LSVi3Yl3pQHHul9djPae0Kc1yncngkqj3Wid+l1YMDlV6S6RQt5j8Sdj
         YWJIZrjtEfUzFfGQhSF8sAEHJ9QTaR+Zfw9UyWPPVZtMa3o4iHIChTFYwrYErBZLGxwW
         DiTEhgei/DHqST5qT9oUjPX01Un0umf5uYPwuVEY6xbo7/jUIehB9cGBGm59Rf2ebLP/
         /TGEBJvDkf7oyyqXe0D+WKa1CGbwDO8iUQTTQYFmyvAF+RPs3XOEyLljvIas1GRP0n8N
         Z1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HCu3swpM3JCV50k6ZcWSUdcyGBcr8prizowXxNin5Yo=;
        b=Y+2yZMqMBIg6H6a2FNNczeQJkK0XzoxgVHbsNVoy2UFGqcG7NREf20aOyQY78pZ6ze
         WFZkzWqmKWb1/iXpnvRmSnjMuffLcE01rKI18LwPv56XuMZxvyoGLjS3m7PYRPk7kMOE
         Q+8bWZKJrt3cmj+TDpmGWNA6fAHtCfTVNlqErrC7pjy00KBZFzQDcGfLbtBXF8ut6MCC
         9BSX/t+GWfAS0pRb2srUOgJDqEwQmHa5gXv1gauZgRp3dM0/VcsuO/9MVHoIl3H9IhfP
         Jl3aHH2ORCY/RtiiPDSx6kclBHPq0UR46d5zagCRjAVIviHe2Rzn3kPaQuO3Nst5ATiy
         DqjQ==
X-Gm-Message-State: APjAAAVeyseFWDAvyOpiUieSzWkpLgnnBbM1feQWHpF3/3tH7ZUfUWZy
        1j+T/k7Q3ZBozexDobZIalX6Gw==
X-Google-Smtp-Source: APXvYqwO9M4qZjpZYl652jcC13m4seu86L7WZZYHJBH8yXU/VmSJT0DU8se+/bybcXOe14AMN2IPAQ==
X-Received: by 2002:aca:39d7:: with SMTP id g206mr20734392oia.101.1573439130470;
        Sun, 10 Nov 2019 18:25:30 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id e19sm4363985otj.51.2019.11.10.18.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 18:25:29 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] fs: ext4: remove unused variable warning in parse_options()
Date:   Sun, 10 Nov 2019 18:25:23 -0800
Message-Id: <20191111022523.34256-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit c33fbe8f673c5 ("ext4: Enable blocksize < pagesize for
dioread_nolock") removed the only user of 'sbi' outside of the ifdef,
so it caused a new warning:

fs/ext4/super.c:2068:23: warning: unused variable 'sbi' [-Wunused-variable]

Fixes: c33fbe8f673c5 ("ext4: Enable blocksize < pagesize for dioread_nolock")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f3279210f0ba9..ee8c42d8a04f0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2065,7 +2065,7 @@ static int parse_options(char *options, struct super_block *sb,
 			 unsigned int *journal_ioprio,
 			 int is_remount)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_sb_info __maybe_unused *sbi = EXT4_SB(sb);
 	char *p, __maybe_unused *usr_qf_name, __maybe_unused *grp_qf_name;
 	substring_t args[MAX_OPT_ARGS];
 	int token;
-- 
2.11.0

