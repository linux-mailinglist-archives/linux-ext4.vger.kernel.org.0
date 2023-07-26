Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A7E762A62
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jul 2023 06:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGZEqd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 00:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjGZEqc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 00:46:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBBF19AD;
        Tue, 25 Jul 2023 21:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B5B2611CA;
        Wed, 26 Jul 2023 04:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD845C433C7;
        Wed, 26 Jul 2023 04:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690346790;
        bh=4xflMMefEBJiXdJ0HYuN9/P/BK23r7QhoU0TNNVEllo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rf2WA9MfDmNHKuQ3GOvzwNTDxDNWN9nes0O5WCiEnVQpvl3myDgmoWncLjDsKOj37
         ZDiMBXO0xft4LpKwBO8askT6St6T1SMU5Tu0Hp376kBdLNQXhjJuaJtd+FCrKvrPay
         6JckXbII2Y4Erm3q+spplOOuC9GqEIYla6i3lWjo=
Date:   Wed, 26 Jul 2023 06:46:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 5.10 000/509] 5.10.188-rc1 review
Message-ID: <2023072600-clamp-unending-70fc@gregkh>
References: <20230725104553.588743331@linuxfoundation.org>
 <CA+G9fYs217H+k5pNx_uobpHmg0vM4qRk9UT_OKspxn5d-NoNqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs217H+k5pNx_uobpHmg0vM4qRk9UT_OKspxn5d-NoNqA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 25, 2023 at 08:10:24PM +0530, Naresh Kamboju wrote:
> On Tue, 25 Jul 2023 at 16:42, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.10.188 release.
> > There are 509 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.188-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Following commit caused build failures on all the architectures,
> 
> > Chao Yu <chao@kernel.org>
> >     ext4: fix to check return value of freeze_bdev() in ext4_shutdown()
> 
> ext4: fix to check return value of freeze_bdev() in ext4_shutdown()
> commit c4d13222afd8a64bf11bc7ec68645496ee8b54b9 upstream
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/2/build ARCH=x86_64 SRCARCH=x86
> CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
> clang' LLVM=1 LLVM_IAS=1
> /builds/linux/fs/ext4/ioctl.c:634:7: error: incompatible pointer to
> integer conversion assigning to 'int' from 'struct super_block *'
> [-Wint-conversion]
>                 ret = freeze_bdev(sb->s_bdev);
>                     ^ ~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> make[3]: *** [/builds/linux/scripts/Makefile.build:286: fs/ext4/ioctl.o] Error 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Argh, I saw that warning be added, and forgot to go back and track it
down to fix it.  I'll go drop the patch now and push out some new -rcs,
thanks for that.

greg k-h
