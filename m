Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F24B7D15CB
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjJTS3e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTS3e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 14:29:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53978D8;
        Fri, 20 Oct 2023 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697826572; x=1729362572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RV7eYTrVoYda1avxZkkjEOSNEkZA1PkbTCOaAUMlZ5c=;
  b=HWwsuBto1Qh1GN4nXt55QxeQjEoQS0aqIyAmnQA8ZXm2xzoLwwA4k8PR
   PrNjsaaI8IM7JlOwXS9SBZSgeuJxDDAriJgPXQBil4FP0AYcgyRdZN3+j
   MJV2oEP3KQ/NTZQEy7RopJPw8I9bVeJqJF5HgUc+0htmO9Bzzl81i0OcJ
   MWjrcbeGj+ZrUtBwCfQQEhpBjuiE817dykUYcNGKeUDdcMeo2EgkNfkOd
   e0cMX1jspRqsE+V1p2fIvbPVcYBpNQtKTDRnGE8EWogSjZX+dIBjb/5oE
   Q4QJwVFMzPGNWqUBEWXtTlayzKNh5ZfRYLWdrBUq41QkvKF1aocJqOrej
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="390437274"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="390437274"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 11:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="881146601"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="881146601"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 11:29:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qtuFR-00000007EBH-21bP;
        Fri, 20 Oct 2023 21:29:25 +0300
Date:   Fri, 20 Oct 2023 21:29:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Baokun Li <libaokun1@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
References: <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_SBL_A autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 20, 2023 at 10:23:57AM -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2023 at 07:52, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:

...

> That said - while unlikely, mind just sending me the *failing* copy of
> the fs/quota/dquot.o object file, and I'll take a look at the code
> around that call. I've looked at enough code generation issues that
> it's worth trying..

For the sake of purity, I have rebuilt the whole tree to confirm it doesn't boot.
Here [7] is what I got.

I'll reply to this with the attached object file, I assume it won't go to the
mailing list, but should be available in your mailbox.

[7]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-jr/

-- 
With Best Regards,
Andy Shevchenko


