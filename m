Return-Path: <linux-ext4+bounces-11870-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4AFC61BD4
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Nov 2025 20:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6C6E359C76
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Nov 2025 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CEC24A04A;
	Sun, 16 Nov 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjLTwkWw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B4D2417D1
	for <linux-ext4@vger.kernel.org>; Sun, 16 Nov 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763321722; cv=none; b=spmlLsXdIcfBsH5oITGG0AKa09nsEkCRdoH+KoeDVJ+20ugMfZrUz8fqFqSrR0XoKiQd1SH6Hyez0yPzH+tKYZ4jMTsyZddmo4D7LKaNlPgpDDULicTiOE8wgTMxMyWHL4MfwHS/JQw2UWZdy3MU+6r3gQ8VAZZZfYYanmHITvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763321722; c=relaxed/simple;
	bh=+XLyfB9syaM1dcJAJnv3sk1oOZlE3BUe4nk1wRoQJMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gu4RzCCopqPqSBgVh0WJ0iyQGwUJUOXbX9/QBr2lYyWaUUFIZRnx7FFIDhYpwtfanTe/YeiFo8WKlAz8X6oPG1ONYWuWync63AZ1v3/62XrvYpHx3SqzNHFSYn0Unt5xHm58+R/iFrycKn6Zsg4VPlsbLj8X1QDVLnHOrJp31do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjLTwkWw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477632d9326so24946395e9.1
        for <linux-ext4@vger.kernel.org>; Sun, 16 Nov 2025 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763321718; x=1763926518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOm/Qpp1i5LjY0bBSuDn0L0O31rDBT9dvq8zoJW3Po8=;
        b=XjLTwkWwAIrNemm0YLeg1wi6n0KSC09ukb3cOwWqwOudQ+ScaRY4/7rBHkWu85ZI1W
         q9MQkRkKcBT/r7WgGo5fM6MMEJ8mrJaiBAWLp8XRH/9JCPGooAQnDiCMdx+A8wHrqFRk
         OntvUPNRF6mK0X6Thpp4rAscK1yUjw8CFszmQ09vCbbXFfVm9SQeC39Jqagfoo1LLCTM
         3qZULcdHtEmDmw+y6x/YRdEYPoE0y++ptQlNGIIx3dop7ETe915OK0wAQUlCJHeMwLO7
         313HPOpp6u6g2oP830KnkgS77K/u9zuavoGBXfcr0rC4XDE+xJ2x/rWfI6NOI+yQX5sI
         CwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763321718; x=1763926518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zOm/Qpp1i5LjY0bBSuDn0L0O31rDBT9dvq8zoJW3Po8=;
        b=rUSg2H7LvnEKiHUWbPjGh83VfwJi0l+YSmkxDy2/QXgkCZ//+oAfU4VsxSk6qRa1aG
         y21SR6k+PBF3q8ipKz5d/m491E+VYz/+DALhtuyuWrpDE+u9PN3/zK7UiDTQ5Pktx91n
         qxVZXpfjO+QZzYw2ce6bLs1MgsJ9JpNE1sK0CMzzT6ehIpOEHycIz7KgvStmaJraFacM
         sv3Ie6vdUPoqoLp6AsvfXYH/cTs5qfy4ANkNo0czxuRXxUW95QbJMfXbZps9Pi6FSh/1
         UAg2zJGG6ejKV6+rPak69YOvAlK7EV6/DItR9K226uvV9+8cCRc8Harp27ABiHQMTgYY
         6g0w==
X-Forwarded-Encrypted: i=1; AJvYcCX1bmcnlPAp5XEmmsoajtlKs3qcHRPlshh/JBL9lL1MX/ACbmz0VhYg1ySV1saVanK6kCN67vIibde8@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDpyqwhy/cI+QprYWGP5FzxYC1s7dgIcJjFocGrN5vi19BULg
	3MOmcA48XWJL1f97cKaA2rREu07ySgA6Hr7r6RRdAcIaVHqR1AS05L0F
X-Gm-Gg: ASbGncuLztxP8Mhbi8qsKUVqSLmxZ/Bhav7ki6E/Pe7hwzUsZitv+GZt++a2v1db4Mh
	jltnE/a+tHdCn/EXvaoSpRLdyeKucAAYcZtos5s2fqbOua3+GiCQJqSR61BkNMV4oyi7nYQXInd
	UqQR2AuD/5+JODTvwqxhwcyNzVA6z4RgR87bVllKF0RNU0P5Q6kpeR3iw4Ahpx2yk+DUxcZ3Bdv
	ag421wCANSYxggyodHcp6Qcfj4sSl3gEmMmk1jtqelKwSHtojK/t6sCXW9bu1OMaVMlwcN70XEY
	st/3p6N2zLYpAmsuliK5KFKI7hdeHncr4mFXj+MkW8ynja8XOwi20Up1U9X60ZLlxYnD8oILCEc
	Kvo514M2PgfcylsenHyfnggF5kA7f1Ue45PaHaECp0gYtjMCt230LIZpq6qSLE6Eft/ir0Dg9BK
	vNtASbNUy9pIdvM9PiYmqVYt7iHwoJ2Pkzh5TYJoCRxptK/uqq7fkF5TCuf0vUaPI=
