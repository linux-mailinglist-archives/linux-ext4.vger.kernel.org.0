Return-Path: <linux-ext4+bounces-6279-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8ABA2432C
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2025 20:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740B3188624D
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jan 2025 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305C81F2C5A;
	Fri, 31 Jan 2025 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtRPh+/m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E71C3C1F
	for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2025 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351032; cv=none; b=dzi8Y8xDn9WiZ3yuvPiSpHTRW3Z9WvM27B/OOQ86x8N8DxPQfXfRKpAsuoSRvkTtHN7C3kE8Fm1sgpLmdazFVABDLFM/u8Kpj+eynzoNAzDl6VLA+ysynAym6svRoNlJ+H+SEvPzjWZ6ZBFcEO4xkPhsY9kTnCPdG7m0UHybjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351032; c=relaxed/simple;
	bh=HGKgCrD34eiQimlf4+cvDNwfNb/2Dei0o6sRjf0UFG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyvbvtkIjPNMJAFJD3PIkzlX0atjIW6yPdXEt4wSjQBmBtHZ5hYy+UnyHwr6KmAxC2kUL96iBvDDML4EKvBcXEov5kQGt81bdP82BYeQvz9z06NU4bl636wSY3IyZm42biQMPKt4DCbTiUcZcdgvDOMo6W+xH512pbv7howLQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtRPh+/m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738351029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBP2ejv55jQWoe5lkaW4/iObWJ65jHHcwOH2JS5+DwU=;
	b=OtRPh+/mDsfxSaTWBOIZLr7wtGboUEzdysdGMYmtS5XYXOPhKcayUkLywagOHPNDYwxvMD
	s6JlwnV5Onc/7C7MioW7oS6Kr7YFaIe99npmilWndE3OAGN161XNvQHK67b4lmosa/Jbgo
	h44qj2wl8heY6weG7xGLrB56Id8Uq20=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-GK7PyJlIN96pNMDztasr3w-1; Fri, 31 Jan 2025 14:17:07 -0500
X-MC-Unique: GK7PyJlIN96pNMDztasr3w-1
X-Mimecast-MFC-AGG-ID: GK7PyJlIN96pNMDztasr3w
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7ea122d0bso1295515ab.0
        for <linux-ext4@vger.kernel.org>; Fri, 31 Jan 2025 11:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351027; x=1738955827;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBP2ejv55jQWoe5lkaW4/iObWJ65jHHcwOH2JS5+DwU=;
        b=rL5yKXY1HPEbeGGDvy5wwN9W4mFUbCyxYGgu9pT0qDkW0w1xx6E0/shRKqc36jx3zx
         ENx8iioI2e0GD4XNg6Ft2QjnYW8XG2HInljikm1u0lKJ4BzLnkyVn989bUbueiyvJBDm
         aBsXHmm+Q+wIf3G3+rVEwWTQYKRGI6xCJDuEJrH4+BdhXHGpMaz+y+z2FFEOq7ozznUz
         kTCQhxL6vAV8corTOw1orar3yQl3NZgMB9IfIS7Na4a12Wu8EheLLtoPuuAFP9mQvnb+
         fr4ODEGVq17/Q8IoJWudzjzZOGq22gHEchIHuZZG89TEXm14JhYUSmFTJx21/3XaTuYv
         Re5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJiVpPJaV+WvXs6IzQYq7l7n61BvH1v9ZUmvD92XiZoWvxAu1Klt9UZlteigHUSJdS6CbHEn+F2/rV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+VbdcUyEx4veSk2n04LYId73kuzr1xOxL0RvfeCI5ZZplJtj
	1Uev/Atu59Z9zdkbGQUQRLOP1QXkqCPNbkVJ5ApYOdKZpgSBvHryB2PGlZuhhBNjMNT7D05h8mY
	a9lpkNb33dGL7EqzifXLDuG3fCvHoYKlmDepA/BaXWNSbifDQ3jURYARduc4=
X-Gm-Gg: ASbGnctmMZrqZLRM+qD5jeE+Uk21u9SYcwI/xQaxmBimUlDabm+hgfsc8ymKdchAsr9
	rwXksFIc9tEuU3ZWg1Tv4sWJSDlfZz8K3W4DVDheqUDSGOdfYipWlodPENWBRNKdYcfMti47cK7
	z7izTct2aoVPoCv3KpWPgoRklCITkNWB+bh0fOIE7yUxnoIaMu3iiHE/7M5XYrMA3sM8jNTHadr
	g6Qc3ibRq0O/Vdq+Z+GK4m40hbwKenHpz+OUzyGOFX7i46uYLG0UE2XZpEgR+3LPgTbzxhkk210
	CXLkAXaF
