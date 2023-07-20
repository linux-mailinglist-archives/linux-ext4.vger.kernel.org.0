Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3445175A530
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 06:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGTElh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 00:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGTElg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 00:41:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EEC1BFC
        for <linux-ext4@vger.kernel.org>; Wed, 19 Jul 2023 21:41:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36K4fK8T018002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 00:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689828082; bh=WDkuzsGfOvgmcwkIftU4ohf8YDiv8w29EGl2vrbIwtc=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=lm4z5U3hUf4M4K+hUJVD3HeEgIgziEjlSeT2rYFQzPcGb+LWoSBd127vHYZDb7Dax
         Wj8KZNtIPtaKLz/AyfwKcWBDlgSaIwsVwFRyvFuogCnUrDKTH5zYmVgvMew2ablErc
         J8B2VvKNbQx0HVwLAIHloX/L7Hfvsn0Ab5J6gRX/siZphLTi677yegCcKmV784SXPj
         tRecXeA5hZVzQl0fkXhni+vbIvb2xaumo1eF4lJgJ4nUq6cLBsDnr+3blmAgRBGZyL
         R3Peux0rUpfUunywAPKdP1WAEN02osN0N1zpPzvnVplAsI2zZbb0o33cW/UfyrZBa4
         N9aenpL3D8+YQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9728615C026A; Thu, 20 Jul 2023 00:41:20 -0400 (EDT)
Date:   Thu, 20 Jul 2023 00:41:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kai Tomerius <kai@tomerius.de>
Cc:     "Alan C. Assis" <acassis@gmail.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Forsman <bjorn.forsman@gmail.com>,
        linux-embedded@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: File system robustness
Message-ID: <20230720044120.GB5764@mit.edu>
References: <20230717075035.GA9549@tomerius.de>
 <CAG4Y6eTU=WsTaSowjkKT-snuvZwqWqnH3cdgGoCkToH02qEkgg@mail.gmail.com>
 <20230718053017.GB6042@tomerius.de>
 <CAEYzJUGC8Yj1dQGsLADT+pB-mkac0TAC-typAORtX7SQ1kVt+g@mail.gmail.com>
 <CAG4Y6eTN1XbZ_jAdX+t2mkEN=KoNOqprrCqtX0BVfaH6AxkdtQ@mail.gmail.com>
 <20230718213212.GE3842864@mit.edu>
 <20230719105138.GA19936@tomerius.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719105138.GA19936@tomerius.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 19, 2023 at 12:51:39PM +0200, Kai Tomerius wrote:
> > In answer to Kai's original question, the setup that was described
> > should be fine --- assuming high quality hardware.
> 
> I wonder how to judge that ... it's an eMMC supposedly complying to
> some JEDEC standard, so it *should* be ok.

JEDEC promulgates the eMMC interface specification.  That's the
interface used to talk to the device, much like SATA and SCSI and
NVMe.  The JEDEC eMMC specification says nothing about the quality of
the implementation of the FTL, or whether it is safe from power drops,
or how many wirte cycles are supported before the eMMC soldered on the
$2000 MCU would expire.

If you're a cell phone manufacturer, the way you judge it is *before*
you buy a few million of the eMMC devices, you subject the samples to
a huge amount of power drops and other torture tests (including
verifying the claimed number of write cycles in spec sheet), before
the device is qualified for use in your product.

> But on another aspect: how about the interaction between dm-integrity
> and ext4? Sure, they each have their own journal, and they're
> independent layers. Is there anything that could go wrong, say a block
> that can't be recovered in the dm-integrity layer, causing ext4 to run
> into trouble, e.g., an I/O error that prevents ext4 from mounting?
> 
> I assume tne answer is "No", but can I be sure?

If there are I/O errors, with or without dm-integrity, you can have
problems.  dm-integrity will turn bit-flips into hard I/O errors, but
a bit-flip might cause silent file system cocrruption (at least at
first), such that when you finally notice that there's a problem,
several days or weeks or months may have passed, the data loss might
be far worse.  So turning an innocous bit flip into a hard I/O error
can be a feature, assuming that you've allowed for it in your system
architecture.

If you assume that the hardware doesn't introduce I/O errors or bit
flips, and if you assume you don't have any attackers trying to
corrupt the block device with bit flips, then sure, nothing will go
wrong.  You can buy perfect hardware from the same supply store where
high school physics teachers buy frictionless pulleys and massless
ropes.  :-)

Cheers,

						- Ted
