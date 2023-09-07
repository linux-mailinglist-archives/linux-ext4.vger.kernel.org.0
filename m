Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09416796F1D
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Sep 2023 04:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjIGC4p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Sep 2023 22:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjIGC4p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Sep 2023 22:56:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BBCF2;
        Wed,  6 Sep 2023 19:56:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf078d5f33so4348575ad.3;
        Wed, 06 Sep 2023 19:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694055400; x=1694660200; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vECF2v0aoKNOXBJ7Lx7exLL11HKeotVPrQhskxEeZcQ=;
        b=ngtqaZx4hKJtw6v62r/AR+diOHxuWSMI4bYALeLfw72Y/6ZnjB1MfI5zzrqCyPao/1
         4B8FEHWcrcl/iXXk4h+t/dbj/T3KGLcEVmEbDjGUJzhXOQg6qJshnfCL2FWRCL0JeBbf
         QDz9xiHcThCImT2W9KH8gUOxf9Qls+HLx6Is5axcSQbDpHF8EhND0Wmh3RkkgsAfB3Ds
         dvVrfwliJgATcTqQS/8X3QGDmk0WG6xY57CfiY82ajuhL6MvieFqwk5b5GSVM8Eas4LE
         iLT6SKkgdPSYzdXWytE3qvLbWxLdfgf2myArLlWHvlvPMENtXRhSGAaM2Zn5tIEg81H+
         MUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694055400; x=1694660200;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vECF2v0aoKNOXBJ7Lx7exLL11HKeotVPrQhskxEeZcQ=;
        b=XOJR+twxU897tSVqvqolKMLmiUJfHpDpOOOt82469o061WIQQrpZ5EvEt0gfkPUw3v
         q0a/BVo+nYZ7VELVL4/jXt8+Jn/4b/F4EHUgUbzWT6QD6mwRKYjQKF8khN3ZUswmMLQt
         epgfhvD5OYLjztttaNIUALe26pAVnxcrpeEvkU/CKl91AnHe8ztccXPICUSk+6fBfbwb
         6zgikonx8lqej/lkZ4fNm4HLU3gR4hTF7tRVpHk5v2vp5K7Y8qQv/wg4n+X9/sgGh4GF
         jOpqQoSzx+U9b4AoHNCNAx+XoS1CO0iOcE6L445WR9AQx/g/tanTorWhiJDS4uMlTF4J
         /+VA==
X-Gm-Message-State: AOJu0Yxyg/Ex2ZIma2As6T7ISdfKdgFqFY+8FxFKqUvmu7/dz2eoR2Kx
        1ZFniVLTMLo/xffDDVP20SNnT4vbfLc=
X-Google-Smtp-Source: AGHT+IFX7EOOvW+giJUHxkZTFk2jOHD8kl0zg/4Lv/0P7DLtO3XVZLpQV5WpAwt65q10pxaCElwr/Q==
X-Received: by 2002:a17:903:1206:b0:1bc:2d43:c741 with SMTP id l6-20020a170903120600b001bc2d43c741mr20702410plh.66.1694055400295;
        Wed, 06 Sep 2023 19:56:40 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001b8a7e1b116sm11906309plb.191.2023.09.06.19.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 19:56:39 -0700 (PDT)
Date:   Thu, 07 Sep 2023 08:26:35 +0530
Message-Id: <87tts63d3w.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@kernel.org>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery test fails
In-Reply-To: <ZPjYTDB6x83BIJMc@casper.infradead.org>
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

> On Wed, Sep 06, 2023 at 01:38:23PM +0100, Matthew Wilcox wrote:
>> > Is this code path a possibility, which can cause above logs?
>> > 
>> >    ptr = jbd2_alloc() -> kmem_cache_alloc()
>> >    <..>
>> >    new_folio = virt_to_folio(ptr)
>> >    new_offset = offset_in_folio(new_folio, ptr)
>> > 
>> > And then I am still not sure what the problem really is? 
>> > Is it because at the time of checkpointing, the path is still not fully
>> > converted to folio?
>> 
>> Oh yikes!  I didn't know that the allocation might come from kmalloc!
>> Yes, slab might use high-order allocations.  I'll have to look through
>> this and figure out what the problem might be.
>
> I think the probable cause is bh_offset().  Before these patches, if
> we allocated a buffer at offset 9kB into an order-2 slab, we'd fill in
> b_page with the third page of the slab and calculate bh_offset as 1kB.
> With these patches, we set b_page to the first page of the slab, and
> bh_offset still comes back as 1kB so we read from / write to entirely
> the wrong place.
>
> With this redefinition of bh_offset(), we calculate the offset relative
> to the base page if it's a tail page, and relative to the folio if it's
> a folio.  Works out nicely ;-)

