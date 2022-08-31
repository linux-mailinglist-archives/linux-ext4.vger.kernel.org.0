Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D05C5A7C87
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiHaLwr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 07:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiHaLwo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 07:52:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203FBD25F3
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 04:52:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70BA422197;
        Wed, 31 Aug 2022 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661946760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tc74wLhqrVOPdqT0/HRKQhhoBmYHKgwESZLkcq/31zw=;
        b=Zi7YCtZ24cJSPRd3/Px3GZxHTcA9sb91SO4uIln5XdaZAtWi5Ti6az5Yut9XL0qrWIv++P
        KxA91av44huRQtz9F+JheEpwO0g/cUdynurgtITFlBakdYpBzGeRYrDk5YoY0Zr0BwPxL4
        XfQgn0/w8bUFHpWt489aSQquestU35o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661946760;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tc74wLhqrVOPdqT0/HRKQhhoBmYHKgwESZLkcq/31zw=;
        b=WbBXqjsD/MHio/Zq2O7WrO2WB3uCZh+RIXasM4rbAacgohk7RTQpa/SMvQePSV7JSKv/uz
        XDZRcm8PtUTuHJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49BA61332D;
        Wed, 31 Aug 2022 11:52:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ngn+EYhLD2M6CgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:52:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 471BBA067B; Wed, 31 Aug 2022 13:52:39 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:52:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, lczerner@redhat.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 08/13] ext4: factor out ext4_handle_csum()
Message-ID: <20220831115239.g4br24j2fi4e2k4x@quack3>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-9-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830120411.2371968-9-yanaijie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 30-08-22 20:04:06, Jason Yan wrote:
> Factor out ext4_handle_csum(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  fs/ext4/super.c | 83 +++++++++++++++++++++++++++----------------------
>  1 file changed, 46 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9ee27472b802..96cf23787bba 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4563,6 +4563,50 @@ static int ext4_encoding_init(struct super_block *sb, struct ext4_super_block *e
>  	return 0;
>  }
>  
> +static int ext4_handle_csum(struct super_block *sb, struct ext4_super_block *es)

I'd rather call this function like ext4_init_metadata_csum().
ext4_handle_csum() seems to vague to me.

Otherwise the patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	/* Warn if metadata_csum and gdt_csum are both set. */
> +	if (ext4_has_feature_metadata_csum(sb) &&
> +	    ext4_has_feature_gdt_csum(sb))
> +		ext4_warning(sb, "metadata_csum and uninit_bg are "
> +			     "redundant flags; please run fsck.");
> +
> +	/* Check for a known checksum algorithm */
> +	if (!ext4_verify_csum_type(sb, es)) {
> +		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
> +			 "unknown checksum algorithm.");
> +		return -EINVAL;
> +	}
> +	ext4_setup_csum_trigger(sb, EXT4_JTR_ORPHAN_FILE,
> +				ext4_orphan_file_block_trigger);
> +
> +	/* Load the checksum driver */
> +	sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
> +	if (IS_ERR(sbi->s_chksum_driver)) {
> +		int ret = PTR_ERR(sbi->s_chksum_driver);
> +		ext4_msg(sb, KERN_ERR, "Cannot load crc32c driver.");
> +		sbi->s_chksum_driver = NULL;
> +		return ret;
> +	}
> +
> +	/* Check superblock checksum */
> +	if (!ext4_superblock_csum_verify(sb, es)) {
> +		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
> +			 "invalid superblock checksum.  Run e2fsck?");
> +		return -EFSBADCRC;
> +	}
> +
> +	/* Precompute checksum seed for all metadata */
> +	if (ext4_has_feature_csum_seed(sb))
> +		sbi->s_csum_seed = le32_to_cpu(es->s_checksum_seed);
> +	else if (ext4_has_metadata_csum(sb) || ext4_has_feature_ea_inode(sb))
> +		sbi->s_csum_seed = ext4_chksum(sbi, ~0, es->s_uuid,
> +					       sizeof(es->s_uuid));
> +	return 0;
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct buffer_head *bh, **group_desc;
> @@ -4632,44 +4676,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	sbi->s_kbytes_written = le64_to_cpu(es->s_kbytes_written);
>  
> -	/* Warn if metadata_csum and gdt_csum are both set. */
> -	if (ext4_has_feature_metadata_csum(sb) &&
> -	    ext4_has_feature_gdt_csum(sb))
> -		ext4_warning(sb, "metadata_csum and uninit_bg are "
> -			     "redundant flags; please run fsck.");
> -
> -	/* Check for a known checksum algorithm */
> -	if (!ext4_verify_csum_type(sb, es)) {
> -		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
> -			 "unknown checksum algorithm.");
> -		goto failed_mount;
> -	}
> -	ext4_setup_csum_trigger(sb, EXT4_JTR_ORPHAN_FILE,
> -				ext4_orphan_file_block_trigger);
> -
> -	/* Load the checksum driver */
> -	sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
> -	if (IS_ERR(sbi->s_chksum_driver)) {
> -		ext4_msg(sb, KERN_ERR, "Cannot load crc32c driver.");
> -		ret = PTR_ERR(sbi->s_chksum_driver);
> -		sbi->s_chksum_driver = NULL;
> -		goto failed_mount;
> -	}
> -
> -	/* Check superblock checksum */
> -	if (!ext4_superblock_csum_verify(sb, es)) {
> -		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
> -			 "invalid superblock checksum.  Run e2fsck?");
> -		ret = -EFSBADCRC;
> +	err = ext4_handle_csum(sb, es);
> +	if (err)
>  		goto failed_mount;
> -	}
> -
> -	/* Precompute checksum seed for all metadata */
> -	if (ext4_has_feature_csum_seed(sb))
> -		sbi->s_csum_seed = le32_to_cpu(es->s_checksum_seed);
> -	else if (ext4_has_metadata_csum(sb) || ext4_has_feature_ea_inode(sb))
> -		sbi->s_csum_seed = ext4_chksum(sbi, ~0, es->s_uuid,
> -					       sizeof(es->s_uuid));
>  
>  	ext4_set_def_opts(sb, es);
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
