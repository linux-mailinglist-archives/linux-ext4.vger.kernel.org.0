Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93D73E2C2
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jun 2023 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFZPFs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jun 2023 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjFZPFp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jun 2023 11:05:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A61701
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 08:05:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DB5A1F8AA;
        Mon, 26 Jun 2023 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687791939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aWFDnZv4CerJwczUnZzg5xiK6W7jp2Wh8+PFGW0fpcM=;
        b=QoXZnNJdfVZWxO+ABy6WDNXBuHU54xqM8dI50lOV0UIKh3KrHPYkDj8QKH3sj5coduZKBi
        Lv1RWq8JuBNp8nImv501jhdANHThc+a0IElYJUPQtSKaxshZG2IL4xe0Hm0C03tm5VQq+F
        OxN7B2OEBNu6rSXdGj9w0hZftmXWXWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687791939;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aWFDnZv4CerJwczUnZzg5xiK6W7jp2Wh8+PFGW0fpcM=;
        b=ufoRr0h5ecZhjjFkD2FOMNm49xpVSCUwliwjw65vbQxeYQM8aC79EKWNu6sE025rakGteJ
        UiYgi9lzyiMrGeCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6CD4613905;
        Mon, 26 Jun 2023 15:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KMCLGkOpmWQnGgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Jun 2023 15:05:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D6AACA0754; Mon, 26 Jun 2023 17:05:38 +0200 (CEST)
Date:   Mon, 26 Jun 2023 17:05:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz,
        harshadshirwadkar@gmail.com, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH] jbd2: correct the end of the journal recovery scan range
Message-ID: <20230626150538.4n2avgl6hll7lphp@quack3>
References: <20230626073322.3956567-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626073322.3956567-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 26-06-23 15:33:22, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> We got a filesystem inconsistency issue below while running generic/475
> I/O failure pressure test with fast_commit feature enabled.
> 
>  Symlink /p3/d3/d1c/d6c/dd6/dce/l101 (inode #132605) is invalid.
> 
> If fast_commit feature is enabled, a special fast_commit journal area is
> appended to the end of the normal journal area. The journal->j_last
> point to the first unused block behind the normal journal area instead
> of the whole log area, and the journal->j_fc_last point to the first
> unused block behind the fast_commit journal area. While doing journal
> recovery, do_one_pass(PASS_SCAN) should first scan the normal journal
> area and turn around to the first block once it meet journal->j_last,
> but the wrap() macro misuse the journal->j_fc_last, so the recovering
> could not read the next magic block (commit block perhaps) and would end
> early mistakenly and missing tN and every transaction after it in the
> following example. Finally, it could lead to filesystem inconsistency.
> 
>  | normal journal area                             | fast commit area |
>  +-------------------------------------------------+------------------+
>  | tN(rere) | tN+1 |~| tN-x |...| tN-1 | tN(front) |       ....       |
>  +-------------------------------------------------+------------------+
>                      /                             /                  /
>                 start               journal->j_last journal->j_fc_last
> 
> This patch fix it by use the correct ending journal->j_last.
> 
> Fixes: 5b849b5f96b4 ("jbd2: fast commit recovery path")
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://lore.kernel.org/linux-ext4/20230613043120.GB1584772@mit.edu/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Ah, great catch! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 0184931d47f7..c269a7d29a46 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -230,12 +230,8 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
>  /* Make sure we wrap around the log correctly! */
>  #define wrap(journal, var)						\
>  do {									\
> -	unsigned long _wrap_last =					\
> -		jbd2_has_feature_fast_commit(journal) ?			\
> -			(journal)->j_fc_last : (journal)->j_last;	\
> -									\
> -	if (var >= _wrap_last)						\
> -		var -= (_wrap_last - (journal)->j_first);		\
> +	if (var >= (journal)->j_last)					\
> +		var -= ((journal)->j_last - (journal)->j_first);	\
>  } while (0)
>  
>  static int fc_do_one_pass(journal_t *journal,
> @@ -524,9 +520,7 @@ static int do_one_pass(journal_t *journal,
>  				break;
>  
>  		jbd2_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
> -			  next_commit_ID, next_log_block,
> -			  jbd2_has_feature_fast_commit(journal) ?
> -			  journal->j_fc_last : journal->j_last);
> +			  next_commit_ID, next_log_block, journal->j_last);
>  
>  		/* Skip over each chunk of the transaction looking
>  		 * either the next descriptor block or the final commit
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
