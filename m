Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267A2762A6C
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jul 2023 06:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGZEsp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 00:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjGZEsn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 00:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B769419AD;
        Tue, 25 Jul 2023 21:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B3FE61454;
        Wed, 26 Jul 2023 04:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B48C433C7;
        Wed, 26 Jul 2023 04:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690346921;
        bh=j05fp7XKlb1XILs70jytnIlmOpJI+jAGPXqYgx5xKQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhwRuWCu2EQcXJQUj3naa4ii/Gad/Z6LhqEPEjEelKRdNG2l6toiz76azBmWtuN0N
         xrRvs1PAhplKhhZm9uD8DE+XHTfVjY4ahYf6txS/7T2hd+WhwGLZM1bMATBbd7GYKp
         RzRzoJaYrYqXWf8vmN+r8beqGd1NZX0PWhzkNg1U=
Date:   Wed, 26 Jul 2023 06:48:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 5.4 000/313] 5.4.251-rc1 review
Message-ID: <2023072631-repaint-ultimate-cc30@gregkh>
References: <20230725104521.167250627@linuxfoundation.org>
 <CA+G9fYuH-jyxJwgEgX4J4+eh=nEEk9aqt4YPNUW9j==mwtw=jA@mail.gmail.com>
 <a3849202-24f9-4ad0-f10c-a4a6f8627e80@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3849202-24f9-4ad0-f10c-a4a6f8627e80@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 25, 2023 at 08:48:03PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 25/07/23 8:16 pm, Naresh Kamboju wrote:
> > On Tue, 25 Jul 2023 at 17:06, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > This is the start of the stable review cycle for the 5.4.251 release.
> > > There are 313 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > >          https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc1.gz
> > > or in the git tree and branch at:
> > >          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Following commit caused build failures on stable-rc 5.4 and 5.10.
> > 
> > ext4: fix to check return value of freeze_bdev() in ext4_shutdown()
> > commit c4d13222afd8a64bf11bc7ec68645496ee8b54b9 upstream.
> > 
> > fs/ext4/ioctl.c:595:7: error: incompatible pointer to integer
> > conversion assigning to 'int' from 'struct super_block *'
> > [-Wint-conversion]
> >                  ret = freeze_bdev(sb->s_bdev);
> >                      ^ ~~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> > 
> 
> I have seen this error too in 5.4.y build.
> 
> Just more information about this.
> 
> In 5.4.y:
> struct super_block *freeze_bdev(struct block_device *bdev)
> {
> 	...
> }
> 
> In 5.15.y
> int freeze_bdev(struct block_device *bdev)
> {
> 	...
> }
> 
> This changed in this commit which is in 5.11-rc1,(not in 5.4.y and 5.10.y)
> Commit info:
>   commit-id              : 040f04bd2e825f1d80b14a0e0ac3d830339eb779
>   subject          : fs: simplify freeze_bdev/thaw_bdev
> 
> 
> Thanks,
> Harshit

Thanks, will go drop this as well.

greg k-h
