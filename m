Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FDB24C80C
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHTWzX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 18:55:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34903 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTWzU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Aug 2020 18:55:20 -0400
Received: from mail-vk1-f198.google.com ([209.85.221.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1k8tSn-0002cX-RP
        for linux-ext4@vger.kernel.org; Thu, 20 Aug 2020 22:55:17 +0000
Received: by mail-vk1-f198.google.com with SMTP id o26so954110vkn.21
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 15:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zI/K6WF/hyi29f3bR/5neadnZsBA08HlwY9LFG1FwfM=;
        b=Y8MFPaLxRDtP58wTsqy1VFFBDXpGooOWPZX1NrOCYsNIpeOOybEVbm8Iz8L3FsVdt7
         HaiWzK+06BDOedwe/SD4+RJ8WIOO9Du/ZhnwWWHIJkVHGSqXAwTK2hIuRNQhDGwh99ui
         jVlfKmi7jwGS2oZkPHKMi107VrpMgxHFrvRP2fhkdbzk997R5x6HfK6MTFnkGfSMmjgU
         +/IWeRMhXDoT3dxl8AhKsZ3A3Q34xuX1GRuNdhFfhRLPtHRe8Mwt/ow9lUlnMLnDJI1l
         7WBVNQLq3m5MpGUn+S3maDY0q1Qi83QA2oRTbHRnD43ry+RUHTlK1hWqzFOxWfrmZs7v
         2rPg==
X-Gm-Message-State: AOAM531UTIKciKbsbjbN8xDrfQu2v6g7oKyTPYWygqY678XCT46Db1bA
        9WwrIBDeDs8E6usTwBhB1FwxD4LT37Wq3ukXfcZmr7ukmEDEQY+ezafYvlkIwHhzQ8usiUw5RCA
        h+GfCKn2CBgq2ffeY39nZksV1SCuAdUjEGLxFV+ZXV1f1h+T0eK9c1bw=
X-Received: by 2002:ab0:41:: with SMTP id 59mr58270uai.40.1597964116887;
        Thu, 20 Aug 2020 15:55:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyP/e1xJO/bLOjh8vTN4QRwGIyT4il7uwVMusdRvfv9H+CY1l//tYVKKLep0O4i876S91R2M7mdr9joGzQX9s=
X-Received: by 2002:ab0:41:: with SMTP id 59mr58256uai.40.1597964116535; Thu,
 20 Aug 2020 15:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200810010210.3305322-1-mfo@canonical.com> <20200810010210.3305322-4-mfo@canonical.com>
 <20200819084421.GD1902@quack2.suse.cz> <20200819104139.GJ1902@quack2.suse.cz>
In-Reply-To: <20200819104139.GJ1902@quack2.suse.cz>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Thu, 20 Aug 2020 19:55:05 -0300
Message-ID: <CAO9xwp2UBLyD5f3wzwBHQHA9NvxuasR3c+KCBsFLWR_NitLOxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] ext4: data=journal: write-protect pages on
 submit inode data buffers callback
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Thanks a bunch for the detailed comments, including in the cover letter.
Your attention and patience for explanations are really appreciated.

I _think_ I got most of it for the next iteration -- a few follow up questions:

On Wed, Aug 19, 2020 at 7:41 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 19-08-20 10:44:21, Jan Kara wrote:
> > I was thinking about this and we may need to do this somewhat differently.
> > I've realized that there's the slight trouble that we now use page dirty
> > bit for two purposes in data=journal mode - to track pages that need write
> > protection during commit and also to track pages which have buffers that
> > need checkpointing. And this mixing is making things complex. So I was
> > thinking that we could simply leave PageDirty bit for checkpointing
> > purposes and always make sure buffers are appropriately attached to a
> > transaction as dirty in ext4_page_mkwrite(). [snip]
> > [snip] Furthermore I
> > don't think that the tricks with PageChecked logic we play in data=journal
> > mode are really needed as well which should bring further simplifications.
> > I'll try to code this cleanup.
>
> I was looking more into this but it isn't as simple as I thought because
> get_user_pages() users can still modify data and call set_page_dirty() when
> the page is no longer writeably mapped. And by the time set_page_dirty() is
> called page buffers are not necessarily part of any transaction so we need
> to do effectively what's in ext4_journalled_writepage(). To handle this
> corner case I didn't find anything considerably simpler than the current
> code.
>
> So let's stay with what we have in
> ext4_journalled_submit_inode_data_buffers(), we just have to also redirty
> the page if we find any dirty buffers.
>

Could you please clarify/comment whether the dirty buffers "flags" are
different between
the suggestions for ext4_page_mkwrite() and
ext4_journalled_submit_inode_data_buffers() ?

I'm asking because..

In ext4_page_mkwrite() the suggestion is to attach buffers as dirty to
a transaction, which I guess can be done with
ext4_walk_page_buffers(..., write_end_fn) after
ext4_walk_page_buffers(..., do_journal_get_write_access) -- just as
done in ext4_journalled_writepage() -- and that sets the buffer as
*jbd* dirty (BH_JBDDirty.)

In ext4_journalled_submit_inode_data_buffers() the suggestion is to
check for dirty buffers to redirty the page
(for the case of buffers that need checkpointing) and I think this is
the non-jbd/just dirty (BH_Dirty.)

If I actually understood your explanation/suggest, the dirty buffer
flags should be different,
as otherwise we'd be unconditionally setting buffers dirty on
ext4_page_mkwrite() to later
check for (known to be) dirty buffers in
ext4_journalled_submit_inode_data_buffers().

...

And as you mentioned no cleanup / keeping ext4_journalled_writepage()
and the PageChecked bit,
I would like to revisit two questions from the cover letter that would
have no impact with the cleanup,
so to confirm my understanding for the next steps.

    > 3) When checking to redirty the page in the writepage callback,
    >    does a buffer without a journal head means we should redirty
    >    the page? (for the reason it's not part of the committing txn)

Per your explanation about the page dirty bit for buffers that need
checkpointing, I see we cannot redirty
the page just because a buffer isn't part of the transaction -- the
buffer has to be dirty -- so I think it falls
down to your suggestion of 'also redirty if we find any dirty buffers'
(regardless of a buffer w/out txns.) right?

    > 4) Should we clear the PageChecked bit?
    ...
    > Should we try to prevent that [ext4_journalled_writepage()
running later] by, say, clearing the pagechecked bit
    > in case we don't have to redirty the page (in the writepage callback) ?

And I think the answer is no, per your explanation about page dirty
being set elsewhere outside of our control,
and thus ext4_journalled_page() still needs to run, and thus the  page
checked bit still needs to remain set; correct?

Thanks again,




>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



--
Mauricio Faria de Oliveira
