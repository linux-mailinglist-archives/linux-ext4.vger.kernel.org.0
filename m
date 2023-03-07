Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028076AD9CB
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCGJCl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 04:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCGJCk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 04:02:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2660E50736;
        Tue,  7 Mar 2023 01:02:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1C4021A16;
        Tue,  7 Mar 2023 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678179757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0GWNW+aEY+jTsa8kMVIy+b7YzFxeCuVU3o8GQn5FGEk=;
        b=ZEUDKUn7O9IistxTZCCYE/zxivovXBfeSeb7VfaFIoqXcz8AooSmphbARyrKAz8in8msUn
        PlsbyigRP7wxH/+6KLQsz7hOnp+mFi97xJISwfDdWHfvbJaaXQc4Z39FYIXXUlVDeOurZ8
        pCJIgb9K9ilD1T/pemKESAr9K9JDUSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678179757;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0GWNW+aEY+jTsa8kMVIy+b7YzFxeCuVU3o8GQn5FGEk=;
        b=u1OZXv5gFf2fzqDiv09hfyxKXKCZ7X9MVpAGw1Nf3dJryHJtBMBlV3s7DKU+XT3cQppc1J
        uCa6FCg159wOJrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9084A13440;
        Tue,  7 Mar 2023 09:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id In41I639BmQqLQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Mar 2023 09:02:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E5909A06F3; Tue,  7 Mar 2023 10:02:35 +0100 (CET)
Date:   Tue, 7 Mar 2023 10:02:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v5 1/2] ext4: commit super block if fs record error when
 journal record without error
Message-ID: <20230307090235.ofr2jjah5komdoas@quack3>
References: <20230307061703.245965-1-yebin@huaweicloud.com>
 <20230307061703.245965-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307061703.245965-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 07-03-23 14:17:02, Ye Bin wrote:
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

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 88f7b8a88c76..dfa31eea1346 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5920,6 +5920,7 @@ static int ext4_load_journal(struct super_block *sb,
>  		err = jbd2_journal_wipe(journal, !really_read_only);
>  	if (!err) {
>  		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
> +
>  		if (save)
>  			memcpy(save, ((char *) es) +
>  			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
> @@ -5928,6 +5929,14 @@ static int ext4_load_journal(struct super_block *sb,
>  			memcpy(((char *) es) + EXT4_S_ERR_START,
>  			       save, EXT4_S_ERR_LEN);
>  		kfree(save);
> +		es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state &
> +					   EXT4_ERROR_FS);
> +		/* Write out restored error information to the superblock */
> +		if (!bdev_read_only(sb->s_bdev)) {
> +			int err2;
> +			err2 = ext4_commit_super(sb);
> +			err = err ? : err2;
> +		}
>  	}
>  
>  	if (err) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