Thanks Matthew for explaining the problem clearly.


>
> I have three other things I'm trying to debug right now, so this isn't
> tested, but if you have time you might want to give it a run.

sure, I gave it a try.

>
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 6cb3e9af78c9..dc8fcdc40e95 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -173,7 +173,10 @@ static __always_inline int buffer_uptodate(const struct buffer_head *bh)
>  	return test_bit_acquire(BH_Uptodate, &bh->b_state);
>  }
>  
> -#define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
> +static inline unsigned long bh_offset(struct buffer_head *bh)
> +{
> +	return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
> +}
>  
>  /* If we *know* page->private refers to buffer_heads */
>  #define page_buffers(page)					\


I used "const" for bh to avoid warnings from fs/nilfs/alloc.c

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


But this change alone was still giving me failures. On looking into
usage of b_data, I found we use offset_in_page() instead of bh_offset()
in jbd2. So I added below changes in fs/jbd2 to replace offset_in_page()
to bh_offset()...

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 1073259902a6..0c25640714ac 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -304,7 +304,7 @@ static __u32 jbd2_checksum_data(__u32 crc32_sum, struct buffer_head *bh)

        addr = kmap_atomic(page);
        checksum = crc32_be(crc32_sum,
-               (void *)(addr + offset_in_page(bh->b_data)), bh->b_size);
+               (void *)(addr + bh_offset(bh)), bh->b_size);
        kunmap_atomic(addr);

        return checksum;
@@ -333,7 +333,7 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
        seq = cpu_to_be32(sequence);
        addr = kmap_atomic(page);
        csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
-       csum32 = jbd2_chksum(j, csum32, addr + offset_in_page(bh->b_data),
+       csum32 = jbd2_chksum(j, csum32, addr + bh_offset(bh),
                             bh->b_size);
        kunmap_atomic(addr);

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 4d1fda1f7143..2ac57f7a242d 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -942,7 +942,7 @@ static void jbd2_freeze_jh_data(struct journal_head *jh)

        J_EXPECT_JH(jh, buffer_uptodate(bh), "Possible IO failure.\n");
        page = bh->b_page;
-       offset = offset_in_page(bh->b_data);
+       offset = bh_offset(bh);
        source = kmap_atomic(page);
        /* Fire data frozen trigger just before we copy the data */
        jbd2_buffer_frozen_trigger(jh, source + offset, jh->b_triggers);


With all of above diffs, here are the results.

ext4/1k: 15 tests, 1 failures, 1709 seconds
  generic/455  Pass     43s
  generic/475  Pass     128s
  generic/482  Pass     183s
  generic/455  Pass     43s
  generic/475  Pass     134s
  generic/482  Pass     191s
  generic/455  Pass     41s
  generic/475  Pass     139s
  generic/482  Pass     135s
  generic/455  Pass     46s
  generic/475  Pass     132s
  generic/482  Pass     146s
  generic/455  Pass     47s
  generic/475  Failed   145s
  generic/482  Pass     156s
Totals: 15 tests, 0 skipped, 1 failures, 0 errors, 1709s

I guess the above failure (generic/475) could be due to it's flakey
behaviour which Ted was mentioning.


Now, while we are at it, I think we should also make change to reiserfs from
offset_in_page() to bh_offset()

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 015bfe4e4524..23411ec163d4 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -4217,7 +4217,7 @@ static int do_journal_end(struct reiserfs_transaction_handle *th, int flags)
                        page = cn->bh->b_page;
                        addr = kmap(page);
                        memcpy(tmp_bh->b_data,
-                              addr + offset_in_page(cn->bh->b_data),
+                              addr + bh_offset(cn->bh),
                               cn->bh->b_size);
                        kunmap(page);
                        mark_buffer_dirty(tmp_bh);


I will also run "auto" group with ext4/1k with all of above change. Will
update the results once it is done.


-ritesh
