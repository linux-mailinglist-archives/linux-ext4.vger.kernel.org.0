Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D0C76EC3D
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjHCOUA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbjHCOT7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:19:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A403CF5
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:19:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 640BC21972;
        Thu,  3 Aug 2023 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691072397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odxYfEb+d9Lzu0pipeV3kkQo9cFWI+LjAOy3HrhwUNg=;
        b=EQNrHRy9TFxqkS76YRAmLgTYeXPI+wetF1WP4vw+hO+oV0rPspBzLtNcrQM0xj9vp0MbXM
        IqPgUV3zysGqRajEDVSW6Y2Xw4t2sajvAtVsDc43lgTyOaXhLMB6lH6S1vXPE3aVYXQWkh
        CxB1/baRDQAe6gIawPcIiIfW7Q6rLxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691072397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odxYfEb+d9Lzu0pipeV3kkQo9cFWI+LjAOy3HrhwUNg=;
        b=VLNXwuX6UHjMUHSL5UwTjktKgX2zIV5b1+MU13NfFX8S7kL32RBrBsuSktRXpZiePrTwI9
        xYtup+1dEoxxiSBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55E2F1333C;
        Thu,  3 Aug 2023 14:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id COf3FI23y2SPDAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 14:19:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E03C7A076B; Thu,  3 Aug 2023 16:19:56 +0200 (CEST)
Date:   Thu, 3 Aug 2023 16:19:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 05/12] jbd2: open code jbd2_verify_csum_type() helper
Message-ID: <20230803141956.6cj4izjqx4npzrbn@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-6-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704134233.110812-6-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 04-07-23 21:42:26, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> jbd2_verify_csum_type() helper check checksum type in the superblock for
> v2 or v3 checksum feature, it always return true if these features are
> not enabled, and it has only one user, so open code it is more clear.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d84f26b08315..46ab47b4439e 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -115,14 +115,6 @@ void __jbd2_debug(int level, const char *file, const char *func,
>  #endif
>  
>  /* Checksumming functions */
> -static int jbd2_verify_csum_type(journal_t *j, journal_superblock_t *sb)
> -{
> -	if (!jbd2_journal_has_csum_v2or3_feature(j))
> -		return 1;
> -
> -	return sb->s_checksum_type == JBD2_CRC32C_CHKSUM;
> -}
> -
>  static __be32 jbd2_superblock_csum(journal_t *j, journal_superblock_t *sb)
>  {
>  	__u32 csum;
> @@ -1429,13 +1421,13 @@ static int journal_get_superblock(journal_t *journal)
>  		goto out;
>  	}
>  
> -	if (!jbd2_verify_csum_type(journal, sb)) {
> -		printk(KERN_ERR "JBD2: Unknown checksum type\n");
> -		goto out;
> -	}
> -
>  	/* Load the checksum driver */
>  	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
> +		if (sb->s_checksum_type != JBD2_CRC32C_CHKSUM) {
> +			printk(KERN_ERR "JBD2: Unknown checksum type\n");
> +			goto out;
> +		}
> +
>  		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
>  		if (IS_ERR(journal->j_chksum_driver)) {
>  			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
