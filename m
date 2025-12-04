Return-Path: <linux-ext4+bounces-12156-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9993CA4691
	for <lists+linux-ext4@lfdr.de>; Thu, 04 Dec 2025 17:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAF233027DB1
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Dec 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F829ACF7;
	Thu,  4 Dec 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ0ef+17"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4D28682
	for <linux-ext4@vger.kernel.org>; Thu,  4 Dec 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864381; cv=none; b=UDSlWypjomFEkJvqipwZgj4eVIH7ZgxQrzUJLjKEc08T9ndQ5V51OFLyUuDL8yXV8C+EgeE/UBSlWKSgkOO9oBrZM4gnj/lz5b8L09pXMLOZ767/UZJWAkrBpwcHRrJXjCwamatJzP3YduiYbRIlNJn4vatKick9VKWmW45HLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864381; c=relaxed/simple;
	bh=xXQZL4XRqapOpPAjZe/DTlodJEzzdFw6jF/jZNBkClo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uV1bGzNP3sS4I5WmU2Z7zj6+0od19VDbynQAXLU6G9/DrrJeDlYtIdllvyMFyMz3S119xlP7m0cDn/0ZISiKPRrdkQpAD7TyiJ+5Aq66KK/asNTiwuT9J+Wvfy5Qd5VkMQ8ejNbIdawJoKgnzG4NUcu3J0G8NADItxIpB4Z44ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ0ef+17; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so9727185e9.3
        for <linux-ext4@vger.kernel.org>; Thu, 04 Dec 2025 08:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764864378; x=1765469178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXKq9E2d1BT8u3SfgrZoGjtWQWoazLglvSADoK1+opM=;
        b=MJ0ef+17S9oLVDNEqv2QkrFxP/ch0Ia8d9c58eTkiWPj3v6JVtpfLRrZs04wCadrl5
         bkFciE4RwulksAWdr4gXhuaLZ+umEECUUIL5LYsdrPh+KeACrY1xtvqd1ZCz/7amWU9S
         2ScktO76IjzuJvW4clLErzj+06cFTLkjsMuZXrKIjaVOg3szuw1259DwcJZV4fFnbw2x
         FjPsdxTj1ydkyKlpB3XddRuKoaawKJm6fZP4ibMd7kpbOP578WyRu+10AoJgkjHVpwSg
         zZJaimJ29awPhpJ24iiSCvT1eIOEHE1NOd8PgxmHzwRzcTtF/ZZ8Tx13q0XMdGBJByV+
         b4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764864378; x=1765469178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dXKq9E2d1BT8u3SfgrZoGjtWQWoazLglvSADoK1+opM=;
        b=nfH/S/D4c6B3ZdgbeOLaLNKaoCy0Z3CiBA+5h3u+bmtarNVrljt2NJTb3gMFhhDvC/
         v4JJ4nwUzhW+yZpMzZZC5MRRv3GgBlX0PXA7Ymv0fB+b95Ax4r/+uD6TjZaK9oqi5Bh9
         dsZsHDEznbgN+DYDQYWgkbmWUwsaNjDQdnU5NJAL5Era2dltaCwkyZFjqibjTQdP7iHA
         Ml1ul4BhgzSIuunvUVjW9pjTJMwXo2SfKZtDWOt3IZqy2OLhYNhdNKKGUBdR6C4vgmHV
         vtPJx+smzLzaciVL7lFnXyIhXiRh9xdmw9PgO4V6O4wFMr5Of8JCFsDPOisbJCxOnj4W
         gMug==
X-Forwarded-Encrypted: i=1; AJvYcCVYBdBl5bko7t4mER6zehyXLSvQmg8CJTGaOxOezxd19kazg6bCNpygPSFnv3j8UmvE0xhocCGGMWx9@vger.kernel.org
X-Gm-Message-State: AOJu0YwK62N2XhcXgYV7VPn6PrWrYy3Y0cwjhPTDn3WdRjU93ECkOpVL
	A/+UQwp3uCrdCT0K+NbCr/HmysSXHkVMWK0I/tKV75Xv6RDcU6TjOnJB
