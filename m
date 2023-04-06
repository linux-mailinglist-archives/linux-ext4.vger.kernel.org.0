Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488996D9B5B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjDFO4k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 10:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDFO4k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 10:56:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD1E94
        for <linux-ext4@vger.kernel.org>; Thu,  6 Apr 2023 07:56:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 336EuJB2018009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 10:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1680792981; bh=fp1zX/6xjLg+UUsh0qeMkDT0yUwpyagDDLySycM8opc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Sxu5BbaWX0Bgn43aP7SKFzoa9wbWdK/GPVF9QH+sb6HK+ULi5BJZUYCPM6i/3wnrA
         1REwHstqK/peatGlEKcQOfvD49+gqQMwhuVQofpRkiWHwAoV1QH6UyZdw3obRuTRUG
         t7NDRjJ53F7xYp286FlJN2xZBmER2Hv8RJF2i7C+Z8+UAhkI2x1jrMzU4hdH7AJTY7
         pzA9XKKhmeBXFjN+au+p5m2UBmFGCis3Tg1iovrNiiMLD+wgTZQpSS0iukeGfcBa7m
         YGmNbcZPZAWankVFKuBwlIZSSYnYnLDBwWQokLg7mQ/zdrB6ysKbc1Py7Goyz+6LBs
         8NXHbsJDqECwA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2112F15C3ACE; Thu,  6 Apr 2023 10:56:19 -0400 (EDT)
Date:   Thu, 6 Apr 2023 10:56:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/29] fs: Add FGP_WRITEBEGIN
Message-ID: <20230406145619.GA162032@mit.edu>
References: <20230324180129.1220691-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324180129.1220691-2-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 24, 2023 at 06:01:01PM +0000, Matthew Wilcox wrote:
> This particular combination of flags is used by most filesystems
> in their ->write_begin method, although it does find use in a
> few other places.  Before folios, it warranted its own function
> (grab_cache_page_write_begin()), but I think that just having specialised
> flags is enough.  It certainly helps the few places that have been
> converted from grab_cache_page_write_begin() to __filemap_get_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Hey Willy,

Which commit/branch did you base this patch series on?  This commit
conflict with Vishal Moola's e8dfc854eef2 ("ext4: convert
mext_page_double_lock() to mext_folio_double_lock()") which landed in
v6.3-rc1.

I'm guessing what happened is that you based it on the ext4 dev branch
that I used when I sent the pull request to Linus, before I moved the
dev branch's origin to be on v6.3-rc3.  And since Vishal's patches
went in via the mm tree, and not the ext4 tree, we have conflicts with
the ext4 folio work done by some of Vishal's work in the last merge
window.

Sorry, I should have noticed this problem earlier (we had some painful
merge conflicts due to the ext4 changes in the mm tree) so I should
have realized this would continue to bite us this cycle.  :-/

I hate to do this, but would you mind rebasing this on the current
ext4 dev branch.  Thanks, and again, sorry for not catching this
sooner.

					- Ted
