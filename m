Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C191302E8
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Jan 2020 16:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgADPFl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 Jan 2020 10:05:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:13333 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgADPFl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 4 Jan 2020 10:05:41 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2020 07:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,395,1571727600"; 
   d="scan'208";a="217018878"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2020 07:05:40 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1inkzk-0008wQ-2W; Sat, 04 Jan 2020 23:05:40 +0800
Date:   Sat, 4 Jan 2020 23:04:57 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: [ext4:pu 13/14] fs/ext4/namei.c:1424:12-13: WARNING: return of 0/1
 in function 'ext4_match' with return type bool
Message-ID: <202001042353.ELj62MwN%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git pu
head:   84df4cb550cf6bfd1d92585fb11736774d07cad5
commit: 50d710db6f001ce37e13efd62b09bd8c0fc593e8 [13/14] ext4: Hande casefolding with encryption

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> fs/ext4/namei.c:1424:12-13: WARNING: return of 0/1 in function 'ext4_match' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
