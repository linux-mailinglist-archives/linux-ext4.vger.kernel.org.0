Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30292796F65
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Sep 2023 05:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjIGDsK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Sep 2023 23:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIGDsJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Sep 2023 23:48:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938CDCE6;
        Wed,  6 Sep 2023 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nFNrx+1oT35lq3jlqAiBGWUXRAbURzvzkzb4iEv8f+4=; b=iu2WETm6UjNAezwa5WiNZ3KIJL
        MMT4GxcKyFaJdS9aKyZ/qB6SZ1h3q0n5LMfk63dvhhh//KDnLw/+ZAlWFDw8tw8DqI9PUFp3wqj78
        TBmRN22nKrLVU4XwMPQ8oJOoIZ23o9L44O3xp51KW/Lln0+0yFh+c2mWQSqHaN7ewrSslqo7kt0HH
        yElUCbYXfSjnDod/iHOVUh+rE9cgPFzlfKTnS7qsoX38y5q9t50OsmHQLBxLi7zGIlK5jWb6iupSb
        hHYmfqyEi3utmAGR3eilB8+NTBUOMHorqmZe0FkUMUkgSWLviSygGR3iV6AQzZDWAMiPxtColHyl0
        sshJwOCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qe5zq-007whg-Lf; Thu, 07 Sep 2023 03:47:58 +0000
Date:   Thu, 7 Sep 2023 04:47:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@kernel.org>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery
 test fails
Message-ID: <ZPlH7rGfslnFmgYn@casper.infradead.org>
References: <ZPjYTDB6x83BIJMc@casper.infradead.org>
 <87tts63d3w.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tts63d3w.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 07, 2023 at 08:26:35AM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Wed, Sep 06, 2023 at 01:38:23PM +0100, Matthew Wilcox wrote:
> >> > Is this code path a possibility, which can cause above logs?
> >> > 
> >> >    ptr = jbd2_alloc() -> kmem_cache_alloc()
> >> >    <..>
> >> >    new_folio = virt_to_folio(ptr)
> >> >    new_offset = offset_in_folio(new_folio, ptr)
> >> > 
> >> > And then I am still not sure what the problem really is? 
> >> > Is it because at the time of checkpointing, the path is still not fully
> >> > converted to folio?
> >> 
> >> Oh yikes!  I didn't know that the allocation might come from kmalloc!
> >> Yes, slab might use high-order allocations.  I'll have to look through
> >> this and figure out what the problem might be.
> >
> > I think the probable cause is bh_offset().  Before these patches, if
> > we allocated a buffer at offset 9kB into an order-2 slab, we'd fill in
> > b_page with the third page of the slab and calculate bh_offset as 1kB.
> > With these patches, we set b_page to the first page of the slab, and
> > bh_offset still comes back as 1kB so we read from / write to entirely
> > the wrong place.
> >
> > With this redefinition of bh_offset(), we calculate the offset relative
> > to the base page if it's a tail page, and relative to the folio if it's
> > a folio.  Works out nicely ;-)
> 
> Thanks Matthew for explaining the problem clearly.
> 
> 
> >
> > I have three other things I'm trying to debug right now, so this isn't
> > tested, but if you have time you might want to give it a run.
> 
> sure, I gave it a try.
> 
> >
> > diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> > index 6cb3e9af78c9..dc8fcdc40e95 100644
> > --- a/include/linux/buffer_head.h
> > +++ b/include/linux/buffer_head.h
> > @@ -173,7 +173,10 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
> >  	return test_bit_acquire(BH_Uptodate, &bh->b_state);
> >  }
> >  
> > -#define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
> > +static inline unsigned long bh_offset(struct buffer_head *bh)
> > +{
> > +	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
> > +}
> >  
> >  /* If we *know* page->private refers to buffer_heads */
> >  #define page_buffers(page)					\
> 
> 
> I used "const" for bh to avoid warnings from fs/nilfs/alloc.c

Excellent.  I didn't try compiling nilfs ;-)

> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 4ede47649a81..b61fa79cb7f5 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -171,7 +171,10 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
>         return test_bit_acquire(BH_Uptodate, &bh->b_state);
>  }
> 
> -#define bh_offset(bh)          ((unsigned long)(bh)->b_data & ~PAGE_MASK)
> +static inline unsigned long bh_offset(const struct buffer_head *bh)
> +{
> +       return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
> +}
> 
>  /* If we *know* page->private refers to buffer_heads */
>  #define page_buffers(page)                                     \
> 
> 
> But this change alone was still giving me failures. On looking into
> usage of b_data, I found we use offset_in_page() instead of bh_offset()
> in jbd2. So I added below changes in fs/jbd2 to replace offset_in_page()
> to bh_offset()...
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 1073259902a6..0c25640714ac 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -304,7 +304,7 @@ static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
> 
>         addr = kmap_atomic(page);
>         checksum = crc32_be(crc32_sum,
> -               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
> +               (void *)(addr + bh_offset(bh)), bh->b_size);
>         kunmap_atomic(addr);

