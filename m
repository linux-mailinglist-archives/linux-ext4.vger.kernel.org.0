Return-Path: <linux-ext4+bounces-101-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB557F58D5
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 08:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4843D2816AB
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E813FFE;
	Thu, 23 Nov 2023 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFgG7Ejh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CF691
	for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 23:07:13 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b845ba9ba9so363553b6e.3
        for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 23:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700723232; x=1701328032; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZFFkbh6MiO/OnOl0Tt/bMt+3lLhDn5ty1VAw3ZEdkOA=;
        b=SFgG7EjhJ8hSIsWllvjlLT53jIIRNSqFZQKGBUUfoPB/93t2gk1suPs7eFWxU+7GBC
         DMDmjFPzQaWm/bzI2TL5CSC6uHLpG3UKPbZMHCzNW/weYXNfZS0VRlwQyPaf+P3NnWWv
         EireuRkqd5UOOs12U/yZdXNbqFFA2BJ/i4vA3qgaDpIC81cOqcz99FCjRx9T1/nDn6rF
         D943AmySyup6f+lmWfQB6zcHpqgRZnAtLw+21Qdvkiwlfwp/OFROusQsps7bHNxBfkNn
         6l+vz78Bj6IehbbzUzzHJ3pMe6jTWgrzHV6HqTSSX5iPgYIcLM0Lri/Ixo2Ge1RTcff9
         nFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700723232; x=1701328032;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZFFkbh6MiO/OnOl0Tt/bMt+3lLhDn5ty1VAw3ZEdkOA=;
        b=EL9INWRessjS3q5Q+4Kfq+GsF7unLlJg+HusTStM6N7s8YklPbYxzayn8PsAoZha80
         Wd6ejyXXR445yG0WP6xEKRwi4l3ybs+ejnGnEbO8T2Xp4j1UVBu1QfErN5bld6qeGqT5
         3mfRPqHPcWuesOxExZ/g/LeoQaVNtQE33aZgk3WOT7ZNtsmH4fEN3j2qcwQGXwH2hp2g
         qJqDjWQ+TnYINjIDEWpXozeRRA4d/DA9hlnf7pIhpWMEhjJP78Oowmf1duMjXvP6s9Qk
         XUv+N2WdxNblS39mkzdEnaPHRf6jNzsOZm+QQMzeZH4AEkt4VLSVrHP1/tNfs4i27L61
         DReQ==
X-Gm-Message-State: AOJu0YxZYWKgyUlErVRouVSBid5XOkuBOPflH2qjFheP83eXLAMHEccO
	JOemmuo4DcNMLDEsbCEDi4O27e+1wNc=
X-Google-Smtp-Source: AGHT+IHmzWYwmEt3PTkjO0TLFL5OhrpAlbcD5ItCRN1eiTbZMMb7RK7SkKW4FM7XLF2ej+/uWGrCbw==
X-Received: by 2002:a05:6808:14c9:b0:3ad:9540:5475 with SMTP id f9-20020a05680814c900b003ad95405475mr6492357oiw.45.1700723232317;
        Wed, 22 Nov 2023 23:07:12 -0800 (PST)
Received: from dw-tp ([129.41.58.16])
        by smtp.gmail.com with ESMTPSA id h33-20020a631221000000b00578afd8e012sm618576pgl.92.2023.11.22.23.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 23:07:11 -0800 (PST)
Date: Thu, 23 Nov 2023 12:37:03 +0530
Message-Id: <87zfz5q76w.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix warning in ext4_dio_write_end_io()
In-Reply-To: <20231122181440.12043-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Jan Kara <jack@suse.cz> writes:

> The syzbot has reported that it can hit the warning in
> ext4_dio_write_end_io() because i_size < i_disksize. Indeed the
> reproducer creates a race between DIO IO completion and truncate
> expanding the file and thus ext4_dio_write_end_io() sees an inconsistent
> inode state where i_disksize is already updated but i_size is not
> updated yet. Since we are careful when setting up DIO write and consider
> it extending (and thus performing the IO synchronously with i_rwsem held
> exclusively) whenever it goes past either of i_size or i_disksize, we
> can use the same test during IO completion without risking entering
> ext4_handle_inode_extension() without i_rwsem held. This way we make it
> obvious both i_size and i_disksize are large enough when we report DIO
> completion without relying on unreliable WARN_ON.

Does it make sense to add this in ext4_handle_inode_extension()?
	WARN_ON_ONCE(!inode_is_locked(inode));
Ohk, we already have "lockdep_assert_held_write(&inode->i_rwsem)" so
hopefully it can catch via lockdep.


So, IIUC, the WARN happened when we were doing a non-extending
AIO-DIO write which was racing with truncate trying to expand the file
size. Because only then the DIO completion will not have i_rwsem held
which can race with truncate. Truncate since it is expanding the file
size, will not use inode_dio_wait() (since no block allocations).

Is this understanding correct?

>
> Reported-by: syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
> Fixes: 91562895f803 ("ext4: properly sync file size update after O_SYNC direct IO")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/file.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 0166bb9ca160..ba497aabdd1e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -386,10 +386,11 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>  	 * blocks. But the code in ext4_iomap_alloc() is careful to use
>  	 * zeroed/unwritten extents if this is possible; thus we won't leave
>  	 * uninitialized blocks in a file even if we didn't succeed in writing
> -	 * as much as we intended.
> +	 * as much as we intended. Also we can race with truncate or write
> +	 * expanding the file so we have to be a bit careful here.
>  	 */
> -	WARN_ON_ONCE(i_size_read(inode) < READ_ONCE(EXT4_I(inode)->i_disksize));
> -	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize))
> +	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
> +	    pos + size <= i_size_read(inode))
>  		return size;
>  	return ext4_handle_inode_extension(inode, pos, size);
>  }
> -- 
> 2.35.3

