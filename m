Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7626E3DF5
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Apr 2023 05:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDQD02 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 23:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDQD00 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 23:26:26 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD41FC4
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 20:26:24 -0700 (PDT)
Received: from letrec.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33H3Q5Jd011119
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Apr 2023 23:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1681701967; bh=qj4/O/c2njLshehlBcYNufXeeA0runhyjTh7GdSy1pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HLzPaFr6yy8s8K1AHT+JM2GDUGVxfYFb/Kg6dphR4oxTJPZkNTmucD1tg6cjDOS4B
         745xTAhkdTN4pZqreaph1wA5pHWvX3xVMochZU1MC5avGgtbSqPlkp9s98aqueYIfp
         pH1qGjkzuXgvpjQuYQhkSp23CV42sFKuLE9dxFRgnyR6m0D1wrvaWUEb5h/jiZAri5
         BoOsH7HFb5B+VJfwMB95F9IEYUexVueyz0WLqtwJKCEqvO11ZQKco5SWOcqDrlF18+
         s9zmwT1T9zF+NwnkscxDz50sya+QntPImB/PluhQTmFCDfWn2ptPcw/3qd72WDt74J
         9Rp0WgYtkDGiQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 6FB368C03E4; Sun, 16 Apr 2023 23:26:05 -0400 (EDT)
Date:   Sun, 16 Apr 2023 23:26:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        William McVicker <willmcvicker@google.com>,
        linux-ext4@vger.kernel.org,
        "Stephen E. Baker" <baker.stephen.e@gmail.com>,
        adilger.kernel@dilger.ca
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <ZDy8Tcp9Z/GILVRI@mit.edu>
References: <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
 <YpQixl+ljcC1VHNU@mit.edu>
 <CAFDdnB1WxrqddeLJwjsqqgoij1q_QGa=SBs-i=j31W2QbksJ=Q@mail.gmail.com>
 <YpVeeKRH1bycP7P1@mit.edu>
 <YpVxYchs1wScNRDw@mit.edu>
 <CAFDdnB1KJVSXXzXKOc+T+g1Qewr11AS4f9tFJqSMLvfpiX-5Lg@mail.gmail.com>
 <YpjNf8WGfYh31F+2@mit.edu>
 <ZDnbW1qYmBLycefL@google.com>
 <20230416054742.GA5427@lst.de>
 <ZDuOB8We29IAYR/4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDuOB8We29IAYR/4@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Apr 15, 2023 at 10:56:23PM -0700, Christoph Hellwig wrote:
> On Sun, Apr 16, 2023 at 07:47:42AM +0200, Christoph Hellwig wrote:
> > We could do that, but it seems a bit ugly.  What prevents symbol_request
> > from working properly for this case in your setup?
> 
> To anwer to myself - I guess we need something else than a plain
> EXPORT_SYMBOL for everything that is used by
> symbol_request.  Which would be a nice cleanly anyway - exports for
> symbol_request aren't normal exports and should probably have a clear
> marker just to stand out anyway.

Agreed, that's the best/cleanest long-term solution.

The short-term hack that William could use in the interim would be to
simply configure CONFIG_UNUSED_KSYMS_WHITELIST to include
'utf8_data_table', which will solve his immediate problem without
needing to maintain an out-of-tree patch in his kernel.

Presumably, that's what the long-term solution would effectively do,
except it would be automated as opposed to requiring people who use
CONFIG_TRIM_UNUSED_KSYMS to have to do manually.  Note also that there
are only a half-dozen or so such symbols in the Linux kernel today, so
while we could and probably should automate it, it's not clear to me
the number of use cases where CONFIG_TRIM_UNUSED_KSYMS is going to be
relevant are very likely quite small.  (The only ones I can think of
are the Android Generic Kernel Image and for enterprise Linux
distributions.  And in both cases, I suspect those use cases will
probably have a very large list of symbol added to the allow list, so
adding those few extra symbols is probably going to be in the noise.

						- Ted
