Return-Path: <linux-ext4+bounces-2247-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6BC8B86F5
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2024 10:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B521F23B4A
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2024 08:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201154670;
	Wed,  1 May 2024 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mqAo+nql"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559050282
	for <linux-ext4@vger.kernel.org>; Wed,  1 May 2024 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552389; cv=none; b=BGxYtlA5YR4YEtHG4xxRGuUJbWQzgr/u6AMbgNMJTIyknuP66dwl5G9zAjZHJz7p7kq42tc0xjniJAup6uwWjnIlkVuAl4ML0AqDcbQOw6OpZAagXZ2GEmkkNTjF66AHmf08gY0MHnXn4yY8tYiuqS47KLUcqfuwEAk1wIoW/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552389; c=relaxed/simple;
	bh=Sm5FnFUyYdyHJUqxyzhk02pT/oeijbycGLLbBF7pMUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlIvX3Y8eklME9OxJvjdrhiaX7ugYjpDWff2xiLcwXUEUMNmsfg+BXvqS/vfC0tIkaD6KLbMfy7+0agxcEWImUtzOoTYxyn74ZxKj+mlhOHW6EOOsmgtyU8gY5o8Mhnef4U/EPyX7BYLw4jgDKREzDRHWhHEjZsZQje/QLOyh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mqAo+nql; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b33d011e5dso117424a91.0
        for <linux-ext4@vger.kernel.org>; Wed, 01 May 2024 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714552387; x=1715157187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTYNlvyrYVbQYSeq48cS2P70mX2dX5gOsnD6+FgyUPQ=;
        b=mqAo+nqlkFoz6bfARGP5j0I9RTX7DLhccAVp6CofbL+IxL9vtW/lTZ4cvR/HzzcyqM
         3ajBa3cnRSPN147EpZ6WaSb0s5rZ2aDfnFeg8xFFShIjRlKplh+T0YtJCXroiLc0x33p
         upHj0M24AIAGeBTqE70lyEHOStZLNlaIMFpV3J1UO03FORK55XRLuUSKLWh2SN4qmmYc
         DUtTYLJ22VYLfyO16SfVQVE9f0cDVquD0XrPTWM8hUK4PyVPAjYmcdUf8ZTtPFEWdp/p
         WGyHFevs2Z7KzYXs1SXlXSYock3M6ljsSvHOZkJ5tLDSwQiVhABgkBSsnStHPsRRdad2
         obzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714552387; x=1715157187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTYNlvyrYVbQYSeq48cS2P70mX2dX5gOsnD6+FgyUPQ=;
        b=twLlo+5Ja/5MqBHr1Ztx612o2AdLpqe1DQKl6praG8qJt0U1vxSngvjitTyFZoLZCT
         SjFUX5MNxCXMmSVtHhE2StvWP9llOUiRwRhErxOgSpzt89PSk7w/T53xNhtMdJ0dLngs
         klfnfcuqEc+QiuigAowqyO9jOI99wcCKyLiPLxE/wg+/tq9DUuemMiYAJnz/uIOtpXu2
         vjRssGnG3c4gU+DP3uOBKwItNQOkRwlUzDpobkwjqIC8TYL1aelkuyccueBn3gg2DxLc
         vccTrU00fl4V2iCGjG3xre7JqV7AnAh1w/ErWnM2Pdzrj5M4hV9NWEzct3Y7F6kC268C
         LJfg==
X-Gm-Message-State: AOJu0YwEnLuCqjg/oNNPLyt02esssOLmhHnIw3vYo7cVuwHCbnkw/8GP
	dmPXeb7IFGAg3ZM67m01gePKVWjvVtF4Zl0MhswRYXkFKRDAaln9NtonCYjiEco=
