Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695AF172E0C
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2020 02:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgB1BOb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Feb 2020 20:14:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:60164 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbgB1BOb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 27 Feb 2020 20:14:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 17:14:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="230951144"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Feb 2020 17:14:29 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j7UEW-0002WU-Em; Fri, 28 Feb 2020 09:14:28 +0800
Date:   Fri, 28 Feb 2020 03:18:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, jack@suse.cz, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: [RFC PATCH] ext4: ext4_iomap_xattr_ops can be static
Message-ID: <20200227191849.GA79833@5ae7410f0801>
References: <2341a116e39ff0934b1f90aee8f4e10ac0371648.1582800839.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2341a116e39ff0934b1f90aee8f4e10ac0371648.1582800839.git.riteshh@linux.ibm.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Fixes: e3d16669487e ("ext4: Move ext4_fiemap to use iomap framework.")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 extents.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 204795232ce7e..42eeedd9db00c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4915,7 +4915,7 @@ static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
 	return error;
 }
 
-const struct iomap_ops ext4_iomap_xattr_ops = {
+static const struct iomap_ops ext4_iomap_xattr_ops = {
 	.iomap_begin		= ext4_iomap_xattr_begin,
 };
 
