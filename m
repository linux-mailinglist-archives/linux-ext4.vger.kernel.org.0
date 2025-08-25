Return-Path: <linux-ext4+bounces-9617-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D57C8B346C2
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 18:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016E47A7420
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78A35965;
	Mon, 25 Aug 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyQHW3Vo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5A299924
	for <linux-ext4@vger.kernel.org>; Mon, 25 Aug 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138094; cv=none; b=FxvCSRxf1qAnysz/gheZ/veCoMSgk0Fm4gA0ZENPon9teVomLpu0A5bvK8i0bnLSAHL2VFJRXjFs9Gd+ZbSy5vlA+96JZQ5q0XdG2eCpefZaZbTuInF9fI7OsWkyrVCpICBMXSX6dy04yj/otBfbJLNEVu70pB/vqaXxB4G9idI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138094; c=relaxed/simple;
	bh=lx8unmZZotH1lOPOwGBWaz+oEXYueOAZnio+N2QuHm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRAGxZwHAwQmpqVo1gYsMflUhZvqe5PzZ6p8dVzmTbO/cVpGNh/URsOMuZRITB9Zsj/6BnoloaOTPhT3zseDZ9to/hriiAk/5UmthYzVfdohVMeHBWZ8gxnkjfZxeBtTMbWS3Vz2yUDkTkHKMoCSkmiDic995jD0HUOY6UlVu0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyQHW3Vo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756138091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S26mrjD5N2pdJld3xZ+GOHAoTX+ohujbOU33KruSQAI=;
	b=eyQHW3VoHf1AJQQExlIgxT57KKaXdK6U3CenPzCM9ToEvhdp8vmZE3zjdwTvsRzCfz2Vvp
	ANkNblAvZ9JZ4ZqAs8iWEQkXHBhLnXuG6jZk9mzrp0FP75hV2xeEHswp9k5ByRH9BcnIBZ
	nAIH4txp98tUlhzlqRnu6p08g9/2cgg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-0z8CRFVQPE2zDHvU5ARJ7w-1; Mon, 25 Aug 2025 12:08:08 -0400
X-MC-Unique: 0z8CRFVQPE2zDHvU5ARJ7w-1
X-Mimecast-MFC-AGG-ID: 0z8CRFVQPE2zDHvU5ARJ7w_1756138088
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47253319b8so3444722a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 25 Aug 2025 09:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138087; x=1756742887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S26mrjD5N2pdJld3xZ+GOHAoTX+ohujbOU33KruSQAI=;
        b=GSr5vKiD+IZxfok8n1xGE7gN4q+QPW8i0OLZ/+okq6IOqhCl1aEqMxHfJH9M3Gf9jk
         iJ+folAY8zkSu0sEUTyC1KfXvytYyGqbZm4p+SiEOA5uKGACXbYqNVk8Qg185PoZKFUe
         keWWqxoUDIeiNVski8N4kJR3bR6wLkLCyZeZts5LMpAoRKvQF7D9zr0X5gumgJPy2d/i
         MliW37ghcgxdnQB2d6Nw7C8Ha6DGRfRiSpiRXDzEqbfHBeID08Oa7vdqJw11lRYQSjNs
         oBsUBxAoZoTX3D6xg4DGvb+DKzhUCrP6uc2dr0HThjpYz7286HAm+/u8C6dZ0Ai5Uvqj
         ENiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVna1aVsHuKaDk5QZXdsq7BHtbFlJuZ4hOFGFtRs6cETlThfuQlvX8zbgHS0VJK3GSR+Wjgpnn2gSMy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QzIRn2oRKyJPa9wATUqGypnNApJOGqoWrESJsRP+XbtUxBQi
	Yi+yeIrmSmJzXXCSe4YjHX1cazS8LnDZZYszgrdyrGO6mJgD6LJ/qUUHZQuO2qlEn/vrrmt8Lf4
	kkX27pYX+JU2Huzxh2VBnW6v9QkALF3LBGq66VY7pjyN3sy8D+kwij65wKFK9dXMlFPmRLac=
