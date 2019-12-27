Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2768912B431
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 12:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfL0LQw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 06:16:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:29076 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfL0LQv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Dec 2019 06:16:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 03:16:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,362,1571727600"; 
   d="scan'208";a="215169594"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2019 03:16:50 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iknbu-0004Aq-Ep; Fri, 27 Dec 2019 19:16:50 +0800
Date:   Fri, 27 Dec 2019 19:15:22 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH v4 07/20] ext4: add generic diff tracking routines and
 range tracking
Message-ID: <201912271803.9D3k70fT%lkp@intel.com>
References: <20191224081324.95807-7-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224081324.95807-7-harshadshirwadkar@gmail.com>
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

>> fs/ext4/ext4_jbd2.c:417:5: sparse: sparse: symbol '__ext4_fc_track_range' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
