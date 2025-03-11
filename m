Return-Path: <linux-ext4+bounces-6767-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D91DA5D04B
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 21:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C844017CB65
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0D223335;
	Tue, 11 Mar 2025 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRKYs3u8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298891E8336;
	Tue, 11 Mar 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723284; cv=none; b=V/XsF7DfPOWVlCKPAXU/Ou0NJnf4OnZSlY0eIt8Hu3KvY8EDnKVvDztrQNkeTByG6ofop1rC2XnKAhqoIA08WrTNwD7UvHfh1/NUZr13K8vAaLAKJ1jS23d3DQh0E+LPk69a3M9Vo36TqV9TIkufVK4ijhkF7/e7N0VpAcs2qmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723284; c=relaxed/simple;
	bh=D2A2IZnBHN+EoyX6mct98H9AZxLT/NlYZhNNNGH4hOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YclqaIFbroTYRAjL5RDOfGYrEkRlSIEEyclsA2J+EkfM0kDshIekeUjBa7CFWF4u6/pu5zES11tmEjDxtWv7TW4+s7clz1kWBIHGm4UUi3vr7VzOPX4JmS0tHDGyJSG53gGUQbWH5pDO/6p99ejYWzBoaxbLS+yA2kE7jllg+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRKYs3u8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4394a823036so50645015e9.0;
        Tue, 11 Mar 2025 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741723281; x=1742328081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qFhtHxY/uDqNyIojZGB9+AuGiGGlLJ5Td0/uLKfH98=;
        b=aRKYs3u8pL6iZV1KWN2iPGc5d1lxTK5E5KY4RVZi9vf5XnuyR3b2cCBL8fDaRTc1qj
         kEmILXDTjklAOFvAzfGyjM3B+WMHeKdwnJfV5J5j9py5I7LaIqSsd/zyCptFJoT/s5bF
         0R9viWpP/s2EvOCkYip85ZCkk4ATv/UiumZYjCAzso5xhn3HJxRH3A76zE6GPRXU1/sT
         CRuR3TWVUs3X+4aqw4EkPRxUUaK+YTDeCVkCRGBdMNCizSZip5M70/U6ixxxkyzt1XJT
         0ncFZgBffeG/jUWHJRMJDtCkr+Y7ODoeXdsEuWfEEgcMCWaDzqK4c6IbzjqWTTibqpD4
         WfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741723281; x=1742328081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qFhtHxY/uDqNyIojZGB9+AuGiGGlLJ5Td0/uLKfH98=;
        b=TCvKQ8FkI+XKTFsFplUqpVMLINpfSWFb8JzvZOX5ma6qUhXNrQmrCDpuAyWfzbeF74
         Kxm6B/8OpeGcLMxIKspeGrhbZUMfVkpSu/IQuGMcnlIkuNuCj11QU5mZfPckYBK/ai8b
         KJVZ9yPndAPt6AkbOSDwQOECaO7yAJFng6ICPG7PsOI5I9U3F9EhbEdGHC/oBIeYxxgV
         hbgxnDJ8axaguvOmnB+cCLi9bFEPn0s7JLQiUi6eDUqTpt9NrVd3GrSahzUhYcxvQzIr
         vmMwklNpLn4t0v66rEhvPGlwlZpq7UXHVr+Mb3AS6EpP+NeTwx2WVZ4rY97By2Iqx6Xk
         jMfw==
X-Forwarded-Encrypted: i=1; AJvYcCU/JkcEnvhMoDNNpp1/l4/pwYe0/e0eZUdJUO1uTXjOHYwa9NmsfmHWog4zPrU2x0mllbLavQbbuaHdvwbn@vger.kernel.org, AJvYcCUVuPohIHccXgMygpfj1+Kvl69j1iLfCgJS8LjbSLgcnSNaaCDnWG0aevJ/Rsk0MB3tbnu5/Ababmhf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3+ksm5j5MDLY9mLvhOnNmtq/rnUPsk5OsZI4svDp5tm5opBz
	vo+oa12laj7MQDV8P7KHCy6oJQwM+YmgCmGsBcdGh/94vGRrEUsMEZXQcQ==
