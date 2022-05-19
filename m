Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5052DE75
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiESUd3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240828AbiESUd2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 16:33:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5EB719C5
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 13:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F95BB82852
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 20:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4FEC385AA;
        Thu, 19 May 2022 20:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652992405;
        bh=g22bXAXTZmdIS0EuXClsOsWJKTibdtEoxOIoGn+1a+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3L8hlzg+FLyGlJ0+WYyWsHhn+nZhuUdLNoreq4zIJSw5kDKnd8/kq3MBG9p6kf5y
         ZaK9scYSSDnEUIT6SdpTIReSwfYLBti+kdH+z4uROzpiMB7pYKbqG+obr5aAmlnhOv
         QAldZwU6IIgypSDoTm/qZD2BHC0cjc5A1Zwx2b2Ldu0kJDqlbM1kV6OX1pXYaiTJ3W
         BWgqdjcGy0dS9hwI3wInVm5fw7yRqEIbXVA3Fuu9R8B59wR3y3+lL5kIghDUBQpoeI
         rS1s4v77N55GqvipUfLjQvXuMg67XhVtUohxQAmW4ZKJgO+mhc6T20kLo/VCjMUtzk
         l/qz5QOBmHcqw==
Date:   Thu, 19 May 2022 13:33:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [tytso-ext4:dev 17/25] fs/ext4/super.c:2799:29: warning: unused
 variable 'sbi'
Message-ID: <Yoapk4osojwJyrxM@sol.localdomain>
References: <202205200431.kzojEoNc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205200431.kzojEoNc-lkp@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 20, 2022 at 04:12:21AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> head:   b76a7dd9a7437e8c21253ce3a7574bebde3827f9
> commit: 0df27ddf69f38e5ab1e1c73e46c35eecc6ca1609 [17/25] ext4: only allow test_dummy_encryption when supported
> config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220520/202205200431.kzojEoNc-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?id=0df27ddf69f38e5ab1e1c73e46c35eecc6ca1609
>         git remote add tytso-ext4 https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
>         git fetch --no-tags tytso-ext4 dev
>         git checkout 0df27ddf69f38e5ab1e1c73e46c35eecc6ca1609
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/ext4/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/ext4/super.c:2799:29: warning: unused variable 'sbi' [-Wunused-variable]
>            const struct ext4_sb_info *sbi = EXT4_SB(sb);
>                                       ^
>    1 warning generated.
> 
> 
> vim +/sbi +2799 fs/ext4/super.c
> 
>   2794	
>   2795	static int ext4_check_test_dummy_encryption(const struct fs_context *fc,
>   2796						    struct super_block *sb)
>   2797	{
>   2798		const struct ext4_fs_context *ctx = fc->fs_private;
> > 2799		const struct ext4_sb_info *sbi = EXT4_SB(sb);
>   2800	
>   2801		if (!IS_ENABLED(CONFIG_FS_ENCRYPTION) ||
>   2802		    !(ctx->spec & EXT4_SPEC_DUMMY_ENCRYPTION))
>   2803			return 0;
>   2804	
>   2805		if (!ext4_has_feature_encrypt(sb)) {
>   2806			ext4_msg(NULL, KERN_WARNING,
>   2807				 "test_dummy_encryption requires encrypt feature");
>   2808			return -EINVAL;
>   2809		}
>   2810		/*
>   2811		 * This mount option is just for testing, and it's not worthwhile to
>   2812		 * implement the extra complexity (e.g. RCU protection) that would be
>   2813		 * needed to allow it to be set or changed during remount.  We do allow
>   2814		 * it to be specified during remount, but only if there is no change.
>   2815		 */
>   2816		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE &&
>   2817		    !DUMMY_ENCRYPTION_ENABLED(sbi)) {
>   2818			ext4_msg(NULL, KERN_WARNING,
>   2819				 "Can't set test_dummy_encryption on remount");
>   2820			return -EINVAL;
>   2821		}
>   2822		return 0;
>   2823	}
>   2824	

That's kind of annoying; it's because DUMMY_ENCRYPTION_ENABLED() is a macro that
doesn't use its argument when !CONFIG_FS_ENCRYPTION.

I'll send a new version of this patch that just makes the contents of
ext4_check_test_dummy_encryption() be conditional on CONFIG_FS_ENCRYPTION.

This will be temporary, as the ifdef will go away later in "ext4: fix up
test_dummy_encryption handling for new mount API".

- Eric
