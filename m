Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09D76A6CC6
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 14:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCANDh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 08:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjCANDa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 08:03:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A056C3E616;
        Wed,  1 Mar 2023 05:03:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A92B1FE12;
        Wed,  1 Mar 2023 13:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677675800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsUz2ZF21Zo4pWO3KKHyhfS3MF4yNcPvkS7A8IQtuU8=;
        b=pHxeUmVKlSTo/HVAG3z4o2zf4mzCEkC+OfvEWLqR7lyiovqPWV30aqNsVryKQriUY6GFI9
        q3/HCFuJMoMG0BdsUykqDwVdVsDZzjcK3Zy5j6Qvt2+QpaqdapJNJLKFfq6mlKRC+8Q9uz
        Orfh+6SejhrT12p0VQ/t9LYYbGe+qJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677675800;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsUz2ZF21Zo4pWO3KKHyhfS3MF4yNcPvkS7A8IQtuU8=;
        b=1ubwTF6tL+EaLPagUvR5obN/BMwGZ9coW1BGjGBlKuY/QdR+yjq+UF8pPkspnUWfN5825K
        G9Zk/AXcO/e58tDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CDD913A3E;
        Wed,  1 Mar 2023 13:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3VZfBhhN/2N+BgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 13:03:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8EAC7A06E5; Wed,  1 Mar 2023 14:03:19 +0100 (CET)
Date:   Wed, 1 Mar 2023 14:03:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v4 1/2] ext4: commit super block if fs record error when
 journal record without error
Message-ID: <20230301130319.yrh65hqjl2ve5d2v@quack3>
References: <20230301115909.184772-1-yebin@huaweicloud.com>
 <20230301115909.184772-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301115909.184772-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 01-03-23 19:59:08, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, 'es->s_state' maybe covered by recover journal. And journal errno
> maybe not recorded in journal sb as IO error. ext4_update_super() only
> update error information when 'sbi->s_add_error_count' large than zero.
> Then 'EXT4_ERROR_FS' flag maybe lost.
> To solve above issue just recover 'es->s_state' error flag after journal
> replay like error info.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks. The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index faae05493471..9df8fada2dce 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5910,7 +5910,9 @@ static int ext4_load_journal(struct super_block *sb,
>  	if (!ext4_has_feature_journal_needs_recovery(sb))
>  		err = jbd2_journal_wipe(journal, !really_read_only);
>  	if (!err) {
> +		int err2;
>  		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
> +
>  		if (save)
>  			memcpy(save, ((char *) es) +
>  			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
> @@ -5919,6 +5921,11 @@ static int ext4_load_journal(struct super_block *sb,
>  			memcpy(((char *) es) + EXT4_S_ERR_START,
>  			       save, EXT4_S_ERR_LEN);
>  		kfree(save);
> +		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
> +					   EXT4_ERROR_FS);
> +		/* Write out restored error information to the superblock */
> +		err2 = ext4_commit_super(sb);
> +		err = err ? : err2;
>  	}
>  
>  	if (err) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