X-Gm-Gg: ASbGncvKLPUxNUHQOpWDPP8203kGoIuF6VlogJt/GjLasgzYddLLKOUOoEK4hVhTsVD
	1KuLQdOB5yF1iKO6BwbxIt6hgDlneZLQbmF6x/ZRz1HBFM46+lnXuVuR1Zm4EwdYDaQVysuQSNS
	3/JpFgGgfctoSWisG2arntZlibGltE1a5i2z23JjUvlFML2MLNNSuT+8vDo4TIeFIn7NrsgVIYe
	1UhLCyZmZPwl54lizPXB8La9009el5YDzetrXVV3IixrKoK3InGUUV4esk7pBMEe8WVqYQvYeyu
	l70e5q2sLBH1YRM6dy3oquelQYxwP4s8wZ8XqO/HvOx9gS6i/Eelt7pNNgq7S0uu8rnJQ2Frrr/
	LO+fFHQ6W45ZV7dcI2zAXVX6F6PyAp43xLoZD6Ut4nA+vw9doFsVIDfaNBU1+qFYLTe8ilvWMc2
	t2M3I3HJwEg9pe741PDEyFxrtfycTgzsFEHG1gm7GrHS/BpFu7Q4l1
X-Google-Smtp-Source: AGHT+IGjDfSaOP0WWHDkFxUHwKFzufcnMBp7gCeM0mvuDse3NTaXQKKxv3oelMPj3t4na6gRs5v1QQ==
X-Received: by 2002:a05:600c:4f54:b0:477:97ca:b727 with SMTP id 5b1f17b1804b1-4792af34840mr80627185e9.19.1764864377404;
        Thu, 04 Dec 2025 08:06:17 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479308cd87csm40628425e9.0.2025.12.04.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:06:16 -0800 (PST)
Date: Thu, 4 Dec 2025 16:06:15 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.cz>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix ext4_tune_sb_params padding
Message-ID: <20251204160615.3e89de15@pumpkin>
In-Reply-To: <6893f1e7-3e0b-4cf1-9c35-5d28b2507129@app.fastmail.com>
References: <20251204101914.1037148-1-arnd@kernel.org>
	<20251204123507.2e6091a9@pumpkin>
	<6893f1e7-3e0b-4cf1-9c35-5d28b2507129@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Dec 2025 14:42:06 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Dec 4, 2025, at 13:35, David Laight wrote:
> > On Thu,  4 Dec 2025 11:19:10 +0100
> > Arnd Bergmann <arnd@kernel.org> wrote:
> >  
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The padding at the end of struct ext4_tune_sb_params is architecture
> >> specific and in particular is different between x86-32 and x86-64,
> >> since the __u64 member only enforces struct alignment on the latter.  
> >
> > Is it worth adding a compile-time check for the size somewhere?
> > Since the intention seems to be that any extensions will use the padding.  
> 
> There is already ABI checking with abigail that ensures that struct
> members and sizes don't change in the future, which I think covers
> that. I would also like to push my series to enable -Werror=padded
> in the header checks, but I'm not sure yet what others think of the
> idea.

Putting it in the command line is going to be griefsome (at least in the
short term) even for uapi headers - where you really don't want padding.
(Tell that to some of the standards bodies...)
It is a shame there isn't an attribute, but you can wrap definitions:

#define check_padding(...) _Pragma("GCC diagnostic push"); \
    _Pragma("GCC diagnostic error \"-Wpadded\""); \
    __VA_ARGS__ \
    _Pragma("GCC diagnostic pop");
    
check_padding(

typedef struct fubar {
    int a;
    char b;
} fred;

) /* check_padding */

I've thought about doing something similar to avoid the 'type-limits' check
inside statically_true() and the like for W=1 builds.

	David

