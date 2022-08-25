Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89915A0E92
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Aug 2022 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiHYK5U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Aug 2022 06:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbiHYK5H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Aug 2022 06:57:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36BAA364;
        Thu, 25 Aug 2022 03:57:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44A855C446;
        Thu, 25 Aug 2022 10:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661425025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s8SR+gQMDrofSbIUhaVQPDx4KdCnSHqChKukc6toPhQ=;
        b=zNcQo8pgYOyT64drYJ4KsptavsKSn/4hSmJPIGPZru1XLtadGjWmZ4sElVNQ1c2UOwafoj
        WCuiE6Q21TwWNKPhYN1ke/E2MrqeWID8GbgtumvfGHt3iF9LMhFKy53+5Q2bv0S68xq+8E
        fIEpFea4EEQf8efz+xn6ZlKL/IESfyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661425025;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s8SR+gQMDrofSbIUhaVQPDx4KdCnSHqChKukc6toPhQ=;
        b=DBRXnjRFbihD55jU3qG3QBzK4r7+40apmR5Aeo6f82wLz/CIA9KFOpAep46zrxlE/SkTZX
        ArVReGQqIyOKEQDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BF0013517;
        Thu, 25 Aug 2022 10:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b9PDBoFVB2PhbAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 Aug 2022 10:57:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86879A0679; Thu, 25 Aug 2022 12:57:04 +0200 (CEST)
Date:   Thu, 25 Aug 2022 12:57:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        jack@suse.cz, mgorman@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] mm: migrate: buffer_migrate_folio_norefs() fallback
 migrate not uptodate pages
Message-ID: <20220825105704.e46hz6dp6opawsjk@quack3>
References: <20220825080146.2021641-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825080146.2021641-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 25-08-22 16:01:46, Zhihao Cheng wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Recently we notice that ext4 filesystem occasionally fail to read
> metadata from disk and report error message, but the disk and block
> layer looks fine. After analyse, we lockon commit 88dbcbb3a484
> ("blkdev: avoid migration stalls for blkdev pages"). It provide a
> migration method for the bdev, we could move page that has buffers
> without extra users now, but it will lock the buffers on the page, which
> breaks a lot of current filesystem's fragile metadata read operations,
> like ll_rw_block() for common usage and ext4_read_bh_lock() for ext4,
> these helpers just trylock the buffer and skip submit IO if it lock
> failed, many callers just wait_on_buffer() and conclude IO error if the
> buffer is not uptodate after buffer unlocked.
> 
> This issue could be easily reproduced by add some delay just after
> buffer_migrate_lock_buffers() in __buffer_migrate_folio() and do
> fsstress on ext4 filesystem.
> 
>   EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #73193:
>   comm fsstress: reading directory lblock 0
>   EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #75334:
>   comm fsstress: reading directory lblock 0
> 
> Something like ll_rw_block() should be used carefully and seems could
> only be safely used for the readahead case. So the best way is to fix
> the read operations in filesystem in the long run, but now let us avoid
> this issue first. This patch avoid this issue by fallback to migrate
> pages that are not uotodate like fallback_migrate_folio(), those pages
> that has buffers may probably do read operation soon.
> 
> Fixes: 88dbcbb3a484 ("blkdev: avoid migration stalls for blkdev pages")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Thanks for the analysis and the fix! As you noted above this is actually a
bug in the filesystems that they assume that locked buffer means it is
under IO.  Usually that is the case but there are other places that lock
the buffer without doing IO. Page migration is one of them, jbd2 machinery
another one, there may be others.

So I think this really ought to be fixed in filesystems instead of papering
over the bug in the migration code. I agree this is more work but we will
reduce the technical debt, not increase it :). Honestly, ll_rw_block()
should just die. It is actively dangerous to use. Instead we should have
one call for readahead of bhs and the rest should be converted to
submit_bh() or similar calls. There are like 25 callers remaining so it
won't be even that hard.

And then we have the same buggy code as in ll_rw_block() copied to
ext4_bread_batch() (ext4_read_bh_lock() in particular) so that needs to be
fixed as well...

								Honza

> ---
>  mm/migrate.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6a1597c92261..bded69867619 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -691,6 +691,38 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  	if (!head)
>  		return migrate_folio(mapping, dst, src, mode);
>  
> +	/*
> +	 * If the mapped buffers on the page are not uptodate and has refcount,
> +	 * some others may propably try to lock the buffer and submit read IO
> +	 * through ll_rw_block(), but it will not submit IO once it failed to
> +	 * lock the buffer, so try to fallback to migrate_folio() to prevent
> +	 * false positive EIO.
> +	 */
> +	if (check_refs) {
> +		bool uptodate = true;
> +		bool invalidate = false;
> +
> +		bh = head;
> +		do {
> +			if (buffer_mapped(bh) && !buffer_uptodate(bh)) {
> +				uptodate = false;
> +				if (atomic_read(&bh->b_count)) {
> +					invalidate = true;
> +					break;
> +				}
> +			}
> +			bh = bh->b_this_page;
> +		} while (bh != head);
> +
> +		if (!uptodate) {
> +			if (invalidate)
> +				invalidate_bh_lrus();
> +			if (filemap_release_folio(src, GFP_KERNEL))
> +				return migrate_folio(mapping, dst, src, mode);
> +			return -EAGAIN;
> +		}
> +	}
> +
>  	/* Check whether page does not have extra refs before we do more work */
>  	expected_count = folio_expected_refs(mapping, src);
>  	if (folio_ref_count(src) != expected_count)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
