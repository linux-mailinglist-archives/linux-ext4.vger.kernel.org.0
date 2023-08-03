Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F77276EC1F
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjHCOPZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjHCOPH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:15:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163FA44BD
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:14:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E27C21985;
        Thu,  3 Aug 2023 14:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691072084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Vvsf/cP6XtXX3T8+N+tbMjuIiHy5xSPVgqEW/dHUJw=;
        b=OZ6eFM9FGMwe1opOctFlOuMfjyksdw9mCWD3yO78Uurua+Rn0KAruk/tYGiMfhHy64gu7r
        NNPWcW5SEBklAIX7urn8iC6EdZIFxYnvS08ZIHCwloDjFX8l1Ne54UcBlbizoaPX0vr88U
        K5nLj3Lv0Hp0cN4y20eIscSRRaKrsl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691072084;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Vvsf/cP6XtXX3T8+N+tbMjuIiHy5xSPVgqEW/dHUJw=;
        b=ZnKw5C0sTLL4nC5EFSL62Ya0GFspEJCE+LxWawtkVL7eVYMceXgC3LD3WEiWS5y492TtRw
        aurTNEox7FBW7wBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F3281333C;
        Thu,  3 Aug 2023 14:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vC70IlS2y2TyCQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 14:14:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2C1FCA076B; Thu,  3 Aug 2023 16:14:44 +0200 (CEST)
Date:   Thu, 3 Aug 2023 16:14:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 03/12] jbd2: don't load superblock in
 jbd2_journal_check_used_features()
Message-ID: <20230803141444.eovm5swjewaepela@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-4-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-4-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:24, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since load_superblock() has been moved to journal_init_common(), the
> in-memory superblock structure is initialized and contains valid data
> once the file system has a journal_t object, so it's safe to access it,
> let's drop the call to journal_get_superblock() from
> jbd2_journal_check_used_features() and also drop the setting/clearing of
> the veirfy bit of the superblock buffer.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b247d374e7a6..c7cdb434966f 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1361,8 +1361,6 @@ static int journal_get_superblock(journal_t *journal)
>  	bh = journal->j_sb_buffer;
>  
>  	J_ASSERT(bh != NULL);
> -	if (buffer_verified(bh))
> -		return 0;
>  
>  	err = bh_read(bh, 0);
>  	if (err < 0) {
> @@ -1437,7 +1435,6 @@ static int journal_get_superblock(journal_t *journal)
>  			goto out;
>  		}
>  	}
> -	set_buffer_verified(bh);
>  	return 0;
>  
>  out:
> @@ -2224,8 +2221,6 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
>  
>  	if (!compat && !ro && !incompat)
>  		return 1;
> -	if (journal_get_superblock(journal))
> -		return 0;
>  	if (!jbd2_format_support_feature(journal))
>  		return 0;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
