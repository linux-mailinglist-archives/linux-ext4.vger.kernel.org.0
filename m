Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E6D647358
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 16:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLHPky (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 10:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHPkx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 10:40:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B878E31A
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 07:40:52 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jn7so1828330plb.13
        for <linux-ext4@vger.kernel.org>; Thu, 08 Dec 2022 07:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9iD4xYQAdoFdD9qNfxjrMKJ2Vz68c2+WegvHBp3CPck=;
        b=d/GKGtnEI9B2lu1+HTQ7Zrl6ygYz3+PVKG7lwrA8CFTN9eGYVdr2JUblQmPZIOOMD7
         16ITEyPnDyc61AeEkKe9OUA5MkDkG59Lz/tezT9nioAI7i+6wKQT/4p3KoYWZGf3OXvW
         JFTE4BNJhI0Q1QePmE0WRAcl8K3wFmnphJmX8WHPMu8MjSgpQJn9DCMQpHGxaI3POx/d
         2IXKSHlWXoKGdnsf+fNrBY/BRiTKAQyysSQOSM4CmUiKr56Icfze6Y3Xa47Y4jyYWRV0
         EHpuo+RvES6rPt6kGi1lWC7hLbdZJnZfmeSCQTQ9BXAngL4Lo3QBWGvQAVrMcm5r2YWb
         cTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iD4xYQAdoFdD9qNfxjrMKJ2Vz68c2+WegvHBp3CPck=;
        b=Q3kIm076DRuSOddW/tDJmHtzEY7gIEbTV6A+qft3wfGldoL85l5OUi+h0GIWFOjTXz
         q+JWMs1RvuWhFGM2zCsC5czCvcG9xKq75Kyn9rrIrssskaqf3a9IzwcgqZ/f57Aek+Mj
         CUrrit9Ehpf8ewiujTmTrvhX0Pndo9abunqWfVc3JJT/LAdmoSazX9MiMqHIa3s/IVuS
         AKgbBykBctEGvmG0lAQFzxEVhdUHU/QmoWGtVu9ahfYwQoLqc5C6KV98x5Iz6Hy2h0Fc
         es8IIp7+oJvWVtpPgV/ixbAmCIrOrx8K+Y8eaTB9jj9Ou8SiBAXbfO+5h0zGzqfyCSXX
         7UJg==
X-Gm-Message-State: ANoB5pnPvkTzgKWLePrE1UBsBFQzHgM86VNledd2zEus3154zWI4b51H
        igCqfkz0kR34ORm5iNFX90ETYzr1T+k=
X-Google-Smtp-Source: AA0mqf5qI1TIpkJH7faYGpn6OzDYgmhrtM1WTi03yjFZT4BTX2jhcMGfm7K3pcyvZ7NeJUjfVdzOUg==
X-Received: by 2002:a17:902:b611:b0:188:f570:7bdf with SMTP id b17-20020a170902b61100b00188f5707bdfmr2168970pls.40.1670514052228;
        Thu, 08 Dec 2022 07:40:52 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902c40f00b001869ba04c83sm262346plk.245.2022.12.08.07.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 07:40:51 -0800 (PST)
Date:   Thu, 8 Dec 2022 21:10:46 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 10/13] ext4: Switch to using write_cache_pages() for
 data=journal writeout
Message-ID: <20221208154046.s6aub2mhqfzewhuk@riteshh-domain>
References: <20221207112259.8143-1-jack@suse.cz>
 <20221207112722.22220-10-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207112722.22220-10-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/12/07 12:27PM, Jan Kara wrote:
> Instead of using generic_writepages(), let's use write_cache_pages() for
> writeout of journalled data. It will allow us to stop providing
> .writepage callback.

Ok. Just one quick query. I didn't look too deep for this and thought will
directly check it here.
What about marking an error via mapping_set_error() which earlier the
__writepage() call was handling in case of any error during writeback?

> Our data=journal writeback path would benefit from
> a larger cleanup and refactoring but that's for a separate cleanup
> series.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b93a436bf5bc..f3b3792c1c96 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2705,6 +2705,12 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  	return err;
>  }
>
> +static int ext4_writepage_cb(struct page *page, struct writeback_control *wbc,
> +			     void *data)
> +{
> +	return ext4_writepage(page, wbc);
> +}
> +
>  static int ext4_do_writepages(struct mpage_da_data *mpd)
>  {
>  	struct writeback_control *wbc = mpd->wbc;
> @@ -2731,7 +2737,9 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  		goto out_writepages;
>
>  	if (ext4_should_journal_data(inode)) {
> -		ret = generic_writepages(mapping, wbc);
> +		blk_start_plug(&plug);
> +		ret = write_cache_pages(mapping, wbc, ext4_writepage_cb, NULL);
> +		blk_finish_plug(&plug);
>  		goto out_writepages;
>  	}
>
> --
> 2.35.3
>
