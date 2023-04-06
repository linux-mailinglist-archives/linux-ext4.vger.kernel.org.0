Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88A6D9BA9
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbjDFPEl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbjDFPEg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 11:04:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F46BE74
        for <linux-ext4@vger.kernel.org>; Thu,  6 Apr 2023 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u7gTGrNg5RfnMd2h3kCbs/th0MqPdk8C76PAinozrjo=; b=IrygRPNLRvP1Ujy66L04odciSW
        jFkA/OZpNx8MTUwJXnwlT+UyUJYP4icMJ36G5ZaNl5c3qWlvYpr0YVVYi7Vq1dP02YUYS1Kprh5fj
        BSa9xYFUJg88ct2I6DneSLY++tVw0WUDE9/VgHzBwwSh/MRLkg57/WtWgoG0gplVDEl/95HL3rzYK
        jMbwVpleZCthapg1tZlCLC3WopB0YKs6v3CbzIk0rKnkVYPFgbd2MNUatNWNmoczCEH52St/BxHtM
        PtCHCHJGOfnWOhlTR5bnmrewR3ZDSE4ni5S88RoVwFenn7/wL7OmXsyHE/GCdjsSPtps/2H9/0xox
        DBK0ntCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkR9j-00HW6N-L8; Thu, 06 Apr 2023 15:04:07 +0000
Date:   Thu, 6 Apr 2023 16:04:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/29] fs: Add FGP_WRITEBEGIN
Message-ID: <ZC7fZ72RcbteNqO2@casper.infradead.org>
References: <20230324180129.1220691-2-willy@infradead.org>
 <20230406145619.GA162032@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406145619.GA162032@mit.edu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 06, 2023 at 10:56:19AM -0400, Theodore Ts'o wrote:
> On Fri, Mar 24, 2023 at 06:01:01PM +0000, Matthew Wilcox wrote:
> > This particular combination of flags is used by most filesystems
> > in their ->write_begin method, although it does find use in a
> > few other places.  Before folios, it warranted its own function
> > (grab_cache_page_write_begin()), but I think that just having specialised
> > flags is enough.  It certainly helps the few places that have been
> > converted from grab_cache_page_write_begin() to __filemap_get_folio().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Hey Willy,
> 
> Which commit/branch did you base this patch series on?  This commit

next-20230321.  I haven't noticed any conflicts while rebasing to
next-20230404.

> conflict with Vishal Moola's e8dfc854eef2 ("ext4: convert
> mext_page_double_lock() to mext_folio_double_lock()") which landed in
> v6.3-rc1.

I'm not sure why you're seeing that conflict.  The context lines look
like it's applied after mext_folio_double_lock, eg:

@@ -126,7 +126,6 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,

> I'm guessing what happened is that you based it on the ext4 dev branch
> that I used when I sent the pull request to Linus, before I moved the
> dev branch's origin to be on v6.3-rc3.  And since Vishal's patches
> went in via the mm tree, and not the ext4 tree, we have conflicts with
> the ext4 folio work done by some of Vishal's work in the last merge
> window.
> 
> Sorry, I should have noticed this problem earlier (we had some painful
> merge conflicts due to the ext4 changes in the mm tree) so I should
> have realized this would continue to bite us this cycle.  :-/
> 
> I hate to do this, but would you mind rebasing this on the current
> ext4 dev branch.  Thanks, and again, sorry for not catching this
> sooner.
> 
> 					- Ted
