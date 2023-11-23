Return-Path: <linux-ext4+bounces-104-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BF67F5B9E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 10:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A771C20D94
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EEE2136D;
	Thu, 23 Nov 2023 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSDGWGdR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF715D41
	for <linux-ext4@vger.kernel.org>; Thu, 23 Nov 2023 01:47:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf8720c6b7so5341205ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 23 Nov 2023 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700732852; x=1701337652; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s/DGfawFzxsiKwS5JGtaRUxbihW/WN2+/86KFfasBTU=;
        b=VSDGWGdRGXwn+XUWxYOXQ0wCVhPwChuDiiQXxn8a0Swb6kwdFadaAruDOXXAOrroQ2
         T2JwIXbbE5ksz+fmzrDLpC2Q9vhqHLRPBI6Rs1FSC1cG98mTOncXUpRBPxQDvK1l50LU
         wf2M6bMzeUWvgiBratxF2kHwr1nE+5RtTIRodP4aAZKYLnK3/05N4PkBUzl0sXKCemyt
         d5/m9MqfOADZqUcRHJh5RaqTitSeHM4vETMIVvwJXpyLle8KGoMPYJ/22YvnLB27LCSD
         v9v1jzMXtm7ly32uDiWEaUWDwS7EOABMiQCb/emn1q0t3jiLhauRa6B2tOKaqNHV2v8X
         Fwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700732852; x=1701337652;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/DGfawFzxsiKwS5JGtaRUxbihW/WN2+/86KFfasBTU=;
        b=dTW6/Mtk4nQRUhIueKfv+79p8zepVKGoEhPtPbLTMxXYFU1LkEysbi+5neKyMej2Da
         o9DcwJUrw+AOIXiEdyewrzvvdZwEVTuR5lxfSy4if2ZWYzxnLGP92qHM7Ai272srHTHz
         gJT434c1owM58MPH8XXbEwGvvK8MV4WcQvjCBgrYJ13si9LSsAi67oZxGAkmFA0cE9QD
         UZJN4sQ8F+lb0q9vHveAqlV39TVbINDGJaw8Ah/Ns1KR/oi2n45CyKNVz/xKCF/AP/D/
         NbJen9cJl3doVwatGdQWcXwlCJ2EGZsXCsSP6s8E/yMtykGvT6Eua6TL+hUnM7zLGIuF
         ICjg==
X-Gm-Message-State: AOJu0YxPN0T8NNPBhqESsbCyjvLvXQ0J7OV8Wev5xiIh7+yxd8cpQPYf
	ouv9+3wMft9ytkfMLgAo5bU=
X-Google-Smtp-Source: AGHT+IGLiCiQYddqT2L9MVlst+TVottL9XxPLNts71dZ19FFKhdCPR3nfg+WaEBk2Ta9UZQVx1uWCg==
X-Received: by 2002:a17:902:8646:b0:1ce:6687:c93e with SMTP id y6-20020a170902864600b001ce6687c93emr4474516plt.69.1700732852327;
        Thu, 23 Nov 2023 01:47:32 -0800 (PST)
Received: from dw-tp ([129.41.58.16])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709027fce00b001cf5d1c85cdsm943454plb.218.2023.11.23.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:47:31 -0800 (PST)
Date: Thu, 23 Nov 2023 15:17:28 +0530
Message-Id: <87ttpcrebz.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix warning in ext4_dio_write_end_io()
In-Reply-To: <20231123084954.oegpgspqm37nnz2a@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> On Thu 23-11-23 12:37:03, Ritesh Harjani wrote:
>> Jan Kara <jack@suse.cz> writes:
>> 
>> > The syzbot has reported that it can hit the warning in
>> > ext4_dio_write_end_io() because i_size < i_disksize. Indeed the
>> > reproducer creates a race between DIO IO completion and truncate
>> > expanding the file and thus ext4_dio_write_end_io() sees an inconsistent
>> > inode state where i_disksize is already updated but i_size is not
>> > updated yet. Since we are careful when setting up DIO write and consider
>> > it extending (and thus performing the IO synchronously with i_rwsem held
>> > exclusively) whenever it goes past either of i_size or i_disksize, we
>> > can use the same test during IO completion without risking entering
>> > ext4_handle_inode_extension() without i_rwsem held. This way we make it
>> > obvious both i_size and i_disksize are large enough when we report DIO
>> > completion without relying on unreliable WARN_ON.
>> 
>> Does it make sense to add this in ext4_handle_inode_extension()?
>> 	WARN_ON_ONCE(!inode_is_locked(inode));
>> Ohk, we already have "lockdep_assert_held_write(&inode->i_rwsem)" so
>> hopefully it can catch via lockdep.
>
> Exactly.
>  
>> So, IIUC, the WARN happened when we were doing a non-extending
>> AIO-DIO write which was racing with truncate trying to expand the file
>> size. Because only then the DIO completion will not have i_rwsem held
>> which can race with truncate. Truncate since it is expanding the file
>> size, will not use inode_dio_wait() (since no block allocations).
>> 
>> Is this understanding correct?
>
> Yes, correct.

Thanks Jan,

Also ext4_inode_extension_cleanup() function can take care of deleting
the inode from the orphan list in case if there is a race with truncate 
which extended made both i_disksize and inode->i_size and the DIO
completion couldn't call ext4_handle_inode_extension(), right?

In that case, does it make sense to update a comment here too? 

@@ -350,7 +350,10 @@ static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
        }
        /*
         * If i_disksize got extended due to writeback of delalloc blocks while
-        * the DIO was running we could fail to cleanup the orphan list in
+        * the DIO was running, or
+        * If i_disksize and inode->i_size both got extened during truncate
+        * which raced with DIO completion,
+        * In both such cases, we could fail to cleanup the orphan list in
         * ext4_handle_inode_extension(). Do it now.
         */
        if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {


-ritesh

>
> 								Honza
>
>> 
>> >
>> > Reported-by: syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
>> > Fixes: 91562895f803 ("ext4: properly sync file size update after O_SYNC direct IO")
>> > Signed-off-by: Jan Kara <jack@suse.cz>
>> > ---
>> >  fs/ext4/file.c | 7 ++++---
>> >  1 file changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> > index 0166bb9ca160..ba497aabdd1e 100644
>> > --- a/fs/ext4/file.c
>> > +++ b/fs/ext4/file.c
>> > @@ -386,10 +386,11 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>> >  	 * blocks. But the code in ext4_iomap_alloc() is careful to use
>> >  	 * zeroed/unwritten extents if this is possible; thus we won't leave
>> >  	 * uninitialized blocks in a file even if we didn't succeed in writing
>> > -	 * as much as we intended.
>> > +	 * as much as we intended. Also we can race with truncate or write
>> > +	 * expanding the file so we have to be a bit careful here.
>> >  	 */
>> > -	WARN_ON_ONCE(i_size_read(inode) < READ_ONCE(EXT4_I(inode)->i_disksize));
>> > -	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize))
>> > +	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
>> > +	    pos + size <= i_size_read(inode))
>> >  		return size;
>> >  	return ext4_handle_inode_extension(inode, pos, size);
>> >  }
>> > -- 
>> > 2.35.3
>> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

