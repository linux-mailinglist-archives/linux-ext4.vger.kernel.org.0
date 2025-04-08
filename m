Return-Path: <linux-ext4+bounces-7144-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E4A81611
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 21:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55917882EE1
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 19:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C715324EAA5;
	Tue,  8 Apr 2025 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ef+Uykgz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41F24889E
	for <linux-ext4@vger.kernel.org>; Tue,  8 Apr 2025 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141940; cv=none; b=ZqtTeERV/RRfV5yQfdJ7V5suy+pX6mtwp4Bkr8mXzvHB2xH+cSfrpxzu/58a28Brktc2kutuq+AI/w/aPNBh/iqfkWknvbvgZPP+AP8Z3tCb9sb1dxGCHTB87SydF0dy8YCsveKxwdIjOy+thI978ZGy9Qzi8JDd261MNE2pwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141940; c=relaxed/simple;
	bh=blK+2dSu5U1MvGMATzL2nzu5PORFi1D65ho5AwWGdJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMvVy1Cp1ijvn1La6Fkq7FuBJEUmqynoRqTH9zMdN8AVBYR3UF1pDAmhWrSPy+iewRb+pl1tnSL2l1Ca6EVuzkhHSTatan0X85t1roH9lbyM8Vzp3MTT3fxrDaBLcxRRGWsmSpT0sXrf9vUkSMImnvcFr5A9vRkcpl7jKE2pw+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ef+Uykgz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744141937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oma75DDDa0KBCALqpSmWhoycUi8mZCtafF3LLZWkW7M=;
	b=Ef+UykgzGi8I3S+owzcLPtPEtqjHq8182Uh1MBvu0cheadY2uvjufPKnYuUlrayImDwOWN
	JRrrkTHFPtOpKQGdlyXPDOAw4n9T/6veMjS0SdRv0f0wt2C7Fp3LZAafp9U//r1lTH8MbG
	jZzgUX+G/bxskBuVqxVMtOgctM6kOBc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-gwfV2KLkODeYg7lg43IK-A-1; Tue, 08 Apr 2025 15:52:14 -0400
X-MC-Unique: gwfV2KLkODeYg7lg43IK-A-1
X-Mimecast-MFC-AGG-ID: gwfV2KLkODeYg7lg43IK-A_1744141930
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so5995334a91.2
        for <linux-ext4@vger.kernel.org>; Tue, 08 Apr 2025 12:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744141930; x=1744746730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oma75DDDa0KBCALqpSmWhoycUi8mZCtafF3LLZWkW7M=;
        b=Buc94btejlomA/AdGyzkkJPOqty43mIKwP57HzUAoVq3kioOB74NAYpqPbmVU7k6Nr
         DPPJdvuLu8Tho5Cgt6OmLsu83pZUmtdM5Esh1oXIgqTyrzpVlT1obM586U1TJldjX9m6
         AdiHQVTUyHhkjaTyiUTXS9OU7r+bdAy3d+7ROnoCLKiNZQZ12ZTc3jdQYp8uHxmJ85EN
         KGfN73kGOsh3JuCajKVnwWw7xZKpTU8+wM1ld+u+i4BF5le/JExLo5r6sAHlIS1Blfs/
         IDiA0NifE06qi27eO3Hk+txK4Pvli416enQ6vqYrvyONkOsrkPB+wkxQetLleqTsoxGK
         KgHw==
X-Forwarded-Encrypted: i=1; AJvYcCVQdZD5vaYU+1uSt10cROkqkIXapFiF+sywcx0YZ44gOul8YcFERqENNcs7z8YpBTWSKFJVLlUpUVdc@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEBBMOoIbx+Os/VXZI9GHD3ibz+xqn+sdM4UAumZaxpXXuuv0
	KhenptzvL9X+Gxr3Z8zjmsqC+o5AIrVfgw/QY66nhMJxug8viZ0LIPkbXYahQDJwXpAcdxhXq2d
	Sh8nu7+uSVFrqU2k0c66aw/BBuUGXZCYxXEHZrzUTBmqi0pz1d0HLMD/3HaM=
X-Gm-Gg: ASbGncvuY3ogdkSC6HDVI4E4WtNlsq0wRwSXra17pGV5P8kavxvFUSPDU+zQ9RrEbUB
	Fwt5z255ST/xLX/p0IXiGlXAY6EvkTB+92xEFJ2nJ9lGlhfYF8EA9zyjDwEpb5xyet5aFkdp6Vl
	/gV6MUWc6BGFoKBBawxsiqRPYCeEvn72K9E5QW+m9/cYCDk7DWksUsI7rzPVbMLcc3MBK9hRZ9H
	R1Bd1UzwCVshcg3t97ql1dk/jeeMaVS/sLiqgHpUwumkXLre9xAWmlTcQw0iTP+VTzaoss6GoOt
	UL2nPCDvmwQj7YxDiKr+VkEXierCiFk0IqD5mYac+MjIgzjpaIFgFzTP
X-Received: by 2002:a17:90b:548b:b0:305:5f2c:c577 with SMTP id 98e67ed59e1d1-306dbb649c0mr588759a91.3.1744141929978;
        Tue, 08 Apr 2025 12:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm7E/3wZjw60/tbMTgKGkRRZGRb84veeXZNtHIzFZfBshr9NZ1jKAa0LpWgW18rEJLmLK80Q==
X-Received: by 2002:a17:90b:548b:b0:305:5f2c:c577 with SMTP id 98e67ed59e1d1-306dbb649c0mr588736a91.3.1744141929613;
        Tue, 08 Apr 2025 12:52:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30588a2f845sm11504240a91.22.2025.04.08.12.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 12:52:09 -0700 (PDT)
Date: Wed, 9 Apr 2025 03:52:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] common/rc: fix dumping of corrupt ext* filesystems
Message-ID: <20250408195205.zelfuglmamb5w3ft@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250407235931.GB6274@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407235931.GB6274@frogsfrogsfrogs>

On Mon, Apr 07, 2025 at 04:59:31PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The parameters to _ext4_metadump are device, dumpfile, and compress
> options.  This callsite got the arguments in the wrong order, which
> causes fstests to compress all of /dev/sdX as /dev/sdX.zst which is not
> what we want.
> 
> Cc: <fstests@vger.kernel.org> # v2022.05.01
> Fixes: 9fb30a9500c169 ("common: capture qcow2 dumps of corrupt ext* filesystems")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index b2155d37a90d68..a71c15986efd18 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3552,7 +3552,7 @@ _check_generic_filesystem()
>          case "$FSTYP" in
>          ext*)
>              local flatdev="$(basename "$device")"
> -            _ext4_metadump "$seqres.$flatdev.check.qcow2" "$device" compress
> +            _ext4_metadump "$device" "$seqres.$flatdev.check.qcow2" compress
>              ;;
>          esac
>      fi
> 


