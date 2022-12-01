Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED9263EC10
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 10:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLAJNY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 04:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiLAJNX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 04:13:23 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB0314
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 01:13:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so4606447pjs.4
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 01:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVG4GIsUk00p4Bj3slpV4vZQXi6ZX2Y8IrkrlWOmQK0=;
        b=nePs/HjEQ8e6139x7Lq4/FDNSPOU0tUBjh0bZtLDaNeXFyzn2+JPY8fY6u0GqzgnBZ
         QZaMVBx/rlSKxo1OVPWiRnwN2ld6yg6RY1bkGj4mYZ4NI8QzzuMQAzOTnqdxndjyICFj
         +RUv4fLzWkN1rt5nZKWJ9uJUvfbW3t0aq7V5cBFrDQUvzrCDaQUMmnAcPXEtdrBShFsH
         te9ucw/wZsetis/pIZpaj4kTYOWcsMSbhaZr32ZZxoMeCBUIZCX0t+w/vi/nFZs7bTm/
         mtKkgvz0FTtfmZL3pEc2Qn/T4A9KxG7vG1a0ktc4QJoYJurFjcqc64QFc7TxWdgUcLRs
         4ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVG4GIsUk00p4Bj3slpV4vZQXi6ZX2Y8IrkrlWOmQK0=;
        b=Tc7e2Ufx1LTFHNWLc5Z/H3Fpdw2TmUbPWMVTMfogXAUT6Oz3l4xESdMnayPsxoldsC
         Xmk3LWTzQ+oPJPHQASdKly10oCfTDtyjmb0X8Q5Luh5Xfif2AB2TG2TxewqIZIHEnEsC
         J+drIK/teooSe/aq7suHnLfDYBh2aXo5nSakLxAWaNXpwsHLqGFFWE6jEhSfybbzpAk9
         s4MWnMwRYNf+zdHhaz7ghSAKKd07rKzOoNoUhn3lbZqgTGhldWpwZjj3XGxznmC8SWLA
         NadGqirX1Ok6zSg5hfdqXC0V/DV/a4lpMgmDltjrWvlFxsFIhQ5Gjyc+IFWWpR/N1Pvp
         HNbQ==
X-Gm-Message-State: ANoB5pn6bmb4ENIS/iLGvrJxOvp+EWGa+buVloYdw/QU+hkutZTjfXvr
        q9ueSN7XdnmZjfb9gcn+QI0=
X-Google-Smtp-Source: AA0mqf4Tek+CSPgCjlro3+IBBkMJ17Ic3hV+h1m6ywL/rl7jgbsUQf1r8AciaG0OFyLVL1rJ1SPKXg==
X-Received: by 2002:a17:90b:3e8b:b0:1fb:825c:af8a with SMTP id rj11-20020a17090b3e8b00b001fb825caf8amr29879461pjb.104.1669886001635;
        Thu, 01 Dec 2022 01:13:21 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id n6-20020a6546c6000000b0047063eb4098sm2172327pgr.37.2022.12.01.01.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:13:21 -0800 (PST)
Date:   Thu, 1 Dec 2022 14:43:16 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/9] ext4: Move keep_towrite handling to
 ext4_bio_write_page()
Message-ID: <20221201091316.fs54l7fa257tkynv@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130163608.29034-2-jack@suse.cz>
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
> When we are writing back page but we cannot for some reason write all
> its buffers (e.g. because we cannot allocate blocks in current context) we
> have to keep TOWRITE tag set in the mapping as otherwise racing
> WB_SYNC_ALL writeback that could write these buffers can skip the page
> and result in data loss. We will need this logic for writeback during
> transaction commit so move the logic from ext4_writepage() to
> ext4_bio_write_page().


Nice explaination.
Moving set_page_writeback() and set_page_writeback_keepwrite() to after
identifying any buffers needs to be written back or not is also sweet.
This avoid unnecessary calling of end_page_writeback().

