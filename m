Return-Path: <linux-ext4+bounces-9213-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C9B145E2
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 03:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082CA4E1C47
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55351F1317;
	Tue, 29 Jul 2025 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MMwIAU8P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E711C861F;
	Tue, 29 Jul 2025 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753753254; cv=none; b=rZ7ME0iz0WEPGTAzRJiXwzGcifu9h9719+9KpubWHGLvIv+scs7hO/4GcJ6mIwA9lVI776mql/KG2OW4k767bResN/SFTFdnZBIddwEY01fI+yvVvj0PoVmgP6rTZr5rvxThgYFQ496poxQPGvZj3YnFDx4wV5WMVNkwE9mEKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753753254; c=relaxed/simple;
	bh=jo3ijy+JTGr03KTDI0usXnbpLcxXkxyM0nshqrU9Le0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jt1WyjJWmU6EIMfmmfgCK0i8dJvndTPPTd0Aqc7GXKHR/3GBT+80OG2Ah1sWZ056isAHq/OIVlpZ6yD9JY+sfJhn1XJqgrmNAzLzNQhjJ3VDR1VHboyOUWnjZJXYALBBcfMZ/FWw0ZgzV6qperf1Zvhg7BEl55ut7Zf1P0P/1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MMwIAU8P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=YD3CmDSfJU1ULhXx89mEK0BRfVdB034fXGaNnPcOSpc=; b=MMwIAU8PAolD/byoGQvhYyiHJS
	FRj6Gix9yJyCSk53z4uZ1ezhbLsqhdD2SF3EqsxEUWo3wiNWfaESOuLT3T6huRV2E1Mi03w1Kadoy
	d5Vbia8FoXJqlEToMOB5/iPCUqVn2YntG3W01h9XDMJey99DXQTOeSoStQmO0ER8R6Hr/KD7xh5k5
	tg50ZXdPuD8xDANeR5CxyybE2MGY3GiYhHa1mvdYMlWpjA5fryVKv9vzJfiRlQPj/zhm3bfgK5tcG
	S5Qdv3JDCzIK/9aOMo1ai3Vjtze+KbA/wohCho4bQ+B8fMRJRNVm0C8O0Wvgjb2Zq1Y66qzuGiBtX
	kR7enR6w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugZKl-0000000FiMq-2NMk;
	Tue, 29 Jul 2025 01:40:51 +0000
Message-ID: <742afa67-600e-4a9e-ae7d-f67de31eb603@infradead.org>
Date: Mon, 28 Jul 2025 18:40:50 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixed commit: Fixes Sphinx warnings about duplicate
 reference labels in Documentation/filesystems/ext4/atomic_writes.rst.
To: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, corbet@lwn.net, linux-ext4@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20250729013200.84919-1-andreluizrodriguescastro@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250729013200.84919-1-andreluizrodriguescastro@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Andre,

The warnings should be part of the patch description, not in the patch itself.

Still missing the actual ext4 change.

More below.


On 7/28/25 6:32 PM, Andre Luiz da Nobrega wrote:
> Specifically, the label '.. _atomic_write_bdev_support:' was renamed to
> '.. _atomic_write_bdev_support_section:' to ensure label uniqueness
> within the document.
> 
> Signed-off-by: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
> ---
>  Documentation/filesystems/ext4/atomic_writes.rst |  2 +-
>  warn_output.txt                                  | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>  create mode 100644 warn_output.txt
> 
> diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
> index 80f83112d24d..e8cf983049b4 100644
> --- a/Documentation/filesystems/ext4/atomic_writes.rst
> +++ b/Documentation/filesystems/ext4/atomic_writes.rst
> @@ -204,7 +204,7 @@ writes are supported.
>  .. _atomic_write_bdev_support_section:
>  
>  Hardware Support
> -----------------
> +-----------------

Unneeded change?

>  
>  The underlying storage device must support atomic write operations.
>  Modern NVMe and SCSI devices often provide this capability.
> diff --git a/warn_output.txt b/warn_output.txt
> new file mode 100644
> index 000000000000..593c6fa5b65d
> --- /dev/null
> +++ b/warn_output.txt
> @@ -0,0 +1,12 @@
> +Using alabaster theme
> +[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/filesystems/ext4/atomic_writes.rst:5: WARNING: duplicate label atomic_writes, other instance in /home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/filesystems/ext4/atomic_writes.rst[39;49;00m
> +[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/filesystems/ext4/atomic_writes.rst:207: WARNING: duplicate label atomic_write_bdev_support, other instance in /home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/filesystems/ext4/atomic_writes.rst[39;49;00m
> +[91mWARNING: ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1068 struct member 'mcm' not described in 'mpc_funcs'[39;49;00m
> +[91mWARNING: ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1068 struct member 'rmcm' not described in 'mpc_funcs'[39;49;00m
> +[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/gpu/drm-kms:360: ./drivers/gpu/drm/drm_fourcc.c:362: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:35.
> +Declaration is '.. c:function:: const struct drm_format_info * drm_format_info (u32 format)'.[39;49;00m
> +[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/gpu/drm-kms:476: ./drivers/gpu/drm/drm_modeset_lock.c:375: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:49.
> +Declaration is '.. c:function:: int drm_modeset_lock (struct drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'.[39;49;00m
> +[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/gpu/drm-uapi:557: ./drivers/gpu/drm/drm_ioctl.c:915: WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:70.
> +Declaration is '.. c:function:: bool drm_ioctl_flags (unsigned int nr, unsigned int *flags)'.[39;49;00m
> +[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/arch/powerpc/htm.rst: WARNING: document isn't included in any toctree[39;49;00m

-- 
~Randy


