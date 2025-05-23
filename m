Return-Path: <linux-ext4+bounces-8182-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D5AAC22A1
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 14:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBE116433C
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E679DA;
	Fri, 23 May 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyMnLgRs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACD7E9;
	Fri, 23 May 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003465; cv=none; b=hKchHm631ch+WUL3oXgjQTRZaoipxtM+eeMcSP1tCPDb7Ei9e3xg9dGNQ0NDmVoifcSlytt37d5YyO29alYXPCAZIA1y/iI18jdRbJMkr5jI9YC4kNk9e2I/CjjUP3kOhX6Ypsx9F4LZkA+lH89DIUaoxPR+zBhkWqUKsnK56xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003465; c=relaxed/simple;
	bh=zYFr+I1bNQIoAAYyuQ0AB1ehPMbnBPch3q9BFHXKHZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvvJoiJ6vJvi85+n/wsivC8tAigCtXMxaihILCnegd76hx+Mxu0Mxr7C73e8EcZdatjzx7d60IA53sRT+SXKrtwbQSB4bZgg6JOMbYINW6bPfRXppyhNqS/aap7B2x/nHI0Zn3xjPlNmHE0d+5PswUVXVh2fZflNXletPRYWFrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyMnLgRs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso114417275e9.2;
        Fri, 23 May 2025 05:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748003462; x=1748608262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dy8YHa9sBE+qJ+igAsZENydvLd039JNemEnM7InNoVc=;
        b=hyMnLgRsAWmNj0Xn8FDax038kfzZstDHB5qLJIq4avUFS2OIO7SNS7aX3tBXb0CKLV
         s8kJeiW6X5DAYAGEyW7wStJHn7XyOd9JFQdlG0HX2AsAblmpOBGUfDFbiSYpXvrWRJy3
         JpfsVLrNW7WQKQ2jxLHAN4OlOXhsARD0UhVdHEp899gskTHb5Kde8juy76AtOFKxQaA5
         bsCx1SMCNroS/7s3owXyYdZst5zQwFGoRix0LLz02zWRCA8e1oEn6NIzPyIwhaZk8wP/
         ZMZ8h4za/NfiyVuPkWZirLJ7Dz6x0wFj7YM4FPRevK2DTt5XPitI2iWUIrnVhoPkiC1/
         hpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748003462; x=1748608262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy8YHa9sBE+qJ+igAsZENydvLd039JNemEnM7InNoVc=;
        b=MhriNamNpyVN7YGourrsmhYjxcwMCGORUg7Zs0iigxdOvI0sDT71vE53nA+bK1V/WU
         U8wDnPZzYS8HoSGVrwKXKtihMjwoveG8TVKZr0BTGN+xcnZsdvo5wu1VphpZfUaQBECr
         pTsgCH4NY0gXGwelwMydV7wICHDc1tQLaBCZ0uBd2dWf44tkSrCUqsgz0biUhL75CPTd
         4UZ39KtKz10zblA2Ecr315pL2VL9gymn0/JmopyoUpceA46poMR0EEd/htPZsnOFOadi
         pYzW1DStH+rJyqzQw4/K/W0PuXVSnsRnuUim/6DNx9mDasoOjhJ4zD/Zt6jRY/uA45QC
         OMwg==
X-Forwarded-Encrypted: i=1; AJvYcCV8SXg9AlPcWHP0ydSUsDR1AXskw9I/xZaM9ZKZo5q5X2x5Y3f9iuqwjCKYIBm9vii1T74pqMsR0JPrGJxEKlZ3@vger.kernel.org, AJvYcCVvmmgrEDQd6ISVukZRMZiddN4RX8a/3Ta/B2DUcIt255tvfkz8HfobZthx+/b53r4vOjq+Th4m/QTi@vger.kernel.org, AJvYcCXDB27i6xREiBkvEEflFoG7u6q7cbQlV3u+n7Qj+9c9wMoRyYFqBwKZcHQtVD9k5h7zCggTHWMdGTGMzaxU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+5MKMqDUzuE1c0jJdju61o5qLySSKhuJt57U1rzeZyhq8Vjc
	F4oqv5stpPk5ilmEUXWG+lAnOq3F9KiQsmMVuO9NqOE/uRkO/1NC4s8ERKI3Sg==
