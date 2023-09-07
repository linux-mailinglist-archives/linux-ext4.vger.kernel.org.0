Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45217974E2
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Sep 2023 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjIGPlz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Sep 2023 11:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343629AbjIGPal (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Sep 2023 11:30:41 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E881A8;
        Thu,  7 Sep 2023 08:30:14 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5733aa10291so633789eaf.3;
        Thu, 07 Sep 2023 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100569; x=1694705369; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+/hO2N46XznIelRZGnvhxfN7kXWieLW8xVcbOFNy2Oc=;
        b=mktv6dMF8iVfFstPbh2EWO0fany+Bh3vPJVRoGRRXd1/ACRBBZqVDIsR4GJFRH5Ech
         lugOiiGWPjOLxU/pw8GHJNFhGtx5vAu5MSRyuMKjR4/0c3T1V0qLcjZ+CWfu7tS3w9Wt
         R/NCp4GRbKJn2vhCPa86NzZqY5rNz9ePGSF1LwLy2pOfjB3aNxXKGWTzHmi8uCsqcoQw
         iaiQeZwXTYUdLnu8rXngB/7AjPdeTqEvp3Z6bDHjV1m7KsNgnh+yh4z/Ze8+iHbeYV7v
         GTAjRK29uiYf9uKjMAbXSSkX2OWFmCXqaz2dK860AaWVxZhuqf8j9wIkom3oNukT9NDo
         j+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100569; x=1694705369;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/hO2N46XznIelRZGnvhxfN7kXWieLW8xVcbOFNy2Oc=;
        b=bCLEy7e8dVMJiOdvJKfNcrWmbTO6Fh/8Ofs6WTlFzYE0dme0srQ/VfjmwPVff4FQXl
         Vn6xxcI7COwzchqkP6eskb7uvuLl/n/A7uVfgY4XLSkwJmFUBeVFgKOurkfXc9VmYv5X
         KYarY8AR4Vrois7omD7532PzzRdzd4ddsRRkKgWBmHF3qkHhF3NXfOGL87I/TZNs6lqx
         c4+hPIj2VhDjlt+2vwEQy9UIYbqpJppoDk2zB4prNtZvRFroXvk/7f245hiTR416ndEu
         4mCnzco8/QsAxAqRexQb0vpI9Ir+9fLWW4dleuthdMjU8ugrOvVFkOr8Ox804i54TNpm
         8u3g==
X-Gm-Message-State: AOJu0Yzi670/SjCcxp/pFqVuT+mfJ7WGO8qRx8AHNmP2OEc87BXC0k3H
        wFiNDdTWfDcsM8PNk5u6xukWc/MKQv8=
X-Google-Smtp-Source: AGHT+IEUdY8Ee7GuXR9uQ/JpSu00OBMEQ7TZYl4SVgH2Wo/8XSmSFkG2Yqt3GrcxaKraHy5jEKWyRg==
X-Received: by 2002:a17:90a:6383:b0:267:f5d1:1dd3 with SMTP id f3-20020a17090a638300b00267f5d11dd3mr14830230pjj.11.1694093743834;
        Thu, 07 Sep 2023 06:35:43 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090a110900b0026f4bb8b2casm1601966pja.6.2023.09.07.06.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 06:35:43 -0700 (PDT)
Date:   Thu, 07 Sep 2023 19:05:38 +0530
Message-Id: <87r0na2jit.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@kernel.org>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery test fails
In-Reply-To: <ZPlH7rGfslnFmgYn@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Sep 07, 2023 at 08:26:35AM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> 
>> > On Wed, Sep 06, 2023 at 01:38:23PM +0100, Matthew Wilcox wrote:
>> >> > Is this code path a possibility, which can cause above logs?
>> >> > 
>> >> >    ptr = jbd2_alloc() -> kmem_cache_alloc()
>> >> >    <..>
>> >> >    new_folio = virt_to_folio(ptr)
>> >> >    new_offset = offset_in_folio(new_folio, ptr)
>> >> > 
>> >> > And then I am still not sure what the problem really is? 
>> >> > Is it because at the time of checkpointing, the path is still not fully
>> >> > converted to folio?
>> >> 
>> >> Oh yikes!  I didn't know that the allocation might come from kmalloc!
>> >> Yes, slab might use high-order allocations.  I'll have to look through
>> >> this and figure out what the problem might be.
>> >
>> > I think the probable cause is bh_offset().  Before these patches, if
>> > we allocated a buffer at offset 9kB into an order-2 slab, we'd fill in
>> > b_page with the third page of the slab and calculate bh_offset as 1kB.
>> > With these patches, we set b_page to the first page of the slab, and
>> > bh_offset still comes back as 1kB so we read from / write to entirely
>> > the wrong place.
>> >
>> > With this redefinition of bh_offset(), we calculate the offset relative
>> > to the base page if it's a tail page, and relative to the folio if it's
>> > a folio.  Works out nicely ;-)
>> 
>> Thanks Matthew for explaining the problem clearly.
>> 
>> 
>> >
>> > I have three other things I'm trying to debug right now, so this isn't
>> > tested, but if you have time you might want to give it a run.
>> 
>> sure, I gave it a try.
>> 
>> >
>> > diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
>> > index 6cb3e9af78c9..dc8fcdc40e95 100644
>> > --- a/include/linux/buffer_head.h
>> > +++ b/include/linux/buffer_head.h
>> > @@ -173,7 +173,10 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
>> >  	return test_bit_acquire(BH_Uptodate, &bh->b_state);
>> >  }
>> >  
>> > -#define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
>> > +static inline unsigned long bh_offset(struct buffer_head *bh)
>> > +{
>> > +	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
>> > +}
>> >  
>> >  /* If we *know* page->private refers to buffer_heads */
>> >  #define page_buffers(page)					\
>> 
>> 
>> I used "const" for bh to avoid warnings from fs/nilfs/alloc.c
>
> Excellent.  I didn't try compiling nilfs ;-)
>
>> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
>> index 4ede47649a81..b61fa79cb7f5 100644
>> --- a/include/linux/buffer_head.h
>> +++ b/include/linux/buffer_head.h
>> @@ -171,7 +171,10 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
>>         return test_bit_acquire(BH_Uptodate, &bh->b_state);
>>  }
>> 
>> -#define bh_offset(bh)          ((unsigned long)(bh)->b_data & ~PAGE_MASK)
>> +static inline unsigned long bh_offset(const struct buffer_head *bh)
>> +{
>> +       return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
>> +}
>> 
>>  /* If we *know* page->private refers to buffer_heads */
>>  #define page_buffers(page)                                     \
>> 
>> 
>> But this change alone was still giving me failures. On looking into
>> usage of b_data, I found we use offset_in_page() instead of bh_offset()
>> in jbd2. So I added below changes in fs/jbd2 to replace offset_in_page()
>> to bh_offset()...
>> 
>> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
>> index 1073259902a6..0c25640714ac 100644
>> --- a/fs/jbd2/commit.c
>> +++ b/fs/jbd2/commit.c
>> @@ -304,7 +304,7 @@ static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
>> 
>>         addr = kmap_atomic(page);
>>         checksum = crc32_be(crc32_sum,
>> -               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
>> +               (void *)(addr + bh_offset(bh)), bh->b_size);
>>         kunmap_atomic(addr);
>
> Hm, that's not going to work on a highmem machine.  It'll work on 64-bit!
> Actually, no, it'll work on a highmem machine because slab doesn't
> allocate from highmem.  Still, it's a bit unclean.  Let's go full folio
> on this one:
>
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 1073259902a6..8d6f934c3d95 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -298,14 +298,12 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
>  
>  static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
>  {
> -	struct page *page = bh->b_page;
>  	char *addr;
>  	__u32 checksum;
>  
> -	addr = kmap_atomic(page);
> -	checksum = crc32_be(crc32_sum,
> -		(void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
> -	kunmap_atomic(addr);
> +	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
> +	checksum = crc32_be(crc32_sum, addr, bh->b_size);
> +	kunmap_local(addr);
>  
>  	return checksum;
>  }
> @@ -322,7 +320,6 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
>  				    struct buffer_head *bh, __u32 sequence)
>  {
>  	journal_block_tag3_t *tag3 = (journal_block_tag3_t *)tag;
> -	struct page *page = bh->b_page;
>  	__u8 *addr;
>  	__u32 csum32;
>  	__be32 seq;
> @@ -331,11 +328,10 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
>  		return;
>  
>  	seq = cpu_to_be32(sequence);
> -	addr = kmap_atomic(page);
> +	addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
>  	csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
> -	csum32 = jbd2_chksum(j, csum32, addr + offset_in_page(bh->b_data),
> -			     bh->b_size);
> -	kunmap_atomic(addr);
> +	csum32 = jbd2_chksum(j, csum32, addr, bh->b_size);
> +	kunmap_local(addr);
>  
>  	if (jbd2_has_feature_csum3(j))
>  		tag3->t_checksum = cpu_to_be32(csum32);
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 4d1fda1f7143..5f08b5fd105a 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -935,19 +935,15 @@ static void warn_dirty_buffer(struct buffer_head *bh)
>  /* Call t_frozen trigger and copy buffer data into jh->b_frozen_data. */
>  static void jbd2_freeze_jh_data(struct journal_head *jh)
>  {
> -	struct page *page;
> -	int offset;
>  	char *source;
>  	struct buffer_head *bh = jh2bh(jh);
>  
>  	J_EXPECT_JH(jh, buffer_uptodate(bh), "Possible IO failure.\n");
> -	page = bh->b_page;
> -	offset = offset_in_page(bh->b_data);
> -	source = kmap_atomic(page);
> +	source = kmap_local_folio(bh->b_folio, bh_offset(bh));
>  	/* Fire data frozen trigger just before we copy the data */
> -	jbd2_buffer_frozen_trigger(jh, source + offset, jh->b_triggers);
> -	memcpy(jh->b_frozen_data, source + offset, bh->b_size);
> -	kunmap_atomic(source);
> +	jbd2_buffer_frozen_trigger(jh, source, jh->b_triggers);
> +	memcpy(jh->b_frozen_data, source, bh->b_size);
> +	kunmap_local(source);
>  
>  	/*
>  	 * Now that the frozen data is saved off, we need to store any matching
>
> (I've been thinking about adding a kmap_local_bh(bh))
>
>> ext4/1k: 15 tests, 1 failures, 1709 seconds
>>   generic/455  Pass     43s
>>   generic/475  Pass     128s
>>   generic/482  Pass     183s
>>   generic/455  Pass     43s
>>   generic/475  Pass     134s
>>   generic/482  Pass     191s
>>   generic/455  Pass     41s
>>   generic/475  Pass     139s
>>   generic/482  Pass     135s
>>   generic/455  Pass     46s
>>   generic/475  Pass     132s
>>   generic/482  Pass     146s
>>   generic/455  Pass     47s
>>   generic/475  Failed   145s
>>   generic/482  Pass     156s
>> Totals: 15 tests, 0 skipped, 1 failures, 0 errors, 1709s
>> 
>> I guess the above failure (generic/475) could be due to it's flakey
>> behaviour which Ted was mentioning.
>> 
>> 
>> Now, while we are at it, I think we should also make change to reiserfs from
>> offset_in_page() to bh_offset()
>> 
>> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
>> index 015bfe4e4524..23411ec163d4 100644
>> --- a/fs/reiserfs/journal.c
>> +++ b/fs/reiserfs/journal.c
>> @@ -4217,7 +4217,7 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
>>                         page = cn->bh->b_page;
>>                         addr = kmap(page);
>>                         memcpy(tmp_bh->b_data,
>> -                              addr + offset_in_page(cn->bh->b_data),
>> +                              addr + bh_offset(cn->bh),
>>                                cn->bh->b_size);
>>                         kunmap(page);
>
> This one should probably be:
>
> -			addr = kmap(page);
> -			memcpy(tmp_bh->b_data,
> -				addr + offset_in_page(cn->bh->b_data),
> -				cn->bh->b_size);
> -			kunmap(page);
> +			memcpy_from_folio(tmp_bh->b_data, cn->bh->b_folio,
> +					bh_offset(cn->bh), cn->bh->b_size);
>
>> I will also run "auto" group with ext4/1k with all of above change. Will
>> update the results once it is done.
>
> Appreciate it!  I don't think you'll see a significant difference with
> the patches above; you've nailed the actual problems and I'm just
> using slighlty nicer APIs.

Thanks Matthew for proposing the final changes using folio.
(there were just some minor change required for fs/reiserfs/ for unused variables)
Pasting the final patch below (you as the author with my Signed-off-by &
Tested-by), which I have tested it on my system with "ext4/1k -g auto"

-------------------- Summary report
KERNEL:    kernel 6.5.0-xfstests-11705-ge1ee6db7734e #62 SMP PREEMPT_DYNAMIC Thu Sep  7 10:39:34 IST 2023 x86_64
CMDLINE:   -c ext4/1k -g auto
CPUS:      4
MEM:       7943.72

ext4/1k: 527 tests, 1 failures, 39 skipped, 9182 seconds
  Failures: ext4/059
Totals: 531 tests, 39 skipped, 5 failures, 0 errors, 9123s

You also proposed you would like to add kmap_local_bh(), hence not
sending it as a separate patch, in case if you would like to do it differently.

Thanks again for helping with the fix! 

---

From baeedb714497ae8f3809cc6e7cffa8884af43fac Mon Sep 17 00:00:00 2001
Message-Id: <baeedb714497ae8f3809cc6e7cffa8884af43fac.1694092539.git.ritesh.list@gmail.com>
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Thu, 7 Sep 2023 10:01:54 +0530
Subject: [PATCH] buffer: Fix definition of bh_offset() for struct buffer_head

Note that buffer head infrastructure is being transitioned from page based to
folio based- d685c668b069: ("buffer: add b_folio as an alias of b_page").

Now, jbd2_alloc() allocates a buffer (bh) from kmem cache when the
buffer_size is < PAGE_SIZE. (for e.g. 1k blocksize on 4k pagesize) and
then we might save this buffer info inside buffer_head, using
folio_set_bh() :-
        bh->b_folio = folio;
        if (!highmem)
          bh->b_data = folio_address(folio) + offset;

So far all good. However, while using this buffer's b_data, we use
bh_offset() or offset_in_page(), which assumes the buffer to be of
a PAGE_SIZE. This is not true anymore with b_folio as slab might use
high-order allocations.

This patch fixes the definition of bh_offset() and make use of
bh_offset() instead of offset_in_page() at places inside fs/jbd2 and
fs/reiserfs.
Also while we are at it, this patch converts these places to use folio
APIs instead.

Fixes: 8147c4c4546f ("jbd2: use a folio in jbd2_journal_write_metadata_buffer()")
Reported-by: Zorro Lang <zlang@kernel.org>
Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/jbd2/commit.c            | 16 ++++++----------
 fs/jbd2/transaction.c       | 12 ++++--------
 fs/reiserfs/journal.c       | 11 +++--------
 include/linux/buffer_head.h |  5 ++++-
 4 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 1073259902a6..8d6f934c3d95 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -298,14 +298,12 @@ static int journal_finish_inode_data_buffers(journal_t *journal,

 static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)
 {
-       struct page *page = bh->b_page;
        char *addr;
        __u32 checksum;

-       addr = kmap_atomic(page);
-       checksum = crc32_be(crc32_sum,
-               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
-       kunmap_atomic(addr);
+       addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
+       checksum = crc32_be(crc32_sum, addr, bh->b_size);
+       kunmap_local(addr);

        return checksum;
 }
@@ -322,7 +320,6 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
                                    struct buffer_head *bh, __u32 sequence)
 {
        journal_block_tag3_t *tag3 = (journal_block_tag3_t *)tag;
-       struct page *page = bh->b_page;
        __u8 *addr;
        __u32 csum32;
        __be32 seq;
@@ -331,11 +328,10 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
                return;

        seq = cpu_to_be32(sequence);
-       addr = kmap_atomic(page);
+       addr = kmap_local_folio(bh->b_folio, bh_offset(bh));
        csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
-       csum32 = jbd2_chksum(j, csum32, addr + offset_in_page(bh->b_data),
-                            bh->b_size);
-       kunmap_atomic(addr);
+       csum32 = jbd2_chksum(j, csum32, addr, bh->b_size);
+       kunmap_local(addr);

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
-       struct page *page;
-       int offset;
        char *source;
        struct buffer_head *bh = jh2bh(jh);

        J_EXPECT_JH(jh, buffer_uptodate(bh), "Possible IO failure.\n");
-       page = bh->b_page;
-       offset = offset_in_page(bh->b_data);
-       source = kmap_atomic(page);
+       source = kmap_local_folio(bh->b_folio, bh_offset(bh));
        /* Fire data frozen trigger just before we copy the data */
-       jbd2_buffer_frozen_trigger(jh, source + offset, jh->b_triggers);
-       memcpy(jh->b_frozen_data, source + offset, bh->b_size);
-       kunmap_atomic(source);
+       jbd2_buffer_frozen_trigger(jh, source, jh->b_triggers);
+       memcpy(jh->b_frozen_data, source, bh->b_size);
+       kunmap_local(source);

        /*
         * Now that the frozen data is saved off, we need to store any matching
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 015bfe4e4524..541ee1c5d2b3 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -4205,8 +4205,6 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
                /* copy all the real blocks into log area.  dirty log blocks */
                if (buffer_journaled(cn->bh)) {
                        struct buffer_head *tmp_bh;
-                       char *addr;
-                       struct page *page;
                        tmp_bh =
                            journal_getblk(sb,
                                           SB_ONDISK_JOURNAL_1st_BLOCK(sb) +
@@ -4214,12 +4212,9 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
                                             jindex) %
                                            SB_ONDISK_JOURNAL_SIZE(sb)));
                        set_buffer_uptodate(tmp_bh);
-                       page = cn->bh->b_page;
-                       addr = kmap(page);
-                       memcpy(tmp_bh->b_data,
-                              addr + offset_in_page(cn->bh->b_data),
-                              cn->bh->b_size);
-                       kunmap(page);
+                       memcpy_from_folio(tmp_bh->b_data, cn->bh->b_folio,
+                                       bh_offset(cn->bh), cn->bh->b_size);
+
                        mark_buffer_dirty(tmp_bh);
                        jindex++;
                        set_buffer_journal_dirty(cn->bh);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 4ede47649a81..b61fa79cb7f5 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -171,7 +171,10 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
        return test_bit_acquire(BH_Uptodate, &bh->b_state);
 }

-#define bh_offset(bh)          ((unsigned long)(bh)->b_data & ~PAGE_MASK)
+static inline unsigned long bh_offset(const struct buffer_head *bh)
+{
+       return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
+}

 /* If we *know* page->private refers to buffer_heads */
 #define page_buffers(page)                                     \
--
2.30.2
