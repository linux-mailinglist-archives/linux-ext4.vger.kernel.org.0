Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF2C6D9BD7
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 17:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbjDFPIp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 11:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239704AbjDFPIZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 11:08:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C3AF23
        for <linux-ext4@vger.kernel.org>; Thu,  6 Apr 2023 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jzl+p+MMfFhJ+nNMsEILT6QwILEqSSIZfVxRVhQtawU=; b=OUoZ5i6RbdOBR8rLJccvSyiTvt
        7v9HaM6zIKkB6WG0C7hZCcU/QTAyYSmWk7hqjYtVsRbz1shSqLZiwbY25UpawqCgRJkTIk68s2qpe
        InLKAiDa5j1A/0dTwOmDudWyk+O+JOVkPYMOEbI4NPJRdczYp7esYrY2qcESi9SEiPkDSzZ0plpWS
        IRbtYDZMZBJCfDiaWmaHGe9ttC6RxHV/EhNWMd9/MXfD9DUkr9ZKjU/k41PWbAEngzuA9FTt+Llmt
        wUyKRpw0wSzp337UT/kxeWBJ7bj7xlGB/XD5zuFdYlxZ1H2dFPsjTJYxAvQOTHjmrhAs5SzR/rtYT
        LtW59Sxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkRDX-00HWJN-Er; Thu, 06 Apr 2023 15:08:03 +0000
Date:   Thu, 6 Apr 2023 16:08:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/29] fs: Add FGP_WRITEBEGIN
Message-ID: <ZC7gU2uyA0Zcjn2W@casper.infradead.org>
References: <20230324180129.1220691-2-willy@infradead.org>
 <20230406145619.GA162032@mit.edu>
 <ZC7fZ72RcbteNqO2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC7fZ72RcbteNqO2@casper.infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 06, 2023 at 04:04:07PM +0100, Matthew Wilcox wrote:
> On Thu, Apr 06, 2023 at 10:56:19AM -0400, Theodore Ts'o wrote:
> > On Fri, Mar 24, 2023 at 06:01:01PM +0000, Matthew Wilcox wrote:
> > > This particular combination of flags is used by most filesystems
> > > in their ->write_begin method, although it does find use in a
> > > few other places.  Before folios, it warranted its own function
> > > (grab_cache_page_write_begin()), but I think that just having specialised
> > > flags is enough.  It certainly helps the few places that have been
> > > converted from grab_cache_page_write_begin() to __filemap_get_folio().
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > Hey Willy,
> > 
> > Which commit/branch did you base this patch series on?  This commit
> 
> next-20230321.  I haven't noticed any conflicts while rebasing to
> next-20230404.
> 
> > conflict with Vishal Moola's e8dfc854eef2 ("ext4: convert
> > mext_page_double_lock() to mext_folio_double_lock()") which landed in
> > v6.3-rc1.
> 
> I'm not sure why you're seeing that conflict.  The context lines look
> like it's applied after mext_folio_double_lock, eg:
> 
> @@ -126,7 +126,6 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,

Ah, I see the conflicting patch in -next.  It's hch's

    mm: return an ERR_PTR from __filemap_get_folio

@@ -141,18 +141,18 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
        flags = memalloc_nofs_save();
        folio[0] = __filemap_get_folio(mapping[0], index1, fgp_flags,
                        mapping_gfp_mask(mapping[0]));
-       if (!folio[0]) {
+       if (IS_ERR(folio[0])) {
                memalloc_nofs_restore(flags);
-               return -ENOMEM;
+               return PTR_ERR(folio[0]);

This is a syntactic, not semantic conflict.  I can fix that up, but of
course it will be a conflict for Linus to resolve.
