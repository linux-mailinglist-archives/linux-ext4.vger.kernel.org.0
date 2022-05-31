Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1053893A
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 02:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiEaARI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 20:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiEaARI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 20:17:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7245050078
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 17:17:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24V0GuMm001047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 20:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653956218; bh=P3mVIzOKUqwVADQU0cXbrviXhIQxBCuaPdBX62zOmx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DBsH3vWN2sQKc/uOHskuE3blE7/mOg5IrnB53MVTLOUzyQIfpYYWjCk34yygaGdHl
         yFMXhjEKufueBYlp//joimHo0NJf7+/zScXx+dhCY//hxxuyRt2jrQee/kLnK/B/ok
         Z8YSGG87T4hLlUng5JCWpLm99Wdpi76xMf+TDcNKUBTiWihnkRkgkjjr+YB6nvVUNI
         x3UYzPyImlTpM4mu/X46LjItr8GQiueu53LMn9cNc970uH3b0JPx1H1/LtOo63hiOi
         h4AtY36CmhqKlvon23o8z32nFyUG+JdYSbhD8UepjEVD11Im6AmIc8YZHwMYYSr1Kg
         Ku+24ZiNGgA9g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 77A0B15C3A95; Mon, 30 May 2022 20:16:56 -0400 (EDT)
Date:   Mon, 30 May 2022 20:16:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Stephen E. Baker" <baker.stephen.e@gmail.com>
Cc:     adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <YpVeeKRH1bycP7P1@mit.edu>
References: <CAFDdnB1Rq3vNe_qt_0u+inzOuL4vrGhgbOoQZKBwfBktni=Npw@mail.gmail.com>
 <YpLLTkje/QUYPP9z@mit.edu>
 <YpNk4bQlRKmgDw8E@mit.edu>
 <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
 <YpQixl+ljcC1VHNU@mit.edu>
 <CAFDdnB1WxrqddeLJwjsqqgoij1q_QGa=SBs-i=j31W2QbksJ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFDdnB1WxrqddeLJwjsqqgoij1q_QGa=SBs-i=j31W2QbksJ=Q@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 30, 2022 at 06:20:46PM -0400, Stephen E. Baker wrote:
> The other thought I had was - this device has a strict size limit on kernels,
> which is why I had to start building my own in the first place. Nothing over
> 32MB can boot. However I verified my kernel was smaller than that. I
> minimized my config even further and my Image is now 20MB uncompressed
> which is smaller than it was before, so that's not it either.
> 
> Here is my full config:

I don't know what to tell you.  I took your config, stripped out all
of the modules, and enabled CONFIG_HYPERVISOR_GUEST,
CONFIG_VIRTIO_MENU, and CONFIG_VIRTIO_BLK, and build a 5.16 kernel.
This worked just fine using kvm-xfstests booting into a root file
system that had case folding enabled.  (See my previous e-mail for a
description for how to test things.)

So I can't replicate your problem.  Without the boot logs, I'm not
sure what else we can do here.  Maybe you can figure out a way to
replicate the problem using kvm-xfstests?  We really need a solid
reproducer on a system where we can debug things and see the kernel
logs.

						- Ted
