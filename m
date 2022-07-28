Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A662A58369D
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jul 2022 04:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiG1CCL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 22:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiG1CCK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 22:02:10 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D29B5004A
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 19:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658973727; i=@fujitsu.com;
        bh=XbNBJ5Nf6zmJfAYotmbOD2uKkJrmWYl5t+6u/wuFs9Q=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=kmiyAbSDbRti8NQnbjaQC0GEQa5iLlRcbNNY7clhZLLCcPC/EIvpkDX5WNG1utfR/
         6KRTiuZ3B2PI1s3pEGP7uXk73zC4UsQI3SK4cs0AD3pqey3iQ61jG6ufe9wUnqkOSx
         LusOgBqyyaggayrR9o2eXDH9s7bIov+Kwr9WzGoc60S2sQ2Scwp6Fz1r57KioOh6fR
         VolGkxh1p3hryY+RnlB+F6M3C8SVT/G2Bt9/WleIN+G1Hz/uTvg7sOfAZgfNcaW9r3
         cw6fSrBiR0w7Benzzz9UXq8gjzkzNWnLljCw24z+B+VMFCphUGFQRtC4WgyXCTc34L
         BPtLASMIyF1PA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRWlGSWpSXmKPExsViZ8ORqCv37mG
  SwdEeHYvLT/gsZk9vZrL4uWwVu8WyB5tZLGbOu8Nm0drzk92BzWPTqk42j6YzR5k93u+7yuZx
  ZsERdo/Pm+QCWKNYM/OS8isSWDOWf9rKUvBLuOLpgl/sDYwnBbsYuTiEBLYwSnS2bGKBcJYzS
  Zz+1ssI4exhlLi15gtQhpODTUBT4lnnAmYQW0RAQWL5nf2sIDazQDejxJVtpSC2sICbRNuEU2
  D1LAKqElNOPGACsXkFPCS27ZzJCGJLAPVOefieGSIuKHFy5hMWiDkSEgdfvGCGqFGUuNTxDaq
  +QuL14UtQcTWJq+c2MU9g5J+FpH0WkvYFjEyrGK2SijLTM0pyEzNzdA0NDHQNDU11TXWNTE31
  Eqt0E/VSS3XLU4tLdA31EsuL9VKLi/WKK3OTc1L08lJLNjECgz2lmPX/Dsbuvp96hxglOZiUR
  HlnLnyYJMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCd9MroJxgUWp6akVaZg4w8mDSEhw8SiK8US
  Bp3uKCxNzizHSI1ClGRSlxXvv7QAkBkERGaR5cGyzaLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhT
  nYFQS5t3wDGgKT2ZeCdz0V0CLmYAWb1F4ALK4JBEhJdXAtGyJwJHak4XMxwIn8z8SV6rP4Fij
  Xnj8zIq1/7KN2/aYLfecb9B6Pt7zT17gPyWuWxdqNzlHRs5W3qvd9jTw+LuWz2zbpi3u/L38e
  wvjmigVa+ebbSdi+gW6LaNDK//v+LQ/7fjMV5uVb3t/XpPwpCfzxA2fZ6sN5qinxPdwatmfuv
  /XOPTHvLcy2boZzseePs64PPN32nKN0icHOqeU/JiuuLhLrObuvwdTtws4yoqwNmZOPbueoTO
  sra5AfcGeV2/E8wOTl1+J3afnePx9wv/o7a3vH7TmzJNNmPvkvQ+TPINy/KrmW08qjG9fPDC3
  8rPPoowCGd2/QfZeu9JKc6T7yy27udauk7js92DOVyWW4oxEQy3mouJEANw/9EpxAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-587.messagelabs.com!1658973726!275102!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28741 invoked from network); 28 Jul 2022 02:02:06 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-9.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Jul 2022 02:02:06 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 45103100197;
        Thu, 28 Jul 2022 03:02:06 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 38FBA100043;
        Thu, 28 Jul 2022 03:02:06 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 28 Jul 2022 03:02:03 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <lczerner@redhat.com>, <djwong@kernel.org>,
        <jlayton@kernel.org>, <jack@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1] ext4: Remove deprecated noacl/nouser_xattr options
Date:   Thu, 28 Jul 2022 11:02:49 +0800
Message-ID: <1658977369-2478-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These two options should have been removed since 3.5, but none notices it.
Recently, I and Darrick found this. Also, have some discussion for this[1][2][3].

So now, let's remove them.

Link: https://lore.kernel.org/linux-ext4/6258F7BB.8010104@fujitsu.com/T/#u[1]
Link: https://lore.kernel.org/linux-ext4/20220602110421.ymoug3rwfspmryqg@fedora/T/#t[2]
Link: https://lore.kernel.org/linux-ext4/08e2ca4c8f6344bdcd76d75b821116c6147fd57a.camel@kernel.org/T/#t[3]
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/ext4/super.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 845f2f8aee5f..1eff864069c1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1576,7 +1576,7 @@ enum {
 	Opt_bsd_df, Opt_minix_df, Opt_grpid, Opt_nogrpid,
 	Opt_resgid, Opt_resuid, Opt_sb,
 	Opt_nouid32, Opt_debug, Opt_removed,
-	Opt_user_xattr, Opt_nouser_xattr, Opt_acl, Opt_noacl,
+	Opt_user_xattr, Opt_acl,
 	Opt_auto_da_alloc, Opt_noauto_da_alloc, Opt_noload,
 	Opt_commit, Opt_min_batch_time, Opt_max_batch_time, Opt_journal_dev,
 	Opt_journal_path, Opt_journal_checksum, Opt_journal_async_commit,
@@ -1662,9 +1662,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("oldalloc",		Opt_removed),
 	fsparam_flag	("orlov",		Opt_removed),
 	fsparam_flag	("user_xattr",		Opt_user_xattr),
-	fsparam_flag	("nouser_xattr",	Opt_nouser_xattr),
 	fsparam_flag	("acl",			Opt_acl),
-	fsparam_flag	("noacl",		Opt_noacl),
 	fsparam_flag	("norecovery",		Opt_noload),
 	fsparam_flag	("noload",		Opt_noload),
 	fsparam_flag	("bh",			Opt_removed),
@@ -1814,13 +1812,10 @@ static const struct mount_opts {
 	{Opt_journal_ioprio, 0, MOPT_NO_EXT2},
 	{Opt_data, 0, MOPT_NO_EXT2},
 	{Opt_user_xattr, EXT4_MOUNT_XATTR_USER, MOPT_SET},
-	{Opt_nouser_xattr, EXT4_MOUNT_XATTR_USER, MOPT_CLEAR},
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 	{Opt_acl, EXT4_MOUNT_POSIX_ACL, MOPT_SET},
-	{Opt_noacl, EXT4_MOUNT_POSIX_ACL, MOPT_CLEAR},
 #else
 	{Opt_acl, 0, MOPT_NOSUPPORT},
-	{Opt_noacl, 0, MOPT_NOSUPPORT},
 #endif
 	{Opt_nouid32, EXT4_MOUNT_NO_UID32, MOPT_SET},
 	{Opt_debug, EXT4_MOUNT_DEBUG, MOPT_SET},
@@ -2120,10 +2115,6 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
2.27.0