Hm, that's not going to work on a highmem machine.  It'll work on 64-bit!
Actually, no, it'll work on a highmem machine because slab doesn't
allocate from highmem.  Still, it's a bit unclean.  Let's go full folio
on this one:

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 1073259902a6..8d6f934c3d95 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -298,14 +298,12 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 
 static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
 {
-	struct page *page = bh->b_page;
 	char *addr;
 	__u32 checksum;
 
-	addr = kmap_atomic(page);
-	checksum = crc32_be(crc32_sum,
-		(void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
-	kunmap_atomic(addr);
+	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
+	checksum = crc32_be(crc32_sum, addr, bh->b_size);
+	kunmap_local(addr);
 
 	return checksum;
 }
@@ -322,7 +320,6 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
 				    struct buffer_head *bh, __u32 sequence)
 {
 	journal_block_tag3_t *tag3 = (journal_block_tag3_t *)tag;
-	struct page *page = bh->b_page;
 	__u8 *addr;
 	__u32 csum32;
 	__be32 seq;
@@ -331,11 +328,10 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
 		return;
 
 	seq = cpu_to_be32(sequence);
-	addr = kmap_atomic(page);
+	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
 	csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
-	csum32 = jbd2_chksum(j, csum32, addr + offset_in_page(bh->b_data),
-			     bh->b_size);
-	kunmap_atomic(addr);
+	csum32 = jbd2_chksum(j, csum32, addr, bh->b_size);
+	kunmap_local(addr);
 
 	if (jbd2_has_feature_csum3(j))
 		tag3->t_checksum = cpu_to_be32(csum32);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 4d1fda1f7143..5f08b5fd105a 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -935,19 +935,15 @@ static void warn_dirty_buffer(struct buffer_head *bh)
 /* Call t_frozen trigger and copy buffer data into jh->b_frozen_data. */
 static void jbd2_freeze_jh_data(struct journal_head *jh)
 {
-	struct page *page;
-	int offset;
 	char *source;
 	struct buffer_head *bh = jh2bh(jh);
 
 	J_EXPECT_JH(jh, buffer_uptodate(bh), "Possible IO failure.\n");
-	page = bh->b_page;
-	offset = offset_in_page(bh->b_data);
-	source = kmap_atomic(page);
+	source = kmap_local_folio(bh->b_folio, bh_offset(bh));
 	/* Fire data frozen trigger just before we copy the data */
-	jbd2_buffer_frozen_trigger(jh, source + offset, jh->b_triggers);
-	memcpy(jh->b_frozen_data, source + offset, bh->b_size);
-	kunmap_atomic(source);
+	jbd2_buffer_frozen_trigger(jh, source, jh->b_triggers);
+	memcpy(jh->b_frozen_data, source, bh->b_size);
+	kunmap_local(source);
 
 	/*
 	 * Now that the frozen data is saved off, we need to store any matching

(I've been thinking about adding a kmap_local_bh(bh))

> ext4/1k: 15 tests, 1 failures, 1709 seconds
>   generic/455  Pass     43s
>   generic/475  Pass     128s
>   generic/482  Pass     183s
>   generic/455  Pass     43s
>   generic/475  Pass     134s
>   generic/482  Pass     191s
>   generic/455  Pass     41s
>   generic/475  Pass     139s
>   generic/482  Pass     135s
>   generic/455  Pass     46s
>   generic/475  Pass     132s
>   generic/482  Pass     146s
>   generic/455  Pass     47s
>   generic/475  Failed   145s
>   generic/482  Pass     156s
> Totals: 15 tests, 0 skipped, 1 failures, 0 errors, 1709s
> 
> I guess the above failure (generic/475) could be due to it's flakey
> behaviour which Ted was mentioning.
> 
> 
> Now, while we are at it, I think we should also make change to reiserfs from
> offset_in_page() to bh_offset()
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 015bfe4e4524..23411ec163d4 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -4217,7 +4217,7 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
>                         page = cn->bh->b_page;
>                         addr = kmap(page);
>                         memcpy(tmp_bh->b_data,
> -                              addr + offset_in_page(cn->bh->b_data),
> +                              addr + bh_offset(cn->bh),
>                                cn->bh->b_size);
>                         kunmap(page);

This one should probably be:

-			addr = kmap(page);
-			memcpy(tmp_bh->b_data,
-				addr + offset_in_page(cn->bh->b_data),
-				cn->bh->b_size);
-			kunmap(page);
+			memcpy_from_folio(tmp_bh->b_data, cn->bh->b_folio,
+					bh_offset(cn->bh), cn->bh->b_size);

> I will also run "auto" group with ext4/1k with all of above change. Will
> update the results once it is done.

Appreciate it!  I don't think you'll see a significant difference with
the patches above; you've nailed the actual problems and I'm just
using slighlty nicer APIs.
