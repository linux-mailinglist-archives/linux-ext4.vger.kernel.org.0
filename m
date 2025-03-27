Return-Path: <linux-ext4+bounces-6992-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944DDA72E6A
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 12:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72E33B605F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EEA20FA91;
	Thu, 27 Mar 2025 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gbZDG9RS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ONHwBw2m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gbZDG9RS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ONHwBw2m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909361C5F0C
	for <linux-ext4@vger.kernel.org>; Thu, 27 Mar 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073482; cv=none; b=WESpjuRTDzFt850x9tfoF1dqTT0AO5pXBPUpTbzzfSLK6bxMeubXN22wBzKVuU2scwfCgTtt+1UGvFl3duVVyMRDeFTJIHLx0riEYsMOXN8aF2XTl48g8JrYnwcPgTf9JtKblEMz6wKBT5kM4DDbnWXKzHgVfgTmI3HYMmUmuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073482; c=relaxed/simple;
	bh=pTzcdMX2gKKmeQ7EjG7dR7gGzZ3E2KhEcNsyUbHHs1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmJNHMNt+Rl3rnDlmDiwpjjLqoHyBdi43eByq/OlUvR0G0V5WYZQnp3Wh0XobIIdcQ/TbQzOB8sZPX9c+eLjFpfbsV7v05j44XDY0WABifiDd0SHTcZ+70u1xX96a8lGKLPwcv2l+w7zIkypPiVAGqoUQYWDcbc8om/LfFJXhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gbZDG9RS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ONHwBw2m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gbZDG9RS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ONHwBw2m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6B5B210F9;
	Thu, 27 Mar 2025 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743073478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F2hRXtlJSPaFBXmmZEjPBl/lgNeemTaLhpMFN3k2MTo=;
	b=gbZDG9RSDzJlvTQksk+5MiYyDOyVEi/4LrjhZtw+XcYbk7FOdi1nMsdOv7BEgK8KDDXwwT
	ip757sKdbJX20sdHewxl4vI4vHa0DhSC33UZSHHjhuCpC4DuIXMBZtE1QTguA1dPJEE6ft
	R9j7tuFsePZdZ/khHzrrIVre/+4pBYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743073478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F2hRXtlJSPaFBXmmZEjPBl/lgNeemTaLhpMFN3k2MTo=;
	b=ONHwBw2myu3wRE8gy7esgAadSF2g8isgfN1qv5skPJSsrGJ6ULUSkJW2UCh+ozgNmhedVw
	yb7kz3Qn1c29EfAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743073478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F2hRXtlJSPaFBXmmZEjPBl/lgNeemTaLhpMFN3k2MTo=;
	b=gbZDG9RSDzJlvTQksk+5MiYyDOyVEi/4LrjhZtw+XcYbk7FOdi1nMsdOv7BEgK8KDDXwwT
	ip757sKdbJX20sdHewxl4vI4vHa0DhSC33UZSHHjhuCpC4DuIXMBZtE1QTguA1dPJEE6ft
	R9j7tuFsePZdZ/khHzrrIVre/+4pBYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743073478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F2hRXtlJSPaFBXmmZEjPBl/lgNeemTaLhpMFN3k2MTo=;
	b=ONHwBw2myu3wRE8gy7esgAadSF2g8isgfN1qv5skPJSsrGJ6ULUSkJW2UCh+ozgNmhedVw
	yb7kz3Qn1c29EfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A47B1376E;
	Thu, 27 Mar 2025 11:04:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q2aoJcYw5WfwIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Mar 2025 11:04:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 42985A082A; Thu, 27 Mar 2025 12:04:38 +0100 (CET)
Date: Thu, 27 Mar 2025 12:04:38 +0100
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jann Horn <jannh@google.com>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: don't treat fhandle lookup of ea_inode as FS
 corruption
Message-ID: <auitbbb56g2mpb52irzcfh3qfob3qjot3326qpigdvhw7wyw6b@p624krjopkc7>
References: <20241129-ext4-ignore-ea-fhandle-v1-1-e532c0d1cee0@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-ext4-ignore-ea-fhandle-v1-1-e532c0d1cee0@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hi Ted!

was this fix missed?

