Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E314542CE4
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbiFHKPO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiFHKOn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 06:14:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ED9F827D
        for <linux-ext4@vger.kernel.org>; Wed,  8 Jun 2022 03:02:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A7B621A20;
        Wed,  8 Jun 2022 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654682550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JINZ9VlD9DtZibC+30KtzLfT1TvMRt/NBb1lWIO6Li8=;
        b=1D08+MVHEh0PeVqO4zBX7/Aa2XTAm98JODUPTAxeld9qjs6FlVApbJqoMvEXoY62igbch3
        jiDjYl12CXyYJEaKhLG7tbactXbx4MrHV612spA5Ixsj6WcInmAsIUW5SO0HXOAfTQqgf6
        pm/sPw6MJc52I08kVZ1xKi3xTCJ1eSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654682550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JINZ9VlD9DtZibC+30KtzLfT1TvMRt/NBb1lWIO6Li8=;
        b=80ILTGSjx0q2vBsCpGSin/SFU3DHHbMF+QFAHCIhlkHBdKQ0QROY/cYUv9FjhBnF7/ADMd
        zbfJXXfDxoZT2zAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F02EB2C142;
        Wed,  8 Jun 2022 10:02:29 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8BD6A06E2; Wed,  8 Jun 2022 12:02:29 +0200 (CEST)
Date:   Wed, 8 Jun 2022 12:02:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH] jbd2: Remove unused exports for jbd2 debugging
Message-ID: <20220608100229.qry77pkurz5mbu62@quack3.lan>
References: <20220606144047.16780-1-jack@suse.cz>
 <202206081021.Y85M7FUG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206081021.Y85M7FUG-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

yeah, I was grepping the sources whether I can see an external use of
jbd2_debug() and didn't notice the macro in include/linux/jbd2.h that is
calling __jbd2_debug() is actually called jbd_debug(). I actually think we
should use ext4_debug() instead of jbd_debug() in ext4 code but anyway,
my patches need tweaking...

								Honza

On Wed 08-06-22 10:29:23, kernel test robot wrote:
> Hi Jan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tytso-ext4/dev]
> [also build test ERROR on linus/master v5.19-rc1 next-20220607]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/jbd2-Remove-unused-exports-for-jbd2-debugging/20220606-224629
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: microblaze-buildonly-randconfig-r012-20220605 (https://download.01.org/0day-ci/archive/20220608/202206081021.Y85M7FUG-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/9aaaac58ce0525ce441ad75b45bf3e5f3911a82b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Jan-Kara/jbd2-Remove-unused-exports-for-jbd2-debugging/20220606-224629
>         git checkout 9aaaac58ce0525ce441ad75b45bf3e5f3911a82b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "__jbd2_debug" [fs/ext4/ext4.ko] undefined!
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
