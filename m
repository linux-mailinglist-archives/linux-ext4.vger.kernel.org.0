Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A18A1EB3D1
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jun 2020 05:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBDhf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Jun 2020 23:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBDhf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Jun 2020 23:37:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9967C061A0E
        for <linux-ext4@vger.kernel.org>; Mon,  1 Jun 2020 20:37:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f21so4438922pgg.12
        for <linux-ext4@vger.kernel.org>; Mon, 01 Jun 2020 20:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PsJKIrAWcWbkYn5jDTQZMb6ZHVSMlybw+igoymrj+F8=;
        b=s0BHcy4vhAl0+AARK4t4UGQrDoi18jX1IQ2MNLMYsSBUfL6jRtX9gV+sUESLGvHiip
         HaetjqUpkiFVK1uqPELf7NJANK5z9Qk4M9S2LxS7J4n4f/Udl0ofvDqy9eaZrs3HmvHa
         j8HoLSe4h16Di2Pt3y7PEll5jQrm6tL1Eb5FYSJ0mXy5X9lH9AEOIY8fPeVaWrAls2ZI
         TN+sW5qVq77YbOqyUNkSEdzkmQD210efhCOUSrlKaQ2oeI4R0cpwUC8FqQnya8PN1jOJ
         qwB2/oZ7kiYjsxacYbkXRddHVz/vNwNv1nRV3HN5Ob76xJ7N6d2fKq87tJIRWy5RYVje
         JQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PsJKIrAWcWbkYn5jDTQZMb6ZHVSMlybw+igoymrj+F8=;
        b=Yu3+kbs9WnhQ1BYXfb4KB87DN/xrk1ICplSYnyzuCTr2Ylrd9xaTMfohbdoZFuyS1Y
         fzrC0XQvtm+xQZoSY9kzZ3hbWs4sg+Bs5juzmCtwxv4ld4sES3IrlfxEewU6HrEE8S+H
         caUXjWxFsdRRKmozOkBf4qtoy7F5BziN8+7O9CxblghPWmZaUM+bQQnwinJwCSFZmMTD
         CIoe4PW1r8CuSJeaIg9TgNdbbDiIYusbboz1LxRUOTrSxXcLRKTs7vtRUNXTxzu+zJPD
         IB0X1/+GjaRu2GnipAk/FAZYCs84oKAhkByZhxIzMsRVHL6Rb/zdqkdKEdfShbpKVJur
         k5HQ==
X-Gm-Message-State: AOAM5338veG2y7yOR+8hR0f0rl42eHyiVFe7FttmhQ6YBW7pc+LvVLBc
        +PVUYH89TwIVL2gqY5i/vnU3GFBb
X-Google-Smtp-Source: ABdhPJxFNpyUxPrmPCb6WzsZJY5kP7JKhbpP240BAII2sjKsrzlI+XeJ4xNruBSL1i9Ug+VKWmgSPA==
X-Received: by 2002:a62:6281:: with SMTP id w123mr23599126pfb.248.1591069053611;
        Mon, 01 Jun 2020 20:37:33 -0700 (PDT)
Received: from localhost.localdomain ([124.123.82.91])
        by smtp.gmail.com with ESMTPSA id f7sm772625pjp.24.2020.06.01.20.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 20:37:32 -0700 (PDT)
Subject: Re: [ext4:dev] BUILD SUCCESS 38bd76b9696c5582dcef4ab1af437e0666021f65
To:     kbuild test robot <lkp@intel.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <5ed48f9f.pv0w9Bx5zgTYVA1H%lkp@intel.com>
From:   Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <328b7e4f-bc56-6f71-35bf-ded4f3763c78@gmail.com>
Date:   Tue, 2 Jun 2020 09:07:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5ed48f9f.pv0w9Bx5zgTYVA1H%lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Not sure why this warning is coming. Is this since sparse checker could
not understand goto statements for lock/unlock? Looked into code and it
looks fine to me. Let me know if I missed something here.

https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/tree/fs/ext4/mballoc.c?h=dev#n2175

-ritesh


