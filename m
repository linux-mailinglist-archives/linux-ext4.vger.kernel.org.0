Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD801289F35
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Oct 2020 10:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgJJIOq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 10 Oct 2020 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbgJJIKW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 10 Oct 2020 04:10:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65236C0613CF
        for <linux-ext4@vger.kernel.org>; Sat, 10 Oct 2020 01:10:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 132so2306264pfz.5
        for <linux-ext4@vger.kernel.org>; Sat, 10 Oct 2020 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fX/6DwXysqCrksQgFgb+4R3alOKyGkE2+FYcNluzFrM=;
        b=MwnZBF1iUQGVFsYqwGLc+Apo7Bn30BI7DZNmscghAiu7p0fRnpIKAY/YnLwOKzU3hR
         0U16qrfiUFXwDF7rPoM54LGUKPBTdXR7lyhZ0dkbSge66SY0cUR3Pvk5DdrHccuWjePn
         6PntI9+5jEGHp7QL3Yp3w5KP8g/MKJ36ZpZs+BgkpKrOdk9xlrmJDaMx/g3It/d1XLi7
         BXPoUHKkDlnMPq9UEISUYVKJd/EKIC6v1/2tmijjIjfQNUXFQaVO7u1Sor4p/ldUhAtb
         VdOlAqJzcUthROXIDMecrsY+eTD+HQAAPPDokKITHB2gpm7L0o22KSzArjjrNe7/D5ke
         buew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fX/6DwXysqCrksQgFgb+4R3alOKyGkE2+FYcNluzFrM=;
        b=Lsg3fPhw5ojPcvOtYjRpR/K+TEwFZRHqeM5bqd70TKXPyZ312gjn3wUNktg2i8TLzX
         tDePVAVit1joaou60mp3fiQ2Qk71lCrbMIl61ZTsUbnBcHLr30RXbTt+0TjYHTnSPfCj
         oCuES4zidq9BQ1v2sOzNjyz16+ukgKIlaQt42Ub+kHL+5XIcCFdwmwnO+E/Q6TTQekQA
         IEgCLqJrCPbqoWt4DHru+3I2aKfkzfZMt2frZGKyJU2AuaO+bSq81uAklVfhxBPqHAEA
         kPlpDIspLMwjgPs+Z55flbDbvaX5y/wLakzw2hPpmt360h3IsffM02AJemoiCA3OM4+i
         vEtQ==
X-Gm-Message-State: AOAM5338srs1XPl9pp4hDo2T7HvQP8w0/JQl20wbahPt+of+QTy/VkkD
        qxkcbab7F3Xw+wD8+771kfl7e8rdwG69
X-Google-Smtp-Source: ABdhPJwUfeEHEmXZmT36oHXVxyidOPh7Ul3RlX0L5ooRNWA49t8F38LbiCaDm1GA7ZJny9n90hdg5Q==
X-Received: by 2002:a63:5404:: with SMTP id i4mr6511763pgb.334.1602317421493;
        Sat, 10 Oct 2020 01:10:21 -0700 (PDT)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id q65sm12588063pga.88.2020.10.10.01.10.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 01:10:20 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [RFC PATCH] ext4: use the normal helper to get the actual inode
Date:   Sat, 10 Oct 2020 16:10:16 +0800
Message-Id: <1602317416-1260-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Here we use the READ_ONCE to fix race conditions in ->d_compare() and
->d_hash() when they are called in RCU-walk mode, seems we can use
the normal helper d_inode_rcu() to get the actual inode.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/ext4/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 1d82336b1cd4..3bf6cb8e55f6 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -674,7 +674,7 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
 {
 	struct qstr qstr = {.name = str, .len = len };
 	const struct dentry *parent = READ_ONCE(dentry->d_parent);
-	const struct inode *inode = READ_ONCE(parent->d_inode);
+	const struct inode *inode = d_inode_rcu(parent);
 	char strbuf[DNAME_INLINE_LEN];
 
 	if (!inode || !IS_CASEFOLDED(inode) ||
@@ -706,7 +706,7 @@ static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
 {
 	const struct ext4_sb_info *sbi = EXT4_SB(dentry->d_sb);
 	const struct unicode_map *um = sbi->s_encoding;
-	const struct inode *inode = READ_ONCE(dentry->d_inode);
+	const struct inode *inode = d_inode_rcu(dentry);
 	unsigned char *norm;
 	int len, ret = 0;
 
-- 
2.20.0

