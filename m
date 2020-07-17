Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F132322374D
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgGQImf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 04:42:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20144 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725864AbgGQIme (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 Jul 2020 04:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594975353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vKx59TqV7hfuid3XZv5xM+ngmqK/hX16uabprp+kirA=;
        b=L3yVeobTGV1c8Z/9j6eHZzgPmvD7Rv/v6STI8lyXC5knb3/xN+WIIoKGzpeLGWnSkSPcjq
        Qu+KCEn46PzsDd/dIr5wQz1Yk5nBJ32kjpmhe5EZGJ1UwXyFQDtIZALfgekS08Uc+XuqfO
        58tXcmnfGxlBPZIcnWRueZeKty6dic4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-6_ghySXVMLSM5pZI1wApjA-1; Fri, 17 Jul 2020 04:42:31 -0400
X-MC-Unique: 6_ghySXVMLSM5pZI1wApjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A583D19253C6;
        Fri, 17 Jul 2020 08:42:30 +0000 (UTC)
Received: from work (unknown [10.40.193.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B72AB100164C;
        Fri, 17 Jul 2020 08:42:29 +0000 (UTC)
Date:   Fri, 17 Jul 2020 10:42:25 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: handle read only external journal device
Message-ID: <20200717084225.llc676amtmhwqj4i@work>
References: <20200716183901.5016-1-lczerner@redhat.com>
 <43F86B80-4895-4146-B65B-788D16161323@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F86B80-4895-4146-B65B-788D16161323@dilger.ca>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 17, 2020 at 02:10:18AM -0600, Andreas Dilger wrote:
> On Jul 16, 2020, at 12:39 PM, Lukas Czerner <lczerner@redhat.com> wrote:
> > 
> > Ext4 uses blkdev_get_by_dev() to get the block_device for journal device
> > which does check to see if the read-only block device was opened
> > read-only.
> > 
> > As a result ext4 will hapily proceed mounting the file system with
> > external journal on read-only device. This is bad as we would not be
> > able to use the journal leading to errors later on.
> > 
> > Instead of simply failing to mount file system in this case, treat it in
> > a similar way we treat internal journal on read-only device. Allow to
> > mount with -o noload in read-only mode.
> > 
> > This can be reproduced easily like this:
> > 
> > mke2fs -F -O journal_dev $JOURNAL_DEV 100M
> > mkfs.$FSTYPE -F -J device=$JOURNAL_DEV $FS_DEV
> > blockdev --setro $JOURNAL_DEV
> > mount $FS_DEV $MNT
> > touch $MNT/file
> > umount $MNT
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> > fs/ext4/super.c | 55 ++++++++++++++++++++++++++++++-------------------
> > 1 file changed, 34 insertions(+), 21 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 330957ed1f05..a15e3c751766 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5088,7 +5089,30 @@ static int ext4_load_journal(struct super_block *sb,
> > 	} else
> > 		journal_dev = new_decode_dev(le32_to_cpu(es->s_journal_dev));
> > 
> > -	really_read_only = bdev_read_only(sb->s_bdev);
> > +	if (journal_inum && journal_dev) {
> > +		ext4_msg(sb, KERN_ERR, "filesystem has both journal "
> > +		       "and inode journals!");
> 
> (style) keep error string on a single line.  Also, "journal and inode journal"
> is not very clear what the problem is.  Maybe something like:
> 
> +		ext4_msg(sb, KERN_ERR,
> +			 "filesystem has both journal inode and device!");

Ok, I'll change it. Explicitely saying "journal device" makes it even
more clear to me.

+			 "filesystem has both journal inode and journal device!");

> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (journal_inum) {
> > +		if (!(journal = ext4_get_journal(sb, journal_inum)))
> > +			return -EINVAL;
> > +	} else {
> > +		if (!(journal = ext4_get_dev_journal(sb, journal_dev)))
> > +			return -EINVAL;
> > +	}
> > +
> > +	journal_dev_ro = bdev_read_only(journal->j_dev);
> > +	really_read_only = bdev_read_only(sb->s_bdev) | journal_dev_ro;
> > +
> > +	if (journal_dev_ro && !sb_rdonly(sb)) {
> > +		ext4_msg(sb, KERN_ERR, "write access "
> > +			"unavailable, cannot proceed "
> > +			"(try mounting read-only)");
> 
> (style) should keep error strings on a single line.  Also, this isn't very
> obvious that that this is because of the read-only journal device.  Maybe:
> 
> 		ext4_msg(sb, KERN_ERR,
> 			 "journal device read-only, try mounting with '-o ro'");

Yeah, that's better, thanks.

> 
> > @@ -5141,11 +5152,8 @@ static int ext4_load_journal(struct super_block *sb,
> > 		kfree(save);
> > 	}
> > 
> > -	if (err) {
> > -		ext4_msg(sb, KERN_ERR, "error loading journal");
> > -		jbd2_journal_destroy(journal);
> > -		return err;
> > -	}
> > +	if (err)
> > +		goto err_out;
> > 
> > 	EXT4_SB(sb)->s_journal = journal;
> > 	ext4_clear_journal_err(sb, es);
> > @@ -5159,6 +5167,11 @@ static int ext4_load_journal(struct super_block *sb,
> > 	}
> > 
> > 	return 0;
> > +
> > +err_out:
> > +	ext4_msg(sb, KERN_ERR, "error loading journal");
> 
> Is there any error case that doesn't already print its own error message?
> Maybe better to leave the ext4_msg() in the original location, and only
> do cleanup here.

True, it makes it kind of redundant when we've already printed the
error.

Thanks Andreas, I'll resend the new version.
-Lukas

> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


