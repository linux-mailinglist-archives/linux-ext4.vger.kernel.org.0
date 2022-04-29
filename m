Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF696515260
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Apr 2022 19:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379730AbiD2Rja (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Apr 2022 13:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiD2Rj3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Apr 2022 13:39:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5318D6D870
        for <linux-ext4@vger.kernel.org>; Fri, 29 Apr 2022 10:36:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 623D81F468B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651253767;
        bh=WFkUTD/dDPR/qJnlQ9orusQLtC1nPcHZDLtxaEunj9I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Ie837G/c8saHQIrQcP9DyGcD1gYFUVruL411V2jnz05CDCF5Ruhf/FC1nQfIU3sW0
         keD8Wb9L9FOLgtJnhqOq0Zdtu9Z6oyWZ9ZORpHu6J30Pd3En16JcLDNn3cuo8JaigY
         pEXIuxp+/COLiXwKR3HnO9e0C5JbEXwKj/e7LAxxnOQ9j4N2hHRXLVCdggr7yeiEd8
         zASF4a/f/d0bpLERLDGc5nE6AVgD1BepHKbAcsxdx6OTxMXeGfg28LXgaJJl4nqb6G
         3Q/zIrar6IKeEygYuFYSkDFYzzeXaRl5JidSl/DlpSNH1DZfaqBpluIvJ9Xx7EhT3Y
         HPbZMPzCu//Bg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     kernel test robot <lkp@intel.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 7/7] f2fs: Reuse generic_ci_match for ci comparisons
Organization: Collabora
References: <20220428221027.269084-8-krisman@collabora.com>
        <202204291733.QRyzoWB6-lkp@intel.com>
Date:   Fri, 29 Apr 2022 13:36:04 -0400
In-Reply-To: <202204291733.QRyzoWB6-lkp@intel.com> (kernel test robot's
        message of "Fri, 29 Apr 2022 17:12:49 +0800")
Message-ID: <87ee1fx057.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi Gabriel,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on tytso-ext4/dev]
> [also build test ERROR on jaegeuk-f2fs/dev-test linus/master v5.18-rc4 next-20220428]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/Clean-up-the-case-insenstive-lookup-path/20220429-061233
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: microblaze-buildonly-randconfig-r004-20220428 (https://download.01.org/0day-ci/archive/20220429/202204291733.QRyzoWB6-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/8955999168ad8e2d440ec534ebe26830da9bc6f6
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/Clean-up-the-case-insenstive-lookup-path/20220429-061233
>         git checkout 8955999168ad8e2d440ec534ebe26830da9bc6f6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
>>> ERROR: modpost: "generic_ci_match" [fs/f2fs/f2fs.ko] undefined!
> ERROR: modpost: "generic_ci_match" [fs/ext4/ext4.ko] undefined!

Missing an EXPORT_SYMBOL, I guess. sorry for the noise. will fix and
resend.

-- 
Gabriel Krisman Bertazi
