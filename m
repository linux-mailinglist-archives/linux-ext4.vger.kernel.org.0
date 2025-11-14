Return-Path: <linux-ext4+bounces-11860-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D97C5B5C9
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Nov 2025 06:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC39E3555A9
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Nov 2025 05:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777592D662D;
	Fri, 14 Nov 2025 05:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrQf2JM0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D0F199230
	for <linux-ext4@vger.kernel.org>; Fri, 14 Nov 2025 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763096863; cv=none; b=QVVonCDY0XYc5x+hCr+908hnqhoVOTzk0fFiP256TBfIELHtWsBKIiYn3IehYTpOHGleimK/G+oNtSUIByJqmjM/LZC5zvnDFvNyWiuhao+XNP4q0Tq8dGFYoNATiNKk/acy7My3XUpq43MoRv2+yiMuEMMBps6atRb+PBZChFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763096863; c=relaxed/simple;
	bh=PfYlbSnhkbQA76udjWHZBttEuBLcch9/E9x/Zjt8xyE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=oThgMYUqaLDozrjlmkvlil459IHx0VgUBG9WyqPsc5/xsRZWHxkkDv/9WkmJHvBORS/S0yzpva2S8g2ZbayoFEZxqaA3Bly1MkmQfTDO5hn7roiO4txsMiK/fo+50aVBRoYo7W1zXoCrJpvs3WJprJpzM/9sY1MmS7nQR0dRAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrQf2JM0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2980d9b7df5so14704895ad.3
        for <linux-ext4@vger.kernel.org>; Thu, 13 Nov 2025 21:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763096861; x=1763701661; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kc5SP3ZHaud5cAzsFrlPvf9GXnKWLDwtapilGbxVFYk=;
        b=GrQf2JM0zh8zw6Jr7ILa9BEPQx4LfTUvAE5+qXxKFDBMvsY56NxzIkrDrQ1kyFbAyr
         A27hb6EnySfASDkrx4ncV6BSuszpVSRlpJ4JaV6Bg5c+ZTvWTOONrtWjN+K9Wb4SHT9W
         wSICbWm7eY1f4SmkuB8M+b/SSLsf4vRX4qw45+J4GaOHzFPgTt1nqzAocm/5ocW2I3hz
         ZclpDE0ueni90R8yp7L7MvsujNEadJbL7Cldeqch8/KI5GH+Guy3Uz0Z54Tq3MtepuIh
         aW+X4TbFTmaWbqJMAMC596MSrT3HTeIswVE2WxLdHS6+wLJeIiUrtWfKrJ8lgm+WS02w
         ZIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763096861; x=1763701661;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kc5SP3ZHaud5cAzsFrlPvf9GXnKWLDwtapilGbxVFYk=;
        b=KZRfTjoqTqKurdQHfuobx4e9RVipJF6Ity1xe6OcmTzwTS+ZkWp7FLCR/yMou8ordp
         A3slwPoqp9jENqrgqgj5UUSncY3ohDLkHnWNSDGf84Vb0/Ldmq3/rpOT5a4pZBOKmWm/
         7+9BeIorfLnZjNhgHRxNdPL/o4YLaJxiQNkUVOul9tEPXkwdMlMVqSxQFD4l0SZ/3O9F
         IADpntLc8JxEDPsN1ECg4O/vUBKx9FFmgtooDjF9rls6JVCJA4oXNtg/Bz3HdDI9FZOP
         BVqvqmQb53lMHgUl+Uty2hIki3AAHYnHcuk6Xr0CtpvlmXZ5krVU064H5Nw7hYTYUDdP
         wnXA==
X-Forwarded-Encrypted: i=1; AJvYcCV3fRCaWYsUt0+yQVViiVXsLr1yQY3beeDuXjeP+/Op3ofC0mtBHp93dY/vzgdVrAWEgwX8q1chf3rL@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSUAJ6SanIWTDtxRMW1pI3vkvskgBv6mgvI585tz4AqjRMQyL
	gAao5oQRUQTIHYap8EATNbRzG6KMPbuGKeSPT9CI0PdIcv9wwEBiBpVg
X-Gm-Gg: ASbGncvHedsvUDWkmUwxfY16JuKFQ2Du3t9VAhHRZwi8/sz1khRcJFun6rDvXCU0GC6
	mahy5kPPgtcXwsriIs4qGojQ6PRJ7li2vbqSyFimOlKkPgo0+8uN56hjj0SVL5Yijg1oY0y+CDm
	IvDORR1WjosdiPQGx2nLIeQLZMvG8FY2gPFNKhK1rQSz54WsqTXMgNxdaF+Hws1jRJu/aSjL240
	Ra/rEI9BDTxchKrjHglmGr4GIHkrieLLCqwl9C6+/3noB0JdPv+kRalzESqeOcB0f4eG62HS3xW
	UFkj8ZFper9jHp6vEv7mn1BRgRSTvuD2GKrqJcItjLEVJlFwyEbGqFGI/PjsVlClXqzD6a/ATnU
	lyipVtTw4N1rzeY97e98ELPxfGnxw1EtOpYqP7hzYLWYLDSTF5ldgp6arxuRAstBZSpNlsX4=
X-Google-Smtp-Source: AGHT+IEK285v1wC2XvzGikqccbF9tOIC6uZx3BccuaEpsjgYn5FPyTQAAYCs+R3hkEKMpO8EagDTJA==
X-Received: by 2002:a17:902:ebcd:b0:294:f70d:5e33 with SMTP id d9443c01a7336-2986a6ba476mr19617915ad.12.1763096860963;
        Thu, 13 Nov 2025 21:07:40 -0800 (PST)
Received: from dw-tp ([49.207.219.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d195fsm3835410b3a.18.2025.11.13.21.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:07:40 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Christian Brauner <brauner@kernel.org>, djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu, dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] mm: Add PG_atomic
In-Reply-To: <aRSuH82gM-8BzPCU@casper.infradead.org>
Date: Fri, 14 Nov 2025 10:30:09 +0530
Message-ID: <87ecq18azq.ritesh.list@gmail.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <5f0a7c62a3c787f2011ada10abe3826a94f99e17.1762945505.git.ojaswin@linux.ibm.com> <aRSuH82gM-8BzPCU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Nov 12, 2025 at 04:36:05PM +0530, Ojaswin Mujoo wrote:
>> From: John Garry <john.g.garry@oracle.com>
>> 
>> Add page flag PG_atomic, meaning that a folio needs to be written back
>> atomically. This will be used by for handling RWF_ATOMIC buffered IO
>> in upcoming patches.
>
> Page flags are a precious resource.  I'm not thrilled about allocating one
> to this rather niche usecase.  Wouldn't this be more aptly a flag on the
> address_space rather than the folio?  ie if we're doing this kind of write
> to a file, aren't most/all of the writes to the file going to be atomic?

As of today the atomic writes functionality works on the per-write
basis (given it's a per-write characteristic). 

So, we can have two types of dirty folios sitting in the page cache of
an inode. Ones which were done using atomic buffered I/O flag
(RWF_ATOMIC) and the other ones which were non-atomic writes. Hence a
need of a folio flag to distinguish between the two writes.

-ritesh


