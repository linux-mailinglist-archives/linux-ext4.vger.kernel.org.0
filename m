Return-Path: <linux-ext4+bounces-8879-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B84EEAFC11B
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 05:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7FF1AA5945
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83301188596;
	Tue,  8 Jul 2025 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp3GGWEy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6210F9E8;
	Tue,  8 Jul 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751943697; cv=none; b=X/wRfbuV+87Gohq64Mv9KZjoWDordyECFO4Um1Cft0w3FwVvPCrvnX32qnujwqckklxGI1N8YAglxcrvzrO+40bhhhVURzZzYgSl6OttvOFL03sq+IvpafEnhq9WK/vZQ5CUisiKHGiKW26JpwOdvcZhoKm2UC66R7rGoTljcqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751943697; c=relaxed/simple;
	bh=+BeXurnvgcec7XX2vVFhp3ZKDvZGd+M3cEDZquo5nVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvqX7fdlpHRD6OS6ywOfFO05e/jZ7UK1tlPfjcs2sZpVSqYh3oXn8HHIn3qMbPE83/hQI6rVaEE3O2c9oBVnKknWg/tb7q/ZFkLCjfW28+QWrWBDfqRLso6QiMxHMChwW59oQvvI3C6zcDaIlos9bGj7Vu0+V+xZFf91wm8thlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp3GGWEy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23636167afeso37098805ad.3;
        Mon, 07 Jul 2025 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751943695; x=1752548495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gmj1hJawcW+tXN9mS5Ft1iwKlmEiCOVLQGy2pYWMUpE=;
        b=Cp3GGWEyEzxC1O/7Xi179dpMY2Bf1yVpIpfccTN8X+pFL92fX1gAc+i6T4svbApDFq
         QwW/tuLUqvlLRB1g5EI2JBDJ84nGuild3qJfKrY/yTCqXDvw1qyyz+ZNoAZ+v+X3T5QN
         4GMyup+kHwP4wlrKegBhS8vyNdDXxOSPv/WZ8aTFssS1SeJ7isgB9YZ2FK8q3pY/q4Tp
         BpgGD/sjXHpnNEUXIEsdQihJgWxbOyGkQau7k1hgM4wOhWcbgGWLweojB6LS2Ukzd8Uf
         9J1XOQkO9MyJe8YIE4bucKgl0bABFC9j2vbouLGFq7Oy045nZG7BUMRoONx7agy+hzHo
         YWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751943695; x=1752548495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gmj1hJawcW+tXN9mS5Ft1iwKlmEiCOVLQGy2pYWMUpE=;
        b=SGW/yGV7+InL8hNSZsCZz6MNCFD1Lla1E6qDTDbIeKnD0fqSksnR5JbwTDwE7w5Ioo
         051bvi6YvT7GA2O55kwdWMeWPgk9PzMmlPucTPbC5cfUpui2Qd2mPc/DpkueJUL/iF5A
         qvvHNYe8YYk3o974M4PAvuEPL/nxcbCM0B1b808ch6yokIFsfnRrLeXNLbJbqdA5ABpw
         XQcvgZWp+Cj6HrPdiPddpp/7FoUKK8480sKMoXA+9t2dCRAr8gQ1b9VZc9dhKQ+bXA9z
         5njPwJ8YBDzx/3psb+E7IA2UoGLePQ8d4DMEOckBc4fM1DVNkyJMUp7TLVVGsC9rIOXu
         rYog==
X-Forwarded-Encrypted: i=1; AJvYcCUlof0LGq6u6qaBcnb+BD939qVxG2gl4fB5kpta8Fn/huQHu/cFwHwL9twM1genCh3P2WefhHYbnU+CzCik@vger.kernel.org, AJvYcCWpnn3zECgE9wszdlbEdCVnmE/dJA272DA5wFt74I7/YgS1rnJ/RuWBaiyDwp4SWW4HWOzbjREBgX5F@vger.kernel.org
X-Gm-Message-State: AOJu0YygitmTb90MdXlAHMTwD0/2KeOb8gIoRM7PLnQ9JWSLRp10+Z7r
	goyq9+pLrExy7bonndvhhLHH+5oTVcPHwTudHR0NuAqzxcNkr3Gw/hOQFy4DdQ==
