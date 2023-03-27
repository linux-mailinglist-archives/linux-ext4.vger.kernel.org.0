Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150D56C9F3E
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 11:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC0JV7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 05:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjC0JV6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 05:21:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A6A4218;
        Mon, 27 Mar 2023 02:21:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C820821C8C;
        Mon, 27 Mar 2023 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679908906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+9goiW+ZfCMempnHXl1UBmZS82+VSCPvk8oB6SF3SE=;
        b=u69/M1sS1th1mCAeaavPJqM+jkFCpvv9CbeAqyag7QqbPj5InzlD1XBUFSUJy6Ewqd1XRh
        VrysN8ORWpGSMiS3p9/ulOY4iM0Mt3KrEM7bOkshjzxmFIqaU/u+xcZGOSZJYFBp/ENh/R
        g3oVTQygHn2ro59D10u4ScdWhL2OFek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679908906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+9goiW+ZfCMempnHXl1UBmZS82+VSCPvk8oB6SF3SE=;
        b=TWkO+0jz1G8yqq7TCtxMsuFxdmgjo1MF2ihxaw31ajOnVi3P1L2+LoDiGpo6wS0TTAcFK5
        s3SHyiCrLjq6COCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA0A313482;
        Mon, 27 Mar 2023 09:21:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qFZkLSpgIWRGYgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Mar 2023 09:21:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3DE69A071C; Mon, 27 Mar 2023 11:21:46 +0200 (CEST)
Date:   Mon, 27 Mar 2023 11:21:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 2/2] ext4: refactoring to use the unified helper
 ext4_quotas_off()
Message-ID: <20230327092146.z3zllmhry7zjca4d@quack3>
References: <20230327022703.576857-1-libaokun1@huawei.com>
 <20230327022703.576857-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327022703.576857-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 27-03-23 10:27:03, Baokun Li wrote:
> Rename ext4_quota_off_umount() to ext4_quotas_off(), and add type
> parameter to replace open code in ext4_enable_quotas().
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1->V2:
> 	Adapting to the changes in PATCH 1/2.
> 
>  fs/ext4/super.c | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bd1ca1c3022e..59c5dd4dbe5a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1157,12 +1157,12 @@ static void dump_orphan_list(struct super_block *sb, struct ext4_sb_info *sbi)
>  #ifdef CONFIG_QUOTA
>  static int ext4_quota_off(struct super_block *sb, int type);
>  
> -static inline void ext4_quota_off_umount(struct super_block *sb)
> +static inline void ext4_quotas_off(struct super_block *sb, int type)
>  {
> -	int type;
> +	BUG_ON(type > EXT4_MAXQUOTAS);
>  
>  	/* Use our quota_off function to clear inode flags etc. */
> -	for (type = 0; type < EXT4_MAXQUOTAS; type++)
> +	for (type--; type >= 0; type--)
>  		ext4_quota_off(sb, type);
>  }
>  
> @@ -1178,7 +1178,7 @@ static inline char *get_qf_name(struct super_block *sb,
>  					 lockdep_is_held(&sb->s_umount));
>  }
>  #else
> -static inline void ext4_quota_off_umount(struct super_block *sb)
> +static inline void ext4_quotas_off(struct super_block *sb, int type)
>  {
>  }
>  #endif
> @@ -1209,7 +1209,7 @@ static void ext4_put_super(struct super_block *sb)
>  			 &sb->s_uuid);
>  
>  	ext4_unregister_li_request(sb);
> -	ext4_quota_off_umount(sb);
> +	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
>  
>  	flush_work(&sbi->s_error_work);
>  	destroy_workqueue(sbi->rsv_conversion_wq);
> @@ -5541,7 +5541,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  failed_mount10:
>  #ifdef CONFIG_QUOTA
> -	ext4_quota_off_umount(sb);
> +	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
>  failed_mount9:
>  #endif  /* CONFIG_QUOTA */
>  	ext4_release_orphan_info(sb);
> @@ -7014,20 +7014,8 @@ int ext4_enable_quotas(struct super_block *sb)
>  					"(type=%d, err=%d, ino=%lu). "
>  					"Please run e2fsck to fix.", type,
>  					err, qf_inums[type]);
> -				for (type--; type >= 0; type--) {
> -					struct inode *inode;
> -
> -					inode = sb_dqopt(sb)->files[type];
> -					if (inode)
> -						inode = igrab(inode);
> -					dquot_quota_off(sb, type);
> -					if (inode) {
> -						lockdep_set_quota_inode(inode,
> -							I_DATA_SEM_NORMAL);
> -						iput(inode);
> -					}
> -				}
>  
> +				ext4_quotas_off(sb, type);
>  				return err;
>  			}
>  		}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
