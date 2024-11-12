Return-Path: <linux-ext4+bounces-5076-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841399C5975
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 14:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155CB1F23473
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC141F940C;
	Tue, 12 Nov 2024 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDeYHWG6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B741F8927
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419185; cv=none; b=fDdlSX8Hg5XSQY2rKSY8qEC4jVtaUcbncUku5MSP8c77gRZYMzLbgGGm+X97schWxxnTga//Ojsju1fYXy99Ycq0Fo2qD0zNY2d4lXZgtCeHH21GINvIWasIqD2x11B3lmCdfDMtPEJ7XK7D+fdVEfnjh4XQgzCb84pXbzf1iH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419185; c=relaxed/simple;
	bh=gQvy+VYOhlAhneYdMjO3fIAwASqfAM0e11A5GPQMUmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVJQvOXU65qdZt+fWKINxh6Mgi9S9qUEvQvr9RtM7IDkyvrYGMai7ccT4Qjp4ukLzcHpREmpUaOkiNyZpvnHDsMyfPR2SJgffNJHnfa/AYUSahW8wq7xww1BJyp1q0v2Xl4L7UFy1J4oHCN06SHW6LNl6tEOI2Dwh562CvFQa7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDeYHWG6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731419182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2hrZaON2UE7YH0/syk7LfurGMUbOzJdYtyDIkouThw=;
	b=HDeYHWG6o21/MPYQgJcUla55so2lcaU/9EksOpUSHm0LtO9coKPZGogp2+P7y1YideQ1zx
	Njac5ceTqPOM4ReUcQULzT6hsPGzfkYS9IbHy5VCceLf/bYgnyBgHGPkoiMZmWJ6dlr6e+
	cZsD202D4AYaQ0E21kI6Y/2YOWnyJZE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-U18T3QqTORmkVFvXTucTTg-1; Tue, 12 Nov 2024 08:46:20 -0500
X-MC-Unique: U18T3QqTORmkVFvXTucTTg-1
X-Mimecast-MFC-AGG-ID: U18T3QqTORmkVFvXTucTTg
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-72094cd0435so6006153b3a.3
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 05:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731419180; x=1732023980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2hrZaON2UE7YH0/syk7LfurGMUbOzJdYtyDIkouThw=;
        b=hrUb9ObdCAUFsKTq+aIygZL3xra9t951chBw6N3Y3iVQAoe0toASO6YcaTrS5wLcJe
         CCWdzsHP4HwsSwu8yJf37DLkZCTes4GcSxk16vmhcxxL6nu8N3AXAQDm89zGgaljqByN
         eLjw84l90ZuuASL6Vknb/0MdytuWoc6ibZSHsIm/I7tFsnCJd1PrGk9OuDljmKH19Wmt
         QQAZ3MvpXFnVjHTwkNQJY0Vdq2U/YlYiswdW4ojAXPvAYYDqDqiiMXkPRmpTC2yFqF3D
         btGyiQ25zyXWhDak9wXNdVxYaXAsM2mFJG5QfFLpOYTLGObXiXXu9KtDTUwZz76DsbHl
         OwHg==
X-Forwarded-Encrypted: i=1; AJvYcCWtpGc0KCx+2+rNRY1OvxC9zcLHIHxAJwDouavyrL6TP429+hgpPTvIgUmofZS+CkPDHo+cFkpsKwP8@vger.kernel.org
X-Gm-Message-State: AOJu0YycHTThtf4eXvCpG3hrJZtnoMzVROXhFyCrn3BRqoXdErAsdS1F
	oSSDzWumRvVz5q566Wx83e96k/fZ+DVi+ua/0+JmDHrejDmrhIxsT1L59NbfZtpgxKdZMY6cUh4
	/p50KEyhf7K1yrjO7witlTQVHokgqFW+p9Z9SPrVj0F5Hrd1voB2BfLCXpm0=
X-Received: by 2002:a05:6a00:23c4:b0:71e:55e2:2c54 with SMTP id d2e1a72fcca58-724132be6a7mr21039249b3a.12.1731419179782;
        Tue, 12 Nov 2024 05:46:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCcSiqT2dO8HHFhyHcEZCd3d3DkSw0Wz7NzZzhASXAFJHr0BuQ3n9OlbFBVBHRCq7Q2h72dw==
X-Received: by 2002:a05:6a00:23c4:b0:71e:55e2:2c54 with SMTP id d2e1a72fcca58-724132be6a7mr21039215b3a.12.1731419179280;
        Tue, 12 Nov 2024 05:46:19 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860a2bsm11519464b3a.21.2024.11.12.05.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 05:46:18 -0800 (PST)
Date: Tue, 12 Nov 2024 21:46:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	libaokun1@huawei.com, jack@suse.cz, tytso@mit.edu
Subject: Re: [PATCH v2] ext4/032: add a new testcase in online resize tests
Message-ID: <20241112134615.cumyngqffzc67h3n@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241111152100.152924-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111152100.152924-1-aleksandr.mikhalitsyn@canonical.com>

On Mon, Nov 11, 2024 at 04:21:00PM +0100, Alexander Mikhalitsyn wrote:
> Add a new testcase for [1] commit in ext4 online resize testsuite.
> 
> Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libaokun@huaweicloud.com [1]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

This version looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/032     |  6 ++++++
>  tests/ext4/032.out | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 6bc3b61b..238ab178 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -10,6 +10,9 @@
>  . ./common/preamble
>  _begin_fstest auto quick ioctl resize
>  
> +_fixed_by_kernel_commit 6121258c2b33 \
> +	"ext4: fix off by one issue in alloc_flex_gd()"
> +
>  BLK_SIZ=4096
>  CLUSTER_SIZ=4096
>  
> @@ -136,6 +139,9 @@ for CLUSTER_SIZ in 4096 16384 65536; do
>  
>  	## Extending a 2/3rd block group to 1280 block groups.
>  	ext4_online_resize $(c2b 24576) $(c2b 41943040)
> +
> +	# tests for "ext4: fix off by one issue in alloc_flex_gd()"
> +	ext4_online_resize $(c2b 6400) $(c2b 786432)
>  done
>  
>  status=0
> diff --git a/tests/ext4/032.out b/tests/ext4/032.out
> index b372b014..d5d75c9e 100644
> --- a/tests/ext4/032.out
> +++ b/tests/ext4/032.out
> @@ -60,6 +60,12 @@ QA output created by 032
>  +++ resize fs to 41943040
>  +++ umount fs
>  +++ check fs
> ++++ truncate image file to 786432
> ++++ create fs on image file 6400
> ++++ mount image file
> ++++ resize fs to 786432
> ++++ umount fs
> ++++ check fs
>  ++ set cluster size to 16384
>  +++ truncate image file to 98304
>  +++ create fs on image file 65536
> @@ -115,6 +121,12 @@ QA output created by 032
>  +++ resize fs to 167772160
>  +++ umount fs
>  +++ check fs
> ++++ truncate image file to 3145728
> ++++ create fs on image file 25600
> ++++ mount image file
> ++++ resize fs to 3145728
> ++++ umount fs
> ++++ check fs
>  ++ set cluster size to 65536
>  +++ truncate image file to 393216
>  +++ create fs on image file 262144
> @@ -170,3 +182,9 @@ QA output created by 032
>  +++ resize fs to 671088640
>  +++ umount fs
>  +++ check fs
> ++++ truncate image file to 12582912
> ++++ create fs on image file 102400
> ++++ mount image file
> ++++ resize fs to 12582912
> ++++ umount fs
> ++++ check fs
> -- 
> 2.43.0
> 


