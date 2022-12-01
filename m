Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8151263EBAA
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 09:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiLAI5Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 03:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLAI5X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 03:57:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA0447306
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 00:57:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id h28so1243801pfq.9
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 00:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqAsJq68lp1suq1MPr1/B5R8HSnB6TQZgPxuiYKSwXA=;
        b=ZI9zQ9GdKraZVsCBDuoXC2xOZ1FJOzNTpTROJubRjAE+L1RfTCa5P37DM/SNgRYYng
         Ikqvtz9BULh6cw0af4XzcyZ0j5m17eqzK9sa7zEygE07yehGs+NTrx60RYdbtMa2qx/l
         qeYIk7JTwp1YFUnX/PKws28FVVw87NXrS9QvVKpH+/XqYI885G8UKC6ZCzHMwHLXKonC
         H1CqRg7rx8j7QAkuzb2gqNcYrsPt8bRIUilcoHU9PUWjH+KdoqcjLdq9upCfOE30XIQa
         k56N5cpHXbMRQAbmV1CjRxl22Ttek1w6qjZmueXssmk5zrPYEBw3u2QnPDmB0hDTRfWS
         VmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqAsJq68lp1suq1MPr1/B5R8HSnB6TQZgPxuiYKSwXA=;
        b=EfVuueQR7GVWhDm8VA1uAw7qvgK+xKR/SpvywRKQnK3qPu1j9eWDPTwV+tOu5+yZNP
         EM18ehmx613EfN19oLz+mjal1lv+ujeEaLf/Uc70ZlGZUjO1sHOOVqAHiK6uFgr0/Au5
         trkrh2kDiHDk/mrBDFsr3zyd2lPMwpd6RrgwrZ2OdR8vSDtpUxpq4XSxFmT/q9t5Fuhy
         flDL3VvL/eicCKGkfofbT5Pu0IRm20ApxnjPQ0xi+8qzulZOlLogE0Y4RZfcpuVwtlMP
         mxNuedHOUBbwuevus5uliUTdYCYOE7PhIN3PStL8r53cAiwmqP6QcXqYcqeZ5lMdrfa/
         gFXA==
X-Gm-Message-State: ANoB5pkuuKmJI6z02T97rz7zLIOSwaCj6gLvqmFXSVGvcYPLJAvr5ekq
        bNO2G46UhlU4+JiOKTchT+8=
X-Google-Smtp-Source: AA0mqf6E5VkUSjKb0WVliLk6o300CL+JmrKUfFHj4Rsm6xZ6iSUtnEihX7hbi5c1B4Gz+7dlgphaOw==
X-Received: by 2002:a05:6a00:4009:b0:563:2ada:30a3 with SMTP id by9-20020a056a00400900b005632ada30a3mr47609009pfb.27.1669885042188;
        Thu, 01 Dec 2022 00:57:22 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id 13-20020a62180d000000b00573769811d6sm466162pfy.44.2022.12.01.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 00:57:21 -0800 (PST)
Date:   Thu, 1 Dec 2022 14:27:16 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/9] ext4: Handle redirtying in ext4_bio_write_page()
Message-ID: <20221201085716.g5avthxgxjzorcmq@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163608.29034-1-jack@suse.cz>
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
> Since we want to transition transaction commits to use ext4_writepages()
> for writing back ordered, add handling of page redirtying into
> ext4_bio_write_page(). Also move buffer dirty bit clearing into the same
> place other buffer state handling.
>

So when we will move away from ext4_writepage() and will instead call
ext4_writepages() (for transaction commits requiring ordered write handling),
this patch should help with redirtying the page, if any of the page buffer
cannot be written back which is when either the buffer is either marked delayed
(which will require block allocation) or is unwritten (which may also
require some block allocation during unwritten to written conversion).

Also, one other good thing about this patch is, we don't have to loop over all
the buffers seperately to identify whether a page needs to be set redirty or not.
With this change we will redirty the page in the same loop (if required)
and identify all the mapped buffers for writeback.


Moving the clearing of buffer dirty state also looks right to me.

Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/page-io.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 97fa7b4c645f..4e68ace86f11 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -482,6 +482,13 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  			/* A hole? We can safely clear the dirty bit */
>  			if (!buffer_mapped(bh))
>  				clear_buffer_dirty(bh);
> +			/*
> +			 * Keeping dirty some buffer we cannot write? Make
> +			 * sure to redirty the page. This happens e.g. when
> +			 * doing writeout for transaction commit.
> +			 */
> +			if (buffer_dirty(bh) && !PageDirty(page))
> +				redirty_page_for_writepage(wbc, page);
>  			if (io->io_bio)
>  				ext4_io_submit(io);
>  			continue;
> @@ -489,6 +496,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  		if (buffer_new(bh))
>  			clear_buffer_new(bh);
>  		set_buffer_async_write(bh);
> +		clear_buffer_dirty(bh);
>  		nr_to_submit++;
>  	} while ((bh = bh->b_this_page) != head);
>
> @@ -532,7 +540,10 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  			printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
>  			redirty_page_for_writepage(wbc, page);
>  			do {
> -				clear_buffer_async_write(bh);
> +				if (buffer_async_write(bh)) {
> +					clear_buffer_async_write(bh);
> +					set_buffer_dirty(bh);
> +				}
>  				bh = bh->b_this_page;
>  			} while (bh != head);
>  			goto unlock;
> @@ -546,7 +557,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  		io_submit_add_bh(io, inode,
>  				 bounce_page ? bounce_page : page, bh);
>  		nr_submitted++;
> -		clear_buffer_dirty(bh);
>  	} while ((bh = bh->b_this_page) != head);
>
>  unlock:
> --
> 2.35.3
>
