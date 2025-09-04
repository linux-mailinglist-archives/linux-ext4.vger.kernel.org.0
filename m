Return-Path: <linux-ext4+bounces-9810-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9CFB43133
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 06:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC0056543C
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 04:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7559F1DE4EF;
	Thu,  4 Sep 2025 04:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7a94fDq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681D7E107
	for <linux-ext4@vger.kernel.org>; Thu,  4 Sep 2025 04:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960548; cv=none; b=BGmbJkEy9AdUJmEzfXl5ALKgpNIf32KUomE/iJmxQyCZtT8CxvYqnARq3Y/rqztDxIX9QP4h1xxPefJsp2h2YfHuFzMNvyqfPKNYySnD1t7PGz4iXanG0oeELjA+5vCecxePUxK04hYCt1H+6QZJSlDw66Lot+RI9Y0cFAxypCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960548; c=relaxed/simple;
	bh=b+MYTXC1WxXrIjtj7nra9NzpIhUXYXmku5cIiFvkX94=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References:
	 MIME-version:Content-type; b=tO5ww115evbEcGRP0moxjIhAx8BeMPxMghKjERp167ibcjTjFCpPlArhVbgL//CxvLA3CqrJIIkGVoTKPnCxi0z3iJgJEcD03iw0bfKWnvN5BtpnDtrcAj9FRqbAknC4rA9Xy2RXjebCQYUz/1OVMkXYQ1M9qWwz4OVA/x3MxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7a94fDq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24879ed7c17so5053035ad.1
        for <linux-ext4@vger.kernel.org>; Wed, 03 Sep 2025 21:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756960546; x=1757565346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:date:in-reply-to
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBqm8HThD8r0qihiqV3EdqziyLsv0yfFvCZzkwTd4VA=;
        b=h7a94fDq1JCSpmrfVXR9V4RdEZ68vyLGlmwIvK4pMj2HVQh5TkaMYAKdb33mQ0szML
         5Hrff3xvapSJPkFgCj85jWZQp4LD3jrBwovYZ/cAQAFMBHj+TBIaZ86bKVr+rf7fcpIO
         UmhCwspPCgQfGpLKHnMB/w8cvSVN+BM/AkvsOwzqS0L7dyQo8axMuOVIUOWyNldXsD5W
         FOt1/GcrbS1Wck/9U6H0gTazIQV4cNYH0cDGrZO3F/+XatC7q9vq2UKtNQhhnisowlr1
         T/Bk1E0dy4uyQIFHlqGg4/ycZ195Zkkh9GebrCGCI9EJQgERYJC/jNhYY10GiDTmCXXs
         JvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960546; x=1757565346;
        h=content-transfer-encoding:mime-version:references:date:in-reply-to
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oBqm8HThD8r0qihiqV3EdqziyLsv0yfFvCZzkwTd4VA=;
        b=hR1gp8mv6XYpXxmPHRvCq+HLYLKElu+o9R4jL4g28wAQoZY/AnJSL45NaS5nB2Sn/K
         8gj5iegZdOhS+XEWTJJmbsd/HEM6NsRkxqz1k5Cpgg6iwNcDdWbh43sDcW42FnRNn4si
         ZL39KlGy5gJj4o+nWtlOUMMKGXQFk2Ea5LzfydmBckuRvuIleQKRhRTJajuA0oHUPeuA
         S5KIlhjLwLtGcyZuaoU1/iVurhsNF8WjUD5R7LuwXDGujkHTJqv2Ll2ykER2qLMWmIyA
         ks/P6Mrkvoh3XQrEMQb7XafYzt+t7yee0uCoJwzCxVOmHbn2PrJlKWSRz0zp1jIFv0wK
         AfUg==
X-Gm-Message-State: AOJu0Yw50rsUKkMi6lvMc/YUuCmyuYQlnnYHYDRGGUxEjqTl3hTp138Z
	ADAkZzVAJSzOMFJ/aHAesg/nssCEVDHoBhtWyd0MxMvOvXTBohUZxnB4
