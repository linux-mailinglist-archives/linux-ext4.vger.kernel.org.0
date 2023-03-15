Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF8A6BBCCC
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 19:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjCOS51 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCOS50 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 14:57:26 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F2D7302A
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 11:57:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32FIvCsl010604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 14:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678906634; bh=G5kNY/Jm4Tqyg3bh3XHD8BUtbVcJf1f2c3VTJKJHgpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=JiW8E1QLpUlDXtPc2+zyD67vFAwJaYyw8NkhR5+xkZLNcTkE+Nc1L1oahf3B47mYG
         MrPqoza5UObdGHZ1moRmYUAdW23FVGbVgf878I7m+nAkUfrktqTxdg/C8EV10ytaSX
         TjfB/5MDVm74Yvos8wjnmXEGdEYMtHYFWKhx11ltBZl0ZSQtijtokDSHuVpYp+qBVH
         9PINw7OGInAvassBoLbUIOIZrfhQpxYfv9AGYVS5TM3JqUcQx/omji4yrlic71TWrv
         bnBXJg57CT6qZiR6ybJas3kBAcVEQRbl2ViYuAUkj3RRTZAZ6LehFwgFnAKhNJJAbI
         VeUGW6HDP7dxA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DA00315C5830; Wed, 15 Mar 2023 14:57:11 -0400 (EDT)
Date:   Wed, 15 Mar 2023 14:57:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ivan Zahariev <famzah@icdsoft.com>, linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <20230315185711.GB3024297@mit.edu>
References: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
 <Y45eV/nA2tj8C94W@mit.edu>
 <20230112150708.y2ws5q3wu2xxow3p@quack3>
 <ea6a88c7-5603-af1d-e775-0857fc605224@icdsoft.com>
 <20230315173217.to44byhvg6baf7ai@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315173217.to44byhvg6baf7ai@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 15, 2023 at 06:32:17PM +0100, Jan Kara wrote:
> On Wed 15-03-23 13:27:11, Ivan Zahariev wrote:
> > On 12.1.2023 г. 17:07, Jan Kara wrote:
> > > So after a bit of thought I agree that the commit 5c48a7df91499 ("ext4: fix
> > > an use-after-free issue about data=journal writeback mode") is broken. The
> > > problem is when we unlock the page in __ext4_journalled_writepage() anybody
> > > else can come, writeout the page, and reclaim page buffers (due to memory
> > > pressure). Previously, bh references were preventing the buffer reclaim to
> > > happen but now there's nothing to prevent it.
> > > 
> > > My rewrite of data=journal writeback path fixes this problem as a
> > > side-effect but perhaps we need a quickfix for stable kernels? Something
> > > like attached patch?
> > > 
> > > 								Honza
> > 
> > Do you consider this patch production ready?
> 
> Ah, the patch has likely fallen through the cracks because I waited for
> some reply and then forgot about it and Ted likely missed it inside the
> thread. But yes I consider the patch safe to test on production machines -
> at least it has passed testing with fstests on my test VM without any
> visible issues.

Yeah, sorry, I didn't see it since it was in an attachment as opposed
to with an explicit [PATCH] subject line.

And at this point, the data=journal writeback patches have landed in
the ext4/dev tree, and while we could try to see if we could land this
before the next merge window, I'm worried about merge or semantic
conflicts of having both patches in a tree at one time.

I guess we could send it to Linus, let it get backported into stable,
and then revert it during the merge window, ahead of applying the
data=journal cleanup patch series.  But that seems a bit ugly.  Or we
could ask for an exception from the stable kernel folks, after I do a
full set of xfstests runs on it.  (Of course, I don't think anyone has
been able to create a reliable reproducer, so all we can do is to test
for regression failures.)

Jan, Greg, what do you think?

					- Ted
