Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14FD462290
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Nov 2021 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhK2Uz0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Nov 2021 15:55:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231759AbhK2Ux0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Nov 2021 15:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638219007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fehrAXIWDS+JK6bB9goiBRH/WsWW4Tx2eVhu6pJSueg=;
        b=ThzlhG6aZFSm+q218oKQcMMHqQngDKFpnSPJYrU3nSZ2kyU8kAE+I4HVgqB3lOGXEe916r
        Le30J1E2Cb8xJ5pBhi7Yc7AFgvuBplPdqx313Hxxki+nKpFS0WSOqdD6u3zrfrR9ZREmW0
        vm94WT0hS4egGmrj7VwB5cePPIP2dIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-2WP1rfzcOu-rvSEKvQoXNg-1; Mon, 29 Nov 2021 15:50:04 -0500
X-MC-Unique: 2WP1rfzcOu-rvSEKvQoXNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C088E190A7A0;
        Mon, 29 Nov 2021 20:50:02 +0000 (UTC)
Received: from work (unknown [10.40.194.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B04E619D9F;
        Mon, 29 Nov 2021 20:50:01 +0000 (UTC)
Date:   Mon, 29 Nov 2021 21:49:57 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH v2] ext4: implement support for get/set fs label
Message-ID: <20211129204957.u43dc5lesun32noq@work>
References: <20211111215904.21237-1-lczerner@redhat.com>
 <20211112082019.22078-1-lczerner@redhat.com>
 <5E8B9CB8-9EEE-4CB2-8DB6-DE995103B513@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E8B9CB8-9EEE-4CB2-8DB6-DE995103B513@dilger.ca>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 29, 2021 at 01:28:09PM -0700, Andreas Dilger wrote:
> On Nov 12, 2021, at 1:20 AM, Lukas Czerner <lczerner@redhat.com> wrote:
> > 
> > Implement support for FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls for
> > online reading and setting of file system label.
> > 
> > ext4_ioctl_getlabel() is simple, just get the label from the primary
> > superblock bh. This might not be the first sb on the file system if
> > 'sb=' mount option is used.
> > 
> > In ext4_ioctl_setlabel() we update what ext4 currently views as a
> > primary superblock and then proceed to update backup superblocks. There
> > are two caveats:
> > - the primary superblock might not be the first superblock and so it
> >   might not be the one used by userspace tools if read directly
> >   off the disk.
> > - because the primary superblock might not be the first superblock we
> >   potentialy have to update it as part of backup superblock update.
> >   However the first sb location is a bit more complicated than the rest
> >   so we have to account for that.
> > 
> > Tested with generic/492 with various configurations. I also checked the
> > behavior with 'sb=' mount options, including very large file systems
> > with and without sparse_super/sparse_super2.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> 
> One minor issue/question inline.
> 
> > +static int ext4_ioctl_setlabel(struct file *filp, const char __user *user_label)
> > +{
> > +	size_t len;
> > +	handle_t *handle;
> > +	ext4_group_t ngroups;
> > +	ext4_fsblk_t sb_block;
> > +	struct buffer_head *bh;
> > +	int ret = 0, ret2, grp;
> > +	unsigned long offset = 0;
> > +	char new_label[EXT4_LABEL_MAX + 1];
> > +	struct super_block *sb = file_inode(filp)->i_sb;
> > +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +	struct ext4_super_block *es = sbi->s_es;
> > +
> > +	/* Sanity check, this should never happen */
> > +	BUILD_BUG_ON(sizeof(es->s_volume_name) < EXT4_LABEL_MAX);
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +	/*
> > +	 * Copy the maximum length allowed for ext4 label with one more to
> > +	 * find the required terminating null byte in order to test the
> > +	 * label length. The on disk label doesn't need to be null terminated.
> > +	 */
> > +	if (copy_from_user(new_label, user_label, EXT4_LABEL_MAX + 1))
> > +		return -EFAULT;
> > +
> > +	len = strnlen(new_label, EXT4_LABEL_MAX + 1);
> > +	if (len > EXT4_LABEL_MAX)
> > +		return -EINVAL;
> > +
> > +	ret = mnt_want_write_file(filp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	handle = ext4_journal_start_sb(sb, EXT4_HT_MISC, EXT4_MAX_TRANS_DATA);
> > +	if (IS_ERR(handle)) {
> > +		ret = PTR_ERR(handle);
> > +		goto err_out;
> > +	}
> > +	/* Update the primary superblock first */
> > +	ret = ext4_journal_get_write_access(handle, sb,
> > +					    sbi->s_sbh,
> > +					    EXT4_JTR_NONE);
> > +	if (ret)
> > +		goto err_journal;
> > +
> > +	lock_buffer(sbi->s_sbh);
> > +	memset(es->s_volume_name, 0, sizeof(es->s_volume_name));
> > +	memcpy(es->s_volume_name, new_label, len);
> 
> (minor) this introduces a very small window where s_volume_name is unset.
> Since "new_label" is already a temporary buffer of the correct size, it
> would be better IMHO to zero it out, copy the new label from userspace
> into it, and then copy EXT4_LABEL_MAX bytes of new_label to s_volume_name.
> 
> It still isn't perfect, but reduces the window significantly.

Very good point, I'll fix that in the next version.

Thanks!
-Lukas

> 
> > +	/* Update backup superblocks */
> > +	ngroups = ext4_get_groups_count(sb);
> > +	for (grp = 0; grp < ngroups; grp++) {
> 
> 		:
> 		:
> 
> > +		ext4_debug("update backup superblock %llu\n", sb_block);
> > +		BUFFER_TRACE(bh, "get_write_access");
> > +		ret = ext4_journal_get_write_access(handle, sb,
> > +						    bh,
> > +						    EXT4_JTR_NONE);
> > +		if (ret) {
> > +			brelse(bh);
> > +			break;
> > +		}
> > +
> > +		es = (struct ext4_super_block *) (bh->b_data + offset);
> > +		lock_buffer(bh);
> > +		if (ext4_has_metadata_csum(sb) &&
> > +		    es->s_checksum != ext4_superblock_csum(sb, es)) {
> > +			ext4_msg(sb, KERN_ERR, "Invalid checksum for backup "
> > +				 "superblock %llu\n", sb_block);
> > +			unlock_buffer(bh);
> > +			brelse(bh);
> > +			ret = -EFSBADCRC;
> > +			break;
> > +		}
> > +		memset(es->s_volume_name, 0, sizeof(es->s_volume_name));
> > +		memcpy(es->s_volume_name, new_label, len);
> 
> Same here.
> 
> The rest looks fine.
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