X-Gm-Gg: ASbGnctRJPzg9pxGzp4mvLLF1ItH6KBO3T25RPRnJCKTFGLfHZVkIiOeXYlDLflJ137
	jWOFqQZxi48FR/r02UGJz1IoBvkpg8tkf6brBHoeQIcaj+2LWsl9ZCc8Ht1PhvbywKaX5IKWkvs
	3BM46Qvs7Oqted+Wzoy4lnUp9xMGpP8paSPBUmSCIHZeJj+L0hPgH9AiqkZv9nf6eCxNezuucKL
	BZSpShTcw/3rByEVuy0e1b6foAUWOvLAO/CT/WToIh5x7okwD5auFkwIVsZhOJu3Ft3NN4ebRMB
	oZ+xDDZOSHlTgF3sToDLD3X+3Dq3vRgEpRfp9TilaWaa87P9eh6dH4gVFVHGfpZ/gFK5SKsIQS5
	RsTUaVFvHJlgYPYYoRFGULl0=
X-Google-Smtp-Source: AGHT+IFFXt/LD/0Oc7GTEg1Gqbax+ta6YURZHUwVL8YfJbn6nJUnOqJdQxem9zMZzSoCO5y/9buAyw==
X-Received: by 2002:a17:902:e788:b0:246:a165:87c7 with SMTP id d9443c01a7336-24944ac69b5mr196134905ad.42.1756960545608;
        Wed, 03 Sep 2025 21:35:45 -0700 (PDT)
Received: from dw-tp ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c965558b8sm32456945ad.68.2025.09.03.21.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:35:44 -0700 (PDT)
Message-ID: <68b91720.170a0220.23bef.d913@mx.google.com>
X-Google-Original-Message-ID: <87v7ly7tjn.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jan Kara <jack@suse.cz>, Sun Yongjian <sunyongjian1@huawei.com>
Cc: linux-ext4@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com, libaokun1@huawei.com, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH -next] ext4: add an update to i_disksize in ext4_block_page_mkwrite
In-Reply-To: <ksmu3jz7ll2kp3xwemvil56ntzljrdaamv5hmdj7dbjniqsprv@25ypuymdslac>
Date: Thu, 04 Sep 2025 09:33:56 +0530
References: <ksmu3jz7ll2kp3xwemvil56ntzljrdaamv5hmdj7dbjniqsprv@25ypuymdslac>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jan Kara <jack@suse.cz> writes:

