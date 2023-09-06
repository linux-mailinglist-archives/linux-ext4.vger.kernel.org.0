Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3C7943EB
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjIFTvy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Sep 2023 15:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjIFTvx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Sep 2023 15:51:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835B171A;
        Wed,  6 Sep 2023 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lYqvfUxrjJBI3W5sFQK8JINW4dgJBOR0soBLBY+UK1E=; b=igC4ioi+4p97koDXBrAP/oiqGk
        pOIvoHwFWFBftnB0pl86swEClAGjyHMnhl4d8aEfJDfaDsngXiBd6cP2cHkyB3UedGn8hsCEek4Xc
        CK9RMeGc6zFtss1QIbxX0pHMAwIMZpcCQh89aFFlt/VAU/YkLqgqG2gJMyqwSrj1frP+baLfXBaRU
        6Ix+acVvbn01n9s25FQT2GE/bg7AXYXiRJJ5LS+enLHiASvnVEJioYIKy19J/pZ+J7N57cMWw08sQ
        3CfwxmcqZoZ3OUxa6msPHaKlswK0uFrLMbgKBaHGTsQ7SBDckpADQaq8zgmwFBN/b9PR6ZwUZDKDw
        sDuFdXxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdyYu-0055PK-SO; Wed, 06 Sep 2023 19:51:40 +0000
Date:   Wed, 6 Sep 2023 20:51:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@kernel.org>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery
 test fails
Message-ID: <ZPjYTDB6x83BIJMc@casper.infradead.org>
References: <ZPendrb8gSbAC6fM@casper.infradead.org>
 <87wmx336ns.fsf@doe.com>
 <ZPhyv7cHxO9vbciL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPhyv7cHxO9vbciL@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 06, 2023 at 01:38:23PM +0100, Matthew Wilcox wrote:
> > Is this code path a possibility, which can cause above logs?
> > 
> >    ptr = jbd2_alloc() -> kmem_cache_alloc()
> >    <..>
> >    new_folio = virt_to_folio(ptr)
> >    new_offset = offset_in_folio(new_folio, ptr)
> > 
> > And then I am still not sure what the problem really is? 
> > Is it because at the time of checkpointing, the path is still not fully
> > converted to folio?
> 
> Oh yikes!  I didn't know that the allocation might come from kmalloc!
> Yes, slab might use high-order allocations.  I'll have to look through
> this and figure out what the problem might be.

I think the probable cause is bh_offset().  Before these patches, if
we allocated a buffer at offset 9kB into an order-2 slab, we'd fill in
b_page with the third page of the slab and calculate bh_offset as 1kB.
With these patches, we set b_page to the first page of the slab, and
bh_offset still comes back as 1kB so we read from / write to entirely
the wrong place.

With this redefinition of bh_offset(), we calculate the offset relative
to the base page if it's a tail page, and relative to the folio if it's
a folio.  Works out nicely ;-)

I have three other things I'm trying to debug right now, so this isn't
tested, but if you have time you might want to give it a run.

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6cb3e9af78c9..dc8fcdc40e95 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -173,7 +173,10 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
 	return test_bit_acquire(BH_Uptodate, &bh->b_state);
 }
 
-#define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
+static inline unsigned long bh_offset(struct buffer_head *bh)
+{
+	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
+}
 
 /* If we *know* page->private refers to buffer_heads */
 #define page_buffers(page)					\