X-Gm-Gg: ASbGncu/gLHMwGLizaZKaVDxCUx0WTembaovCN8eCZRqX7iZyPXgClRj9zLV32WNnl8
	rZ9NwYgwZ8qba7bryQAOg1e/UJl9R1HSjxVGuCcfkRkDmfWXdw+arZkvEr8MEWWEsLVnA8E6J2s
	fR59LqFxRVZ/fhEZdss98yyKl5mAQtnoQtNX7TKNn+7NTOvnKRhRBoxJKavugt32AWdx71WYMIe
	0Rms34dQa5ZF8nYAbUqKQFxAd9WYdP1QTcqBr7Aa6zsg+wLRcIZnmYt2m0zQgI2bcUJNmsRwpcX
	koP0hYwsu8ecu17ANkcZcJ5dt34mFdNMeE1JtFjlF2JKL1ef1WXAfZbiDQwwL2yoLR5fbGDAUu3
	S87Mnp+0akmJW
X-Google-Smtp-Source: AGHT+IEubHsFAZcqzV2ApAFpsnVB/BOoENZZ4MFkRwoqv0KxUSBsMLMhMasInUVv/2TDYbP0WZzkIQ==
X-Received: by 2002:a17:903:2404:b0:23c:8f15:3d46 with SMTP id d9443c01a7336-23c8f154130mr105129025ad.37.1751943694997;
        Mon, 07 Jul 2025 20:01:34 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:a04b:8674:f746:99a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8434f0d8sm98539385ad.82.2025.07.07.20.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 20:01:34 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:01:31 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ext4: Refactor breaking condition for xattr_find_entry()
Message-ID: <aGyKC3ig4N74PPcX@vaxr-BM6660-BM6360>
References: <20250708020013.175728-1-richard120310@gmail.com>
 <20250708022453.GB1845251@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708022453.GB1845251@mit.edu>

On Mon, Jul 07, 2025 at 10:24:53PM -0400, Theodore Ts'o wrote:
> On Tue, Jul 08, 2025 at 10:00:13AM +0800, I Hsin Cheng wrote:
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 8d15acbacc20..1993622e3c74 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -338,7 +338,7 @@ xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
> >  			cmp = name_len - entry->e_name_len;
> >  		if (!cmp)
> >  			cmp = memcmp(name, entry->e_name, name_len);
> > -		if (cmp <= 0 && (sorted || cmp == 0))
> > +		if (!cmp || (cmp < 0 && sorted))
> 
> This is *not* identical.  Suppose memcmp returns a positive value
> (say, 1).  Previously, the conditional would be false.  With your
> change, !cmp would be true, so the overall conditional would be true.
> 
> So this does not appear to be a valid transformation.
> 
> (Note that valid transformations will be done by the compiler
> automatically, without needing to make code changes.)
> 
>    	     	 	      - Ted


Hi Ted,

> This is *not* identical.  Suppose memcmp returns a positive value
> (say, 1).  Previously, the conditional would be false.  With your
> change, !cmp would be true, so the overall conditional would be true.

I would argue that "!cmp" is only true when "cmp" is zero, otherwise
it'll be false no matter the number is positive or negative.

With some transformation according to Demorgan's Law, the following
expressions are equivalent
* "cmp <= 0 && (sorted || cmp == 0)"
* "(cmp <= 0 && sorted) || (cmp <= 0 && cmp == 0)"
* "(cmp <= 0 && sorted) || (cmp == 0)"
* "(cmp == 0) || (cmp <= 0 && sorted)"

Because when "cmp == 0" (which is "!cmp"), the condition is going to
take shortcut, so we can further simplify "(cmp <= 0 && sorted)" to
"(cmp < 0 && sorted)", since "cmp" isn't going to be 0 when entering
this part.

When you put any non-zero value for "cmp", "!cmp" is going to be false
so it will further check whether "(cmp < 0 && sorted)".

This is my derivation flow, let me know if there's anything wrong in it.

> (Note that valid transformations will be done by the compiler
> automatically, without needing to make code changes.)

Makes sense, thanks for the head up, but I think we do have some
benefits from it when compiling with -O2 optimization level?

As the bloat-o-meter indicates the code generation size can actually be
shrinked.

Best regards,
I Hsin Cheng


