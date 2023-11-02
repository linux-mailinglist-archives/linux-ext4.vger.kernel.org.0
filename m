Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675637DEF8A
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Nov 2023 11:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346337AbjKBKJG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Nov 2023 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346147AbjKBKJF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Nov 2023 06:09:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC8136;
        Thu,  2 Nov 2023 03:08:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 363D11F896;
        Thu,  2 Nov 2023 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698919738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3aHkG+hoDOmbGBPikCMsIz7KXZaV7Ke8PQGKcoscHh4=;
        b=cM5ku7uz4EcAkyHf6TRBozx/ZJHeKhRwy8YFd25jK+XV1PWvE/0Pc+pXxslSiT2FIVEMvM
        /TEEfT8mR/RcoyknQrkdc3EwcFTf7fME/ZNT1srHXYtXXNRb07VtsajxnT+nFRYhBabDuh
        ZvBZ6JoiU6fGLs1nhqM0t4r0fqLm8MY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698919738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3aHkG+hoDOmbGBPikCMsIz7KXZaV7Ke8PQGKcoscHh4=;
        b=KCoECzTdPSPZ1kgWG7amUwp3OZ3h34fuj9P/1mjU/k1iuvJdGbF2286Yd7+5WOScOGQkzc
        RyQSAyV1307rg9Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2250913584;
        Thu,  2 Nov 2023 10:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 74xdCDp1Q2XYfgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 02 Nov 2023 10:08:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A41F6A06E3; Thu,  2 Nov 2023 11:08:57 +0100 (CET)
Date:   Thu, 2 Nov 2023 11:08:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/2] ext4: Clarify handling of unwritten bh in
 __ext4_block_zero_page_range()
Message-ID: <20231102100857.tntr4mdz65bddq2f@quack3>
References: <cover.1698856309.git.ojaswin@linux.ibm.com>
 <d859b7ae5fe42e6626479b91ed9f4da3aae4c597.1698856309.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d859b7ae5fe42e6626479b91ed9f4da3aae4c597.1698856309.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 01-11-23 22:08:11, Ojaswin Mujoo wrote:
> As an optimization, I was trying to work on exiting early from this
> function if dealing with unwritten extent since they anyways read 0.
> However, it was realised that there are certain code paths that can
> end up calling ext4_block_zero_page_range() for an unwritten bh that
> might still have data in pagecache. In this case, we can't exit early
> and we do require to process the bh and zero out the pagecache to ensure
> that a writeback can't kick in at a later time and flush the stale
> pagecache to disk.
> 
> Since, adding the logic to exit early for unwritten bh was turning out
> to be much more nuanced and the current code already handles it well,
> just add a comment to explicitly document this behavior.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d7732320431a..76921e834dd4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3632,6 +3632,12 @@ void ext4_set_aops(struct inode *inode)
>  		inode->i_mapping->a_ops = &ext4_aops;
>  }
>  
> +/*
> + * Here we can't skip an unwritten buffer even though it usually reads zero
> + * because it might have data in pagecache (eg, if called from ext4_zero_range,
> + * ext4_punch_hole, etc) which needs to be properly zeroed out. Otherwise a
> + * racing writeback can come later and flush the stale pagecache to disk.
> + */
>  static int __ext4_block_zero_page_range(handle_t *handle,
>  		struct address_space *mapping, loff_t from, loff_t length)
>  {
> -- 
> 2.39.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
