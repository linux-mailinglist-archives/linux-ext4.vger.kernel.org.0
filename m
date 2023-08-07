Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFF4771F06
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Aug 2023 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjHGK7L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Aug 2023 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjHGK7K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Aug 2023 06:59:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D9910FA
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 03:59:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02147210DF;
        Mon,  7 Aug 2023 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691405947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFDX2ZiiMKxL1zxLUHyybYafS/LlZSaxZhEVXewgov0=;
        b=NH4lYmi5+SzVBMAM85Mj7bmTaAGtPFan+KpjkTz6gb2I/NKtDm3HHT/aEKdVLk1u/OKxkP
        JVgm9I9DH3maEKpKbUgH/BmyUVTYqCW+kyx5LEBkhwpaJcq3ZNMJooNzXvuRUMoC+YEJ0D
        qRJFyn0Hr0PsbsB+IFGeGKTZhIkIRzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691405947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFDX2ZiiMKxL1zxLUHyybYafS/LlZSaxZhEVXewgov0=;
        b=CcogD0y1fte0svdgE503B0u1yAxJ9iTxp7Um+GMhWs+hMf8Z+kPlRzLxogDnxq+W86qYGn
        akZVdE/KCtwJTuAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E71FE13910;
        Mon,  7 Aug 2023 10:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yHhgOHrO0GROUAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Aug 2023 10:59:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8798CA076C; Mon,  7 Aug 2023 12:59:06 +0200 (CEST)
Date:   Mon, 7 Aug 2023 12:59:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: drop dio overwrite only flag and associated warning
Message-ID: <20230807105906.teovthvnwrpbmx7n@quack3>
References: <20230804182952.477247-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804182952.477247-1-bfoster@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 04-08-23 14:29:52, Brian Foster wrote:
> The commit referenced below opened up concurrent unaligned dio under
> shared locking for pure overwrites. In doing so, it enabled use of
> the IOMAP_DIO_OVERWRITE_ONLY flag and added a warning on unexpected
> -EAGAIN returns as an extra precaution, since ext4 does not retry
> writes in such cases. The flag itself is advisory in this case since
> ext4 checks for unaligned I/Os and uses appropriate locking up
> front, rather than on a retry in response to -EAGAIN.
> 
> As it turns out, the warning check is susceptible to false positives
> because there are scenarios where -EAGAIN is expected from the
> storage layer without necessarily having IOCB_NOWAIT set on the
> iocb. For example, io_uring can set IOCB_HIPRI, which the iomap/dio
> layer turns into REQ_POLLED|REQ_NOWAIT on the bio, which then can
> result in an -EAGAIN result if the block layer is unable to allocate
> a request, etc. syzbot has also reported an instance of this warning
> and while the source of the -EAGAIN in that case is not currently
> known, it is confirmed that the iomap dio overwrite flag is also not
> set.
> 
> Since this flag is precautionary, avoid the false positive warning
> and future whack-a-mole games with -EAGAIN returns by removing it
> and the associated warning. Update the comments to document when
> concurrent unaligned dio writes are allowed and why the associated
> flag is not used.
> 
> Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com
> Fixes: 310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")
> Signed-off-by: Brian Foster <bfoster@redhat.com>

So if I understand right, you're trying to say that if iomap_dio_rw()
returns -EAGAIN, the caller of ext4_file_write_iter() and not
ext4_file_write_iter() itself is expected to deal with it (like with
IOCB_NOWAIT or other ways that can trigger similar behavior). That sounds
good to me and the patch looks also fine. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
> 
> Hi all,
> 
> This addresses some false positives associated with the warning for the
> recently merged patch. I considered leaving the flag and more tightly
> associating the warning to it (instead of IOCB_NOWAIT), but ISTM that is
> still flakey and I'd rather not play whack-a-mole when the assumption is
> shown to be wrong.
> 
> I'm still waiting on a syzbot test of this patch, but local tests look
> Ok and I'm away for a few days after today so wanted to get this on the
> list. Thoughts, reviews, flames appreciated.
> 
> Brian
> 
>  fs/ext4/file.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index c457c8517f0f..73a4b711be02 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -476,6 +476,11 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  	 * required to change security info in file_modified(), for extending
>  	 * I/O, any form of non-overwrite I/O, and unaligned I/O to unwritten
>  	 * extents (as partial block zeroing may be required).
> +	 *
> +	 * Note that unaligned writes are allowed under shared lock so long as
> +	 * they are pure overwrites. Otherwise, concurrent unaligned writes risk
> +	 * data corruption due to partial block zeroing in the dio layer, and so
> +	 * the I/O must occur exclusively.
>  	 */
>  	if (*ilock_shared &&
>  	    ((!IS_NOSEC(inode) || *extend || !overwrite ||
> @@ -492,21 +497,12 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  
>  	/*
>  	 * Now that locking is settled, determine dio flags and exclusivity
> -	 * requirements. Unaligned writes are allowed under shared lock so long
> -	 * as they are pure overwrites. Set the iomap overwrite only flag as an
> -	 * added precaution in this case. Even though this is unnecessary, we
> -	 * can detect and warn on unexpected -EAGAIN if an unsafe unaligned
> -	 * write is ever submitted.
> -	 *
> -	 * Otherwise, concurrent unaligned writes risk data corruption due to
> -	 * partial block zeroing in the dio layer, and so the I/O must occur
> -	 * exclusively. The inode lock is already held exclusive if the write is
> -	 * non-overwrite or extending, so drain all outstanding dio and set the
> -	 * force wait dio flag.
> +	 * requirements. We don't use DIO_OVERWRITE_ONLY because we enforce
> +	 * behavior already. The inode lock is already held exclusive if the
> +	 * write is non-overwrite or extending, so drain all outstanding dio and
> +	 * set the force wait dio flag.
>  	 */
> -	if (*ilock_shared && unaligned_io) {
> -		*dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
> -	} else if (!*ilock_shared && (unaligned_io || *extend)) {
> +	if (!*ilock_shared && (unaligned_io || *extend)) {
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>  			ret = -EAGAIN;
>  			goto out;
> @@ -608,7 +604,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   dio_flags, NULL, 0);
> -	WARN_ON_ONCE(ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT));
>  	if (ret == -ENOTBLK)
>  		ret = 0;
>  
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