X-Gm-Gg: ASbGnctkMmpML4gjxYhtWN2MW03bJ9oKudEC9UUT35mYy7EFcvoqxXP2zDkcPsUztK3
	mIup0zFSrUlbXIlqvEIsO5SqnuWWVVwQ/sgXeEX2IFNROgZb2tK4oifdSsdNALd9rR+H5JJe8my
	2zyLV0uXp2kRmbHmSlQD3RSSR4y/ma7Cx58hvaY4VRNj4qtzUXuPNaofeG0giw1GF6+0edWqOJq
	99O7LmdggDOyS/hIewL2cKsUJIEW3+17g1neoM8rfJR+kATscVe0/P/ENTolqTIBzuQS5SERmIr
	MYuVLh+ml0ZpsZg83/fdrFmtR6bZm4tMI1gS+w/Lxz2YbYpyDumA4qcXQ+U2bEqtczT9u40YYaS
	hDw4sI7M=
X-Google-Smtp-Source: AGHT+IGtTEJDgKx6kXjkrxG8yv5xGmC0q8UwVL6/L9qjkOa0EZUeDeIKcCgT2OIJ9lu3yQy0ryso/A==
X-Received: by 2002:a05:600c:1c81:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d01be6389mr74488735e9.14.1741723281123;
        Tue, 11 Mar 2025 13:01:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c588dsm215421735e9.21.2025.03.11.13.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:01:20 -0700 (PDT)
Date: Tue, 11 Mar 2025 20:01:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "Artem S. Tashkinov" <aros@gmx.com>,
 linux-ext4@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250311200119.4802d896@pumpkin>
In-Reply-To: <20250311170725.GE8837@mit.edu>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
	<20250310135828.GB8837@mit.edu>
	<20250310221243.0d5db7b3@pumpkin>
	<20250311044935.GD69932@mit.edu>
	<20250311045635.GP2023217@ZenIV>
	<20250311170725.GE8837@mit.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 13:07:25 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Tue, Mar 11, 2025 at 04:56:35AM +0000, Al Viro wrote:
> > On Tue, Mar 11, 2025 at 12:49:35AM -0400, Theodore Ts'o wrote:
> >   
> > > This really goes to my question of exactly how useful the file
> > > creation time concept really is.  Perhaps that's why the developers at
> > > the UC Berkley made ctime be "inode change time", I suspect when they
> > > authored the BSD Fast File System 42 years ago.  Personally, while I
> > > don't find "change time" to be all that useful --- I find "creation
> > > time" an order of magnitude *more* useless.  :-)  
> > 
> > The third timestamp had been introduced in v7 and it had been "change
> > time" from the very beginning, with incremental backups as stated
> > rationale in filesys(5).  "I'm sure that" from David means "I couldn't
> > be arsed to check my WAG"...  
> 
> 
> I actually pulled down the V7 sources and there was a comment in
> /usr/sys/h/ino.h which has a comment around the on-disk inode stating
> "creation time" (see below).  These comments are also there up to
> 3BSD, and changed to "inode change time" in the BSD 4.2 sources,
> probably coincident with the BSD Fast File System implementation.
> 
> So to be fair to David, I'm guessing this is what he saw.

Quite likely - it was a long time ago and I didn't take an 'offsite
backup' of the sources (and I definitely have nothing that will read
the system disk from an old 68010 box).
I didn't use Unix until the mid 80s - and I think that was SVR2 rather
than anything Berkeley. Most of the systems were SVR4 - around the time
of the initial collaboration between AT&T and Sun to get SMP working
(which, IIRC, pulled some BSD code into SVR4).

> I still maintain that "creation time" as a concept isn't terribly
> useful, and that's probably *why* historical Unix systems have used
> ctime as "change time" for decades.  Whether it's 42 years or 45 years
> doesn't really change my point.

I do have half a brain cell that remembers it not quite being 'file
create' time - probably just changes to di_mode, di_uid or di_gid.

Anyway it is all old history.

	David

> 
>   		      		      	 - Ted
> 
> struct dinode
> {
> 	unsigned short	di_mode;     	/* mode and type of file */
> 	short	di_nlink;    	/* number of links to file */
> 	short	di_uid;      	/* owner's user id */
> 	short	di_gid;      	/* owner's group id */
> 	off_t	di_size;     	/* number of bytes in file */
> 	char  	di_addr[40];	/* disk block addresses */
> 	time_t	di_atime;   	/* time last accessed */
> 	time_t	di_mtime;   	/* time last modified */
> 	time_t	di_ctime;   	/* time created */
> };
> 


