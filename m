Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C35A7C71
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiHaLt3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHaLt2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:49:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30280C12D4
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:49:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE57721B14;
        Wed, 31 Aug 2022 11:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661946565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYkpTAfuMbzu1rPeNlB5vmQ9hadafOIDv8FWSRQoIw0=;
        b=wV9ql0iRaRpUyIX99ag3eZktwTn/ladodVuP89uXW8bqFXias/vlbWr+P8bHw1SgK4wPMg
        HDNkpyHru6BIQt2smqfLFPd2N/yUf9tFC6xpe5TtCTpsVnEFGKuWJbghlMe1t8+p3L7YD0
        bSuWCrYGJDdFXT5J+i7mG2ALi1gr4sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661946565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYkpTAfuMbzu1rPeNlB5vmQ9hadafOIDv8FWSRQoIw0=;
        b=jyZY1+JEMxhLGCvnnfJNxxi0C/3CZQ9XGdFgka8CotKmkHZz2oAC62LPRQmQ0i0dhA3yz8
        XKTv1IlhIYQ1SGAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFAC21332D;
        Wed, 31 Aug 2022 11:49:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AFKxMsVKD2O2CAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:49:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67BCEA067B; Wed, 31 Aug 2022 13:49:25 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:49:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/13] ext4: factor out ext4_inode_info_init()
