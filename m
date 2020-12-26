Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E536A2E2F6D
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Dec 2020 00:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgLZXzo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Dec 2020 18:55:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:49842 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgLZXzn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 26 Dec 2020 18:55:43 -0500
IronPort-SDR: sEVpXbpmnePxYDD1CViCoP5umSVyihDbOU2wUMpDesLBKA7xsYrIHqwri9YPlxwYkdnAZUrfc7
 Dxclznhs3eGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9846"; a="163999153"
X-IronPort-AV: E=Sophos;i="5.78,451,1599548400"; 
   d="scan'208";a="163999153"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2020 15:54:59 -0800
IronPort-SDR: OzOJCPEV1lW3n4K1xsV9/KWSIH1sUj9JB+0Ix0MVDSCye05nQMAsPAbIbFSgvS0HWGQfygr+Va
 FfMVjwrJdjMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,451,1599548400"; 
   d="scan'208";a="384156911"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Dec 2020 15:54:58 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ktJOj-0002DO-Np; Sat, 26 Dec 2020 23:54:57 +0000
Date:   Sun, 27 Dec 2020 07:54:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengguang Xu <cgxu519@mykernel.net>, jack@suse.com
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: [RFC PATCH] ext2: ext2_page_mkwrite() can be static
Message-ID: <20201226235402.GA43122@75b6b98162fe>
References: <20201218132757.279685-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218132757.279685-1-cgxu519@mykernel.net>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 file.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index a34119415ef16d..4a5dbf349f6e13 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -30,7 +30,7 @@
 #include "xattr.h"
 #include "acl.h"
 
-vm_fault_t ext2_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t ext2_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
@@ -47,7 +47,7 @@ vm_fault_t ext2_page_mkwrite(struct vm_fault *vmf)
 	return block_page_mkwrite_return(err);
 }
 
-const struct vm_operations_struct ext2_vm_ops = {
+static const struct vm_operations_struct ext2_vm_ops = {
 	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= ext2_page_mkwrite,