X-Gm-Gg: ASbGnctXHGMfvvNM1rYxmGGtAvrkwwCsVQ8S6XchhznEETYXcsnrG7WPu06pT8E8eYj
	ZKwFlddmv4DEoWccvv3zHNT+u+HXpOXna5a9BMd5Ujpot23yDmLpVyrcWIlrwIi79r8EY14iERZ
	nzRvmw1z3Dj3iC2Rt6ukC7vA5owlVAbQLLE3CfG7q+xRk5H+qWmSMgxkgk9gd2Ek88xLcvRVWyB
	1UXBAIrEeprwwt3HfriwUUKv0msyo260qR+A9wOBhSc7WjeKQkWGxTVNbZesbZbDJD7P7+5BcLF
	Awp3uexV0EMSqm6ABw/NU1hARVZoEoZ5lntxpLBnzbSs/Ck82pztzvSIYcCOfWD81lgBAzHaFvM
	deDrd
X-Received: by 2002:a05:6a20:7fa7:b0:220:631c:e090 with SMTP id adf61e73a8af0-24340884ecfmr17792513637.0.1756138087393;
        Mon, 25 Aug 2025 09:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuGQjcHakFAYSJasLNIwmwH5AbB+ig9C8K1dte2zhi+ECS9Vuy2ZlNckCYG18AokysGYZ0Zw==
X-Received: by 2002:a05:6a20:7fa7:b0:220:631c:e090 with SMTP id adf61e73a8af0-24340884ecfmr17792475637.0.1756138086873;
        Mon, 25 Aug 2025 09:08:06 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7c09fsm6956388a12.26.2025.08.25.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:08:06 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:08:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <20250825160801.ffktqauw2o6l5ql3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>

On Fri, Aug 22, 2025 at 01:32:01PM +0530, Ojaswin Mujoo wrote:
> The main motivation of adding this function on top of _require_fio is
> that there has been a case in fio where atomic= option was added but
> later it was changed to noop since kernel didn't yet have support for
> atomic writes. It was then again utilized to do atomic writes in a later
> version, once kernel got the support. Due to this there is a point in
> fio where _require_fio w/ atomic=1 will succeed even though it would
> not be doing atomic writes.
> 
> Hence, add an explicit helper to ensure tests to require specific
> versions of fio to work past such issues.

Actually I'm wondering if fstests really needs to care about this. This's
just a temporary issue of fio, not kernel or any fs usespace program. Do
we need to add a seperated helper only for a temporary fio issue? If fio
doesn't break fstests running, let it run. Just the testers install proper
fio (maybe latest) they need. What do you and others think?

Thanks,
Zorro

> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/rc | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 35a1c835..f45b9a38 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5997,6 +5997,38 @@ _max() {
>  	echo $ret
>  }
>  
> +# Check the required fio version. Examples:
> +#   _require_fio_version 3.38 (matches 3.38 only)
> +#   _require_fio_version 3.38+ (matches 3.38 and above)
> +#   _require_fio_version 3.38- (matches 3.38 and below)
> +_require_fio_version() {
> +	local req_ver="$1"
> +	local fio_ver
> +
> +	_require_fio
> +	_require_math
> +
> +	fio_ver=$(fio -v | cut -d"-" -f2)
> +
> +	case "$req_ver" in
> +	*+)
> +		req_ver=${req_ver%+}
> +		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
> +			_notrun "need fio >= $req_ver (found $fio_ver)"
> +		;;
> +	*-)
> +		req_ver=${req_ver%-}
> +		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
> +			_notrun "need fio <= $req_ver (found $fio_ver)"
> +		;;
> +	*)
> +		req_ver=${req_ver%-}
> +		test $(_math "$fio_ver == $req_ver") -eq 1 || \
> +			_notrun "need fio = $req_ver (found $fio_ver)"
> +		;;
> +	esac
> +}
> +
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.49.0
> 


