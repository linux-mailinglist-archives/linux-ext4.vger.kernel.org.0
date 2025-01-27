Return-Path: <linux-ext4+bounces-6247-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B4DA20013
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2025 22:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F9D3A3CD8
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2025 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7EF1DA60B;
	Mon, 27 Jan 2025 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cgDgaDm3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC41A83E4
	for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2025 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014413; cv=none; b=GBMV2SaUVgAjQhoAXW8z2+tS1QZFFl4RVO996OZFpBl8g89e82KR5KujvLBdbNvkaFSgyTpEgL8Q6DsdYsTvTDSIGqrMRram97gmsDxWUVbYj5hNvx4iUosvEE5eMWv8wHNqOuaDd69a96VB8RN5VWju3kLNTjkciXyWUSLwtRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014413; c=relaxed/simple;
	bh=lxgjK/YaP9QEM+cP1snuQp98WWK2Il9QCcHaoiANiKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB0XiQaivXR4f5X5Q/0au6fK7+b/WgaIXJDlKEusKJ0LxE64bpRw184EA39+I9dMZIOjSE1R4NL8k8BdNun5M9qkRblrdOb0C5fbDs5zt1HScJo53AtgM9wrgvs6nxE79VT5/sxvqtIfy3IFsd8jyhzR+RkrbPe5Dm47KKPWbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cgDgaDm3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-218c8aca5f1so118843745ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2025 13:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738014411; x=1738619211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tE/pKF5Qpj4D13Y1PjIw9zjH1S0tIXaq7kjvEPBHMJ8=;
        b=cgDgaDm3rzgH0yHnpSdkcQdfoxaF9sdAf0+o4P3KdrS3v3uSKz5W26SQ4L6BaZ2ils
         Q1j2Q8YAQNomSw0pJBFfqg5aBsuUKc9l7XC/goX9cDdNUecpNpv2Jeh9ImT7u2flTbpT
         XyjBVv7I/jDMCO4h1rOI976OHJB8xoI4VezMig0c1KpuIwUltGtvCiz4ZfytWH1j19q7
         BDXz7ckrQEoAgq9b/WgUPNB00SDMnAzwfWHILo6QiiowwlBEVQxuQJ/xM3SUOUm4f7hp
         06bE+KHwxh+H8NXCtObTuX3jb9rA/jMVu0l2jg2vRmsgZZnSBah6jWTegYSj8z8TP0dy
         rGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738014411; x=1738619211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE/pKF5Qpj4D13Y1PjIw9zjH1S0tIXaq7kjvEPBHMJ8=;
        b=hrZ/c0E9JBxOs9Uju8aziQPCdlKDsjoul4rwLIp6jke8QW6Dgnvjs18nNe01O02A4J
         XWAK+qkjB2yHaVcnC1Omp3YzkiEHQK9DwlPPg8/FuWwN9n/uWWYw1O8G73BzhA2HAwm1
         mvt35mylk1JJkoLDkg+7evB5fS0ryhFMzUUiEulpsrCLjCB+y0M7imiqJ0loyqB7iyc3
         6dyo5nE9ZhYj0Nh7OEb/tIoG6voLiPrd3vrrNzxnoIG6pveGxPwX5hTeWFQYg88pY1n/
         r42duwXQMIHYDUNydKXRFEBEcNMNvDA1OZZNcd5HE51dfy2rJJglTts0dbdo3b0C2fNy
         lk4w==
X-Forwarded-Encrypted: i=1; AJvYcCV/wm+fn8kh7Ls2BFC7dehbJsv0JC0+03LkyaYjuKCIeV1G+3s5g/K0hahgrkYEGdJEM47Qs24W6mhP@vger.kernel.org
X-Gm-Message-State: AOJu0YyaLoqWdVxJfHvWSIeaZrpryQJsh6wBKanxSKhB0rr+phZEDoKp
	+Zb9vIspjJvl4AJ+xGut2EasZVh0Lwx5JXDGIfLJUe4d0qwdhMCboESnw9d+O+xYCAJJtgrVQc+
	E
X-Gm-Gg: ASbGncuhQZ7rf4jvrcWQoCJNNf5qhS8opVUVR7vcLFUJch5bzUzL9bXBP84l13cCYf3
	Ndtkgv0y6Tt0FbBtLSdM1QQvqmTG0WTCWlhwsVGx4BgDTXGCI07diccWUs6fDiZB4cSG+DZB69x
	QTMaFFrZK9Y/h/hfTAknJ7fPPHVtgFDUH8fhATH8sRIpFMFR7d6BeNlVzzAKpPgIR+ptvza3Egy
	RhPP7clCjDLtBtSy3Z0JKJIdAuMAOBPDniEGBqBjSxl6C8zC3hWOP+l5pPv1sNaC/t+sNQB9bzY
	aNVQ9a59K89j49IxMUoyFLA8NwQuE0Ciw9R2udACD6UzO9URs6EqNDWY
