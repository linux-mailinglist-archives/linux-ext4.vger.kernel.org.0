Return-Path: <linux-ext4+bounces-3746-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C7954F64
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 18:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A183928398B
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B11BF328;
	Fri, 16 Aug 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqQVTVCy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320D156F5D;
	Fri, 16 Aug 2024 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827459; cv=none; b=JGAbvde4bPJDm5BZ0hP/cn7np1khOx8N+yPU8HGCCuSLV+lgZjw3haQnXRyFz1jIWhEVd+Hi6q3V0YIMvqAlmO7uHL8eidn4liqm0Y0e3H19goRKr82j2J0yj+/xJlF3y/KGvjxa9r3mEOvuwobXMW6X+p9/+2FIv89sYl+25Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827459; c=relaxed/simple;
	bh=P1yvz9ycQbyUFJ9qPhHHzH2AjVWgS9mQdF/uReKT7g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qM2wKrSZErKP4JNErLZRQbLEOiJAVPChFHjeQuz6WrwpgsFV3ixsmFEf9WGNon+iNF2GLsQ7Bn5s4XX16ioHud8pTJw420MvWYecNjDQg0Iv/+y88KosqjUM5Fdy51kgjfoFOXnGOCiHwyjETX0kT3ODrg7rmOqMxewvxZB3QYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqQVTVCy; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2702ed1056bso214751fac.3;
        Fri, 16 Aug 2024 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723827457; x=1724432257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfcXAQA8s+nBHjjasu7YSbRlZzK8p/CLFb6AQq7z0Lc=;
        b=FqQVTVCydUbVVNk6uAIhaKBKrCvI71q9lVrgQbcxMrdViiYzf7SZcZV++5mA3akzn+
         5aISVz1oBKNW/s+Sy22bG8OaaaZ3KKJ8a6J51P7lTZ4X17tJUWaB95a5rxnU7JzLZ6C2
         AbcKWnIHrCKO7H6grGjDDr66CNkQ8cb04MqRhZkymdiRmLJbpR+fjiF+MGG7VfMnaEKf
         6rJk2c/nEtlRuTUbjQkRAWSSnIHjnaW8m+M175Q2P8q9S1VY8HfMoFdZpRryMFSu/Mno
         5km2oJ3cTvxxcTUfWhgbI4Yz1lm9Qgqa/5deBAfn/sOqu0GgJxgVHUTlNP4gKdUhiTV4
         woBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723827457; x=1724432257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfcXAQA8s+nBHjjasu7YSbRlZzK8p/CLFb6AQq7z0Lc=;
        b=xNldvP5jYyseLxmUWUMRYSe/sP0P+pJ6JRR4husAghMz+aq8oIxdkbjmc8eVYpWPCE
         loC12DDaZFo2iRTuZPxrR4rZjci2UPRrtamlV2XO+MOvjm+utiMvYPXMOntqJdPMbL5e
         oVO2YXV2lbCbJgol1niBXGJGI7wx6ogJ3JKoX51rcC94Iy42NyVFX3bqInbxfC3wgYW3
         L25LSodEMuAnNUHj3m+Y7nCVdvrTvkDyhCsxsplBdK+7Ol/MbvBiAGmG7N7e4fNKAF0K
         snJTXv9OJ6/k5m4Z6t20jJLDyHZCnhnwX+c//QJTkOfZQL/vNnacRxKcII5s+y4RvxfJ
         Kaqw==
X-Forwarded-Encrypted: i=1; AJvYcCUyWUSVuHOR2cpmjedcPfnzj6xJQrvUj+iXmAm1R6Vn7zUC0diZDilXdbCT860ABJWzjZJmguQvMtbB26sxImkqVr3568atN7BPEHvf7E2xL/61BgTO4o5rgQkZWY9ersKkwkYl6A+BNg==
X-Gm-Message-State: AOJu0Yxa5W9Ahb+hXaziiwjas7c3XIQRYIVT/27F/u2RW2/64iPQmAZ3
	5UjsDZuYDegnFx7TMZXINdyC7n3SXBue7XqCV1e2mydGDoi7Rgie
X-Google-Smtp-Source: AGHT+IEYE2ejBgsgFgtq6CGqz6GDKOegImTu/7JlI9xvyYBxkWRoSFYCbPHdZACcKomtMveLm/T2iQ==
X-Received: by 2002:a05:6870:b48c:b0:269:2745:424d with SMTP id 586e51a60fabf-2701c5b539amr4090758fac.48.1723827456762;
        Fri, 16 Aug 2024 09:57:36 -0700 (PDT)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6359234sm3203959a12.57.2024.08.16.09.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 09:57:36 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: yangerkun@huaweicloud.com
Cc: adilger.kernel@dilger.ca,
	alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu
Subject: Re: [PATCH] ext4: disambiguate the return value of ext4_dio_write_end_io()
Date: Sat, 17 Aug 2024 00:57:27 +0800
Message-ID: <20240816165731.1007238-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <9de82d23-902f-cb18-7688-f5e687e86d14@huaweicloud.com>
References: <9de82d23-902f-cb18-7688-f5e687e86d14@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 20:21:22 +0800, yangerkun@huaweicloud.com wrote:
> 在 2024/8/15 19:27, alexjlzheng@gmail.com 写道:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > The commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
> > direct IO") causes confusion about the meaning of the return value of
> > ext4_dio_write_end_io().
> > 
> > Specifically, when the ext4_handle_inode_extension() operation succeeds,
> > ext4_dio_write_end_io() directly returns count instead of 0.
> > 
> > This does not cause a bug in the current kernel, but the semantics of the
> > return value of the ext4_dio_write_end_io() function are wrong, which is
> > likely to introduce bugs in the future code evolution.
> > 
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> >   fs/ext4/file.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index c89e434db6b7..6df5a92cec2b 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -392,8 +392,9 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> >   	 */
> >   	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
> >   	    pos + size <= i_size_read(inode))
> > -		return size;
> > -	return ext4_handle_inode_extension(inode, pos, size);
> > +		return 0;
> > +	error = ext4_handle_inode_extension(inode, pos, size);
> > +	return error < 0 ? error : 0;
> 
> Why?

Before commit 91562895f803 ("ext4: properly sync file size update after O_SYNC
direct IO"), all filesystems' iomap_dio_ops.end_io() return 0 on success and
negative value on failure.

Moreover, this confusion of return value semantics caused data corruption when
this above patch was merged to the stable branch. See
https://lwn.net/Articles/954285/ for details.

> 
> iomap_dio_complete can use the return value directly without any bug. 
> And I think the code now seems more clearly...
> 

In my opinion, clean code should be clearly defined code, especially the
interface functions connecting various modules. So, what is the return value
definition of iomap_dio_ops.end_io()? What is the return value definition of
ext4_dio_write_end_io()?

Thanks,
Jinliang Zheng

> >   }
> >   
> >   static const struct iomap_dio_ops ext4_dio_write_ops = {