X-Gm-Gg: ASbGncu/PH6yiABucmQVayW0bGJpWxENDmqSb0l3G6CgtgPWVDlYX3nSfuEdJkcB1l8
	x9jqkFMjeBz5eShMd7hAB2dIFnUa6b6FLiRZp7C8DODMkOwVWFuEbv3Vu/MRXmrD5Ix0tejPUtC
	dMuNr2kmHpOunoOVIsvaYzMJGndk3N7oqeg12N6SkDbbo0pkNBQ7Gj7CjARkyevaAWw8m0Oh6sU
	/lIGFimPPSLmNYvgo46iARddf1gdmsdnNyBxsVjgE0lrjP43U1ShlyYz6NIkAa6UlqR/eyQ0m6e
	GhHY/8qa9TP2K5WYU2EYeO/quzjuWr0ZdoPBsUA+1IzYYsbUzO3TS1ukB/latUytuCq1QqW8SPw
	jfmrCyIVDm9rtuQ==
X-Google-Smtp-Source: AGHT+IGRY+SIJAO8OmgYserPwzfW9oLd1sgZc8DxydvmeRylB5vmFcgb6WgrcelOSrX4QdbKqmgZfA==
X-Received: by 2002:a05:600c:4fd6:b0:43d:98e7:38dc with SMTP id 5b1f17b1804b1-44b6cc055e8mr21996825e9.5.1748003462110;
        Fri, 23 May 2025 05:31:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7bae3b9sm136490745e9.33.2025.05.23.05.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 05:31:01 -0700 (PDT)
Date: Fri, 23 May 2025 13:31:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kees Cook <kees@kernel.org>, Ethan Carter Edwards
 <ethan@ethancedwards.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
Message-ID: <20250523133100.1b023a6e@pumpkin>
In-Reply-To: <20250519145930.GB38098@mit.edu>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
	<202505190651.943F729@keescook>
	<20250519145930.GB38098@mit.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 10:59:30 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Mon, May 19, 2025 at 06:52:13AM -0700, Kees Cook wrote:
> > > --- a/fs/ext4/inline.c
> > > +++ b/fs/ext4/inline.c
> > > @@ -1314,7 +1314,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
> > >  		if (pos == 0) {
> > >  			fake.inode = cpu_to_le32(inode->i_ino);
> > >  			fake.name_len = 1;
> > > -			strcpy(fake.name, ".");
> > > +			fake.name[0] = ".";  
> > 
> > This means the trailing NUL byte isn't being copied any more? That seems
> > like a big change, even if name_len is being used for length tracking.  
> 
> Yeah, and so that's something that needs to be tested (and not just
> build tested to catch the obvious FTBFS bug).

The compiler (or headers files) can also allow strcpy() of constant
length strings into arrays (known size). Erroring requests that are too long.
The strcpy() is then converted to a memcpy() which can then be optimised
into writes of constants.

So using strcpy() under those conditions 'isn't all bad' and can generate
better (and less bug prone) code than trying to hand-optimise it.

So even through strcpy() is usually a bad idea, there is not need to
remove the calls that the compiler can validate as safe.

	David   

> However, note how we
> handle normal filenames, as opposed to "." and "..".  From
> ext4_insert_dentry():
> 
> 	de->inode = cpu_to_le32(inode->i_ino);
> 	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
> 	de->name_len = fname_len(fname);
> 	memcpy(de->name, fname_name(fname), fname_len(fname));
> 
> Or were you commenting on the "no functional changes intended" line in
> the commit description?  I agree that this is probably no longer
> accurate.  :-)
> 
> 					- Ted
> 