X-Google-Smtp-Source: AGHT+IGB/ejYIOC3uJdhg8ZHcXpMggAMjYaFDOy6y4q3frzPxQKbzbj2VHa9rnFlVW9v4A+9gfDzsg==
X-Received: by 2002:a05:600c:1f12:b0:471:c72:c7f8 with SMTP id 5b1f17b1804b1-4778fe9b44dmr100716205e9.21.1763321718307;
        Sun, 16 Nov 2025 11:35:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb54bbesm93931885e9.5.2025.11.16.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 11:35:17 -0800 (PST)
Date: Sun, 16 Nov 2025 19:35:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, visitorckw@gmail.com
Subject: Re: [PATCH] ext4: improve str2hashbuf by processing 4-byte chunks
Message-ID: <20251116193513.0f90712a@pumpkin>
In-Reply-To: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
References: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Nov 2025 21:01:05 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> The original byte-by-byte implementation with modulo checks is less
> efficient. Refactor str2hashbuf_unsigned() and str2hashbuf_signed()
> to process input in explicit 4-byte chunks instead of using a
> modulus-based loop to emit words byte by byte.

There are much bigger gains to be made - the current code is horrid.
Not least due to the costs of the indirect calls.
It is better to use conditionals than indirect calls. 


> 
> This change removes per-byte modulo checks and reduces loop iterations,
> improving efficiency.
> 
> Performance test (x86_64, Intel Core i7-10700 @ 2.90GHz, average over 10000
> runs, using kernel module for testing):
> 
>     len | orig_s | new_s | orig_u | new_u
>     ----+--------+-------+--------+-------
>       1 |   70   |   71  |   63   |   63
>       8 |   68   |   64  |   64   |   62
>      32 |   75   |   70  |   75   |   63
>      64 |   96   |   71  |  100   |   68
>     255 |  192   |  108  |  187   |   84
> 
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> ---
>  fs/ext4/hash.c | 48 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
> index 33cd5b6b02d5..75105828e8b4 100644
> --- a/fs/ext4/hash.c
> +++ b/fs/ext4/hash.c
> @@ -141,21 +141,29 @@ static void str2hashbuf_signed(const char *msg, int len, __u32 *buf, int num)
>  	pad = (__u32)len | ((__u32)len << 8);
>  	pad |= pad << 16;
>  
> -	val = pad;
>  	if (len > num*4)
>  		len = num * 4;
> -	for (i = 0; i < len; i++) {
> -		val = ((int) scp[i]) + (val << 8);
> -		if ((i % 4) == 3) {
> -			*buf++ = val;
> -			val = pad;
> -			num--;
> -		}
> +
> +	while (len >= 4) {
> +		val = ((int)scp[0] << 24) + ((int)scp[1] << 16) +
> +				((int)scp[2] << 8) + (int)scp[3];

The (int) casts are unnecessary (throughout), 'char' is always promoted to
'signed int' before any arithmetic.

> +		*buf++ = val;
> +		scp += 4;
> +		len -= 4;
> +		num--;
>  	}
> +
> +	val = pad;
> +
> +	for (i = 0; i < len; i++)
> +		val = (int)scp[i] + (val << 8);
> +
>  	if (--num >= 0)
>  		*buf++ = val;
> +
>  	while (--num >= 0)
>  		*buf++ = pad;
> +
>  }
>  
>  static void str2hashbuf_unsigned(const char *msg, int len, __u32 *buf, int num)
> @@ -167,21 +175,29 @@ static void str2hashbuf_unsigned(const char *msg, int len, __u32 *buf, int num)
>  	pad = (__u32)len | ((__u32)len << 8);
>  	pad |= pad << 16;
>  
> -	val = pad;
>  	if (len > num*4)
>  		len = num * 4;
> -	for (i = 0; i < len; i++) {
> -		val = ((int) ucp[i]) + (val << 8);
> -		if ((i % 4) == 3) {
> -			*buf++ = val;
> -			val = pad;
> -			num--;
> -		}
> +
> +	while (len >= 4) {
> +		val = ((int)ucp[0] << 24) | ((int)ucp[1] << 16) |
> +				((int)ucp[2] << 8) | (int)ucp[3];

Isn't that get_misaligned_be32() ?

	David 

> +		*buf++ = val;
> +		ucp += 4;
> +		len -= 4;
> +		num--;
>  	}
> +
> +	val = pad;
> +
> +	for (i = 0; i < len; i++)
> +		val = (int)ucp[i] + (val << 8);
> +
>  	if (--num >= 0)
>  		*buf++ = val;
> +
>  	while (--num >= 0)
>  		*buf++ = pad;
> +
>  }
>  
>  /*


