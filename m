Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FCF5A7CDC
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiHaMF2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 08:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiHaMFQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 08:05:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E3183A1
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 05:05:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE41A221B5;
        Wed, 31 Aug 2022 12:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661947510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLkN8vHSpFCc1MmfxhXu/zHBZcu0dgldezgP0fe4boQ=;
        b=QoqbVuT6EkqI6WxnYk7vsrfJ6+sp62aq0XXQMQhOP/m/KvsU9J3YhZn3BMXFapg8LOYHfa
        0tysl/0mfKyDHUQfB04CHPvv655YpILLfrOG8cOizjFwE+i6TgKAieoox7Gf1sD0D3Wzq2
        IUuK0TFSMSyxgO3lJmc8AZuF58Ld37g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661947510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLkN8vHSpFCc1MmfxhXu/zHBZcu0dgldezgP0fe4boQ=;
        b=XwM4cC6Rny1RM8JdrPVZFsxffAG0YMHYnu3Vu2YpUXnxFnsILHhe+RSdMzfYw/iAQtHWX8
        p9Koh+Db4hDztPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C2911332D;
        Wed, 31 Aug 2022 12:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kN41InZOD2MlEAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 12:05:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D47EFA067B; Wed, 31 Aug 2022 14:05:09 +0200 (CEST)