On 6/1/20 10:48 AM, kbuild test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git  dev
> branch HEAD: 38bd76b9696c5582dcef4ab1af437e0666021f65  Merge branch 'ext4-dax' into dev
> 
> Warning in current branch:
> 
> fs/ext4/mballoc.c:2209:9: sparse: sparse: context imbalance in 'ext4_mb_good_group_nolock' - different lock contexts for basic block
> 
> Warning ids grouped by kconfigs:
> 
> recent_errors
> |-- i386-randconfig-s001-20200531
> |   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block
> |-- i386-randconfig-s002-20200531
> |   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block
> |-- microblaze-randconfig-s032-20200529
> |   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block
> |-- x86_64-randconfig-s022-20200529
> |   `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block
> `-- x86_64-randconfig-s022-20200531
>      `-- fs-ext4-mballoc.c:sparse:sparse:context-imbalance-in-ext4_mb_good_group_nolock-different-lock-contexts-for-basic-block
> 
> elapsed time: 4240m
> 
> configs tested: 159
> configs skipped: 9
> 
> The following configs have been built successfully.
> More configs may be tested in the coming days.
> 
> arm                                 defconfig
> arm                              allyesconfig
> arm                              allmodconfig
> arm                               allnoconfig
> arm64                            allyesconfig
> arm64                               defconfig
> arm64                            allmodconfig
> arm64                             allnoconfig
> arm                          pxa3xx_defconfig
> arm                         palmz72_defconfig
> sh                            shmin_defconfig
> ia64                            zx1_defconfig
> riscv                          rv32_defconfig
> powerpc                      pasemi_defconfig
> sparc                       sparc64_defconfig
> mips                  decstation_64_defconfig
> mips                          ath79_defconfig
> mips                              allnoconfig
> mips                        qi_lb60_defconfig
> sh                            migor_defconfig
> sh                     magicpanelr2_defconfig
> mips                   sb1250_swarm_defconfig
> powerpc                  mpc885_ads_defconfig
> arm                       aspeed_g5_defconfig
> mips                        maltaup_defconfig
> arc                             nps_defconfig
> sh                          rsk7269_defconfig
> ia64                        generic_defconfig
> mips                             allyesconfig
> arm                       mainstone_defconfig
> arm                            hisi_defconfig
> powerpc                     mpc83xx_defconfig
> m68k                          multi_defconfig
> m68k                             allyesconfig
> arm                         ebsa110_defconfig
> arm                            lart_defconfig
> sh                         microdev_defconfig
> x86_64                              defconfig
> arm                          badge4_defconfig
> arm                        oxnas_v6_defconfig
> powerpc                     pseries_defconfig
> arm                            dove_defconfig
> h8300                            alldefconfig
> arm                            pleb_defconfig
> sh                             espt_defconfig
> arm                           omap1_defconfig
> arm                       spear13xx_defconfig
> sparc64                          allyesconfig
> microblaze                    nommu_defconfig
> powerpc                             defconfig
> arc                           tb10x_defconfig
> arm                        mvebu_v7_defconfig
> powerpc                mpc7448_hpc2_defconfig
> xtensa                              defconfig
> openrisc                            defconfig
> mips                          rb532_defconfig
> arm                         assabet_defconfig
> arc                              alldefconfig
> xtensa                       common_defconfig
> i386                              allnoconfig
> i386                                defconfig
> i386                              debian-10.3
> i386                             allyesconfig
> ia64                             allmodconfig
> ia64                                defconfig
> ia64                              allnoconfig
> ia64                             allyesconfig
> m68k                             allmodconfig
> m68k                              allnoconfig
> m68k                           sun3_defconfig
> m68k                                defconfig
> nios2                               defconfig
> nios2                            allyesconfig
> c6x                              allyesconfig
> c6x                               allnoconfig
> openrisc                         allyesconfig
> nds32                               defconfig
> nds32                             allnoconfig
> csky                             allyesconfig
> csky                                defconfig
> alpha                               defconfig
> alpha                            allyesconfig
> xtensa                           allyesconfig
> h8300                            allyesconfig
> h8300                            allmodconfig
> arc                                 defconfig
> arc                              allyesconfig
> sh                               allmodconfig
> sh                                allnoconfig
> microblaze                        allnoconfig
> mips                             allmodconfig
> parisc                            allnoconfig
> parisc                              defconfig
> parisc                           allyesconfig
> parisc                           allmodconfig
> powerpc                          allyesconfig
> powerpc                          rhel-kconfig
> powerpc                          allmodconfig
> powerpc                           allnoconfig
> i386                 randconfig-a004-20200529
> i386                 randconfig-a001-20200529
> i386                 randconfig-a002-20200529
> i386                 randconfig-a006-20200529
> i386                 randconfig-a003-20200529
> i386                 randconfig-a005-20200529
> i386                 randconfig-a004-20200531
> i386                 randconfig-a003-20200531
> i386                 randconfig-a006-20200531
> i386                 randconfig-a002-20200531
> i386                 randconfig-a005-20200531
> i386                 randconfig-a001-20200531
> x86_64               randconfig-a011-20200531
> x86_64               randconfig-a016-20200531
> x86_64               randconfig-a012-20200531
> x86_64               randconfig-a014-20200531
> x86_64               randconfig-a013-20200531
> x86_64               randconfig-a015-20200531
> i386                 randconfig-a013-20200529
> i386                 randconfig-a011-20200529
> i386                 randconfig-a012-20200529
> i386                 randconfig-a015-20200529
> i386                 randconfig-a016-20200529
> i386                 randconfig-a014-20200529
> i386                 randconfig-a013-20200531
> i386                 randconfig-a012-20200531
> i386                 randconfig-a015-20200531
> i386                 randconfig-a011-20200531
> i386                 randconfig-a016-20200531
> i386                 randconfig-a014-20200531
> x86_64               randconfig-a002-20200529
> x86_64               randconfig-a006-20200529
> x86_64               randconfig-a005-20200529
> x86_64               randconfig-a001-20200529
> x86_64               randconfig-a004-20200529
> x86_64               randconfig-a003-20200529
> riscv                            allyesconfig
> riscv                             allnoconfig
> riscv                               defconfig
> riscv                            allmodconfig
> s390                             allyesconfig
> s390                              allnoconfig
> s390                             allmodconfig
> s390                                defconfig
> sparc                            allyesconfig
> sparc                               defconfig
> sparc64                             defconfig
> sparc64                           allnoconfig
> sparc64                          allmodconfig
> um                               allmodconfig
> um                                allnoconfig
> um                                  defconfig
> um                               allyesconfig
> x86_64                                   rhel
> x86_64                               rhel-7.6
> x86_64                    rhel-7.6-kselftests
> x86_64                         rhel-7.2-clear
> x86_64                                    lkp
> x86_64                              fedora-25
> x86_64                                  kexec
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
