Return-Path: <linux-ext4+bounces-13758-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E87qBS+vmWmoWAMAu9opvQ
	(envelope-from <linux-ext4+bounces-13758-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Feb 2026 14:12:15 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ADC16CE16
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Feb 2026 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C243014C32
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Feb 2026 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05D194A6C;
	Sat, 21 Feb 2026 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evhnVm7n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA543262A6
	for <linux-ext4@vger.kernel.org>; Sat, 21 Feb 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771679527; cv=none; b=SIQb0RIyBLlDnYgpjUJO46clg0ANVRw/H62hV+Bdf4bZaLBYXlMPvUu99565ejL/gs3MSo31qBHXl65yMFWkbHM8uxVujyAmipIi97kX2GHFGQgK4dgWwbqE3iekbAGvB6fabS8QAOPlVsYnRDnPMVbN3ISQoB3I3BXP0qTrW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771679527; c=relaxed/simple;
	bh=PHkrAJ75QYU0Jv5rsD5sU9PEOfpifJXDD50JPrdqLbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KTvOfgK6AlLGzAkUKz2vhjMwmIAz+UzQ01ec3X4SngbI2nZLn+kUxt5G11wgH1rRpk+1PDO78z4m32PMZOJSZ3rjP/NGaPa8HJenrIDE9xnng5D1b93a3AJ9FjLN5NI5iW1W28xRt+blsZE3OL846W/bAh95x0qZTMzZWXkrlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evhnVm7n; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82311f4070cso1922811b3a.0
        for <linux-ext4@vger.kernel.org>; Sat, 21 Feb 2026 05:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771679526; x=1772284326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rhddWZqd/XF9Emsx05Um3GabutTtC4ZTixKnLUClT4c=;
        b=evhnVm7nXySyvgh7/2v3QNffwV1pkGjR8m+6uGl5dJuzDW6rEOC35P8+jlkeRDJVOJ
         ONFJ11f0Zybia2LNJVMttrgedoU6yTFEjG4YfINnoo0bxtLddoGu4jeUB6s7n2vAlLTJ
         fhP3jCyIJNG1EPCgGzSX3X11gFvbtCAZViVeHZvyHAOl4yNC7NIFyu+97D0x3WsGqnJD
         f3rD/Vzc4nhy5G0kh58B8fnfQPE2DMn1omHTJxM9v47umKSZ1WwoDCw1Gw0D9dJjVJeQ
         slca0qAJjK79vug6jv21InEv9Es5cDIgMgwP0FVgtdSZFC5krZ8O5KTBrm46QCnId/d6
         Ur9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771679526; x=1772284326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhddWZqd/XF9Emsx05Um3GabutTtC4ZTixKnLUClT4c=;
        b=LA4quBclKBU3MbBxN4GtojNBYGWUcTDOYqqGpt9fIudM8nrg8fYbpRT6rsSHwH3KOW
         iT1bBWcLuZsEbwwmyUlP/7DuYcMCaWU58UJXc6Ycgug7kQTf47e/qXbpqjOxDjStTAk3
         /yoSHEWiRTNOjurvWUABoGSFLtjyn3G7oxiDToecbOjrKXVLFyoUGG03Px7QVvy0vxJM
         9nzxsuJEit+8b7ZkOnat4CvWcTb3MQQVdUpDEXuoEOIQ0M5BpA3vWs45Y+KjY9ONOnm3
         FP1aB7TBH607sefFOUbVuOSH7pUv1IdUTkTCqG23aQjDYk2UOHVleu+GIPpYdmLq/tnV
         pNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEd5dumasyaL6aAcNHNpuqAkSUc+WGSNCD0mdwL1YzaJIX3HyQcJaSe5L5ylQFcHEflzweEvDxB8k+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39CYt5TrXf52izQleMWDO5G11PvDmhA+jfHXwMu7Jvc95XnEu
	0hvxYB3MD3dJb2v4kpIiB7W4+6gkFKU3g+NiAVrGim4WM8RPrgEzWbjQ
X-Gm-Gg: AZuq6aJxO3kGflYkc6iTtdl19iLLS1itsDdb6fdHvqoASXk4MZae7x6ez4Tp7yxeGPW
	Em9yxhPTJbJOilWj1mPymoF098Txf6PfajAdxkH4sKWXV0ag5qxq9+lv0gRFjj8Eu0gRVor/F0X
	eZMvkuIIpq3MAusRQsmswhzwm4Qvj+k0H36ILuv6pJ7xbN+VFLDplvbKY9bkrH1ZcFh0F+FM0MF
	i+apw924Z0XJSJVfQ7UFoG3Bf6glSBAWalS/znaumCHGpyxXoQ7DwZnEcVUnnVYisMKvMhfWu6j
	Xpv4kJbEtqwzSlUkBWtBKfhIL2LYXHKMqLjYS2jQjnhFE/EeL79qhXhkNT169+Jv/TYNeYHtXt2
	RhV5HJUOOvIGLu5R5swU8zB5ge3iubaxIZM5vwKi6EbJSLAqGUwjRVVoQxklJeKUoIhU4lAUIsg
	6nEVRSoKzm73KaAjEKjfeZ9Lk0Z8ULJFSave+EuBsP1l03
X-Received: by 2002:a05:6a00:22c4:b0:81f:5a94:dc2f with SMTP id d2e1a72fcca58-826badf09c6mr8704774b3a.35.1771679525944;
        Sat, 21 Feb 2026 05:12:05 -0800 (PST)
Received: from [192.168.50.207] ([115.205.86.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd64367bsm2343099b3a.4.2026.02.21.05.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 05:12:05 -0800 (PST)
Message-ID: <d7d4ff91-192f-470b-bba5-2f00ca4dff49@gmail.com>
Date: Sat, 21 Feb 2026 21:13:32 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Update MAINTAINERS file to add reviewers for ext4
To: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20260219152450.66769-1-tytso@mit.edu>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20260219152450.66769-1-tytso@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13758-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46ADC16CE16
X-Rspamd-Action: no action

On 2/19/2026 11:24 PM, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>   MAINTAINERS | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eaf55e463bb4..481dceb6c122 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9581,7 +9581,12 @@ F:	include/linux/ext2*
>   
>   EXT4 FILE SYSTEM
>   M:	"Theodore Ts'o" <tytso@mit.edu>
> -M:	Andreas Dilger <adilger.kernel@dilger.ca>
> +R:	Andreas Dilger <adilger.kernel@dilger.ca>
> +R:	Baokun Li <libaokun1@huawei.com>
> +R:	Jan Kara <jack@suse.cz>
> +R:	Ojaswin Mujoo <ojaswin@linux.ibm.com>
> +R:	Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> +R:	Zhang Yi <yi.zhang@huawei.com>

Hi Ted!

Thank you for adding me as a reviewer. I look forward to contributing 
further.

Best Regards,
Yi.

>   L:	linux-ext4@vger.kernel.org
>   S:	Maintained
>   W:	http://ext4.wiki.kernel.org


