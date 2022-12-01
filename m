Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7861763EC18
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 10:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLAJOt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 04:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLAJOs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 04:14:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C12F442C7
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 01:14:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jn7so1037418plb.13
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 01:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z6TE9+7W41Ph7B8f2F+kU4inirkaFlVRh6KxIJemXM=;
        b=p17SM1EMWXABkvkwOwhuLewa6tTcopdkkTlPjssxX8XrGfrPq5AFdOIrp1iBUclRkk
         QZoVRfKqxZvz5gFm1vgoSfXAFYR8saXCuKiC4m85H1wzhv00tzVpPuNF0e/zLDlaoMLT
         GV1ek06zqqAujH0VqIPvKgF7HHL1lc99smFyM23EFVpYOlPqzylDG29URHKz1xL93OG9
         i92Cwl6rJVhQmJZaZakOD/7vluxSyvvDY1syN84pWwsA/vN0/87z9+R3xDVDO0ctQ4+Z
         cSddCu3w0Np2KOaMkiKrZJ+ZCVi3BBIjQFJbJbNELbzhqldlXG1hy17MXYFpXi2NObwg
         HLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z6TE9+7W41Ph7B8f2F+kU4inirkaFlVRh6KxIJemXM=;
        b=3u+doIsPohCW+tk2oyzouIXxePQo0ON4X80a81xYBtFg2YbGFB4jI+TfHiPUkdVw8T
         tithc3LDbx/MLal1z3g/oe2yt0B/YlmqIu0QkWCcyPxicmfVLNgpxEHDPIB3q+iF4/Wp
         4FJG5/PCjab5CjPs8HW9SbnUX3Af793izY5C0CeQYdy2y75Dkzng5Yod2RnLk5JG9aum
         RdawXbicETpE5S96xeghkDd2RG4qc26JKo1o32ItpvC56tX+6MFDhRWBJtPEW83ujc0E
         cOdL/rEqG/Cncj6ujt6aqy9YC5LT7qmJvcGW00Dh9dFBAL4lubnQn997VqIp29nBjgZR
         BFTg==
X-Gm-Message-State: ANoB5plQS78H+dWEkY/hQgQU2YTFL8Bh2YllvVfJsBtx3TReact1TyKo
        uvJznQge5FPN6cQ8zf3rkVc=
X-Google-Smtp-Source: AA0mqf6mwYvhf/kQsfvdPLfD3U7TXX6lIBBnfV6dSmvR/JQVt8rydnUCpC1ml1QhixP1kgAu4p+xow==
X-Received: by 2002:a17:902:8604:b0:186:fe2d:f3cb with SMTP id f4-20020a170902860400b00186fe2df3cbmr50220665plo.132.1669886087101;
        Thu, 01 Dec 2022 01:14:47 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id 137-20020a62198f000000b0056b9ec7e2desm2731060pfz.125.2022.12.01.01.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:14:46 -0800 (PST)
Date:   Thu, 1 Dec 2022 14:44:42 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/9] ext4: Remove nr_submitted from ext4_bio_write_page()
Message-ID: <20221201091442.flpoeo7s4yknmtwy@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163608.29034-3-jack@suse.cz>
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
> nr_submitted is the same as nr_to_submit. Drop one of them.

Yup. Since we are not calling end_page_writeback() anymore.
So we don't require nr_submitted too.

Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/page-io.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 4f9ecacd10aa..2bdfb8a046d9 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -437,7 +437,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  	unsigned block_start;
>  	struct buffer_head *bh, *head;
>  	int ret = 0;
> -	int nr_submitted = 0;
>  	int nr_to_submit = 0;
>  	struct writeback_control *wbc = io->io_wbc;
>  	bool keep_towrite = false;
> @@ -566,7 +565,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  			continue;
>  		io_submit_add_bh(io, inode,
>  				 bounce_page ? bounce_page : page, bh);
> -		nr_submitted++;
>  	} while ((bh = bh->b_this_page) != head);
>  unlock:
>  	unlock_page(page);
> --
> 2.35.3
>