X-Received: by 2002:a05:6602:6082:b0:854:a5e8:3294 with SMTP id ca18e2360f4ac-854a5e83361mr193247539f.3.1738351027032;
        Fri, 31 Jan 2025 11:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+Yzd6ZzAd6b5E6xmRCqs2veqaIHe5aVhmKvgpoGadfX/Fj5zXiz2QAdx8dJsDaTaRDEZ/zA==
X-Received: by 2002:a05:6602:6082:b0:854:a5e8:3294 with SMTP id ca18e2360f4ac-854a5e83361mr193245939f.3.1738351026674;
        Fri, 31 Jan 2025 11:17:06 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a15d0413sm100237339f.8.2025.01.31.11.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:17:06 -0800 (PST)
Date: Fri, 31 Jan 2025 12:17:03 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 amir73il@gmail.com, brauner@kernel.org, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, Peter Xu <peterx@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
Message-ID: <20250131121703.1e4d00a7.alex.williamson@redhat.com>
In-Reply-To: <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
	<9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


20bf82a898b6 ("mm: don't allow huge faults for files with pre content watches")

This breaks huge_fault support for PFNMAPs that was recently added in
v6.12 and is used by vfio-pci to fault device memory using PMD and PUD
order mappings.  Thanks,

Alex


On Fri, 15 Nov 2024 10:30:28 -0500
Josef Bacik <josef@toxicpanda.com> wrote:

> There's nothing stopping us from supporting this, we could simply pass
> the order into the helper and emit the proper length.  However currently
> there's no tests to validate this works properly, so disable it until
> there's a desire to support this along with the appropriate tests.
> 
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  mm/memory.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index bdf77a3ec47b..843ad75a4148 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -78,6 +78,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/sysctl.h>
> +#include <linux/fsnotify.h>
>  
>  #include <trace/events/kmem.h>
>  
> @@ -5637,8 +5638,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct file *file = vma->vm_file;
>  	if (vma_is_anonymous(vma))
>  		return do_huge_pmd_anonymous_page(vmf);
> +	/*
> +	 * Currently we just emit PAGE_SIZE for our fault events, so don't allow
> +	 * a huge fault if we have a pre content watch on this file.  This would
> +	 * be trivial to support, but there would need to be tests to ensure
> +	 * this works properly and those don't exist currently.
> +	 */
> +	if (fsnotify_file_has_pre_content_watches(file))
> +		return VM_FAULT_FALLBACK;
>  	if (vma->vm_ops->huge_fault)
>  		return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
>  	return VM_FAULT_FALLBACK;
> @@ -5648,6 +5658,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>  static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct file *file = vma->vm_file;
>  	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
>  	vm_fault_t ret;
>  
> @@ -5662,6 +5673,9 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  	}
>  
>  	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
> +		/* See comment in create_huge_pmd. */
> +		if (fsnotify_file_has_pre_content_watches(file))
> +			goto split;
>  		if (vma->vm_ops->huge_fault) {
>  			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
>  			if (!(ret & VM_FAULT_FALLBACK))
> @@ -5681,9 +5695,13 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
>  	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct file *file = vma->vm_file;
>  	/* No support for anonymous transparent PUD pages yet */
>  	if (vma_is_anonymous(vma))
>  		return VM_FAULT_FALLBACK;
> +	/* See comment in create_huge_pmd. */
> +	if (fsnotify_file_has_pre_content_watches(file))
> +		return VM_FAULT_FALLBACK;
>  	if (vma->vm_ops->huge_fault)
>  		return vma->vm_ops->huge_fault(vmf, PUD_ORDER);
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> @@ -5695,12 +5713,16 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
>  	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct file *file = vma->vm_file;
>  	vm_fault_t ret;
>  
>  	/* No support for anonymous transparent PUD pages yet */
>  	if (vma_is_anonymous(vma))
>  		goto split;
>  	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
> +		/* See comment in create_huge_pmd. */
> +		if (fsnotify_file_has_pre_content_watches(file))
> +			goto split;
>  		if (vma->vm_ops->huge_fault) {
>  			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
>  			if (!(ret & VM_FAULT_FALLBACK))


