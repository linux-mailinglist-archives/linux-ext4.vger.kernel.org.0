Return-Path: <linux-ext4+bounces-9355-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB992B2496F
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 14:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463023AC3F9
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478FA194098;
	Wed, 13 Aug 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGRPpOm4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50946161302;
	Wed, 13 Aug 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087651; cv=none; b=XwgUlIyOYDg6dXILHihxlO/w9VmmbaqvjR1/5jV8uweYoii+fTWpVYp3lNcapePcDaqot2Lny7JdE9u9rBH3YtGOUr/4zNk8M37dlxBCwN1OXf8AS+WudNYlwr17nU/HIC6GFCrMy6PTbXJDPHFI8fMGPO59QrQc9sOrhQdrLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087651; c=relaxed/simple;
	bh=5s53h95JR7VRoK+FFUy6Hi4TNY/V+k/Iuflbi6adxQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhSgtGDqzaf7MrMujIzLyDeDs1dqgQZwOVuPANRFF/rPjUcD0H9smeoULmjBaIeeffniBXgpWAl71ydfl6F/Qs5lBqvvre/xeMT5W7Fwrrh9iqcjlEefUtEFGkOFbLIqq/aQ8qHMMLhaGRxAeV3XJ8rqz63HpFdnUlsEs2CKHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGRPpOm4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b8db5e9b35so4010883f8f.1;
        Wed, 13 Aug 2025 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755087649; x=1755692449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfb1RFfBo8f/gSbFXGbIbmLlwjsIH78uMtatdC1O2dw=;
        b=XGRPpOm4HbNPQRpKXiw5L6njsDE7B6q3gNxrKVdEZ3GPrOmW40HzFBbQE0oYFovqrW
         KlMGd7fP0iLD8pJia/zYvdswB3ddv6EMUTXjNWUu9AI3yQG3vmgE1LqPJbt8ltvuSYSn
         xLkoWg+E2ErL8coHg9Yn7wiW9Y1bp5yIUrRQrT0E+iLg7nJhBMtFoz51J2h/PYY0Dsgj
         on5oBkvsnbvhs+uu3Hh3Z3WSBgk+up/aWd+3Ra0XNRpYESQoqfRNPjRqOzkcidQagH5y
         5/10d0ETifCmoFbQf7JXV77FFj7QrpKxLEk9Q9a5cP9VtHtJab3WXkeSm1rf+WzDjyZZ
         NEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755087649; x=1755692449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfb1RFfBo8f/gSbFXGbIbmLlwjsIH78uMtatdC1O2dw=;
        b=g8Hd0JKG6phoLpSWMCv+BbWZjgP/N11C3mFDPckWP7JuQ0Y3q7Zu+u1hnD5IBQOO2g
         ahosoRDxtU/bow91iRo49o70CKrGWiloDDWzuJT918lscfj7ybCPXx//Ahx4m3Uiy+fs
         3/fcrjTQ8vAgjD56kUUOI1FDG1chPdGq/dVYyACVZ768uRsaKz/bgANgtsV/ofOfOVlC
         MS6T6niG5c0rzxLNXU7pGaXM/gT9Z8BHFOjWkclfWZ5UR/X1BSWRbAGhRYC4dYjupugg
         FsSAPzJNvisoVvcUiJ+TTd7yIYoPMIPvfR+oLvW6h3yMJL14rQtZ/wJiBO9I7HMRr8Fs
         4VLA==
