Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5AB6FB0C3
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjEHNBf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 09:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjEHNBe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 09:01:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B467935DB9
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 06:01:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D72881FEB2;
        Mon,  8 May 2023 13:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683550890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GJh091InAkqCjTjznUY59Mt9CidlMTy1x7ymoWKb/4=;
        b=azLHWsY8+EuJj/nb9nHuoIKVsCB/7A2Yi6TpnjrdwM+B805EElbFhZ80jA+Gtkh+MzIose
        FErhTBRCj7YrE9e5jaxQogYnGrXlihZt0ZrI3tUbYqcBmSqTYmvVTpE4F6gWwuyd/ZgMOY
        bnWPrYm+ZJOdkyLe4GZdVeHcwobxwDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683550890;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GJh091InAkqCjTjznUY59Mt9CidlMTy1x7ymoWKb/4=;
        b=DpM0PqmqYKKyHv1wiWV0GViAz0uiP0scSc8ybP1rY0OMFH68jLHxf+pd0ethXEJ7lHIdNY
        Rj2bMi4KioS1XaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AABE8139F8;
        Mon,  8 May 2023 13:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8pWkKaryWGSaXQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 08 May 2023 13:01:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9B269A0729; Sun,  7 May 2023 20:28:33 +0200 (CEST)
Date:   Sun, 7 May 2023 20:28:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] ext4: remove a BUG_ON in ext4_mb_release_group_pa()
Message-ID: <20230507182833.ma7fugevh7imz2tj@quack3>
References: <20230430154311.579720-1-tytso@mit.edu>
 <20230430154311.579720-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430154311.579720-3-tytso@mit.edu>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 30-04-23 11:43:11, Theodore Ts'o wrote:
> If a malicious fuzzer overwrites the ext4 superblock while it is
> mounted such that the s_first_data_block is set to a very large
> number, the calculation of the block group can underflow, and trigger
> a BUG_ON check.  Change this to be an ext4_warning so that we don't
> crash the kernel.
> 
> Reported-by: syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=69b28112e098b070f639efb356393af3ffec4220
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

OK, looks good to me. But frankly there are many other interesting ways how
bogus group numbers output when this happens can return is fun stuff - e.g.
ext4_group_first_block_no() is going to return invalid blocks etc. So it
feels a bit like endless whack-a-mole game. Anyway I agree the series seem
to fix a big chunk of these sites so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/mballoc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index dc13734f399d..9c7881a4ea75 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5047,7 +5047,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
>  	trace_ext4_mb_release_group_pa(sb, pa);
>  	BUG_ON(pa->pa_deleted == 0);
>  	ext4_get_group_no_and_offset(sb, pa->pa_pstart, &group, &bit);
> -	BUG_ON(group != e4b->bd_group && pa->pa_len != 0);
> +	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
> +		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
> +			     e4b->bd_group, group, pa->pa_pstart);
> +		return 0;
> +	}
>  	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
>  	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
>  	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);
> -- 
> 2.31.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
