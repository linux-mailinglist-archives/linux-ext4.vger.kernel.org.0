Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1916C6847
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 13:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCWM14 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 08:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCWM1n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 08:27:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF252233D0;
        Thu, 23 Mar 2023 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679574462; x=1711110462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FRzwRP38LV+jCz/x8LDx7T/2ywMp/f+ziP/0J2e9bvc=;
  b=OCD68J1NX7vX2RWmQOEghg37P4iVKXJ62FNd6q0GOrLZMfE9J4S9uhLA
   VIz3OGBO4Im5FF92ki0SnP5lQp2T8n4vpzwAcl+nF6bj3YtDfdaEY2CWQ
   KL8sj+HXYZfMKNF7CELNDfyQpO3ZvXbbnJ92mKF0vCSEfVb5yoNuqq02o
   nJb4g7h4Zz4jIaahMnkbgulw9sNpKzI1w+YugQu8SvWc+ZE2EXphSPGvx
   MewNxhfy9j3cG6pxGA5VpuIDKK1aBB26MZOM4nZpTMVWgnw0eD8oBbtz3
   zv0+wZ6vL/4cU55gpw5kmIab5cYF5hY64flXKdUiYmN4dNzMkoJyYbAwn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="425749847"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="425749847"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 05:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="659579104"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="659579104"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2023 05:27:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pfK2b-007VT8-15;
        Thu, 23 Mar 2023 14:27:37 +0200
Date:   Thu, 23 Mar 2023 14:27:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/3] jbd2: Avoid printing out the boundary
Message-ID: <ZBxFuSZBRCAM+OQg@smile.fi.intel.com>
References: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
 <20230322141206.56347-2-andriy.shevchenko@linux.intel.com>
 <20230323095346.ibpv25xjjf6rozpv@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323095346.ibpv25xjjf6rozpv@quack3>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 23, 2023 at 10:53:46AM +0100, Jan Kara wrote:
> On Wed 22-03-23 16:12:04, Andy Shevchenko wrote:
> > Theoretically possible that "%pg" will take all room for the j_devname
> > and hence the "-%lu" will go out the boundary due to unconditional
> > sprintf() in use. To make this code more robust, replace two sequential
> > s*printf():s by a single call and then replace forbidden character.
> > It's possible to do this way, because '/' won't ever be in the result
> > of "-%lu".
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you! I'll incorporate this into v2 with dropping not anymore used
variable (as found by LKP).

-- 
With Best Regards,
Andy Shevchenko