X-Forwarded-Encrypted: i=1; AJvYcCUHNgGAzjP5EwRNwduj65XjGETM5adMJfUDZwxpiK6/n5mky0Euc513MVC8FNfldFgAEx7KVrc6@vger.kernel.org, AJvYcCVnrb0Gph7ZJ1n49ZW8+FQiTAh2hP8peXLR7P9gHGA1MaKNoy+pmbTdg/9luBIJfJ5hzGEU2pj3ElAa@vger.kernel.org, AJvYcCW2QG+Uhh7CR53VPjrUsdXEs/sEd+LrxrZ0IOZmpItKrs8b5tSlb9s7VnVXPAuCBDFkWRiFtUv6nFi7og==@vger.kernel.org, AJvYcCXp6vYjR4whdr265LPgvMCwT36MvV5yXynqL4sdgs5lK9h6I2bIu4QO8UHMfDrhol55siX2wET7Hrrgyu+M@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdg5IHUpOrpAXaBfQu8Ivs8iy2qomGcC6Nt4IzaobZ1etOFcj
	P+hrOAtHDw5pW3ue4kdQB2088awki0zIxbMremDiC4DaAAKsgvaa/uWgMDVFug==
X-Gm-Gg: ASbGncvNlxtuXc3T14nIXBxQKIkokksdQuZZ5rI4xQG5zSjE1TUlD0mFYR5vK2i8FL4
	2qCILI0TUS7OS4jvy2mYCBZFhGROt84z/BCkGR7ja4nrvR/eppfDCsScM2eh7yFnu4plav6oxcq
	ZoGVBnFc7WpOe1crNoZkPKwXlJ+rVW1O6eD/li4QhlHvA2z8IeuU47D8fEtlRi42br+DQl3UHQh
	h2i/lkgchHsBBIP8+ZqCjiTnq9DLogKDbzAKc/q5nzkIQynyJUh/gwW3303kBQaujvhjz1Xy6o2
	+LvCdxmImSoHK5jXeeh5Zrws3NgwhI5uWewv4s3D13wHzBSTBpUf2oRcQE97bj3ItJDjCgPL1Hb
	I5E3s2BZfms4LL25XTn53qct9mcstsiDYhQrq3Ug23QZex254YE8MSS0Jm2nMtGIR74tcVKc=
X-Google-Smtp-Source: AGHT+IHSCFnuLG4xJtpJabct98yLFQHMsBPlBenP/g9hGt6KikyCSZRRYdfFImjdXqDP2qUJOpOjKg==
X-Received: by 2002:a05:6000:4285:b0:3b9:13d6:cb4a with SMTP id ffacd0b85a97d-3b917ebb388mr2078550f8f.59.1755087648428;
        Wed, 13 Aug 2025 05:20:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c475067sm46980038f8f.58.2025.08.13.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 05:20:47 -0700 (PDT)
Date: Wed, 13 Aug 2025 13:20:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, Ritesh Harjani
 <ritesh.list@gmail.com>, djwong@kernel.org, john.g.garry@oracle.com,
 tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 01/11] common/rc: Add _min() and _max() helpers
Message-ID: <20250813132034.6d0771de@pumpkin>
In-Reply-To: <43f45a0885f28fd1d1a88122a42830dd9eeb7e2c.1754833177.git.ojaswin@linux.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
	<43f45a0885f28fd1d1a88122a42830dd9eeb7e2c.1754833177.git.ojaswin@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 19:11:52 +0530
Ojaswin Mujoo <ojaswin@linux.ibm.com> wrote:

> Many programs open code these functionalities so add it as a generic helper
> in common/rc
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/rc | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 96578d15..3858ddce 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5873,6 +5873,28 @@ _require_program() {
>  	_have_program "$1" || _notrun "$tag required"
>  }
>  
> +_min() {
> +	local ret
> +
> +	for arg in "$@"; do
> +		if [ -z "$ret" ] || (( $arg < $ret )); then
> +			ret="$arg"
> +		fi
> +	done
> +	echo $ret
> +}

Perhaps:
	local ret="$1"
	shift
	for arg in "$@"; do
		ret=$(((arg) < (ret) ? (arg) : (ret)))
	done;
	echo "$ret"
that should work for 'min 10 "2 + 3"' (with bash, but not dash).

	David

> +
> +_max() {
> +	local ret
> +
> +	for arg in "$@"; do
> +		if [ -z "$ret" ] || (( $arg > $ret )); then
> +			ret="$arg"
> +		fi
> +	done
> +	echo $ret
> +}
> +
>  ################################################################################
>  # make sure this script returns success
>  /bin/true


