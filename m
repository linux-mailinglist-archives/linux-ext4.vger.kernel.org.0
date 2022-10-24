Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026A160B40B
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Oct 2022 19:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiJXR0c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Oct 2022 13:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiJXR0R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Oct 2022 13:26:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9401DE3EC
        for <linux-ext4@vger.kernel.org>; Mon, 24 Oct 2022 09:01:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 22AC321E82;
        Mon, 24 Oct 2022 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666625387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k5tDSQ9reTU5WyF0mG0wYdrynTcc7tc9akL3G/Dfo74=;
        b=uHPdZvtUNe7Or1F2C/dwTs9kzwatXkjHzDyVkUK/TWpmGJfi2aL/eeMBTe93vmmJXOz6Pz
        5l2nYmkIWC8s4TxaoxXyKwflE8TuMmhKoWTjlnsTFpywNGpUcdsRc/OHyWpGvFpwNqa3yO
        RBLHt9mTyvov8cLDXM5ROVPXPFubUBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666625387;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k5tDSQ9reTU5WyF0mG0wYdrynTcc7tc9akL3G/Dfo74=;
        b=18njny/mjKJXb8x0AjdQWpacRH+aWP+KGC/IUMtgnfTzcEk8DXPGsIrqSKAb7IozKdMU4K
        wF1O8iwfILEIOICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15B0A13357;
        Mon, 24 Oct 2022 15:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PmlDBWuvVmOURgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Oct 2022 15:29:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9B670A06F6; Mon, 24 Oct 2022 17:29:46 +0200 (CEST)
Date:   Mon, 24 Oct 2022 17:29:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix wrong return err in
 ext4_load_and_init_journal()
Message-ID: <20221024152946.gafegxwrv5i5djvn@quack3>
References: <20221022130739.2515834-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022130739.2515834-1-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 22-10-22 21:07:39, Jason Yan wrote:
> The return value is wrong in ext4_load_and_init_journal(). The local
> variable 'err' need to be initialized before goto out. The original code
> in __ext4_fill_super() is fine because it has two return values 'ret'
> and 'err' and 'ret' is initialized as -EINVAL. After we factor out
> ext4_load_and_init_journal(), this code is broken. So fix it by directly
> returning -EINVAL in the error handler path.
> 
> Fixes: 9c1dd22d7422 (ext4: factor out ext4_load_and_init_journal())

We format the tag usually as:

Fixes: 9c1dd22d7422 ("ext4: factor out ext4_load_and_init_journal()")

> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Otherwise the patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 989365b878a6..89c6bad28a8a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4885,7 +4885,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>  	flush_work(&sbi->s_error_work);
>  	jbd2_journal_destroy(sbi->s_journal);
>  	sbi->s_journal = NULL;
> -	return err;
> +	return -EINVAL;
>  }
>  
>  static int ext4_journal_data_mode_check(struct super_block *sb)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
