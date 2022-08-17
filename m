Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D5596747
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 04:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbiHQCJu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Aug 2022 22:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238274AbiHQCJt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Aug 2022 22:09:49 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A5C7EFEC;
        Tue, 16 Aug 2022 19:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1660702186; i=@fujitsu.com;
        bh=pe28sQSKtrN6/qiGjOSCUDh43q+ivyIlZ/SxwGp+uJw=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=d8JONErLpEHybrufVjONrQsNtKdaYiqNRBGXtoS8iytZi61gdMYtIbZy8mjUqd8bJ
         6ENYEYI3jND8C9cQ8YnZJNVIHhmQqofCx+Xi8ycxgQkeS4WeGWi+8z61S0MTOirGZq
         IDJRvqIFeC+ZCnG+rCYJIu4SwkQ5y84BnsWvUkhgTMMO+2iYeU1Bss8LUN3A+U7Gv/
         OiW+Jh8+GQbsAP/FcLHUvbkDZrjcrvDRG5D3k+YNyqX6hOVEq7glF4qPZC/QM2ylcu
         hH1D5Hv9XF6wNV+v0qoSLNRR1Jdtl6xNy4ri1eSqIBwasCVCpkV7OgVc9NWMJySbR0
         psj7At0pj18eg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRWlGSWpSXmKPExsViZ8ORpPvS90+
  Swb1bghanW/ayW8ye3sxksezBZhaLmfPusFm8an7EZrHg018Wi9aen+wO7B6L97xk8mg6c5TZ
  4/2+q2weZxYcYff4vEkugDWKNTMvKb8igTVjX/899oIfLBVzWo6zNTBOZuli5OIQEtjIKLH22
  F5WCGcJk8SeZeegnD2MEk8mtzF2MXJysAloSjzrXMAMYosIyEr8n7GaCaSIWWAlo0Tno4tMIA
  lhAWOJ5YeWs4LYLAKqEv0tv8HivAIeEksvN7OA2BICChJTHr5nhogLSpyc+QQsziwgIXHwxQt
  miBpFiUsd3xgh7AqJ14cvQcXVJK6e28Q8gZF/FpL2WUjaFzAyrWK0TirKTM8oyU3MzNE1NDDQ
  NTQ01TW20DUyNNJLrNJN1Est1S1PLS7RBXLLi/VSi4v1iitzk3NS9PJSSzYxAoM/pVjtyg7GP
  at+6h1ilORgUhLl7Wf6kyTEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgtffEygnWJSanlqRlpkDjE
  SYtAQHj5IIb4wPUJq3uCAxtzgzHSJ1ilGXY/HVK3uZhVjy8vNSpcR534IUCYAUZZTmwY2AJYV
  LjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR593kDTeHJzCuB2/QK6AgmoCOOXfwNckRJIkJK
  qoEp9m3LvNn8M39uadDdIcNkFLFP1O6+R8+MqPmmK54sLryieUJobfyVGZo5B0VNbM+3lsyvi
  wo77Ln7xoFnd8705Ba8fdHY96HitU97j9aU+4cufo6YcCTr10eGz1GP7gYfD7042yA6vFfAPI
  yT9W+OXJqFjNuFpdeezNlgysFnEDBHJNMtN9ZMN662fdO2zm/ixn4Xe44yae1IbbM+1zPBJn2
  LRHDlUz5ds6WVapsC+n+xai3ZtfjPfdfD0ma3J97avr4s60B9gIofe/Zrx8miTu6TsuSWPgx8
  UvVnxbWpXtXPor5pXDnFFf9tr+PB3v+LasoM06sY3vxn//uQ69+sC4V2bB7285LkA62Paz9UY
  inOSDTUYi4qTgQAZVDpkIUDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-565.messagelabs.com!1660702185!212978!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3116 invoked from network); 17 Aug 2022 02:09:45 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-13.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Aug 2022 02:09:45 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id EE2411AC;
        Wed, 17 Aug 2022 03:09:44 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id E2BEB1A3;
        Wed, 17 Aug 2022 03:09:44 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 17 Aug 2022 03:09:41 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <jack@suse.cz>, <oliver.sang@intel.com>, <lkp@intel.com>,
        <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <lczerner@redhat.com>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] ext4/053: Remove nouser_xattr test
Date:   Wed, 17 Aug 2022 11:10:23 +0800
Message-ID: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Plan to remove noacl and nouser_xattr mount option in kernel because they
are deprecated[1]. So remove nouser_xattr test in here.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/ext4/053 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/ext4/053 b/tests/ext4/053
index 555e474e..5d2c478a 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -439,7 +439,6 @@ for fstype in ext2 ext3 ext4; do
 	mnt oldalloc removed
 	mnt orlov removed
 	mnt -t user_xattr
-	mnt nouser_xattr
 
 	if _has_kernel_config CONFIG_EXT4_FS_POSIX_ACL; then
 		mnt -t acl
-- 
2.27.0