Date:   Wed, 31 Aug 2022 14:05:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 12/13] ext4: factor out ext4_load_and_init_journal()
Message-ID: <20220831120509.4whig2d6yii7nkxc@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-13-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-13-yanaijie@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:10, Jason Yan wrote:
> This patch group the journal load and initialize code together and
> factor out ext4_load_and_init_journal(). This patch also removes the
> lable 'no_journal' which is not needed after refactor.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 157 +++++++++++++++++++++++++++---------------------
>  1 file changed, 88 insertions(+), 69 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 40f155543df0..95e70f0316db 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4823,6 +4823,93 @@ static int ext4_group_desc_init(struct super_block *sb,
>  	return ret;
>  }
>  
> +static int ext4_load_and_init_journal(struct super_block *sb,
> +				      struct ext4_super_block *es,
> +				      struct ext4_fs_context *ctx)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	int err;
> +
> +	err = ext4_load_journal(sb, es, ctx->journal_devnum);
> +	if (err)
> +		return err;
> +
> +	if (ext4_has_feature_64bit(sb) &&
> +	    !jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
> +				       JBD2_FEATURE_INCOMPAT_64BIT)) {
> +		ext4_msg(sb, KERN_ERR, "Failed to set 64-bit journal feature");
> +		goto out;
> +	}
> +
> +	if (!set_journal_csum_feature_set(sb)) {
> +		ext4_msg(sb, KERN_ERR, "Failed to set journal checksum "
> +			 "feature set");
> +		goto out;
> +	}
> +
> +	if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
> +		!jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
> +					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT)) {
> +		ext4_msg(sb, KERN_ERR,
> +			"Failed to set fast commit journal feature");
> +		goto out;
> +	}
> +
> +	/* We have now updated the journal if required, so we can
> +	 * validate the data journaling mode. */
> +	switch (test_opt(sb, DATA_FLAGS)) {
> +	case 0:
> +		/* No mode set, assume a default based on the journal
> +		 * capabilities: ORDERED_DATA if the journal can
> +		 * cope, else JOURNAL_DATA
> +		 */
> +		if (jbd2_journal_check_available_features
> +		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
> +			set_opt(sb, ORDERED_DATA);
> +			sbi->s_def_mount_opt |= EXT4_MOUNT_ORDERED_DATA;
> +		} else {
> +			set_opt(sb, JOURNAL_DATA);
> +			sbi->s_def_mount_opt |= EXT4_MOUNT_JOURNAL_DATA;
> +		}
> +		break;
> +
> +	case EXT4_MOUNT_ORDERED_DATA:
> +	case EXT4_MOUNT_WRITEBACK_DATA:
> +		if (!jbd2_journal_check_available_features
> +		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
> +			ext4_msg(sb, KERN_ERR, "Journal does not support "
> +			       "requested data journaling mode");
> +			goto out;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA &&
> +	    test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
> +		ext4_msg(sb, KERN_ERR, "can't mount with "
> +			"journal_async_commit in data=ordered mode");
> +		goto out;
> +	}
> +
> +	set_task_ioprio(sbi->s_journal->j_task, ctx->journal_ioprio);
> +
> +	sbi->s_journal->j_submit_inode_data_buffers =
> +		ext4_journal_submit_inode_data_buffers;
> +	sbi->s_journal->j_finish_inode_data_buffers =
> +		ext4_journal_finish_inode_data_buffers;
> +
> +	return 0;
> +
> +out:
> +	/* flush s_error_work before journal destroy. */
> +	flush_work(&sbi->s_error_work);
> +	jbd2_journal_destroy(sbi->s_journal);
> +	sbi->s_journal = NULL;
> +	return err;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh;
> @@ -5182,7 +5269,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	 * root first: it may be modified in the journal!
>  	 */
>  	if (!test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb)) {
> -		err = ext4_load_journal(sb, es, ctx->journal_devnum);
> +		err = ext4_load_and_init_journal(sb, es, ctx);
>  		if (err)
>  			goto failed_mount3a;
>  	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
> @@ -5220,76 +5307,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		clear_opt2(sb, JOURNAL_FAST_COMMIT);
>  		sbi->s_journal = NULL;
>  		needs_recovery = 0;
> -		goto no_journal;
>  	}
>  
> -	if (ext4_has_feature_64bit(sb) &&
> -	    !jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
> -				       JBD2_FEATURE_INCOMPAT_64BIT)) {
> -		ext4_msg(sb, KERN_ERR, "Failed to set 64-bit journal feature");
> -		goto failed_mount_wq;
> -	}
> -
> -	if (!set_journal_csum_feature_set(sb)) {
> -		ext4_msg(sb, KERN_ERR, "Failed to set journal checksum "
> -			 "feature set");
> -		goto failed_mount_wq;
> -	}
> -
> -	if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
> -		!jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
> -					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT)) {
> -		ext4_msg(sb, KERN_ERR,
> -			"Failed to set fast commit journal feature");
> -		goto failed_mount_wq;
> -	}
> -
> -	/* We have now updated the journal if required, so we can
> -	 * validate the data journaling mode. */
> -	switch (test_opt(sb, DATA_FLAGS)) {
> -	case 0:
> -		/* No mode set, assume a default based on the journal
> -		 * capabilities: ORDERED_DATA if the journal can
> -		 * cope, else JOURNAL_DATA
> -		 */
> -		if (jbd2_journal_check_available_features
> -		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
> -			set_opt(sb, ORDERED_DATA);
> -			sbi->s_def_mount_opt |= EXT4_MOUNT_ORDERED_DATA;
> -		} else {
> -			set_opt(sb, JOURNAL_DATA);
> -			sbi->s_def_mount_opt |= EXT4_MOUNT_JOURNAL_DATA;
> -		}
> -		break;
> -
> -	case EXT4_MOUNT_ORDERED_DATA:
> -	case EXT4_MOUNT_WRITEBACK_DATA:
> -		if (!jbd2_journal_check_available_features
> -		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
> -			ext4_msg(sb, KERN_ERR, "Journal does not support "
> -			       "requested data journaling mode");
> -			goto failed_mount_wq;
> -		}
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA &&
> -	    test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
> -		ext4_msg(sb, KERN_ERR, "can't mount with "
> -			"journal_async_commit in data=ordered mode");
> -		goto failed_mount_wq;
> -	}
> -
> -	set_task_ioprio(sbi->s_journal->j_task, ctx->journal_ioprio);
> -
> -	sbi->s_journal->j_submit_inode_data_buffers =
> -		ext4_journal_submit_inode_data_buffers;
> -	sbi->s_journal->j_finish_inode_data_buffers =
> -		ext4_journal_finish_inode_data_buffers;
> -
> -no_journal:
>  	if (!test_opt(sb, NO_MBCACHE)) {
>  		sbi->s_ea_block_cache = ext4_xattr_create_cache();
>  		if (!sbi->s_ea_block_cache) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
