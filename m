Return-Path: <linux-ext4+bounces-13443-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCdKCmcMf2lziwIAu9opvQ
	(envelope-from <linux-ext4+bounces-13443-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Feb 2026 09:18:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC9C53A8
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Feb 2026 09:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91F633014424
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Feb 2026 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C0308F03;
	Sun,  1 Feb 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESsE1TXq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3692E62DC;
	Sun,  1 Feb 2026 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769933924; cv=none; b=iz6Ra5c4RjD5jT3lSonBMtdik6y202l0J/J50wUZHxyTVU3a8KpTsOd0FTtcmqEcDtn3AfzM8H+41c1Au8Rldl0O8RjNKxSqiWXP2iVhYX0vJD7QZfCM2wSPIn3XZb5cRjnraeIn8yrmjGmVHQGr2w/OzlHpmqEORxHcE1PuBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769933924; c=relaxed/simple;
	bh=A4Mqvnvc0NfHCq8RXr630wxVWrxA4qiEUU/doexpgIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j26bHdd3YFWcXrliJwtCc0xmU5uPyJiOt8nIA4laQt1gqpKu1GixVD0V5eWhfev87pjwnu3EszVcZJSIgF2ka2LdzXOa/Tq9Z9z3yfju4M/PmYJQsqftdi33B5+88mtFvitLDWghUQo3y5AsaAZL7+XZPkGMCBqXN867j2G9Yss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESsE1TXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B4CC4CEF7;
	Sun,  1 Feb 2026 08:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769933923;
	bh=A4Mqvnvc0NfHCq8RXr630wxVWrxA4qiEUU/doexpgIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESsE1TXqtIGrqsHJbsjvED3c8VCFe0pI3R4Lel1yu+UCMPtFA1BfhcaHW5Z3+mHj7
	 XQ8TvuRg8kW5kbl/mjlWzzd41fVEAAUqzY1H2MOoEnsvSi6D5ctyvhAPkpO5ajTveo
	 KXEy0yli+QBKESXUwqi6mcIlD8HwkUdf0kHzExxA=
Date: Sun, 1 Feb 2026 09:18:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5L2Z5piK6ZOW?= <3230100410@zju.edu.cn>
Cc: security@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <2026020124-flashbulb-stumble-f24a@gregkh>
References: <271c8570.69a28.19c143721c6.Coremail.3230100410@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <271c8570.69a28.19c143721c6.Coremail.3230100410@zju.edu.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13443-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99EC9C53A8
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 09:21:23PM +0800, 余昊铖 wrote:
> From 34545a4d43adef3147e0ba1c744deb128a05a101 Mon Sep 17 00:00:00 2001
> From: 0ne1r0s <yuhaocheng035@gmail.com>
> Date: Sat, 31 Jan 2026 21:16:52 +0800
> Subject: [PATCH] perf/core: Fix refcount bug and potential UAF in perf_mmap
> 
> The issue is caused by a race condition between mmap() and event
> teardown. In perf_mmap(), the ring_buffer (rb) is accessed via
> map_range() after the mmap_mutex is released. If another thread
> closes the event or detaches the buffer during this window, the
> reference count of rb can drop to zero, leading to a UAF or
> refcount saturation when map_range() or subsequent logic attempts
> to use it.
> 
> Fix this by extending the scope of mmap_mutex to cover the entire
> setup process, including map_range(), ensuring the buffer remains
> valid until the mapping is complete.
> 
> Signed-off-by: 0ne1r0s <yuhaocheng035@gmail.com>
> ---
>  kernel/events/core.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2c35acc2722b..7c93f7d057cb 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  			ret = perf_mmap_aux(vma, event, nr_pages);
>  		if (ret)
>  			return ret;
> -	}
> -
> -	/*
> -	 * Since pinned accounting is per vm we cannot allow fork() to copy our
> -	 * vma.
> -	 */
> -	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> -	vma->vm_ops = &perf_mmap_vmops;
>  
> -	mapped = get_mapped(event, event_mapped);
> -	if (mapped)
> -		mapped(event, vma->vm_mm);
> -
> -	/*
> -	 * Try to map it into the page table. On fail, invoke
> -	 * perf_mmap_close() to undo the above, as the callsite expects
> -	 * full cleanup in this case and therefore does not invoke
> -	 * vmops::close().
> -	 */
> -	ret = map_range(event->rb, vma);
> -	if (ret)
> -		perf_mmap_close(vma);
> +    	/*
> +    	 * Since pinned accounting is per vm we cannot allow fork() to copy our
> +    	 * vma.
> +    	 */
> +    	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> +    	vma->vm_ops = &perf_mmap_vmops;
> +
> +    	mapped = get_mapped(event, event_mapped);
> +    	if (mapped)
> +    		mapped(event, vma->vm_mm);
> +
> +    	/*
> +    	 * Try to map it into the page table. On fail, invoke
> +    	 * perf_mmap_close() to undo the above, as the callsite expects
> +    	 * full cleanup in this case and therefore does not invoke
> +    	 * vmops::close().
> +    	 */
> +    	ret = map_range(event->rb, vma);
> +     	if (ret)
> +    		perf_mmap_close(vma);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.51.0

Can you turn this into a patch we can apply (properly sent, real name
used, etc.) so that the maintainers can review it and apply it
correctly?

Also, be sure to send this to the correct people, I don't think that
the ext4 developers care that much about perf :)

thanks,

greg k-h