The patch looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/ext4.h    |  3 +--
>  fs/ext4/inode.c   |  6 ++----
>  fs/ext4/page-io.c | 36 +++++++++++++++++++++---------------
>  3 files changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8d5453852f98..1b3bffc04fd0 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3756,8 +3756,7 @@ extern void ext4_end_io_rsv_work(struct work_struct *work);
>  extern void ext4_io_submit(struct ext4_io_submit *io);
>  extern int ext4_bio_write_page(struct ext4_io_submit *io,
>  			       struct page *page,
> -			       int len,
> -			       bool keep_towrite);
> +			       int len);
>  extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
>  extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2b5ef1b64249..43eb175d0c1c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2009,7 +2009,6 @@ static int ext4_writepage(struct page *page,
>  	struct buffer_head *page_bufs = NULL;
>  	struct inode *inode = page->mapping->host;
>  	struct ext4_io_submit io_submit;
> -	bool keep_towrite = false;
>
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
>  		folio_invalidate(folio, 0, folio_size(folio));
> @@ -2067,7 +2066,6 @@ static int ext4_writepage(struct page *page,
>  			unlock_page(page);
>  			return 0;
>  		}
> -		keep_towrite = true;
>  	}
>
>  	if (PageChecked(page) && ext4_should_journal_data(inode))
> @@ -2084,7 +2082,7 @@ static int ext4_writepage(struct page *page,
>  		unlock_page(page);
>  		return -ENOMEM;
>  	}
> -	ret = ext4_bio_write_page(&io_submit, page, len, keep_towrite);
> +	ret = ext4_bio_write_page(&io_submit, page, len);
>  	ext4_io_submit(&io_submit);
>  	/* Drop io_end reference we got from init */
>  	ext4_put_io_end_defer(io_submit.io_end);
> @@ -2118,7 +2116,7 @@ static int mpage_submit_page(struct mpage_da_data *mpd, struct page *page)
>  		len = size & ~PAGE_MASK;
>  	else
>  		len = PAGE_SIZE;
> -	err = ext4_bio_write_page(&mpd->io_submit, page, len, false);
> +	err = ext4_bio_write_page(&mpd->io_submit, page, len);
>  	if (!err)
>  		mpd->wbc->nr_to_write--;
>  	mpd->first_page++;
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 4e68ace86f11..4f9ecacd10aa 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -430,8 +430,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
>
>  int ext4_bio_write_page(struct ext4_io_submit *io,
>  			struct page *page,
> -			int len,
> -			bool keep_towrite)
> +			int len)
>  {
>  	struct page *bounce_page = NULL;
>  	struct inode *inode = page->mapping->host;
> @@ -441,14 +440,11 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  	int nr_submitted = 0;
>  	int nr_to_submit = 0;
>  	struct writeback_control *wbc = io->io_wbc;
> +	bool keep_towrite = false;
>
>  	BUG_ON(!PageLocked(page));
>  	BUG_ON(PageWriteback(page));
>
> -	if (keep_towrite)
> -		set_page_writeback_keepwrite(page);
> -	else
> -		set_page_writeback(page);
>  	ClearPageError(page);
>
>  	/*
> @@ -483,12 +479,17 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  			if (!buffer_mapped(bh))
>  				clear_buffer_dirty(bh);
>  			/*
> -			 * Keeping dirty some buffer we cannot write? Make
> -			 * sure to redirty the page. This happens e.g. when
> -			 * doing writeout for transaction commit.
> +			 * Keeping dirty some buffer we cannot write? Make sure
> +			 * to redirty the page and keep TOWRITE tag so that
> +			 * racing WB_SYNC_ALL writeback does not skip the page.
> +			 * This happens e.g. when doing writeout for
> +			 * transaction commit.
>  			 */
> -			if (buffer_dirty(bh) && !PageDirty(page))
> -				redirty_page_for_writepage(wbc, page);
> +			if (buffer_dirty(bh)) {
> +				if (!PageDirty(page))
> +					redirty_page_for_writepage(wbc, page);
> +				keep_towrite = true;
> +			}
>  			if (io->io_bio)
>  				ext4_io_submit(io);
>  			continue;
> @@ -500,6 +501,10 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  		nr_to_submit++;
>  	} while ((bh = bh->b_this_page) != head);
>
> +	/* Nothing to submit? Just unlock the page... */
> +	if (!nr_to_submit)
> +		goto unlock;
> +
>  	bh = head = page_buffers(page);
>
>  	/*
> @@ -550,6 +555,11 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  		}
>  	}
>
> +	if (keep_towrite)
> +		set_page_writeback_keepwrite(page);
> +	else
> +		set_page_writeback(page);
> +
>  	/* Now submit buffers to write */
>  	do {
>  		if (!buffer_async_write(bh))
> @@ -558,11 +568,7 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
>  				 bounce_page ? bounce_page : page, bh);
>  		nr_submitted++;
>  	} while ((bh = bh->b_this_page) != head);
> -
>  unlock:
>  	unlock_page(page);
> -	/* Nothing submitted - we have to end page writeback */
> -	if (!nr_submitted)
> -		end_page_writeback(page);
>  	return ret;
>  }
> --
> 2.35.3
>
