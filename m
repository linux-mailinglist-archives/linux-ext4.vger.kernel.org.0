Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D819737771
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jun 2023 00:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjFTW0O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Jun 2023 18:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjFTW0N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Jun 2023 18:26:13 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8221738
        for <linux-ext4@vger.kernel.org>; Tue, 20 Jun 2023 15:26:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-196.bstnma.fios.verizon.net [173.48.111.196])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35KMPu6K008993
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 18:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687299959; bh=ghpadrxjlqVYCy4LJIRU/TrBqKyMaaRaj4llxsWJ6+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VuDC3rlsEE2M7nrFX+kdWJ1fqp0cWIxKepJzzZqJdDSXOIC20wCPh50H2zSClOqIi
         8ENtOUIpjDbq2Cin4CNkI6zzo9f3XrEOjUeUqwfJnHdqMos83pC6vx2MfAHTu/Z3Ao
         LsbqGfSqKCDoD1LtpXkAI1k26KFJsn2EFUtzqRFsa+uiEQ2TLG9pGePvST28yAQYsV
         zlzbnUWZjREUtehxnfO0kl/Rxtr/ogt47/NcTmDnBWQEmkFXh0rqvCT0eV/aEavsRd
         hTNT3VILA7RgYugO11582ujOrLwlzWJldQR+pb2viluOQEqRM2DJfgncrVFYWOvUSR
         veP01O3mDX1+g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1781C15C0266; Tue, 20 Jun 2023 18:25:56 -0400 (EDT)
Date:   Tue, 20 Jun 2023 18:25:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 9/9] ext4: enable the lazy init thread when
 remounting read/write
Message-ID: <20230620222556.GJ286961@mit.edu>
References: <20230615113917.649505-1-sashal@kernel.org>
 <20230615113917.649505-9-sashal@kernel.org>
 <ZIy60MUrKxit2tNq@duo.ucw.cz>
 <ZJG7GyeSa2xZ89/H@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJG7GyeSa2xZ89/H@sashalap>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 20, 2023 at 10:43:39AM -0400, Sasha Levin wrote:
> > Normally "Fixes" would be "Fixes:" and in the signed-off block. Plus,
> > two consecutive sign-offs from tytso are probably wrong, too.
> 
> I'm really not sure what you want us to do here, or in other places
> where you've commented about issues with the upstream patch...

Yeah, those were issues with the upstream commit.  Sorry about that.

I personally don't care about whether you "clean up" the commit before
having it land in the LTS kernels or leave it as it as originally
commited to upstream, but then again, I'm not the kind of person who
asks whether there's a hyphen in "anal-retentive".  (I'm given to
understand it depends on whether the phrase is being used as an
attributive or predicative adjective.  :-)

						- Ted
