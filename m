Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8207CC201
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Oct 2023 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjJQLt4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Oct 2023 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJQLtz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Oct 2023 07:49:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEABED;
        Tue, 17 Oct 2023 04:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697543394; x=1729079394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEvXlZd7hC9Cz+cD/T7akxPJP8WqqGcQyAHC5pKOQ1M=;
  b=A+/hXgYC+ybTpuzECQWibeJ0l2qmNkeuXQFvUcIvVU+QqdR50QSJ5CzE
   mwnIyP8Ke7FyVPfRxwoymTxc+x4DjzSNpB3aweB0pn/9YE6xkgkfoSajv
   GijOOZSu/iUeZHkKqs9AFmlsQbsxL6jmHq/cn/tbRT2qmjVkI3zPOgHM0
   IQChx/wW3pUymLxN97jH5GRiJSAgNAnXxks76Pf3yuEaKl29d4gE+1+nF
   pWbkv2r3Zoal+owV1dl/YdM1tlKuYAsAjg0li0hocLyyYQgNtnX4VXueo
   zmu6ng7WNN2HoE3BhIHg9hag/tDeethIa7kELejgYWqj4nf4HGCRX+j1H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="471987901"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="471987901"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:49:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="899891366"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="899891366"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:47:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qsia6-00000006H2r-0Z4L;
        Tue, 17 Oct 2023 14:49:50 +0300
Date:   Tue, 17 Oct 2023 14:49:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ferry Toth <ftoth@exalondelft.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZS503UE540ZKUy08@smile.fi.intel.com>
References: <20230830102434.xnlh66omhs6ninet@quack3>
 <ZS5hhpG97QSvgYPf@smile.fi.intel.com>
 <ZS5iB2RafBj6K7r3@smile.fi.intel.com>
 <ZS5i1cWZF1fLurLz@smile.fi.intel.com>
 <20231017113628.coyq2wngiz5dnybs@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017113628.coyq2wngiz5dnybs@quack3>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 17, 2023 at 01:36:28PM +0200, Jan Kara wrote:
> On Tue 17-10-23 13:32:53, Andy Shevchenko wrote:

...

> That's strange because I don't see anything suspicious in the merge and
> furthermore I'd expent none of the changes in the merge to influence early
> boot in any way. Can you share your kernel config? What root filesystem do
> you use? Thanks for the report!

I just read this message and responded a few minutes before that the issue
somewhere else related to the configuration. Thanks for the prompt reply!

Still if you need to see the working/non-working configurations I can
share them.

-- 
With Best Regards,
Andy Shevchenko


