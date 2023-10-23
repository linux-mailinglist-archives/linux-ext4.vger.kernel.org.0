Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF2D7D351D
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Oct 2023 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjJWLp3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Oct 2023 07:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjJWLpN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Oct 2023 07:45:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDEDB;
        Mon, 23 Oct 2023 04:45:11 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="385701223"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="385701223"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="874681317"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="874681317"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:45:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1qutMn-00000007vRG-3QFa;
        Mon, 23 Oct 2023 14:45:05 +0300
Date:   Mon, 23 Oct 2023 14:45:05 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Kees Cook <kees@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTZcwU+nCB0RUI+y@smile.fi.intel.com>
References: <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
 <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
 <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
 <ZTLk1G0KCF7YNjRx@surfacebook.localdomain>
 <BF6761C0-B813-4C98-9563-8323C208F67D@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF6761C0-B813-4C98-9563-8323C208F67D@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Oct 21, 2023 at 04:36:19PM -0700, Kees Cook wrote:
> On October 20, 2023 1:36:36 PM PDT, andy.shevchenko@gmail.com wrote:
> >That said, if you or anyone has ideas how to debug futher, I'm all ears!
> 
> I don't think this has been tried yet:
> 
> When I've had these kind of hard-to-find glitches I've used manual
> built-binary bisection. Assuming you have a source tree that works when built
> with Clang and not with GCC:
> - build the tree with Clang with, say, O=build-clang
> - build the tree with GCC, O=build-gcc
> - make a new tree for testing: cp -a build-clang build-test
> - pick a suspect .o file (or files) to copy from build-gcc into build-test
> - perform a relink: "make O=build-test" should DTRT since the copied-in .o
> files should be newer than the .a and other targets
> - test for failure, repeat
> 
> Once you've isolated it to (hopefully) a single .o file, then comes the
> byte-by-byte analysis or something similar...
> 
> I hope that helps! These kinds of bugs are super frustrating.

I'm sorry, but I can't see how this is not an error prone approach.
If it's a timing issue then the arbitrary object change may help and it doesn't
prove anything. As earlier I tried to comment out the error message, and it
worked with GCC as well. The difference is so little (according to Linus) that
it may not be suspectible. Maybe I am missing the point...

-- 
With Best Regards,
Andy Shevchenko


