Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4793B3EA504
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhHLM7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 08:59:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33284 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhHLM7x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 08:59:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7B2E722248;
        Thu, 12 Aug 2021 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628773166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZBoi/MAdX0le88Btu7+aNPPDknu0t9R37KAGupWIIY=;
        b=FTmFjgw+Yq1EhrlDxg0X/g0L2B5f6nQmxctqR5CpAyU1NFcFp1pLLA3RZxaJ8eZp8Hmm4U
        OU4kO9xNsw9OeQXJ6nhLzRsfPLlntjE20f/AE7apbtHi3TsHi+1gtkADuufIjWuPLROqbg
        bgVL8voknzrE3pnnzmng0P1fTurT+9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628773166;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZBoi/MAdX0le88Btu7+aNPPDknu0t9R37KAGupWIIY=;
        b=CS6kisMrq/AGwbVa9xO5SUy0e6IOJBRHCW5baEScSc6FnVgstR+T1OV6mU18zpbTub3KdJ
        vNcAHH0XyK1oTCBg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 61683A3EF0;
        Thu, 12 Aug 2021 12:59:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3896E1F2AC2; Thu, 12 Aug 2021 14:59:26 +0200 (CEST)
Date:   Thu, 12 Aug 2021 14:59:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH 5/5] ext4: Improve scalability of ext4 orphan file
 handling
Message-ID: <20210812125926.GC14675@quack2.suse.cz>
References: <20210811101925.6973-5-jack@suse.cz>
 <202108120223.efg5X7VY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108120223.efg5X7VY-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 12-08-21 02:19:33, kernel test robot wrote:
> Hi Jan,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on ext4/dev]
> [also build test WARNING on ext3/for_next linus/master v5.14-rc5 next-20210811]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Jan-Kara/ext4-Speedup-orphan-file-handling/20210811-182113
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> config: parisc-randconfig-s032-20210810 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 10.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-348-gf0e6938b-dirty
>         # https://github.com/0day-ci/linux/commit/77029a42c6e037181b218cbf10a93561e664fb9e
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Jan-Kara/ext4-Speedup-orphan-file-handling/20210811-182113
>         git checkout 77029a42c6e037181b218cbf10a93561e664fb9e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash fs/ext4/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> fs/ext4/orphan.c:76:18: sparse: sparse: cast from restricted __le32
> >> fs/ext4/orphan.c:76:18: sparse: sparse: cast from restricted __le32
> >> fs/ext4/orphan.c:76:18: sparse: sparse: cast to restricted __le32
...
>   > 76		} while (cmpxchg(&bdata[j], 0, cpu_to_le32(inode->i_ino)) != 0);

Yeah, I didn't bother to convert 0 to little endian which is tripping up
sparse. I've now added explicit casts of 0 to __le32 so silence the
warning.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