On Fri 29-11-24 21:20:53, Jann Horn wrote:
> A file handle that userspace provides to open_by_handle_at() can
> legitimately contain an outdated inode number that has since been reused
> for another purpose - that's why the file handle also contains a generation
> number.
> 
> But if the inode number has been reused for an ea_inode, check_igot_inode()
> will notice, __ext4_iget() will go through ext4_error_inode(), and if the
> inode was newly created, it will also be marked as bad by iget_failed().
> This all happens before the point where the inode generation is checked.
> 
> ext4_error_inode() is supposed to only be used on filesystem corruption; it
> should not be used when userspace just got unlucky with a stale file
> handle. So when this happens, let __ext4_iget() just return an error.
> 
> Fixes: b3e6bcb94590 ("ext4: add EA_INODE checking to ext4_iget()")
> Signed-off-by: Jann Horn <jannh@google.com>

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> I'm sending this as an RFC patch because the patch I came up with is
> pretty ugly; I think it would be ideal if someone else comes up with a
> nicer patch that can be used instead of this one.  I'm also not sure
> whether it actually matters if we call iget_failed() when this happens
> with a new inode.
> 
> The following testcase demonstrates this issue, and shows that a filesystem
> mounted with errors=remount-ro is remounted to read-only when hitting it.
> Run this as root.
> 
> ```
> #define _GNU_SOURCE
> #include <err.h>
> #include <stdarg.h>
> #include <stdio.h>
> #include <sched.h>
> #include <stddef.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <string.h>
> #include <stdlib.h>
> #include <sys/mount.h>
> #include <sys/mman.h>
> #include <sys/xattr.h>
> #include <sys/stat.h>
> 
> #define SYSCHK(x) ({          \
>   typeof(x) __res = (x);      \
>   if (__res == (typeof(x))-1) \
>     err(1, "SYSCHK(" #x ")"); \
>   __res;                      \
> })
> 
> static int systemf(const char *cmd, ...) {
>   char *full_cmd;
>   va_list ap;
>   va_start(ap, cmd);
>   if (vasprintf(&full_cmd, cmd, ap) == -1)
>     err(1, "vasprintf");
>   int res = system(full_cmd);
>   free(full_cmd);
>   return res;
> }
> 
> int main(void) {
>   // avoid messing with the main mount hierarchy
>   SYSCHK(unshare(CLONE_NEWNS));
>   SYSCHK(mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL));
> 
>   // create and mount new ext4 fs
>   int fs_fd = SYSCHK(memfd_create("ext4-image", 0));
>   SYSCHK(ftruncate(fs_fd, 1024*1024));
>   if (systemf("mkfs.ext4 -O ea_inode /proc/self/fd/%d", fs_fd))
>     errx(1, "mkfs failed");
>   if (systemf("mount -o errors=remount-ro -t ext4 /proc/self/fd/%d /mnt", fs_fd))
>     errx(1, "mount failed");
> 
>   // create file with inode xattr
>   char xattr_body[8192];
>   memset(xattr_body, 'A', sizeof(xattr_body));
>   int file_fd = SYSCHK(open("/mnt/file", O_RDWR|O_CREAT, 0600));
>   SYSCHK(fsetxattr(file_fd, "user.foo", xattr_body, sizeof(xattr_body), XATTR_CREATE));
>   struct stat st;
>   SYSCHK(fstat(file_fd, &st));
> 
>   // trigger bug: do fhandle lookup on inode of file plus one (which will be
>   // the xattr inode)
>   struct handle {
>     unsigned int handle_bytes;
>     unsigned int handle_type;
>     unsigned int ino, gen, parent_ino, parent_gen;
>   } handle = {
>     .handle_bytes = sizeof(handle) - offsetof(struct handle, ino),
>     .handle_type = 1/*FILEID_INO32_GEN*/,
>     .ino = st.st_ino+1,
>     .gen = 0
>   };
>   // this should fail
>   SYSCHK(open_by_handle_at(file_fd, (void*)&handle, O_RDONLY));
> }
> ```
> 
> resulting dmesg:
> ```
> EXT4-fs (loop0): mounted filesystem 13b7e98f-901a-41a4-ba59-4cc58d597798 r/w without journal. Quota mode: none.
> EXT4-fs error (device loop0): ext4_nfs_get_inode:1545: inode #13: comm ext4-ea-inode-f: unexpected EA_INODE flag
> EXT4-fs (loop0): Remounting filesystem read-only
> EXT4-fs (loop0): unmounting filesystem 13b7e98f-901a-41a4-ba59-4cc58d597798.
> ```
> ---
>  fs/ext4/inode.c | 68 ++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 89aade6f45f62d9fd6300ef84c118c6b919cddc9..8a8cc29b211c875a1d22b943004dc3f10b9c4d79 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4705,22 +4705,43 @@ static inline void ext4_inode_set_iversion_queried(struct inode *inode, u64 val)
>  		inode_set_iversion_queried(inode, val);
>  }
>  
> -static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
> -
> +static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
> +			    const char *function, unsigned int line)
>  {
> +	const char *err_str;
> +
>  	if (flags & EXT4_IGET_EA_INODE) {
> -		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
> -			return "missing EA_INODE flag";
> +		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
> +			err_str = "missing EA_INODE flag";
> +			goto error;
> +		}
>  		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
> -		    EXT4_I(inode)->i_file_acl)
> -			return "ea_inode with extended attributes";
> +		    EXT4_I(inode)->i_file_acl) {
> +			err_str = "ea_inode with extended attributes";
> +			goto error;
> +		}
>  	} else {
> -		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
> -			return "unexpected EA_INODE flag";
> +		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
> +			/*
> +			 * open_by_handle_at() could provide an old inode number
> +			 * that has since been reused for an ea_inode; this does
> +			 * not indicate filesystem corruption
> +			 */
> +			if (flags & EXT4_IGET_HANDLE)
> +				return -ESTALE;
> +			err_str = "unexpected EA_INODE flag";
> +			goto error;
> +		}
> +	}
> +	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
> +		err_str = "unexpected bad inode w/o EXT4_IGET_BAD";
> +		goto error;
>  	}
> -	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD))
> -		return "unexpected bad inode w/o EXT4_IGET_BAD";
> -	return NULL;
> +	return 0;
> +
> +error:
> +	ext4_error_inode(inode, function, line, 0, err_str);
> +	return -EFSCORRUPTED;
>  }
>  
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> @@ -4732,7 +4753,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	struct ext4_inode_info *ei;
>  	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
>  	struct inode *inode;
> -	const char *err_str;
>  	journal_t *journal = EXT4_SB(sb)->s_journal;
>  	long ret;
>  	loff_t size;
> @@ -4761,10 +4781,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  	if (!(inode->i_state & I_NEW)) {
> -		if ((err_str = check_igot_inode(inode, flags)) != NULL) {
> -			ext4_error_inode(inode, function, line, 0, err_str);
> +		ret = check_igot_inode(inode, flags, function, line);
> +		if (ret) {
>  			iput(inode);
> -			return ERR_PTR(-EFSCORRUPTED);
> +			return ERR_PTR(ret);
>  		}
>  		return inode;
>  	}
> @@ -5036,13 +5056,21 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		ret = -EFSCORRUPTED;
>  		goto bad_inode;
>  	}
> -	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
> -		ext4_error_inode(inode, function, line, 0, err_str);
> -		ret = -EFSCORRUPTED;
> -		goto bad_inode;
> +	ret = check_igot_inode(inode, flags, function, line);
> +	/*
> +	 * -ESTALE here means there is nothing inherently wrong with the inode,
> +	 * it's just not an inode we can return for an fhandle lookup.
> +	 */
> +	if (ret == -ESTALE) {
> +		brelse(iloc.bh);
> +		unlock_new_inode(inode);
> +		iput(inode);
> +		return ERR_PTR(-ESTALE);
>  	}
> -
> +	if (ret)
> +		goto bad_inode;
>  	brelse(iloc.bh);
> +
>  	unlock_new_inode(inode);
>  	return inode;
>  
> 
> ---
> base-commit: b86545e02e8c22fb89218f29d381fa8e8b91d815
> change-id: 20241129-ext4-ignore-ea-fhandle-743d3723c5e9
> 
> -- 
> Jann Horn <jannh@google.com>
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

