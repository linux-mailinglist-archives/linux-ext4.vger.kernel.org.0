Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5BC3B9F15
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jul 2021 12:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhGBKat (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jul 2021 06:30:49 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:54633 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhGBKat (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jul 2021 06:30:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 747EF5805B9;
        Fri,  2 Jul 2021 06:28:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 02 Jul 2021 06:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm1; bh=35x
        PXqJJf9tkUmQrxzVm6oyhswalGOXtEezGl1pk7tQ=; b=RbaVqdM7OOovcQYrURC
        PUcUQ9X1iwLlcvDg2lZGfwHuy60I34Z2nwyv/1GmavLiO5AVM364K2OjuYQodLq5
        vhsga0/+jNFRvds2Sy2AFnEyoW55G4xdEnnR1uE+vjCgKCHjAgBFZYe5G4T/Eqmv
        gnTA6jr0Ci2tUyS98+nWmDMvlMGTH+ae4uqgieOqzDRb6Oy8Ta1pkhClRfK9atLW
        zh/IsQYQ3Fp+Jctr++ndsoYVG7oTqGvkgVOeYpfG0ZZpuBrsCT/vUULTMWkSgRrQ
        qk/9py40uWF+pIgtH9m44raOYwimkd2Jv3PKFifGBJSAA8BrsRv/3QHU/c1Hb/k7
        /vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=35xPXq
        JJf9tkUmQrxzVm6oyhswalGOXtEezGl1pk7tQ=; b=qa6MvMrkr5SjKw2yIfpznH
        WTXGHZ0mQwSHcq/JWFbE2OXggXobEvRAScYFq9NItMNd3RAW2LLoYbJUkYTVbV65
        YV295C5pOAZJNnuNzsHIoFnc8JaxcZh9ABJWGQKy6rMT7VbG2ypQahlOPiWHE935
        oIGqpnq7ds65T7r5LdaVv5w4KAwE0vCeALEPPOIHI0cGvxZ6AD104eN/6xj/05nC
        H6/z08JuWFGaYdOxvQSpRBYnf0PaV2s5SVhsaMH1MPnIJI9GMymSK8ox6IMFpt/Y
        4Bc7MU5yM26mjq4ZMg2awalq0pmiT7OunVG8jftc3aBHz+sdkuXPUJz4azETVoxg
        ==
X-ME-Sender: <xms:P-reYJNbA6A2_iqAbjw8fXmXZMxlDb5x52PgnbTpNqvtIDJX8hD95Q>
    <xme:P-reYL8rLlOk2aFyboKHoVTKV6NIPbyphWUv3sU_1e55PSG98qxXUOGbIT-0KwbpQ
    -IY1-stBDshsJoA2-A>
X-ME-Received: <xmr:P-reYISSatPvgdRKHzgIcXrfteTPP6SbJabJ6SdixAe8xdsBEszRL94LCQ4NyFocah0KKc8ryE8D0PXcW9oDc9HjZE5YwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeikedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgedtgfefgefhveeglefgfeeigeduueehkeektdeuueetgfehffev
    geeuieetheetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:P-reYFtmlpIzSQn_hy_dpava1auFnoZarqlRhZQ2IrajHHoReOIuPQ>
    <xmx:P-reYBcbJwwqfT2AG9MrLienUytp-LG-2zejtRJxEbKhI6Nq-a_RtA>
    <xmx:P-reYB3PF7tPB7w5W6W89wrWWmMEKGRDKaouID3KVsrDKznlTMkXKQ>
    <xmx:QOreYI66U9PBHcAolrIBkBk-PJZ0bR_s_NHX4SbagpBlu7Ri-bhKjA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jul 2021 06:28:12 -0400 (EDT)
Date:   Fri, 2 Jul 2021 03:27:59 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Wang Jianchao <jianchao.wan9@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
Subject: Re: [PATCH V2 1/7] ext4: remove the 'group' parameter of
 ext4_trim_extent
Message-ID: <YN7qL+AQ85bbJ1yo@localhost>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <61eceb4c-6e5f-34d0-9317-a833d7c63b6f@gmail.com>
 <YNMzhm2gIM2oQfjs@mit.edu>
 <YNOQYF7vKedXQnI8@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNOQYF7vKedXQnI8@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 23, 2021 at 03:49:52PM -0400, Theodore Ts'o wrote:
> CC'ed Josh since he was testing this patchset.
> 
> On Wed, Jun 23, 2021 at 09:13:42AM -0400, Theodore Ts'o wrote:
> > 
> > The conflicts were relatively minor, but the obvious fix-ups resulted
> > in a large number of crashes caused by various stress tests, such as
> > generic/068 and generic/204.  I'm currently investigating to see what
> > I might have messed up when I tried applying these patches, as well as
> > running your patch set applied against 5.12 to make sure the problems
> > weren't introduced by the patch set itself.
> 
> I applied this patch set on top of 5.12, where it applied w/o any
> patch conflicts, and I'm still seeing large number of crashes[1].  The
> crashes are in a wide variety of tests, and many of the stack traces
> involve the ext4_discard_work workqueue.

I applied this on top of a96bfed64c8986d6404e553f18203cae1f5ac7e6, which
required some fixups. I didn't try to run any kind of intensive
stress-tests, but I've run the deletion performance test I mentioned, as
well as various software compiles and other miscellaneous work. I
haven't run into any apparent issues.
