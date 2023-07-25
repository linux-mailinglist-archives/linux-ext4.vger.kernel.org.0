Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFD761C00
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjGYOlL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGYOlL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 10:41:11 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA22706
        for <linux-ext4@vger.kernel.org>; Tue, 25 Jul 2023 07:40:44 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-486487be6aeso91789e0c.1
        for <linux-ext4@vger.kernel.org>; Tue, 25 Jul 2023 07:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690296035; x=1690900835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6jl5+LreKnh1yykcifdBl1Q5Q7VSb/IZl7szWKJ4qmg=;
        b=Mj6Q7S1oyu3AZqRp93gZmaewJj5yosETUiPOwu6KNnAU+nygtqcGHXHS1UU+geok/s
         YzBpQH6kzLq5IkR6AfJT0/eMZ1TCjFgvX2L/rH6CsYW7p6ni8+18gn7hYAbu02W6twzB
         PK8Q7AQvCBjxO6t5+P7GsdfZHHMzx0qPZKRXKh/lOoYeRIWdXHRNcPBNBm/Seixu5fam
         2bCnldqL1PEiWNAZ5GkXmiXRqaGWVdWLHTJ8C8fc0gj0eJuAA9snKlL1e7sdA3pjf80m
         oxZ0549lzTrUUA9AJCjFqFrjqTYYG/kSX3j2oD4m8n17OC5B0ihqwoQ1HvWiql6DPFuv
         47JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296035; x=1690900835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jl5+LreKnh1yykcifdBl1Q5Q7VSb/IZl7szWKJ4qmg=;
        b=F5gRXKm4yYC525/HoEQDXhgKY29QBr+X/3hAGjKOPsYIJyPP5VI7C22S4fUrx1S/Lm
         gJ8uFvOTAen2DIAToEgDm6wIgmZNydSuOZ36JXwM/A0dyhbxDrekAjQNF+kufuxwRjnC
         4729sHQdNO+R2Byk4WU/yWyZM/wjxCDlAXCttknrtw3/ZKHt9Hz7Tj86dXD4c0zLFeJ9
         n5dJwtgZvYqul7ghdUGZZb5Zs6qU/FYstKpiFO/j/JF43oMB9AgRV7KmGk+hyvDiMI3Q
         eDhGAKiCC17f8sSPyS6lj/9pdvw3ITShTVMPbm4/hw0TJ+hNY5NiiRfDPj6fGvAqTnN8
         v0HA==
X-Gm-Message-State: ABy/qLZkXYtVWNGLHfg/S0vH2rRgX5JhtkbukHD4TYmARt8NAZkdQ8Vn
        IeSwDKh61GtKQAbvf01VYnigcucseczoiyayEVUApA==
X-Google-Smtp-Source: APBJJlFV7dvTCeRGn11UfmRwNmuLCKBZhzcl8QTcjtuYmrQjASgxv35b4LwwCFqfZmlNl6OUiU2x+8GQyQCnUVlFY2o=
X-Received: by 2002:a1f:4191:0:b0:471:b18a:f9e5 with SMTP id
 o139-20020a1f4191000000b00471b18af9e5mr4357499vka.4.1690296035612; Tue, 25
 Jul 2023 07:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230725104553.588743331@linuxfoundation.org>
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jul 2023 20:10:24 +0530
Message-ID: <CA+G9fYs217H+k5pNx_uobpHmg0vM4qRk9UT_OKspxn5d-NoNqA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/509] 5.10.188-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 25 Jul 2023 at 16:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.188 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.188-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following commit caused build failures on all the architectures,

> Chao Yu <chao@kernel.org>
>     ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

ext4: fix to check return value of freeze_bdev() in ext4_shutdown()
commit c4d13222afd8a64bf11bc7ec68645496ee8b54b9 upstream

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/2/build ARCH=x86_64 SRCARCH=x86
CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang' LLVM=1 LLVM_IAS=1
/builds/linux/fs/ext4/ioctl.c:634:7: error: incompatible pointer to
integer conversion assigning to 'int' from 'struct super_block *'
[-Wint-conversion]
                ret = freeze_bdev(sb->s_bdev);
                    ^ ~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.
make[3]: *** [/builds/linux/scripts/Makefile.build:286: fs/ext4/ioctl.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org
