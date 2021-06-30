Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A55B3B7E60
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhF3HzY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 03:55:24 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9325 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhF3HzY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 03:55:24 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GFD476VzKz6wMX;
        Wed, 30 Jun 2021 15:48:39 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 30 Jun 2021 15:52:53 +0800
Subject: Re: [ext4:dev 27/31] ERROR: modpost:
 "jbd2_journal_unregister_shrinker" undefined!
To:     kernel test robot <lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
References: <202106301543.8S1z2hfe-lkp@intel.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <861f0729-1c04-c69f-ec2c-67b24bc69cc7@huawei.com>
Date:   Wed, 30 Jun 2021 15:52:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <202106301543.8S1z2hfe-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/6/30 15:25, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> head:   d578b99443fde0968246cc7cbf3bc3016123c2f4
> commit: 4ba3fcdde7e36af93610ceb3cc38365b14539865 [27/31] jbd2,ext4: add a shrinker to release checkpointed buffers
> config: xtensa-randconfig-s032-20210628 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?id=4ba3fcdde7e36af93610ceb3cc38365b14539865
>         git remote add ext4 https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
>         git fetch --no-tags ext4 dev
>         git checkout 4ba3fcdde7e36af93610ceb3cc38365b14539865
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=xtensa 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "jbd2_journal_unregister_shrinker" undefined!
>>> ERROR: modpost: "jbd2_journal_register_shrinker" undefined!
> 

Oh, sorry, I forget to export these two function, I will send a fix patch soon.

Yi.
