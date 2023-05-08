Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F8A6FB930
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 23:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjEHVNg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEHVNf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 17:13:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6B2D6D;
        Mon,  8 May 2023 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XOfR5eYqFEKI2MRwh9rMh2Y6eXpYj1Cs8OGL6W+hOOw=; b=Bm/xNlf3ZvZys8QuPJvX+zIHtq
        nF7j97jCosW8FystIsyTQ2INw9EuyYHCOMjd0w0y4cHC1w4p2Q3eld5ffdWccgKcxN25CqvmXcyX3
        GXBRoOWKV86rvccyT20Y5M6fzHNguYjaRRogHBoWLr+LYfy7LIMoVtZJS4/WNjFvYM0hEurjjH6PK
        nD0FQ3QV0HxQZFkq2DxuuAKw2xcxd1+wohoCZQAwpbkRjjDc3nURzC5YjHSF31vV1/2g9Fr4+UdbK
        zKkg9wTCiPdjauQBSjjV07j+E7LFLkFeqGdXcxq3tm0G350ZAg+UA8e6jm0VrDbAhZAjiS8uyiH7S
        B6LBVoqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pw8Ah-00EVH7-AR; Mon, 08 May 2023 21:13:27 +0000
Date:   Mon, 8 May 2023 22:13:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, linux-mm@kvack.org
Subject: Re: [PATCH] ext4: remove superfluous check that pointer is not NULL
Message-ID: <ZFll93wsEUZIV/aI@casper.infradead.org>
References: <20230508151337.79304-1-tudor.ambarus@linaro.org>
 <ZFkf/oJnCLZSWgYr@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFkf/oJnCLZSWgYr@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 08, 2023 at 12:14:54PM -0400, Theodore Ts'o wrote:
> On Mon, May 08, 2023 at 03:13:37PM +0000, Tudor Ambarus wrote:
> > If @buffer is NULL, no operation is performed for kvfree(buffer),
> > remove superfluous check.
> > 
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> I was looking at this just a few weeks ago, and I couldn't find any
> actual *documentation* that it was safe to call vfree(NIILL) or
> kvfree(NULL).  The problem is there are a lot of architecture-specific
> functions, and unlike with kfree() there is no top-level "if (ptr ==
> NULL) return;" in the top-level vfree() and kvfree().

There doesn't need to be in kvfree().  is_vmalloc_addr() returns 'false'
for NULL, so it calls kfree(), which as you note has an explicit check
for ZERO_OR_NULL_PTR().  is_vmalloc_addr() also returns false for the
ZERO pointer, fwiw.

I agree that this should be explicitly documented as allowed, since it's
not reasonable to expect users to dig through these functions to verify
that such a change is safe.

