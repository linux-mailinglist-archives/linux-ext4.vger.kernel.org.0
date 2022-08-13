Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE6759180C
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Aug 2022 03:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiHMBMB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 21:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiHMBLz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 21:11:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0865A98EC
        for <linux-ext4@vger.kernel.org>; Fri, 12 Aug 2022 18:11:53 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27D1BlaD017018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 21:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660353109; bh=j1g8uhYigspJH989doVivrwoMX5Pu8nguHu7+l9FHh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ponviUl1MmBOzm58Y8sB+MAz+mfCtC0QGkE6837bgTcBgtYlIIFJK7mOSNFGgFamT
         vyprcRLhS4dJlOlbgTrYipJy7JUgf48ivVnSArki0nvB+nwLXD9Vg4RoTqw7cUb/TA
         RatlMucXWKTf9Cm27Va/Cfb0Wsj3zblB5RtgRg1LOlfjI+5DpdsY8LGc1h5rqoOYGu
         9XciZPpMl2MJLcf0wM5H3N0D1YHRfxlmQQlIH4IMrvudq4FVNR5VBZEpiCGdhoRQHk
         ALD7WjvCky/hMQ3dBuW3w5qtWlDQmftBKwrQcOD5uG8Luu9yXjlVBVDPtHPP9Wf3aY
         4k0P0sJ7QmVlw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 762C88C2DE9; Fri, 12 Aug 2022 21:11:47 -0400 (EDT)
Date:   Fri, 12 Aug 2022 21:11:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, Dongyang Li <dongyang@ddn.com>
Subject: Re: [PATCH] debugfs: quiet debugfs 'catastrophic' message
Message-ID: <Yvb6UzeX2Umg1ts+@mit.edu>
References: <20220805220606.11994-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805220606.11994-1-adilger@dilger.ca>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 05, 2022 at 04:06:07PM -0600, Andreas Dilger wrote:
> When debugfs runs with "-c", it prints a scary-looking message:
> 
>     catastrophic mode - not reading inode or group bitmaps
> 
> that is often misunderstood by users to mean that there is something
> wrong with the filesystem, when there is no problem at all.
> 
> Not reading the bitmaps is totally normal and expected behavior for
> the "-c" option, which is used to significantly shorten the debugfs
> command execution time by not reading metadata that isn't needed for
> commands run against very large filesystems.
> 
> Since there is often confusion about what this message means, it
> would be better to just avoid printing anything at all, since the
> use of "-c" is expressly requesting this behavior, and there are
> no messages printed out for other options.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> Reviewed-by: Dongyang Li <dongyang@ddn.com>
> Change-Id: I59b26a601780544ab995aa4ca7ab0c2123c70118

Applied, thanks!

					- Ted