> On Mon 01-09-25 15:01:45, Sun Yongjian wrote:
>> 在 2025/7/31 22:05, sunyongjian@huaweicloud.com 写道:
>> Gentle ping.
>> > From: Yongjian Sun <sunyongjian1@huawei.com>
>> > 
>> > After running a stress test combined with fault injection,
>> > we performed fsck -a followed by fsck -fn on the filesystem
>> > image. During the second pass, fsck -fn reported:
>> > 
>> > Inode 131512, end of extent exceeds allowed value
>> > 	(logical block 405, physical block 1180540, len 2)
>> > 
>> > This inode was not in the orphan list.
>
> Thanks for report! Interesting... Which kernel were you using?
>
>> > Analysis revealed the
>> > following call chain that leads to the inconsistency:
>> > 
>> >                               ext4_da_write_end()
>> >                                //does not update i_disksize
>
> Right, for any write beyond i_disksize to unallocated blocks we update
> i_disksize only during page writeback.
>
>> >                               ext4_punch_hole()
>> >                                //truncate folio, keep size
>
> So here offset + len passed to ext4_punch_hole() is important. Because
> there's ext4_update_disksize_before_punch() call which updates i_disksize
> to i_size if the punched hole reaches EOF. So did you punch hole in the
> middle of the file?
>
>> > ext4_page_mkwrite()
>> >   ext4_block_page_mkwrite()
>> >    ext4_block_write_begin()
>> >      ext4_get_block()
>> >       //insert written extent without update i_disksize
>
> We should insert unwritten extent here, shouldn't we? We use
> ext4_get_block_unwritten() when we are inside i_size. Ah, you mention below
> you use nodioread_nolock. Nasty :)
>
>> > journal commit
>> > echo 1 > /sys/block/xxx/device/delete
>> > 
>> > da-write path updates i_size but does not update i_disksize. Then
>> > ext4_punch_hole truncates the da-folio yet still leaves i_disksize
>> > unchanged. Then ext4_page_mkwrite sees ext4_nonda_switch return 1
>> > and takes the nodioread_nolock path, the folio about to be written
>> > has just been punched out, and it’s offset sits beyond the current
>> > i_disksize. This may result in a written extent being inserted, but
>> > again does not update i_disksize. If the journal gets committed and
>> > then the block device is yanked, we might run into this.
>> > 
>> > To fix this, we now check in ext4_block_page_mkwrite whether
>> > i_disksize needs to be updated to cover the newly allocated blocks.
>> > 
>> > Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
>
> Hum, rather than complicating this niche code what if we just
> unconditionally used ext4_get_block_unwritten() in
> ext4_block_page_mkwrite() when delalloc gets disabled? It is far from any
> performance critical path. What do people think? The code would actually
> have to be something like:
>
> 	if (ext4_should_journal_data(inode))
> 		get_block = ext4_get_block;
> 	else
> 		get_block = ext4_get_block_unwritten;
>

The problem mainly was when e2fsck identify a written extent beyond
i_disksize. But if it is unwritten extent, then we are still good. So
using ext4_get_block_unwritten() by default in page fault path make
sense.

So what about other checks like S_ISREG() and file with indirect blocks
in ext4_should_dioread_nolock()? We still need ext4_get_block() for them right? 
(Do we even fault on !S_ISREG() :) ?)


> to properly handle data journalling. I'm adding Ritesh to CC because I do
> remember there used to be some issues with dioread_nolock with blocksize <
> pagesize which he was able to trigger. But I think they were fixed.
>

Right, they were fixed and dioread_nolock is now the default mount
option for ext4 for bs <= ps. Here are some of the fixes which were
made. [2] was the more recent one from Ojaswin.

[1]: https://lore.kernel.org/all/af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com/
[2]: https://lore.kernel.org/all/d0ed09d70a9733fbb5349c5c7b125caac186ecdf.1695033645.git.ojaswin@linux.ibm.com/
[3]: This patch enabled dioread_nolock for bs < ps.. 
https://lore.kernel.org/all/20231101154717.531865-1-ojaswin@linux.ibm.com/

> 								Honza
>
>> > ---
>> >   fs/ext4/inode.c | 10 ++++++++++
>> >   1 file changed, 10 insertions(+)
>> > 
>> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> > index ed54c4d0f2f9..050270b265ae 100644
>> > --- a/fs/ext4/inode.c
>> > +++ b/fs/ext4/inode.c
>> > @@ -6666,8 +6666,18 @@ static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
>> >   		goto out_error;
>> >   	if (!ext4_should_journal_data(inode)) {
>> > +		loff_t disksize = folio_pos(folio) + len;
>> >   		block_commit_write(folio, 0, len);
>> >   		folio_mark_dirty(folio);
>> > +		if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
>> > +			down_write(&EXT4_I(inode)->i_data_sem);
>> > +			if (disksize > EXT4_I(inode)->i_disksize)
>> > +				EXT4_I(inode)->i_disksize = disksize;
>> > +			up_write(&EXT4_I(inode)->i_data_sem);
>> > +			ret = ext4_mark_inode_dirty(handle, inode);
>> > +			if (ret)
>> > +				goto out_error;
>> > +		}
>> >   	} else {
>> >   		ret = ext4_journal_folio_buffers(handle, folio, len);
>> >   		if (ret)
>> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

