Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F3644D90
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 21:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLFUxn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 15:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLFUxm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 15:53:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665712AC47;
        Tue,  6 Dec 2022 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fCWSY7cJhC6SCsB3eS/lFIy0C//ufeGGLBNh5MPIYFM=; b=XwL9WmsevY1I4e+gKktbMIjyPZ
        7YR84ru8ttEvCxmMOObqRIzHYEebEI2uAbr1/v2x99Q+EqRSvtK7uPJ8gXa/2lhfAvsZZE5DqXeFN
        eGU0a8U8jQ8vZtwQiI3cmQatmYx9pjDu2HrZgw1hGOtrm/kQVW0VL3I2gYMLRTl9sbjRdRtY+vAwW
        pixTnKryWDAJnUtGnw/bErL/18wljmeI4qBUQvjDkAuQYlEQpIsr5pwiBrrhGsKxz8PQ2lMCYifwL
        rjbSBuVtzxI50nVC5RHStvS7qVU0M0JSKpdGOC+6K2ONKh32AiLueU9F1lwvd4YUZ0Cyqyqlv68ev
        zEa3BS9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2ewj-004oCG-4Y; Tue, 06 Dec 2022 20:53:45 +0000
Date:   Tue, 6 Dec 2022 20:53:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH mm-unstable] ext4: Convert mext_page_double_lock() to
 mext_folio_double_lock()
Message-ID: <Y4+r2c+d+gWi93og@casper.infradead.org>
References: <20221206204115.35258-1-vishal.moola@gmail.com>
 <Y4+q+vYuqqM0RKOT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4+q+vYuqqM0RKOT@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 06, 2022 at 08:50:02PM +0000, Matthew Wilcox wrote:
> >  	flags = memalloc_nofs_save();
> > -	page[0] = grab_cache_page_write_begin(mapping[0], index1);
> > -	if (!page[0]) {
> > +	folio[0] = __filemap_get_folio(mapping[0], index1, fgp_flags,
> > +			mapping_gfp_mask(mapping[0]));
> 
> one
> 
> > +	if (!folio[0]) {
> >  		memalloc_nofs_restore(flags);
> >  		return -ENOMEM;
> >  	}
> >  
> > -	page[1] = grab_cache_page_write_begin(mapping[1], index2);
> > +	folio[1] = __filemap_get_folio(mapping[1], index2, fgp_flags,
> > +			mapping_gfp_mask(mapping[1]));
> 
> two

*facepalm*.  Those don't contain calls to compound_head(), they contain
calls to folio_file_page(), which is still a moderately-expensive
unnecessary conversion, but a conversion in the other direction.
