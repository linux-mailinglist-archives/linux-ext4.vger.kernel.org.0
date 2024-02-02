Return-Path: <linux-ext4+bounces-1064-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DB98470F0
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D13D1C23F82
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 13:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4B20F7;
	Fri,  2 Feb 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKgvQAD3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DB1755A
	for <linux-ext4@vger.kernel.org>; Fri,  2 Feb 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879740; cv=none; b=HoA6/8IIDwT+O/OvratLID7vPg22dXjeVCSnoXcgxTgBmJn1bDLxTVcqHD9mKIOTchOQI3kvvxlMNHIgWnhTMT3+bQ8zAv+Lk89DePEIST58pacExnO1ppf2e+bNODJLqsrWDrwb6q9PNGixByxy9ppRe4rcZo98nqiP8KkyyyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879740; c=relaxed/simple;
	bh=WfittIrkOYFPzk2rCzCMPIcDdcjW8IBbvJaYm8qMAgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwws6fbMdIacvo7lHRP7Sb8K2Fi/fp1gJwAUJqK5C/DVKPTHQ2t1aqGvVItGnmM+b3XmjhXJyI/rXfoTUdB7ufCk+L8uqOnpBIM8bMNrIA/AKpGR8+w6EsWJ28FXSk5xzKoCtgpjrZye9PSi2xSi5zUo4CfgriogNH61pCYZ4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKgvQAD3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706879737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Om98aIFFkI/6GP1+GxMYTlvJbRDlSfik3uOG+O17X4g=;
	b=aKgvQAD3ekR+hIVUi3npGisPdSalNEOEyLbvkzRTWMt73Z1y9IFz2kZKePv2pcZ9EpxaX5
	qPZv6WnslkUpkPjBc9Xg5W7lfd5p15HOYwFh74EYi/9T34iAyrvvsD2O1GCW22V2DKyFDy
	7UTstKUnIaASETINJXamurhiKHzmBCc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-tdkBFNBcNiWi_l-8jgummg-1; Fri, 02 Feb 2024 08:15:36 -0500
X-MC-Unique: tdkBFNBcNiWi_l-8jgummg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2962056d9e7so1513671a91.0
        for <linux-ext4@vger.kernel.org>; Fri, 02 Feb 2024 05:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706879735; x=1707484535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Om98aIFFkI/6GP1+GxMYTlvJbRDlSfik3uOG+O17X4g=;
        b=XiqoPXPKUUg7g9L3K5+tMXydKQJKmXgssojM8Iu6u2KoVNZ2UDiLIbnfezcjze5+MR
         mWuX+5+8ASUzmU9ioOEg+MbTIrYk66lmt+Qmh4ydjB5SnD0vATwPLgMCsKJv2Dx629Yh
         NcmriibktPhj5E8g1ESDlYbMJWAqjl9YoBG4/cZRwGay9GZ0hEZtmfMsy0zR7Ie6Kl+B
         yOcg31z/qwGRRhtSRdzeU5hjtYDcBKjtTJIWL8jnEdn1q8x+mIvKfgH+leceMvX8TQeM
         U+GM/g1uBEFiTzEfcIhuBz3fgPkLYrkM3eIno/jsg1x9GGrz5CUsBZAOQ4SsFXG1bbtT
         /W0A==
X-Gm-Message-State: AOJu0YylfRS2Q9vJ9IPGkJmo0P95qw6+Udl3mYZSDdwaj9oXLUfp8xWC
	F0N9zhj0jlpWQPP4mxQjc3mMHNz44adtlJngUSyJ3idTRLMmX9EVTYIT/U6OKEHUiUJQH6zhMhP
	JzsH8sMUlIFStOu369p5+PahlgrcAVwInU6OvXaRIj/WNCeAdhd7AKOKtjbs=
X-Received: by 2002:a17:90a:f2c3:b0:295:f71e:3a06 with SMTP id gt3-20020a17090af2c300b00295f71e3a06mr6890437pjb.37.1706879734989;
        Fri, 02 Feb 2024 05:15:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESKt+htB2oRD/ZBm6B+Z2qtwGgVmuYLz7kVncIgWy6iO+xKstkduRtDJICrHHcBplt8x8wdw==
X-Received: by 2002:a17:90a:f2c3:b0:295:f71e:3a06 with SMTP id gt3-20020a17090af2c300b00295f71e3a06mr6890417pjb.37.1706879734682;
        Fri, 02 Feb 2024 05:15:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIzUg0CcSOoymOl+qsJHYkEuF6rR0jBZXMtQjg4aOLxSOAmBGnA37fbEHjil5RXWPyzuIUgwQAtKvm0iC7+U+WonOiDMYLRloQygZ4+urVSshxp/SJeSbxnA==
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id rr7-20020a17090b2b4700b0029612f113b3sm1725674pjb.47.2024.02.02.05.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:15:34 -0800 (PST)
Date: Fri, 2 Feb 2024 21:15:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Whitney <enwlinux@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] generic/459: don't run on non-journaled ext4 file systems
Message-ID: <20240202131529.jn5z64qfm5r5ibte@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240124195306.1177737-1-enwlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124195306.1177737-1-enwlinux@gmail.com>

On Wed, Jan 24, 2024 at 02:53:06PM -0500, Eric Whitney wrote:
> generic/459 fails when run on an ext4 file system created without a
> journal or when its journal has not been loaded at mount time.
> 
> The test expects that a file system that it has been unable to freeze
> will be automatically remounted read only.  However, the default error
> handling policy for ext4 is to continue when possible after errors.
> 
> A workaround was added to the test in the past to force ext4 to
> perform a read only remount in order to meet the test's expectations.
> The touch command was used to create a new file after a freeze failure.
> This forces ext4 to start a new journal transaction, where it discovers
> the journal has previously aborted due to lack of space, and triggers
> special case error handling that results in a read only remount.
> 
> The workaround requires a journal.  Since ext4 is behaving as designed,
> prevent the test from running if there isn't one.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> ---
>  tests/generic/459 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/generic/459 b/tests/generic/459
> index c3f0b2b0..63fbbc9b 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -49,6 +49,11 @@ _require_command "$THIN_CHECK_PROG" thin_check
>  _require_freeze
>  _require_odirect
>  
> +# non-journaled ext4 won't remount read only after freeze failure
> +if [ "$FSTYP" == "ext4" ]; then
> +	_require_metadata_journaling

I'm wondering ... won't other fs need this, besides ext4?

> +fi
> +
>  vgname=vg_$seq
>  lvname=lv_$seq
>  poolname=pool_$seq
> -- 
> 2.30.2
> 
> 


