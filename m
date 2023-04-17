Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE12D6E3CED
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Apr 2023 02:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDQAWf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 20:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDQAWe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 20:22:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555AE1FEE
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 17:22:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mq14-20020a17090b380e00b002472a2d9d6aso9822422pjb.5
        for <linux-ext4@vger.kernel.org>; Sun, 16 Apr 2023 17:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681690953; x=1684282953;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kzUb+dnKFXQbMCTRcQralYuGqBAI/mILIuDWpFRIY4E=;
        b=jfeWLmtXnhzyK0kdEUh0Ks0VNyBsqP2K1CnZ6oMdqreVIVK9gTMXwO8uruTUlw/h09
         nIyyBy/G4+MxWMteBMORd6iJJbNfIzxlQdXrVlSLljcRlR5MtKLidfUJ2zx2WBsANJ8w
         qEVIu+sKsHHcnUevoSbM25b1gW+8elN1MozUheNI6HIcpeKmB0y+bggP9/5zqONKMMjW
         IUQFZX66sZqgSl4uhvlzPUY/EpJ2+zcaljQt0l+M2mQrBiAbZXgNlkWNm2hdva7epv5g
         2yiw+47Uh4IGagX1Z4V0c0EcyJ+9uARQvBGFzJFxRGfYO9vqI/CrgMl2RXr18RyL3Ff4
         WjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681690953; x=1684282953;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzUb+dnKFXQbMCTRcQralYuGqBAI/mILIuDWpFRIY4E=;
        b=llWJyf0NNrnjIX9Jr18k5REv4QGxj8I02dd1PpJOHYSyCpZgl/r2A98J6Hj+J+0wdi
         HQu69NvPKZ2Fp+CylaBeTZ9AabhEs6UWEIrEeAXlnpsCWOf5e9SQfcZ2x/hlobBUdhyq
         wum1tF9Mwdy84GfFl1vF6OEKlwHDTuquMz/cnpV5XvtwNSRa9GQi5TB8y7/pUNtrroqB
         EehraDPp+jkXoJARRYtzOvlxeIRHyZYOWPFecwQtjlxzx0soFU9j9Duw5B6uKOP3gc5h
         BO/GkGzgDCaRPTsAANhOgSVDtHC6VD69wDR9BEgnHwSeLeEdY9tZsszCjQRy9fYuLCUh
         4iXw==
X-Gm-Message-State: AAQBX9c3PupOPg8stSUcurX6vP5vOktXt/yO4bTCOpZvtL6dNfl+mryl
        S0f/ImXCkyexdsMVORFgZc4=
X-Google-Smtp-Source: AKy350aq94l84SugGgNyBRZu45Mj547lIdXGhcftEuxIV7SlcoavBaRCDikH5Msg/mPZ6oe4WQH3xg==
X-Received: by 2002:a17:903:1211:b0:1a2:23f7:20f with SMTP id l17-20020a170903121100b001a223f7020fmr12517390plh.28.1681690952673;
        Sun, 16 Apr 2023 17:22:32 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b001a1faeac240sm6323528plq.186.2023.04.16.17.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 17:22:32 -0700 (PDT)
Date:   Mon, 17 Apr 2023 05:52:12 +0530
Message-Id: <87zg77ici3.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv1 3/4] ext4: Make mpage_journal_page_buffers use folio
In-Reply-To: <ZDxQghSIxhX+YUME@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Apr 17, 2023 at 12:01:52AM +0530, Ritesh Harjani (IBM) wrote:
>> This patch converts mpage_journal_page_buffers() to use folio and also
>> removes the PAGE_SIZE assumption.
>
> Bit of an oversight on my part.  I neglected to do this after Jan added
> it.  Perils of parallel development ...
>

Yes, these got left overs because of the parallel series.

>> -static int ext4_journal_page_buffers(handle_t *handle, struct page *page,
>> -				     int len)
>> +static int ext4_journal_page_buffers(handle_t *handle, struct folio *folio,
>> +				     size_t len)
>
> Should this be called ext4_journal_folio_buffers?

Sure. Will make the change. Otherwise this patch looks good to you?
I also had a query regarding setting "len = size - folio_pos(folio)" in this patch.
Details of which I had pasted in the cover letter. Let me copy-paste
it here from the cover letter. Could you please take a look at it?


<copy-paste>
Also had a query w.r.t your change [1]. I couldn't understand this change diff
from [1]. Given if we are making the conversion to folio, then shouldn't we do
len = size - folio_pos(pos), instead of len = size & ~PAGE_MASK
Could you please tell if the current change in [1] is kept deliberately?
At other places you did make len as size - folio_pos(pos) which removes the
PAGE_SIZE assumption.

-static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
+static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 {
-	int len;
+	size_t len;

	<...>

	size = i_size_read(mpd->inode);
-	if (page->index == size >> PAGE_SHIFT &&
+	len = folio_size(folio);
+	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(mpd->inode))
 		len = size & ~PAGE_MASK;
-	else
-		len = PAGE_SIZE;
-	err = ext4_bio_write_page(&mpd->io_submit, page, len);
+	err = ext4_bio_write_page(&mpd->io_submit, &folio->page, len);
 	if (!err)
 		mpd->wbc->nr_to_write--;

[1]: https://lore.kernel.org/linux-ext4/20230324180129.1220691-7-willy@infradead.org/


Thanks for the quick review!

-ritesh
