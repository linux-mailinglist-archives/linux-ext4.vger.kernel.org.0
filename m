Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B412FC3CC
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Jan 2021 23:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405466AbhASOcp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jan 2021 09:32:45 -0500
Received: from m12-11.163.com ([220.181.12.11]:51586 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405095AbhASLDf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 19 Jan 2021 06:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=uJAp7e5ypVZ4XLiOT5
        4yrh5KpEtB2S1xmeBJJYkfdgE=; b=lObkR0u28ixdwmm1NAJ2tKz6oB/lV3CQt3
        wJo9Q9bo/6ETaaeKa8TaLVBl64yUvfwhzRzvHFr0sTiM23qFVmkSMmer5xLPw75T
        38DSdkCJaRbl06UQPrmV2XVnOtbimeKjMvNONgMQ+uJgIChU/+MXu4z4IyqW225h
        w+9V9u2gA=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp7 (Coremail) with SMTP id C8CowACXTHYavAZgerdFJg--.35392S4;
        Tue, 19 Jan 2021 19:01:54 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] ext4: stop update inode before return
Date:   Tue, 19 Jan 2021 03:01:21 -0800
Message-Id: <20210119110121.36656-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowACXTHYavAZgerdFJg--.35392S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWxCry8ArW5Cry3Kr17Wrg_yoW3Grb_Za
        y0vw4xKrZ8Zwn3Cws5WF4avrn293yruF1rZrWxtF47Za40ya98uF4qqF9xAF4DWr12gr9x
        ArykJFySyryxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeWlk3UUUUU==
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDhkfclXly7W0CQABsI
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Stop inode updating before returning the error code.

Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/ext4/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c173c8405856..64039bbb656d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5389,8 +5389,10 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 			inode->i_gid = attr->ia_gid;
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
-		if (unlikely(error))
+		if (unlikely(error)) {
+			ext4_fc_stop_update(inode);
 			return error;
+		}
 	}
 
 	if (attr->ia_valid & ATTR_SIZE) {
-- 
2.17.1

