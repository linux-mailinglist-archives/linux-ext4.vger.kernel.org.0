Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DF753B59B
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jun 2022 11:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiFBJBU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jun 2022 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiFBJBT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jun 2022 05:01:19 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA3208D6E
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jun 2022 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1654160476; i=@fujitsu.com;
        bh=VFbJk/8p6gtEuuhuDsiXP33HbT6ize6Aps9/UpVV6ZM=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=SzD4MDGw/Y11KsQeGa2eewleJr26KPqIjF16WqJQoUK52E9qeAEg73CSVDlwcX4kC
         ndbmy8niY7bVn1/HtyJFwGLF+AlzZWCWOxUk8bIapVORsW45nD+fb8+O80QKdi2XgC
         /CHft5J+HlGpMUzDSqevBSTJibuP5HJEkOLITVyfuNZBgGUwU6RvMK3Kv4pr5hVlVT
         Fsb7DHv7MJtWS4bdO0dZ3S5bTRt5XZZQjtBkc7G4N+ChtndiJCLmjiKfLLi0ZK/6xp
         PQVposriSo96pCi4t4fxSUi8uue+1uvqohP79wAgwK5OhtiH7WLoj84xZ/nER59Hh7
         bEzZb5YqpgOVQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsViZ8MxSTemZka
  SwfLdXBYz591hc2D0+LxJLoAxijUzLym/IoE148ecA6wFt9gr3nTeYG9gPMjWxcjFISRwlVHi
  9P4TLBDOQSaJE093Q2V2M0osuPSBuYuRk4NNQFPiWecCMFtEQEFi+Z39rCA2s4C6xPJJv5hAb
  GGBMInVu5+wdzFycLAIqEjseBgKEuYV8JCYdfcIO4gtAdQ65eF7Zoi4oMTJmU9YIMZISBx88Y
  IZokZR4lLHN0YIu0Li9eFLUHE1iavnNjFPYOSfhaR9FpL2BYxMqxitkooy0zNKchMzc3QNDQx
  0DQ1Ndc10Dc0s9RKrdBP1Ukt1y1OLS3QN9RLLi/VSi4v1iitzk3NS9PJSSzYxAkMypZht5Q7G
  lX0/9Q4xSnIwKYnyWlvNSBLiS8pPqcxILM6ILyrNSS0+xCjDwaEkwXu+GignWJSanlqRlpkDj
  A+YtAQHj5IILxMwRoR4iwsSc4sz0yFSpxgVpcR5T4P0CYAkMkrz4NpgMXmJUVZKmJeRgYFBiK
  cgtSg3swRV/hWjOAejkjCvFcgUnsy8Erjpr4AWMwEtvvZtCsjikkSElFQDk11asNVXr1ZVS7u
  n8nb8N1qXB5n8maSWz9Z98llV6S8DjU1P7BbmVlmwx8gWFe29vOmlzYIJ6WGqLqq8Du4XljxN
  dixh+FDzv8izsHlS6+JqueJHb/VCFjGW6dcHdsm6NlpbS61eqVmbU2mw+dmvZ3MzfMV4Lz+rU
  TASCdzSPXcd+/e3DDVpwQy367IikpIqeyP2HBHS1gvxcBXXYDRVepg9ZVPyvp2/9kxiP/3h5v
  qcBeobNr1tLTeZljt9x/rJXgw1TzoaHzAVRqy4VbaxN/dbQ+zFEzFnw6eGrTZUSJ/PuLVn4zK
  9tbP9nz/tsPp1ufdksPdFAQ9zx6wbgVzLZ5nq9Jz6L6ovcfTx/VQlluKMREMt5qLiRAA+h8/w
  RAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-591.messagelabs.com!1654160475!114783!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32492 invoked from network); 2 Jun 2022 09:01:16 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-8.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Jun 2022 09:01:16 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id AEED110046B
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jun 2022 10:01:15 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 98DB8100440
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jun 2022 10:01:15 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 2 Jun 2022 10:01:03 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-ext4@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] ext4: Remove deprecated flag for noacl and noxattr_user mount options
Date:   Thu, 2 Jun 2022 18:01:39 +0800
Message-ID: <1654164099-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since kernel commit f70486055ee3 ("ext4: try to deprecate noacl and
noxattr_user mount options"), we deprecated these two mount options
because no other filesystem used the

But now, acl has been used by ext4 ext2 btrfs f2fs ocfs2 and noxattr_user
has been used by ext4 ext2 f2fs ocfs2.

I think it is time to remove deprecated flag for them.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/ext4/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 450c918d68fc..8a0cc8815ee7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2116,10 +2116,6 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		else
 			return note_qf_name(fc, GRPQUOTA, param);
 #endif
-	case Opt_noacl:
-	case Opt_nouser_xattr:
-		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
-		break;
 	case Opt_sb:
 		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
 			ext4_msg(NULL, KERN_WARNING,
-- 
2.23.0