Message-ID: <20220831114925.5koqvcmefikcdhnx@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-7-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-7-yanaijie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:04, Jason Yan wrote:
> Factor out ext4_inode_info_init(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 137 ++++++++++++++++++++++++++----------------------
>  1 file changed, 75 insertions(+), 62 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d355eda2f184..458d146149b2 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4448,6 +4448,79 @@ static void ext4_fast_commit_init(struct super_block *sb)
>  	sbi->s_fc_replay_state.fc_modified_inodes_used = 0;
>  }
>  
> +static int ext4_inode_info_init(struct super_block *sb,
> +				struct ext4_super_block *es,
> +				int blocksize)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV) {
> +		sbi->s_inode_size = EXT4_GOOD_OLD_INODE_SIZE;
> +		sbi->s_first_ino = EXT4_GOOD_OLD_FIRST_INO;
> +	} else {
> +		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
> +		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
> +		if (sbi->s_first_ino < EXT4_GOOD_OLD_FIRST_INO) {
> +			ext4_msg(sb, KERN_ERR, "invalid first ino: %u",
> +				 sbi->s_first_ino);
> +			return -EINVAL;
> +		}
> +		if ((sbi->s_inode_size < EXT4_GOOD_OLD_INODE_SIZE) ||
> +		    (!is_power_of_2(sbi->s_inode_size)) ||
> +		    (sbi->s_inode_size > blocksize)) {
> +			ext4_msg(sb, KERN_ERR,
> +			       "unsupported inode size: %d",
> +			       sbi->s_inode_size);
> +			ext4_msg(sb, KERN_ERR, "blocksize: %d", blocksize);
> +			return -EINVAL;
> +		}
> +		/*
> +		 * i_atime_extra is the last extra field available for
> +		 * [acm]times in struct ext4_inode. Checking for that
> +		 * field should suffice to ensure we have extra space
> +		 * for all three.
> +		 */
> +		if (sbi->s_inode_size >= offsetof(struct ext4_inode, i_atime_extra) +
> +			sizeof(((struct ext4_inode *)0)->i_atime_extra)) {
> +			sb->s_time_gran = 1;
> +			sb->s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
> +		} else {
> +			sb->s_time_gran = NSEC_PER_SEC;
> +			sb->s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
> +		}
> +		sb->s_time_min = EXT4_TIMESTAMP_MIN;
> +	}
> +
> +	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE) {
> +		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
> +			EXT4_GOOD_OLD_INODE_SIZE;
> +		if (ext4_has_feature_extra_isize(sb)) {
> +			unsigned v, max = (sbi->s_inode_size -
> +					   EXT4_GOOD_OLD_INODE_SIZE);
> +
> +			v = le16_to_cpu(es->s_want_extra_isize);
> +			if (v > max) {
> +				ext4_msg(sb, KERN_ERR,
> +					 "bad s_want_extra_isize: %d", v);
> +				return -EINVAL;
> +			}
> +			if (sbi->s_want_extra_isize < v)
> +				sbi->s_want_extra_isize = v;
> +
> +			v = le16_to_cpu(es->s_min_extra_isize);
> +			if (v > max) {
> +				ext4_msg(sb, KERN_ERR,
> +					 "bad s_min_extra_isize: %d", v);
> +				return -EINVAL;
> +			}
> +			if (sbi->s_want_extra_isize < v)
> +				sbi->s_want_extra_isize = v;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh, **group_desc;
> @@ -4590,68 +4663,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	if (blocksize == PAGE_SIZE)
>  		set_opt(sb, DIOREAD_NOLOCK);
>  
> -	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV) {
> -		sbi->s_inode_size = EXT4_GOOD_OLD_INODE_SIZE;
> -		sbi->s_first_ino = EXT4_GOOD_OLD_FIRST_INO;
> -	} else {
> -		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
> -		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
> -		if (sbi->s_first_ino < EXT4_GOOD_OLD_FIRST_INO) {
> -			ext4_msg(sb, KERN_ERR, "invalid first ino: %u",
> -				 sbi->s_first_ino);
> -			goto failed_mount;
> -		}
> -		if ((sbi->s_inode_size < EXT4_GOOD_OLD_INODE_SIZE) ||
> -		    (!is_power_of_2(sbi->s_inode_size)) ||
> -		    (sbi->s_inode_size > blocksize)) {
> -			ext4_msg(sb, KERN_ERR,
> -			       "unsupported inode size: %d",
> -			       sbi->s_inode_size);
> -			ext4_msg(sb, KERN_ERR, "blocksize: %d", blocksize);
> -			goto failed_mount;
> -		}
> -		/*
> -		 * i_atime_extra is the last extra field available for
> -		 * [acm]times in struct ext4_inode. Checking for that
> -		 * field should suffice to ensure we have extra space
> -		 * for all three.
> -		 */
> -		if (sbi->s_inode_size >= offsetof(struct ext4_inode, i_atime_extra) +
> -			sizeof(((struct ext4_inode *)0)->i_atime_extra)) {
> -			sb->s_time_gran = 1;
> -			sb->s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
> -		} else {
> -			sb->s_time_gran = NSEC_PER_SEC;
> -			sb->s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
> -		}
> -		sb->s_time_min = EXT4_TIMESTAMP_MIN;
> -	}
> -	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE) {
> -		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
> -			EXT4_GOOD_OLD_INODE_SIZE;
> -		if (ext4_has_feature_extra_isize(sb)) {
> -			unsigned v, max = (sbi->s_inode_size -
> -					   EXT4_GOOD_OLD_INODE_SIZE);
> -
> -			v = le16_to_cpu(es->s_want_extra_isize);
> -			if (v > max) {
> -				ext4_msg(sb, KERN_ERR,
> -					 "bad s_want_extra_isize: %d", v);
> -				goto failed_mount;
> -			}
> -			if (sbi->s_want_extra_isize < v)
> -				sbi->s_want_extra_isize = v;
> -
> -			v = le16_to_cpu(es->s_min_extra_isize);
> -			if (v > max) {
> -				ext4_msg(sb, KERN_ERR,
> -					 "bad s_min_extra_isize: %d", v);
> -				goto failed_mount;
> -			}
> -			if (sbi->s_want_extra_isize < v)
> -				sbi->s_want_extra_isize = v;
> -		}
> -	}
> +	if (ext4_inode_info_init(sb, es, blocksize))
> +		goto failed_mount;
>  
>  	err = parse_apply_sb_mount_options(sb, ctx);
>  	if (err < 0)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