X-Google-Smtp-Source: AGHT+IFOwuNx7AccdAPMTsFd/TrWMswt+hLsvIyhT6c29rKAdR6DsscbjKEXbJOOcqxAD+W5F/S89g==
X-Received: by 2002:a17:903:2306:b0:216:4676:dfaf with SMTP id d9443c01a7336-21c355eeb01mr670638065ad.34.1738014410766;
        Mon, 27 Jan 2025 13:46:50 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414edb3sm67875775ad.202.2025.01.27.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 13:46:50 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tcWwR-0000000BKHp-2nR9;
	Tue, 28 Jan 2025 08:46:47 +1100
Date: Tue, 28 Jan 2025 08:46:47 +1100
From: Dave Chinner <david@fromorbit.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext4: use private version of page_zero_new_buffers() for
 data=journal mode
Message-ID: <Z5f-x278Z3wTIugL@dread.disaster.area>
References: <20151007154303.GC24678@thunk.org>
 <1444363269-25956-1-git-send-email-tytso@mit.edu>
 <yxyuijjfd6yknryji2q64j3keq2ygw6ca6fs5jwyolklzvo45s@4u63qqqyosy2>
 <CAHk-=wigdcg+FtWm5Fds5M2P_7GKSfXxpk-m9jkx0C6FMCJ_Jw@mail.gmail.com>
 <CAGudoHGJah8VNm6V1pZo2-C0P-y6aUbjMedp1SeAGwwDLua2OQ@mail.gmail.com>
 <CAHk-=wh=UVTC1ayTBTksd+mWiuA+pgLq75Ude2++ybAoSZAX3g@mail.gmail.com>
 <CAGudoHHyEQ1swCJkFDicb8hYYSMCXyMUcRVrtWkbeYwSChCmpQ@mail.gmail.com>
 <76b80fff-0f62-4708-95e6-87de272f35a5@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76b80fff-0f62-4708-95e6-87de272f35a5@intel.com>

On Mon, Jan 27, 2025 at 12:52:51PM -0800, Dave Hansen wrote:
> On 1/26/25 14:45, Mateusz Guzik wrote:
> >>
> >> So if you don't get around to it, and _if_ I remember this when the
> >> merge window is open, I might do it in my local tree, but then it will
> >> end up being too late for this merge window.
> >>
> > The to-be-unreverted change was written by Dave (cc'ed).
> > 
> > I had a brief chat with him on irc, he said he is going to submit an
> > updated patch.
> 
> I poked at it a bit today. There's obviously been the page=>folio churn
> and also iov_iter_fault_in_readable() got renamed and got some slightly
> new semantics.
....

> Anyway, here's a patch that compiles, boots and doesn't immediately fall
> over on ext4 in case anyone else wants to poke at it. I'll do a real
> changelog, SoB, etc.... and send it out for real tomorrow if it holds up.

> 
> index 4f476411a9a2d..98b37e4c6d43c 100644
> 
> ---
> 
>  b/mm/filemap.c |   25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff -puN mm/filemap.c~generic_perform_write-1 mm/filemap.c
> --- a/mm/filemap.c~generic_perform_write-1	2025-01-27 09:53:13.219120969 -0800
> +++ b/mm/filemap.c	2025-01-27 12:28:40.333920434 -0800
> @@ -4027,17 +4027,6 @@ retry:
>  		bytes = min(chunk - offset, bytes);
>  		balance_dirty_pages_ratelimited(mapping);
>  
> -		/*
> -		 * Bring in the user page that we will copy from _first_.
> -		 * Otherwise there's a nasty deadlock on copying from the
> -		 * same page as we're writing to, without it being marked
> -		 * up-to-date.
> -		 */
> -		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
> -			status = -EFAULT;
> -			break;
> -		}
> -
>  		if (fatal_signal_pending(current)) {
>  			status = -EINTR;
>  			break;
> @@ -4055,6 +4044,11 @@ retry:
>  		if (mapping_writably_mapped(mapping))
>  			flush_dcache_folio(folio);
>  
> +		/*
> +		 * This needs to be atomic because actually handling page
> +		 * faults on 'i' can deadlock if the copy targets a
> +		 * userspace mapping of 'folio'.
> +		 */
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>  		flush_dcache_folio(folio);
>  
> @@ -4080,6 +4074,15 @@ retry:
>  				bytes = copied;
>  				goto retry;
>  			}
> +			/*
> +			 * 'folio' is now unlocked and faults on it can be
> +			 * handled. Ensure forward progress by trying to
> +			 * fault it in now.
> +			 */
> +                        if (fault_in_iov_iter_readable(i, bytes) == bytes) {
> +                                status = -EFAULT;
> +                                break;
> +                        }
>  		} else {
>  			pos += status;
>  			written += status;

Shouldn't all the other places that have exactly the same
fault_in_iov_iter_readable()/copy_folio_from_iter_atomic() logic
and comments (e.g.  iomap_write_iter()) be changed to do this the
same way as this new code in generic_perform_write()?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

