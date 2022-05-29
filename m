Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606A45370E9
	for <lists+linux-ext4@lfdr.de>; Sun, 29 May 2022 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiE2MUC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 May 2022 08:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiE2MUC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 May 2022 08:20:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF26E77F23
        for <linux-ext4@vger.kernel.org>; Sun, 29 May 2022 05:19:59 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24TCJkeL001633
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 May 2022 08:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653826790; bh=Tutz1cneCafX3BKGz0s7Fes3gRFu8+5syfSVUgTpDog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Eo9nYeAKQq8EREpIcxDVdtsicny5fHOTHIWWaarsejde/lxyef7gPJ1btQdWojpdk
         +okSvZJLDLhj/UK/+rJMMPTqaXPpi0w/9wOcRb6IuBqTtWDXY4urhYr8fQ4Mz6dFU1
         ALwAGbQ8IMnhAKlfWIr0YMeiyixY0KnmNPJb/KfjF6ST7w8DaJc+tJtxkeQNsY3zBF
         KoqmZj6WArxCPN5ewUChQonfPHlFYafo70k5K2dyVdAqPG6W7ag1y7U1NUIVQ78KOX
         +wzC7k343hte/K/GGNfCmexmMpd3JjJln6InkK+7Gm7KUfjIvrbuq1cqx4WUyiR12n
         4J4k4OlLc45fQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E84DB15C009C; Sun, 29 May 2022 08:19:45 -0400 (EDT)
Date:   Sun, 29 May 2022 08:19:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Stephen E. Baker" <baker.stephen.e@gmail.com>
Cc:     adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <YpNk4bQlRKmgDw8E@mit.edu>
References: <CAFDdnB1Rq3vNe_qt_0u+inzOuL4vrGhgbOoQZKBwfBktni=Npw@mail.gmail.com>
 <YpLLTkje/QUYPP9z@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpLLTkje/QUYPP9z@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Note: the OP has since replied back to me via private-email, probably
accidentally selecting "reply" instead of "reply-all".  So that other
folks on the list know that they don't need to chase this down:

> I have no backlight in early boot so I can't read console output.
> 
> Since posting this I learned that I was mislead by my git bisect. The commit
> on torvalds tree before this patch was merged
> (79e06c4c4950be2abd8ca5d2428a8c915aa62c24) doesn't boot. What I
> thought was the same issue in this patch was in fact only the result of the
> backlight not turning on (the config option was different for my hardware in
> 5.15 where this patch was based.) I'm still hunting the real issue,
> but it likely
> isn't the filesystem.
> 
> Thank you very much for your effort. I'm very sorry I sent you on a wild goose
> chase.

Cheers,

					- Ted
