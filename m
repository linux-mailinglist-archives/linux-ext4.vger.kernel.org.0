Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7F65389A9
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 03:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbiEaBhr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 21:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiEaBhq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 21:37:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8B24A3CF
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 18:37:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24V1bbqf001314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 21:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653961059; bh=7e9siRRnglYGVqX71qezFbsKcVTcKyX/rTP7Djs2V7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=cSphvK7uLHkU3b8UO2T5brcS64PtkFfYNw0tKqMkSitjeDOytkXlV/qtWhGpkvANW
         iXCS6qieDbnjujOj7W4KeRrO0hrA0+5Xy1DykIYbV8y4wDEHg9Y6Aojd1PNH6EeYMl
         rcM4O3Iprlu8RGGlvAOuBrppId14PWhmfoNepwTJz8fdsp7zmJipzrJc/ymkKhfTez
         sh/rA/c4mkvg43S75KZLXY/Rs6KQd0N/d3gJz0gA10BLdIOIahTRUzybtJerf09KIi
         +56e6Ar/kJxUGcLm/sTkCr3JextsV5RZ1NdjzO+B/khBvNwnUbm3fj1YEm4TcUY79W
         H1HMvOSYK+x/w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6E67E15C3A95; Mon, 30 May 2022 21:37:37 -0400 (EDT)
Date:   Mon, 30 May 2022 21:37:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Stephen E. Baker" <baker.stephen.e@gmail.com>
Cc:     adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <YpVxYchs1wScNRDw@mit.edu>
References: <CAFDdnB1Rq3vNe_qt_0u+inzOuL4vrGhgbOoQZKBwfBktni=Npw@mail.gmail.com>
 <YpLLTkje/QUYPP9z@mit.edu>
 <YpNk4bQlRKmgDw8E@mit.edu>
 <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
 <YpQixl+ljcC1VHNU@mit.edu>
 <CAFDdnB1WxrqddeLJwjsqqgoij1q_QGa=SBs-i=j31W2QbksJ=Q@mail.gmail.com>
 <YpVeeKRH1bycP7P1@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpVeeKRH1bycP7P1@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 30, 2022 at 08:16:56PM -0400, Theodore Ts'o wrote:
> On Mon, May 30, 2022 at 06:20:46PM -0400, Stephen E. Baker wrote:
> > The other thought I had was - this device has a strict size limit on kernels,
> > which is why I had to start building my own in the first place. Nothing over
> > 32MB can boot. However I verified my kernel was smaller than that. I
> > minimized my config even further and my Image is now 20MB uncompressed
> > which is smaller than it was before, so that's not it either.
> > 
> > Here is my full config:
> 
> I don't know what to tell you.  I took your config, stripped out all
> of the modules, and enabled CONFIG_HYPERVISOR_GUEST,
> CONFIG_VIRTIO_MENU, and CONFIG_VIRTIO_BLK, and build a 5.16 kernel.

Sorry, this should have been 5.17 kernel.

> This worked just fine using kvm-xfstests booting into a root file
> system that had case folding enabled.  (See my previous e-mail for a
> description for how to test things.)
> 
> So I can't replicate your problem.  Without the boot logs, I'm not
> sure what else we can do here.  Maybe you can figure out a way to
> replicate the problem using kvm-xfstests?  We really need a solid
> reproducer on a system where we can debug things and see the kernel
> logs.
> 
> 						- Ted
