Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297D26E3ECC
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Apr 2023 07:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjDQFQd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Apr 2023 01:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDQFQd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Apr 2023 01:16:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E9610CE
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 22:16:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f2so15793539pjs.3
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 22:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681708590; x=1684300590;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Da39940bUtCGNnrToOzigumDGUe6e9grd2Jnl74JVMA=;
        b=eGVOA9KFHAna4kgZL0QkFT35SXThSAPQr/DY2IeKZ02DFDNCwTdTVa0W4czkhkTWGM
         BXaq9pMLk+QrO4soZ9+orYhinUabeYAJo03QAwb7XFJ77SyGNnMMv8Mw3KAu2dS2FB1o
         G1IzXY7QJQRBPSNjwhX2XPnT44fA3Ft056Sh7MTnjzorew2yJHCNeOK/m8VeB94v43EB
         vLW4uCXfpKJ/7zMlXlfjyJ282zOhzuZNDYq8jSx/ybGBm8V6XsJ2pZl98BI76P8rR1tJ
         EfjdaciDlyscGwhOpcrel7DRLisHmrfzUIGlHrItE7zjJYWtN9/YdLU+15KsCZqT//ME
         5URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681708590; x=1684300590;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Da39940bUtCGNnrToOzigumDGUe6e9grd2Jnl74JVMA=;
        b=fcQhsWzcKSwUYHjqzH0kVwE0nlWsgdz+1l39YtQQm9M4m8LzrtCm9vHypf+U02E4dw
         xSgHUhDhZGtW91gRDa/OlZPAU23Jf1eHCWyJAhb+lIf+kIGHHi3RGYTke2jRi8jCD2pY
         NqxcjIgjviWww6ozO4sPj6HERUzfH+Z7xvJA9OupBZYMb9pYNBKIxOPugTieQnov1Pa/
         F2jziI+tb5/WKJshbz7SP3A2VN9P3jHu1gLvCzll2fZgzzgOo6Hz1S+i6pMazm9hePUo
         3j1tqnhwc67ECpJrU4Wqw48LPHmSTOmL5oUwzKWt4cXfZ4URAuHv45R/3NE6fDaLdVjb
         Hl7w==
X-Gm-Message-State: AAQBX9eE3rmTjE0x7z9VkPoFpjFT3EHAoZKk+hndh8wX1uFo8FraIMMp
        lSTBhD+EwD6B4/A8Sl8MQyI=
X-Google-Smtp-Source: AKy350bvNrZfXcEaShNUt1vWga1LU2RJN0FpIIziy+t0m4CpPe1g9A+G3L8GH8libuIdrGJGsO4yqQ==
X-Received: by 2002:a05:6a21:7882:b0:ee:4c57:197 with SMTP id bf2-20020a056a21788200b000ee4c570197mr14643063pzc.18.1681708590489;
        Sun, 16 Apr 2023 22:16:30 -0700 (PDT)
Received: from rh-tp ([129.41.58.20])
        by smtp.gmail.com with ESMTPSA id b7-20020a6567c7000000b005038291e5cbsm3021454pgs.35.2023.04.16.22.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 22:16:30 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:24 +0530
Message-Id: <87ttxfhyvr.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv1 3/4] ext4: Make mpage_journal_page_buffers use folio
In-Reply-To: <87zg77ici3.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Mon, Apr 17, 2023 at 12:01:52AM +0530, Ritesh Harjani (IBM) wrote:
>>> This patch converts mpage_journal_page_buffers() to use folio and also
>>> removes the PAGE_SIZE assumption.
>>
>> Bit of an oversight on my part.  I neglected to do this after Jan added
>> it.  Perils of parallel development ...
>>
>
> Yes, these got left overs because of the parallel series.
>
>>> -static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
>>> -				     int len)
>>> +static int ext4_journal_page_buffers(handle_t *handle, struct folio *folio,
>>> +				     size_t len)
>>
>> Should this be called ext4_journal_folio_buffers?
>
> Sure. Will make the change. Otherwise this patch looks good to you?
> I also had a query regarding setting "len = size - folio_pos(folio)" in this patch.
> Details of which I had pasted in the cover letter. Let me copy-paste
> it here from the cover letter. Could you please take a look at it?
>
>
> <copy-paste>
> Also had a query w.r.t your change [1]. I couldn't understand this change diff
> from [1]. Given if we are making the conversion to folio, then shouldn't we do
> len = size - folio_pos(pos), instead of len = size & ~PAGE_MASK
> Could you please tell if the current change in [1] is kept deliberately?
> At other places you did make len as size - folio_pos(pos) which removes the
> PAGE_SIZE assumption.
>
> -static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
> +static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
>  {
> -	int len;
> +	size_t len;
>
> 	<...>
>
> 	size = i_size_read(mpd->inode);
> -	if (page->index == size >> PAGE_SHIFT &&
> +	len = folio_size(folio);
> +	if (folio_pos(folio) + len > size &&
>  	    !ext4_verity_in_progress(mpd->inode))
>  		len = size & ~PAGE_MASK;
> -	else
> -		len = PAGE_SIZE;
> -	err = ext4_bio_write_page(&mpd->io_submit, page, len);
> +	err = ext4_bio_write_page(&mpd->io_submit, &folio->page, len);
>  	if (!err)
>  		mpd->wbc->nr_to_write--;
>
> [1]: https://lore.kernel.org/linux-ext4/20230324180129.1220691-7-willy@infradead.org/

Here is the complete function. Looking at it again, I think we should make
len = size - folio_pos(folio) (at linenumber 26, like how it is done at
other places in ext4-folio patches), because we now call
ext4_bio_write_folio() instead of ext4_bio_write_page().

Although I know it doesn't make a difference in the functionality today
since folio_size(folio) today in case of ext4 is still PAGE_SIZE.

Please let me know if this understanding is correct. If yes, then I can
write a patch to make len = size - folio_pos(folio) at line 26.

If not I will be happy to know more about what am I missing.

 1 static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 2 {
 3         size_t len;
 4         loff_t size;
 5         int err;
 6
 7         BUG_ON(folio->index != mpd->first_page);
 8         folio_clear_dirty_for_io(folio);
 9         /*
10          * We have to be very careful here!  Nothing protects writeback path
11          * against i_size changes and the page can be writeably mapped into
12          * page tables. So an application can be growing i_size and writing
13          * data through mmap while writeback runs. folio_clear_dirty_for_io()
14          * write-protects our page in page tables and the page cannot get
15          * written to again until we release folio lock. So only after
16          * folio_clear_dirty_for_io() we are safe to sample i_size for
17          * ext4_bio_write_folio() to zero-out tail of the written page. We rely
18          * on the barrier provided by folio_test_clear_dirty() in
19          * folio_clear_dirty_for_io() to make sure i_size is really sampled only
20          * after page tables are updated.
21          */
22         size = i_size_read(mpd->inode);
23         len = folio_size(folio);
24         if (folio_pos(folio) + len > size &&
25             !ext4_verity_in_progress(mpd->inode))
26                 len = size & ~PAGE_MASK;
27         err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
28         if (!err)
29                 mpd->wbc->nr_to_write--;
30
31         return err;
32 }

Thanks a lot!!
-ritesh
