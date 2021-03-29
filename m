Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECF34C266
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 06:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhC2EGj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 00:06:39 -0400
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:44550 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2EGI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Mar 2021 00:06:08 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 00:06:08 EDT
Received: from SZ-11126892.vivo.xyz (unknown [58.250.176.229])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 9E6CC540371;
        Mon, 29 Mar 2021 11:58:06 +0800 (CST)
From:   Fengnan Chang <changfengnan@vivo.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     Fengnan Chang <changfengnan@vivo.com>
Subject: [PATCH] ext4: fix error code in ext4_commit_super
Date:   Mon, 29 Mar 2021 11:57:59 +0800
Message-Id: <20210329035800.648-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.29.2.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUpJSkNIHU0aGk9DVkpNSk1CQktJQ01DQ0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6Txw5ST8PCjEtEz9LMw8I
        NTEKC0NVSlVKTUpNQkJLSUNMTE9DVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
        WU5DVUlOS1VKTE1VSUlCWVdZCAFZQUpIT0o3Bg++
X-HM-Tid: 0a787c21b3b9b038kuuu9e6cc540371
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We should set the error code when ext4_commit_super check argument
failed.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 03373471131c..5440b8ff86a8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5501,7 +5501,7 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 	int error = 0;

 	if (!sbh || block_device_ejected(sb))
-		return error;
+		return -EINVAL;

 	/*
 	 * If the file system is mounted read-only, don't update the
--
2.29.0

