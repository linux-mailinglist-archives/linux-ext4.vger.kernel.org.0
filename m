Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF112B5EC
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfL0QhV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 11:37:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:52887 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0QhV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Dec 2019 11:37:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 08:37:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,363,1571727600"; 
   d="scan'208";a="269113835"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2019 08:37:19 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iksc3-000Etr-83; Sat, 28 Dec 2019 00:37:19 +0800
Date:   Sat, 28 Dec 2019 00:36:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH v4 14/20] ext4: main commit routine for fast commits
Message-ID: <201912280016.GUXJDWZo%lkp@intel.com>
References: <20191224081324.95807-14-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224081324.95807-14-harshadshirwadkar@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Harshad,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/perf/core]
[cannot apply to ext4/dev linus/master v5.5-rc3 next-20191220]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Harshad-Shirwadkar/ext4-update-docs-for-fast-commit-feature/20191225-200339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ceb9e77324fa661b1001a0ae66f061b5fcb4e4e6
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   fs/ext4/ext4_jbd2.c:611:5: sparse: sparse: symbol '__ext4_fc_track_range' was not declared. Should it be static?
>> fs/ext4/ext4_jbd2.c:825:6: sparse: sparse: symbol 'submit_fc_bh' was not declared. Should it be static?
>> fs/ext4/ext4_jbd2.c:1156:5: sparse: sparse: symbol 'ext4_fc_perform_hard_commit' was not declared. Should it be static?
   fs/ext4/ext4_jbd2.c:500:12: sparse: sparse: context imbalance in '__ext4_dentry_update' - unexpected unlock
>> fs/ext4/ext4_jbd2.c:923:20: sparse: sparse: context imbalance in 'wait_all_inode_data' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
