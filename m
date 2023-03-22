Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC926C5113
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 17:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCVQqD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Mar 2023 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCVQqB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Mar 2023 12:46:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C384491;
        Wed, 22 Mar 2023 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679503557; x=1711039557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8f7FwvNUieobevaDJ6FwYSHxrE1G7RwHb10tj/oH/6s=;
  b=EwcB7u54BJo+JCpjwrd8aVF6mubE8E3BdsXl0FK0kE3n/LeMbYM0TdWa
   N4ZNjS//Sj9kXMy3/JfpA1s7dmepWHMMNL/ETmr6/l/rm9ipR2mNcly+l
   G53jn3VB/c5E+Vl1vARKb+9IXknH3rD3fzNiIZOB7+rU8fOr6hk1/E5BP
   uIFBYTOuya10VJG/Y2091aNVgMsxRHhjstKoQ+Q1HXNVvz67W1x7rfQQL
   Xs5QvJM5QWxSsdsMVshNuv3312sH7VUlPDTjkHf6P8jxt0lhqF9S3FjXR
   5S995gJGEcQvXei6cKfNdTsQIbV1U2gDT9OXJnVOpzIAG3oDNh099S4z0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="318917430"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="318917430"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 09:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="751117881"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="751117881"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2023 09:45:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pf1as-000DVO-0p;
        Wed, 22 Mar 2023 16:45:46 +0000
Date:   Thu, 23 Mar 2023 00:45:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/3] jbd2: Avoid printing out the boundary
Message-ID: <202303230045.2JeedPWH-lkp@intel.com>
References: <20230322141206.56347-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322141206.56347-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus kees/for-next/pstore kees/for-next/kspp tytso-ext4/dev linus/master v6.3-rc3 next-20230322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/jbd2-Avoid-printing-out-the-boundary/20230322-221425
patch link:    https://lore.kernel.org/r/20230322141206.56347-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/3] jbd2: Avoid printing out the boundary
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20230323/202303230045.2JeedPWH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/6154f5a987ef2ce0084db0eb245d2c3bcde2a02a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/jbd2-Avoid-printing-out-the-boundary/20230322-221425
        git checkout 6154f5a987ef2ce0084db0eb245d2c3bcde2a02a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/jbd2/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303230045.2JeedPWH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/jbd2/journal.c: In function 'jbd2_journal_init_inode':
>> fs/jbd2/journal.c:1491:15: warning: unused variable 'p' [-Wunused-variable]
    1491 |         char *p;
         |               ^


vim +/p +1491 fs/jbd2/journal.c

470decc613ab20 Dave Kleikamp     2006-10-11  1478  
470decc613ab20 Dave Kleikamp     2006-10-11  1479  /**
f7f4bccb729844 Mingming Cao      2006-10-11  1480   *  journal_t * jbd2_journal_init_inode () - creates a journal which maps to a inode.
470decc613ab20 Dave Kleikamp     2006-10-11  1481   *  @inode: An inode to create the journal in
470decc613ab20 Dave Kleikamp     2006-10-11  1482   *
f7f4bccb729844 Mingming Cao      2006-10-11  1483   * jbd2_journal_init_inode creates a journal which maps an on-disk inode as
470decc613ab20 Dave Kleikamp     2006-10-11  1484   * the journal.  The inode must exist already, must support bmap() and
470decc613ab20 Dave Kleikamp     2006-10-11  1485   * must have all data blocks preallocated.
470decc613ab20 Dave Kleikamp     2006-10-11  1486   */
f7f4bccb729844 Mingming Cao      2006-10-11  1487  journal_t *jbd2_journal_init_inode(struct inode *inode)
470decc613ab20 Dave Kleikamp     2006-10-11  1488  {
f0c9fd5458bacf Geliang Tang      2016-09-15  1489  	journal_t *journal;
30460e1ea3e62f Carlos Maiolino   2020-01-09  1490  	sector_t blocknr;
05496769e5da83 Theodore Ts'o     2008-09-16 @1491  	char *p;
30460e1ea3e62f Carlos Maiolino   2020-01-09  1492  	int err = 0;
30460e1ea3e62f Carlos Maiolino   2020-01-09  1493  
30460e1ea3e62f Carlos Maiolino   2020-01-09  1494  	blocknr = 0;
30460e1ea3e62f Carlos Maiolino   2020-01-09  1495  	err = bmap(inode, &blocknr);
470decc613ab20 Dave Kleikamp     2006-10-11  1496  
30460e1ea3e62f Carlos Maiolino   2020-01-09  1497  	if (err || !blocknr) {
f0c9fd5458bacf Geliang Tang      2016-09-15  1498  		pr_err("%s: Cannot locate journal superblock\n",
f0c9fd5458bacf Geliang Tang      2016-09-15  1499  			__func__);
f0c9fd5458bacf Geliang Tang      2016-09-15  1500  		return NULL;
f0c9fd5458bacf Geliang Tang      2016-09-15  1501  	}
f0c9fd5458bacf Geliang Tang      2016-09-15  1502  
cb3b3bf22cf337 Jan Kara          2022-06-08  1503  	jbd2_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
f0c9fd5458bacf Geliang Tang      2016-09-15  1504  		  inode->i_sb->s_id, inode->i_ino, (long long) inode->i_size,
f0c9fd5458bacf Geliang Tang      2016-09-15  1505  		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
f0c9fd5458bacf Geliang Tang      2016-09-15  1506  
f0c9fd5458bacf Geliang Tang      2016-09-15  1507  	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
f0c9fd5458bacf Geliang Tang      2016-09-15  1508  			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
f0c9fd5458bacf Geliang Tang      2016-09-15  1509  			inode->i_sb->s_blocksize);
470decc613ab20 Dave Kleikamp     2006-10-11  1510  	if (!journal)
470decc613ab20 Dave Kleikamp     2006-10-11  1511  		return NULL;
470decc613ab20 Dave Kleikamp     2006-10-11  1512  
470decc613ab20 Dave Kleikamp     2006-10-11  1513  	journal->j_inode = inode;
900d156bac2bc4 Christoph Hellwig 2022-07-13  1514  	snprintf(journal->j_devname, sizeof(journal->j_devname),
6154f5a987ef2c Andy Shevchenko   2023-03-22  1515  		 "%pg-%lu", journal->j_dev, journal->j_inode->i_ino);
6154f5a987ef2c Andy Shevchenko   2023-03-22  1516  	strreplace(journal->j_devname, '/', '!');
8e85fb3f305b24 Johann Lombardi   2008-01-28  1517  	jbd2_stats_proc_init(journal);
470decc613ab20 Dave Kleikamp     2006-10-11  1518  
470decc613ab20 Dave Kleikamp     2006-10-11  1519  	return journal;
470decc613ab20 Dave Kleikamp     2006-10-11  1520  }
470decc613ab20 Dave Kleikamp     2006-10-11  1521  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
