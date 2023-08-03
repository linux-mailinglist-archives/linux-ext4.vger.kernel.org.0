Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C103576ECDA
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbjHCOkZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbjHCOkM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:40:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A67330C7
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:39:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 922C31F747;
        Thu,  3 Aug 2023 14:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691073505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1E5dOoVtRyp9fACvc30iT51lC9g+xY5JNgjO6D1dhk=;
        b=BMlYPwsOGih5J5hI/O58+eSWhTStOA9D/w5PHiZGUen+9SVbL5Pl9mTyRwAEvJLwm2j7Of
        ejDVtndt6oqeAN2Yu4Eu1/P0WHDESU7jqXBFFWEbeb3tTqy0V7nCF46JBP559U0MhT2rum
        5kpxb5tWdu7kel+zlc6Sg5c8gkmmQVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691073505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1E5dOoVtRyp9fACvc30iT51lC9g+xY5JNgjO6D1dhk=;
        b=Bn3LC6qK/pvgCAkahi2lnr2PU4pD7VudmTP/74utSTdu1+/M+E60MxFCPNkKCENMHMLpqW
        OQCWsSQhfyaaWHBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81CFE1333C;
        Thu,  3 Aug 2023 14:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RwKrH+G7y2QXFgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 14:38:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 11C36A076B; Thu,  3 Aug 2023 16:38:25 +0200 (CEST)
Date:   Thu, 3 Aug 2023 16:38:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 07/12] jbd2: add fast_commit space check
Message-ID: <20230803143825.f364hmpsgqbzvjwo@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-8-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-8-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:28, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> If JBD2_FEATURE_INCOMPAT_FAST_COMMIT bit is set, it means the journal
> have fast commit records need to recover, so the fast commit size
> should not be zero, and also the leftover normal journal size should
> never less than JBD2_MIN_JOURNAL_BLOCKS. Add a check into the
> journal_check_superblock() and drop the pointless branch when
> initializing in-memory fastcommit parameters.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Some comments below.


> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index efdb8db3c06e..210b532a3673 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1392,6 +1392,18 @@ static int journal_check_superblock(journal_t *journal)
>  		return err;
>  	}
>  
> +	if (jbd2_has_feature_fast_commit(journal)) {
> +		int num_fc_blks = be32_to_cpu(sb->s_num_fc_blks);
> +
> +		if (!num_fc_blks ||
> +		    (be32_to_cpu(sb->s_maxlen) - num_fc_blks <
> +		     JBD2_MIN_JOURNAL_BLOCKS)) {
> +			printk(KERN_ERR "JBD2: Invalid fast commit size %d\n",
> +			       num_fc_blks);
> +			return err;
> +		}

This is wrong sb->s_num_fc_blks == 0 means that the fast-commit area should
have the default size of 256 blocks. At least that's how it behaves
currently and we should not change the behavior.

Similarly if the number of fastcommit blocks was too big (i.e. there was
not enough space left for ordinary journal), we effectively silently
disable fastcommit and you break this behavior in this patch.

								Honza

> +	}
> +
>  	if (jbd2_has_feature_csum2(journal) &&
>  	    jbd2_has_feature_csum3(journal)) {
>  		/* Can't have checksum v2 and v3 at the same time! */
> @@ -1460,7 +1472,6 @@ static int journal_load_superblock(journal_t *journal)
>  	int err;
>  	struct buffer_head *bh;
>  	journal_superblock_t *sb;
> -	int num_fc_blocks;
>  
>  	bh = getblk_unmovable(journal->j_dev, journal->j_blk_offset,
>  			      journal->j_blocksize);
> @@ -1498,9 +1509,8 @@ static int journal_load_superblock(journal_t *journal)
>  
>  	if (jbd2_has_feature_fast_commit(journal)) {
>  		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
> -		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
> -		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
> -			journal->j_last = journal->j_fc_last - num_fc_blocks;
> +		journal->j_last = journal->j_fc_last -
> +				  be32_to_cpu(sb->s_num_fc_blks);
>  		journal->j_fc_first = journal->j_last + 1;
>  		journal->j_fc_off = 0;
>  	}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
