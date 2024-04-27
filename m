Return-Path: <linux-ext4+bounces-2222-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D798B477C
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Apr 2024 21:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB6F1F2186F
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Apr 2024 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AA13BB47;
	Sat, 27 Apr 2024 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPohQd7E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955839855;
	Sat, 27 Apr 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714244989; cv=none; b=EHCVL+B6fdG9Jex8OOhdekA1orX0rOnh5ASlDnuyv+Y1FpV7nFWKDKXEdBQArvtEhbq2HloXGJw91yp3MU9/b/3ZoA1I5ci9GlLx9rraOvoP3Iq967DygPNbr9gt0XhLAGMtnDcTqzFUPRZPHzKtB8r86TncyrEUeofxeCv0+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714244989; c=relaxed/simple;
	bh=7SbloZTkQ2ukuICsMqMliCPj2k4q6r34C4CagfYRFrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwcv2uI/wRqGGYzvvnijvS4jXkau+Q6uChGXkNx91yn+EXAmPqiSZxjfj7iuSrj88oaGpWt92YCgmalHFxEN4S3JLWt6siCGGWvg+4hdbBtvSbknBIXEtNuQ+EmqovrXGDkfb1KrDFboY8jXyW2jt0THiDA4XX35QgCjENA90P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPohQd7E; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so27979525ad.0;
        Sat, 27 Apr 2024 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714244987; x=1714849787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1c8QYGXght7zJH48PkTxu2QFWe6bkVZxHpdIyRM8/hM=;
        b=KPohQd7EmdZMZtWZNTCXNf65rD7vo1YAeokmHouRhj0v6HjWj1OW0Q2JRmK0j4SQ6I
         dx0yz2cMgkh0w9BoDcuxJ/xoz2FtZkH+3TijeAqB7TSIgTNCcL+guCsTzxq6NzomSrVw
         uhYOiR59puZ3U0dQWqEAXlvctOgCHJQ8/O7/yTIhTRPPlpWJ9qtZ/Lg6gc3tgJNFL4QJ
         +Eb7bwi1/ePxhd3BqLGsHaZKjzTAU7KB164/tlgrcqMZ8EZpETvbTvLGf88GbFV9Z+87
         ZeKwoKbd1Op7LInWQt4o/nuXNUcAEGLQWv7aIeL+R1/naPhb2qOfKjVcZDEbBycR0iX1
         LHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714244987; x=1714849787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1c8QYGXght7zJH48PkTxu2QFWe6bkVZxHpdIyRM8/hM=;
        b=rNyECgyIa556tB+HYpQn6ZBzEgqFpPEszzCDqAdR80AZqZQen+MGOM1DUv/AZtukZH
         yNjItslvYDzNYJ6WUfuiAilqV0pwYgo9MXvl4pUrQkDJb4zuiVi1QfY2jnQ6JXV9b4MV
         9Y4GdFSBTbyKLYQMdlQ7xPLvCeoIjnrgdEhkqPtATXzetzk1778yL/IvCDeHKZW5lhP0
         zq57H7LGuv3w6fWX6Tk44wsSAMAAKdchWetI9kfjiWkh+KNMfPiXQNNQQzQKAhsl5BXi
         0forJ1sjWAIj9o7mTOx1tvEaB22LqaND0ak2YeV8aWENX9pZtEpp03F81QTon2y6i2Hm
         4eVA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Y+vzGmLn08f6pndM4Q8hSjfaVSUH/qURmRC7GO04ri4CG6V/PhAexs7Rm+xvYN8nfSCMeGtVFMjtDii6ehUoqWnib6KYdtpv/jSi+L0cJ6u/gInqQJ540elEh9hwDh//GCr6obsjww==
X-Gm-Message-State: AOJu0Yz1Mfyl/8ypIl7m5zW+AZ3kfBK9E813gBk/KbCtknBrX71VL8up
	CMq3qkSXfGPNXS6Mj1TwhdThLkzIScoXc413U66EVrGFas1VlgzEXsr/NA==
X-Google-Smtp-Source: AGHT+IE6MDmOl71eLiJD4k1ZZi3Gq0rGB1W9bVd6c7UEGDbP5CLPQPLXydryCUbYpkCzierkHuUUPg==
X-Received: by 2002:a17:903:1103:b0:1eb:510e:9fe with SMTP id n3-20020a170903110300b001eb510e09femr3616619plh.27.1714244986864;
        Sat, 27 Apr 2024 12:09:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709029a8700b001e509d4d6ddsm17456275plp.1.2024.04.27.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 12:09:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 27 Apr 2024 12:09:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: implement filesystem specific alloc_inode in unit
 test
Message-ID: <cdeaa9ac-b3aa-4951-9c34-4b4ae71df89d@roeck-us.net>
References: <20240322165518.8147-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322165518.8147-1-shikemeng@huaweicloud.com>

Hi,

On Sat, Mar 23, 2024 at 12:55:18AM +0800, Kemeng Shi wrote:
> We expect inode with ext4_info_info type as following:
> mbt_kunit_init
>   mbt_mb_init
>     ext4_mb_init
>       ext4_mb_init_backend
>         sbi->s_buddy_cache = new_inode(sb);
>         EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
> 
> Implement alloc_inode ionde with ext4_inode_info type to avoid
> out-of-bounds write.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> ---

Ths problem fixed by this patch still affects the mainline kernel,
and is often fatal there if CONFIG_EXT4_KUNIT_TESTS is enabled
due to memory corruptions. Is there a chance to get it applied soon,
or should I just disable CONFIG_EXT4_KUNIT_TESTS for good ?

Thanks,
Guenter

