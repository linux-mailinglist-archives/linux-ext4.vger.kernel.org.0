Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F80463EA1E
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 08:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLAHHD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 02:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLAHHD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 02:07:03 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD685660
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 23:07:02 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d3so782026plr.10
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 23:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUiTV4CLMohxeQaqXSR6njOLhtmUcg91g73uzEJvSLc=;
        b=DSImRl1mqMp37HIVX/T4QXN0lsm0UPQTC6F2joKrU6aRLc4Ex/ukzZxZWTFxHu6nVm
         pupEEh8RJbvUXDx6mv5Ef3u0fTMOyjbEHRgDnHip/nIN1PpIlKr6NdAULjEHTXOpsqBD
         uVteqe3949wQYKWPlPFM04fboDpryrbQd2dh2Rekmp53IzXQJraF+ntR0oc7+afg2Q+4
         /wNAyS1nCsJ7V/Vq8cSnvxWFsGnhforeSYRT2623W4xVCpoHErdWwjWzp4zB+wOVtDQ+
         c5DU0a+o8ikmAhngEqRu0t9kukKv2l76eR2FdGy1eCPu5cQIAEiUWsRvgKBZKXITuv8P
         i7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUiTV4CLMohxeQaqXSR6njOLhtmUcg91g73uzEJvSLc=;
        b=AVK1hPVAa8GVjGxLl1si3qUtr/BFkFmRArJFZSw6syynSvElmMNlmsibp0fNLPVkOr
         GMm95UXdqwwqH5SKAW83VCGmr4Mg088Xvc0eI2D/hxcsdwsQVIfN9an6strp3NFcZOta
         YcWAkuB8DreOTJCQF2FqL9KBMUU6w7vpNHRbV/YQV06cQfac5n7Tci6TRU/KrtxN09zF
         hvT7WtcEw+N0TSpIlXp/viyhXgfqAOI7+cgPg3COpkCoZ/m12zFarpnjHUe0fHezWtY0
         uQ5g8aGJALwxglyqzAc8zR1d0mrhCK0GrPgP/5Y0WoE7GbgyNS+60C7gmuC3312T5rXA
         wyrA==
X-Gm-Message-State: ANoB5pkUCY7TrT7umvTZqamvG9pGZitdk6UzLMhdysDkJyZt0BT2284d
        k4W2qpUScrSTbdYyuLowrwQ=
X-Google-Smtp-Source: AA0mqf6KtxMOw557vvsDAm9uhMZo2v6L5vXo9yP9c2RsuVWElEG/5ESG9ao3mp5mvZeYQ//ZSxgdJQ==
X-Received: by 2002:a17:90a:440f:b0:218:9894:62c1 with SMTP id s15-20020a17090a440f00b00218989462c1mr60527733pjg.205.1669878421670;
        Wed, 30 Nov 2022 23:07:01 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79570000000b00574898527c8sm2492559pfq.74.2022.11.30.23.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 23:07:01 -0800 (PST)
Date:   Thu, 1 Dec 2022 12:36:55 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/9] ext4: Drop pointless IO submission from
 ext4_bio_write_page()
Message-ID: <20221201070655.cugep2fdrtntp67y@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163608.29034-4-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/30 05:35PM, Jan Kara wrote:
> We submit outstanding IO in ext4_bio_write_page() if we find a buffer we
> are not going to write. This is however pointless because we already
> handle submission of previous IO in case we detect newly added buffer
> head is discontiguous. So just delete the pointless IO submission call.

Agreed. io_submit_add_bh() is anyway called at the end for submitting buffers.
And io_submit_add_bh() also has the logic to:
1. submit a discontiguous bio
2. Also submit a bio if the bio gets full (submit_and_retry label).

Hence calling ext4_io_submit() early is not required.

I guess the same will also hold true for at this place.
https://elixir.bootlin.com/linux/v6.1-rc7/source/fs/ext4/page-io.c#L524


But this patch looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/page-io.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 2bdfb8a046d9..beaec6d81074 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -489,8 +489,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  					redirty_page_for_writepage(wbc, page);
>  				keep_towrite = true;
>  			}
> -			if (io->io_bio)
> -				ext4_io_submit(io);
>  			continue;
>  		}
>  		if (buffer_new(bh))
> --
> 2.35.3
>
