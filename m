Return-Path: <linux-ext4+bounces-14719-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLKyKQwer2neOAIAu9opvQ
	(envelope-from <linux-ext4+bounces-14719-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 20:22:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D2223FB81
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 20:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7307C30BF173
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2026 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D535F17D;
	Mon,  9 Mar 2026 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLfZ7l3k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kpc6uuLa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F991361DC8
	for <linux-ext4@vger.kernel.org>; Mon,  9 Mar 2026 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083608; cv=none; b=en1rhsHTgbFM5cdTdF8JfQz2JoRcJNq8aaypcIYqR7cjVkfd25X1Cpmv7Fiol9HoB0w49b6OsO8my3cPPIsA/bsBYGYX2+/1nbYHgN+VEmnvxBuwg9RAg3LwGSwmx0t53GeF8ynRdRCiPInliqCHeKDhDBZHNTqXb1xPenjhFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083608; c=relaxed/simple;
	bh=QpwyLBRI/OOkt0kUJ8q+Dx+CP3iPKCrxuD3cHD7w6v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btsDRXOp5Rcg4bfqiPYNLXLL4vYkzCtPndlQRQ2J7odcjKffT8Vf2nllUvSDJ+79DADjtH/N5g0kJygSDcXwEQFr7NgLTxiC1oUNQ6BTCa19iu1pVUlQRpL4tN0chhwP8am6b8Cx7DWwLotCBalwjh+k56HINSVgH+QBgcjzGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLfZ7l3k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kpc6uuLa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773083605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UO+YM8h3OCEFHm0g8D0cIquq7QfxPMQ2VtOUTJCe2E4=;
	b=GLfZ7l3kCdwVmW8EYQrsbDu1C64I4LtsKmMlUJ2+jr5MfeLnT9Nr0rxc7Qt1VoLmQBVK8c
	oYwgEMEuw5izDD+tHz8d3tGWrnjo0bD8sZuHVUU3BBfoWqDC76RktOFHwnSUIyTd0lIBnn
	Mm0Aokax0DJ4cdARChX7nPJ1AgG6DA8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-nbU-lK2QMMGgfmEX-8U7Bw-1; Mon, 09 Mar 2026 15:13:24 -0400
X-MC-Unique: nbU-lK2QMMGgfmEX-8U7Bw-1
X-Mimecast-MFC-AGG-ID: nbU-lK2QMMGgfmEX-8U7Bw_1773083603
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70dd30025fso44809415a12.2
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2026 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773083603; x=1773688403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UO+YM8h3OCEFHm0g8D0cIquq7QfxPMQ2VtOUTJCe2E4=;
        b=kpc6uuLancKFaJ5YAFLCl+ZH1822oLTZKze0zewfIE+atWB2a2yNkeJMkmC8/nPnUa
         tvtBeOwsaNaYegHricTkcqCjJ/t5LFB33WN4njeVAWMAW8TYpGQCypT8pcLUU/pveJTV
         PrN9vleYzmwcAFD9dOslCtdvvvH7fAAXKqHWVGwFn18diV1/3BprgTmsbN2PKGAxZJo/
         Q4aKKxMCRUkCvSquxl1rwU6qt4zsT1PB0G+GWpFYwYtzSfU3oCJA9L5Q0qGypcZ7ijjZ
         Op4o8HoKAppSbMhRt9Ho0FQvrIyVVFskBxScwv0myYaNvB8MIfZUlXa8YTQe54vVjvmw
         WYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773083603; x=1773688403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UO+YM8h3OCEFHm0g8D0cIquq7QfxPMQ2VtOUTJCe2E4=;
        b=FvtyirfT2ORFlePen2XXqRdaorZh9sCTldPeQ2bFBzicOrk5Ab48KiFrop1ONgXbEf
         BRYkPzXcTsNzTTfybZ47DknjowETxB8Ts4JwX3ZmkFHEyrPqRoUfEsRDfpPBkF50bYCh
         eqklXfLBZoBPIn2WmB3q+QBrcuokAZYlSUbTgLxSvO6kFK0Z8ifLv2WYw+X1jWY1qZzF
         6WVy/93eQrG8w0f6mHqHoY8r03uQIF+RbhAkX/NpgzJC+PvS5o6zrlckZaPxKS4S7t/R
         QDGKoy1nxz3khXHm06qIjdyUyK2vIBc4BVkdDvUyQZHgvRn5K1Avu5bD1cjcbsRSnYVX
         3R4A==
X-Forwarded-Encrypted: i=1; AJvYcCXDEZOkieJwLHlL34kPlGyUpKl6IazVxx8KXVwgcFJxd5CJEx7ziWiUgjKwRcXHYRRlYIq0DyyP9abq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrp0r8If5l2U0wbMl4/sIHy5bSH4CMoNHidakVEAFHsb5QR0Y5
	eAMa9OjxdfLsNvnDmtxh99ciToU7i0UwXa6uYMA8bu8y5Xe0CSFmfo10QRQwpwkg40mshemV5Az
	CNOl9AShwVHHMd6qbpAF8kZaQFVHP39EExCMOPWgYZJKr69Gs07BHJLicMtImfzs=
X-Gm-Gg: ATEYQzxPYmnWKrV9ZKJDaWGkkixMY1iMBuwhV+AVaH+OjWpK88t91aRtrIv1NOpYosZ
	nLvsbLp/iM0oDaQBk1KxVT6LBeUStICEngNA5NxyBHIkR/y4e0KXjCQ274lLtl4sPParIMgqX/g
	Mi+ZP9n+Glla3WLhM+v3sY1nLcTREZ4ewKNVtzK8Q9fNNKoalI5qFWGCT8OaeYnssViNTbfb2yh
	WlaKuTKTY2HoeXPyxTE4JvYGFDAh6QI8dx99fcAlP5M9450bddsgfZ7KAzNJfgFJoCV2yzqHIcB
	U61IfH/sxVjuVBnFI2998DLeUi97fPQ4QET+IHQYsToK9d4Bjhkf0h/q2w+IHROgSHl5Onvf0ce
	nv36BdSKwEO5U2k+Yzzmt0CgPi2AqDPqhq+JOI+5LuS0qkX/YERZAWpFN4A5IJA==
X-Received: by 2002:a05:6a21:2d8a:b0:398:7357:bb84 with SMTP id adf61e73a8af0-3987357bcdemr9099339637.12.1773083602997;
        Mon, 09 Mar 2026 12:13:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d8a:b0:398:7357:bb84 with SMTP id adf61e73a8af0-3987357bcdemr9099315637.12.1773083602558;
        Mon, 09 Mar 2026 12:13:22 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e0acde5sm9444628a12.7.2026.03.09.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 12:13:22 -0700 (PDT)
Date: Tue, 10 Mar 2026 03:13:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <asj@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/9] fstests: add _mkfs_scratch_clone() helper
Message-ID: <20260309191317.vxcjvqfpoqdiycki@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1772095513.git.asj@kernel.org>
 <254fdd3e212f6618ea33207ef24db2b316d2d8fc.1772095513.git.asj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <254fdd3e212f6618ea33207ef24db2b316d2d8fc.1772095513.git.asj@kernel.org>
