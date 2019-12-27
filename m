Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E8C12B430
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 12:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL0LQv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 06:16:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:35886 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfL0LQv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Dec 2019 06:16:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 03:16:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,362,1571727600"; 
   d="scan'208";a="212621126"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Dec 2019 03:16:50 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iknbt-0003xx-T5; Fri, 27 Dec 2019 19:16:49 +0800
Date:   Fri, 27 Dec 2019 19:16:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH] ext4: __ext4_fc_track_range() can be static
Message-ID: <20191227111600.vn3t4tvjlztvq5gj@4978f4969bb8>
References: <20191224081324.95807-7-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224081324.95807-7-harshadshirwadkar@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Fixes: 9b03f2f7eee6 ("ext4: add generic diff tracking routines and range tracking")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ext4_jbd2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 0907b1b913013..b65625bbe7146 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -414,7 +414,7 @@ struct __ext4_fc_track_range_args {
 #define MIN(__a, __b)  ((__a) < (__b) ? (__a) : (__b))
 #define MAX(__a, __b)  ((__a) > (__b) ? (__a) : (__b))
 
-int __ext4_fc_track_range(struct inode *inode, void *arg, bool update)
+static int __ext4_fc_track_range(struct inode *inode, void *arg, bool update)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct __ext4_fc_track_range_args *__arg =
