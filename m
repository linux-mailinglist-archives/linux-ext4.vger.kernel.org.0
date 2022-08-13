Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF34F591808
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Aug 2022 03:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiHMBL0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiHMBLZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 21:11:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205DB03
        for <linux-ext4@vger.kernel.org>; Fri, 12 Aug 2022 18:11:24 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27D1BHZR016788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 21:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660353079; bh=7RgUoYdHb+gOPGegkR0jRJMJusGBIJi6cjgjdNII/Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eyq4+dZk7a4MI0+v9yDDHWdoc2mfQr3WNYTXLfG2oiqNM1pJDwbIUItVPe/2wqC2D
         c+hi9o/T4I7AODyt4YZZmlYbfQF87pxrp2Ta0Afspn+PaGlhjbBg4fLQhQ3Ph1LD4s
         WFixsUhO5yrmvGy7pVsy0MnDGd2FQZEGMjLz2dfCK4KXie7CTEQlXMqPOW2PPrnPGe
         yhgrGq7s0VinadnDdinWXEcaBg7E2iSKxUNhjBZNCO4O586e7Eqq2orBYCB0XfDuKM
         7vcnl9ChZCUdL80dgtYDvaCOzpsduwCcgYOWACsanHmBVXE9OGlSmStKiunlKJDlcF
         Mct0WCQajUIDw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 56A388C2DE9; Fri, 12 Aug 2022 21:11:17 -0400 (EDT)
Date:   Fri, 12 Aug 2022 21:11:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michael Hudson-Doyle <michael.hudson@ubuntu.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] resize2fs: open device read-only when -P is passed
Message-ID: <Yvb6NT31OUb1y2kt@mit.edu>
References: <20220526010828.1462397-1-michael.hudson@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526010828.1462397-1-michael.hudson@ubuntu.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 26, 2022 at 01:08:28PM +1200, Michael Hudson-Doyle wrote:
> We ran into this because we noticed that resize2fs -P $device was
> triggering udev events.
> 
> I added a very simple test that just checks resize2fs -P on a file
> lacking the w bit succeeds.
> 
> Signed-off-by: Michael Hudson-Doyle <michael.hudson@ubuntu.com>

Applied, thanks!

						- Ted