X-Google-Smtp-Source: AGHT+IEiZg4Ov1wyuvwipwKu7F/ZM1MAg10yW7QiVfhsFN3PpgghzgYyHjehJ85DP2fIrKsN7R9vJA==
X-Received: by 2002:a17:90a:a592:b0:2b1:cf6a:848 with SMTP id b18-20020a17090aa59200b002b1cf6a0848mr7414655pjq.7.1714552387057;
        Wed, 01 May 2024 01:33:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id sx11-20020a17090b2ccb00b002b1750f228csm874075pjb.7.2024.05.01.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 01:33:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s25Oi-00HAPQ-1S;
	Wed, 01 May 2024 18:33:04 +1000
Date: Wed, 1 May 2024 18:33:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v4 24/34] ext4: implement buffered write iomap path
Message-ID: <ZjH+QFVXLlcDkSdh@dread.disaster.area>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410142948.2817554-25-yi.zhang@huaweicloud.com>
 <ZjH5Ia+dWGss5Duv@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjH5Ia+dWGss5Duv@dread.disaster.area>

On Wed, May 01, 2024 at 06:11:13PM +1000, Dave Chinner wrote:
> On Wed, Apr 10, 2024 at 10:29:38PM +0800, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Implement buffered write iomap path, use ext4_da_map_blocks() to map
> > delalloc extents and add ext4_iomap_get_blocks() to allocate blocks if
> > delalloc is disabled or free space is about to run out.
> > 
> > Note that we always allocate unwritten extents for new blocks in the
> > iomap write path, this means that the allocation type is no longer
> > controlled by the dioread_nolock mount option. After that, we could
> > postpone the i_disksize updating to the writeback path, and drop journal
> > handle in the buffered dealloc write path completely.
.....
> > +/*
> > + * Drop the staled delayed allocation range from the write failure,
> > + * including both start and end blocks. If not, we could leave a range
> > + * of delayed extents covered by a clean folio, it could lead to
> > + * inaccurate space reservation.
> > + */
> > +static int ext4_iomap_punch_delalloc(struct inode *inode, loff_t offset,
> > +				     loff_t length)
> > +{
> > +	ext4_es_remove_extent(inode, offset >> inode->i_blkbits,
> > +			DIV_ROUND_UP_ULL(length, EXT4_BLOCK_SIZE(inode->i_sb)));
> >  	return 0;
> >  }
> >  
> > +static int ext4_iomap_buffered_write_end(struct inode *inode, loff_t offset,
> > +					 loff_t length, ssize_t written,
> > +					 unsigned int flags,
> > +					 struct iomap *iomap)
> > +{
> > +	handle_t *handle;
> > +	loff_t end;
> > +	int ret = 0, ret2;
> > +
> > +	/* delalloc */
> > +	if (iomap->flags & IOMAP_F_EXT4_DELALLOC) {
> > +		ret = iomap_file_buffered_write_punch_delalloc(inode, iomap,
> > +			offset, length, written, ext4_iomap_punch_delalloc);
> > +		if (ret)
> > +			ext4_warning(inode->i_sb,
> > +			     "Failed to clean up delalloc for inode %lu, %d",
> > +			     inode->i_ino, ret);
> > +		return ret;
> > +	}
> 
> Why are you creating a delalloc extent for the write operation and
> then immediately deleting it from the extent tree once the write
> operation is done?

Ignore this, I mixed up the ext4_iomap_punch_delalloc() code
directly above with iomap_file_buffered_write_punch_delalloc().

In hindsight, iomap_file_buffered_write_punch_delalloc() is poorly
named, as it is handling a short write situation which requires
newly allocated delalloc blocks to be punched.
iomap_file_buffered_write_finish() would probably be a better name
for it....

> Also, why do you need IOMAP_F_EXT4_DELALLOC? Isn't a delalloc iomap
> set up with iomap->type = IOMAP_DELALLOC? Why can't that be used?

But this still stands - the first thing
iomap_file_buffered_write_punch_delalloc() is:

	if (iomap->type != IOMAP_DELALLOC)
                return 0;

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