X-Rspamd-Queue-Id: 23D2223FB81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14719-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlang@redhat.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:41:43PM +0800, Anand Jain wrote:
> Introduce _mkfs_scratch_clone() to mkfs the scratch device and clone it to
> the next device in SCRATCH_DEV_POOL.
> 
> Signed-off-by: Anand Jain <asj@kernel.org>
> ---
>  common/rc | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 9db8b3e88996..2253438ef0f6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1503,6 +1503,38 @@ _scratch_resvblks()
>  	esac
>  }
>  
> +_scratch_mkfs_sized_clone()
> +{
> +	local devs=($SCRATCH_DEV_POOL)
> +	local scratch_data="$1"
> +	local size=$(_small_fs_size_mb 128) # Smallest possible
> +
> +	size=$((size * 1024 * 1024))
> +
> +	# make sure there are two devices
> +	if [ "${#devs[@]}" -ne 2 ]; then

What about if ${#devs[@]} > 2 ?

> +		_notrun "Test requires exactly 2 devices"
> +	fi
> +
> +	case "$FSTYP" in
> +	"btrfs")
> +		_scratch_mkfs_sized $size
> +		_scratch_mount
> +		$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/sv1
> +		_scratch_unmount
> +		;;
> +	"xfs"|"ext4")
> +		_scratch_mkfs_sized $size
> +		;;
> +	*)
> +		_notrun "fstests clone op unsupported for FS $FSTYP"
> +		;;
> +	esac
> +
> +	# clone SCRATCH_DEV devs[0] to devs[1].
> +	dd if=$SCRATCH_DEV of=${devs[1]} bs=$size status=none count=1 || \
> +							_fail "Clone failed"

I'm wondering if we absolutely need to use SCRATCH_DEV_POOL for this test. Could we clone SCRATCH_DEV
to an image file instead? Or would it be feasible to simply run the test using two image files?

Thanks,
Zorro

> +}
>  
>  # Repair scratch filesystem.  Returns 0 if the FS is good to go (either no
>  # errors found or errors were fixed) and nonzero otherwise; also spits out
> -- 
> 2.43.0
> 
> 


