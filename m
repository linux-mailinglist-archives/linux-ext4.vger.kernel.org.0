Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350C77BFD00
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Oct 2023 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjJJNLb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Oct 2023 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjJJNL3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Oct 2023 09:11:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9A4AC;
        Tue, 10 Oct 2023 06:11:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1D9821835;
        Tue, 10 Oct 2023 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696943486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcnlPdXPp8TEZItcZ/fLRAEfXrmV/4GaCHnIViuZCTA=;
        b=C/wakAH4lemrhHu3dIC3LUtIoy/4S/UlQUABM9ptLGmxKpW1IE9kYco9vDmkp2gbZNr9B7
        EmD54OO+2et7g38dq3yeWvw9TLUVU9yJqZygW9LJpIKcahptzeyM9MLP1fAblgiyTyg7u5
        6R6CR4/rQP/WBlV2knXyqoOY7O5DmkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696943486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcnlPdXPp8TEZItcZ/fLRAEfXrmV/4GaCHnIViuZCTA=;
        b=AGkrC0RoW+lXLQy4ntRnDXvQCf2jvkdPTYmPpInT4rb0FwGZZ2TRu7EG+jQIkHaAPfobmo
        4PWHJif4CsnmnRDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4D5D1358F;
        Tue, 10 Oct 2023 13:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R4reN31NJWVGYQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 10 Oct 2023 13:11:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 818B6A061C; Tue, 10 Oct 2023 15:11:25 +0200 (CEST)
Date:   Tue, 10 Oct 2023 15:11:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231010131125.3uyfkqbcetfcqsve@quack3>
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009144340.418904-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 09-10-23 16:43:39, Max Kellermann wrote:
> One important implementation detail of the posix_acl_create() function
> is that it applies the umask to the "mode" parameter.  If
> CONFIG_FS_POSIX_ACL is disabled, this detail is missing and the umask
> may not get applied.
> 
> This patch adds the missing code to posix_acl_create() and to three
> filesystems that omit the posix_acl_create() call if their individual
> ACL support is disabled (CONFIG_EXT2_FS_POSIX_ACL,
> CONFIG_JFS_POSIX_ACL, CONFIG_CEPH_FS_POSIX_ACL).  If
> posix_acl_create() never gets called, the umask needs to be applied
> anyway.
> 
> This bug used to be exploitable easily with O_TMPFILE (see
> https://bugzilla.kernel.org/show_bug.cgi?id=203625) but that part was
> fixed by commit ac6800e279a2 ("fs: Add missing umask strip in
> vfs_tmpfile") last year.  The bug may not be reachable by userspace
> anymore, but since it is apparently still necessary to apply the umask
> again in posix_acl_create(), there is no reason to assume it's not
> necessary with ACL support is disabled.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Thanks for the updated changelog! But as I'm looking into VFS code isn't
this already handled by mode_strip_umask() / vfs_prepare_mode() in
fs/namei.c? Because posix_acl_create() doesn't do anything to 'mode' for
!IS_POSIXACL() filesystems either. So at least ext2 (where I've checked
the mount option handling) does seem to have umask properly applied in all
the cases. But I might be missing something...

								Honza

> ---
>  fs/ceph/super.h           | 6 ++++++
>  fs/ext2/acl.h             | 6 ++++++
>  fs/jfs/jfs_acl.h          | 6 ++++++
>  include/linux/posix_acl.h | 1 +
>  4 files changed, 19 insertions(+)
> 
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 51c7f2b14f6f..58349639bd57 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1194,6 +1194,12 @@ static inline void ceph_forget_all_cached_acls(struct inode *inode)
>  static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
>  				     struct ceph_acl_sec_ctx *as_ctx)
>  {
> +	/* usually, the umask is applied by posix_acl_create(), but if
> +	 * ACL support is disabled at compile time, we need to do it
> +	 * here, because posix_acl_create() will never be called
> +	 */
> +	*mode &= ~current_umask();
> +
>  	return 0;
>  }
>  static inline void ceph_init_inode_acls(struct inode *inode,
> diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
> index 4a8443a2b8ec..0ecaa9c20c0c 100644
> --- a/fs/ext2/acl.h
> +++ b/fs/ext2/acl.h
> @@ -67,6 +67,12 @@ extern int ext2_init_acl (struct inode *, struct inode *);
>  
>  static inline int ext2_init_acl (struct inode *inode, struct inode *dir)
>  {
> +	/* usually, the umask is applied by posix_acl_create(), but if
> +	 * ACL support is disabled at compile time, we need to do it
> +	 * here, because posix_acl_create() will never be called
> +	 */
> +	inode->i_mode &= ~current_umask();
> +
>  	return 0;
>  }
>  #endif
> diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
> index f892e54d0fcd..64a05e663a45 100644
> --- a/fs/jfs/jfs_acl.h
> +++ b/fs/jfs/jfs_acl.h
> @@ -17,6 +17,12 @@ int jfs_init_acl(tid_t, struct inode *, struct inode *);
>  static inline int jfs_init_acl(tid_t tid, struct inode *inode,
>  			       struct inode *dir)
>  {
> +	/* usually, the umask is applied by posix_acl_create(), but if
> +	 * ACL support is disabled at compile time, we need to do it
> +	 * here, because posix_acl_create() will never be called
> +	 */
> +	inode->i_mode &= ~current_umask();
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 0e65b3d634d9..54bc9b1061ca 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -128,6 +128,7 @@ static inline void cache_no_acl(struct inode *inode)
>  static inline int posix_acl_create(struct inode *inode, umode_t *mode,
>  		struct posix_acl **default_acl, struct posix_acl **acl)
>  {
> +	*mode &= ~current_umask();
>  	*default_acl = *acl = NULL;
>  	return 0;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
