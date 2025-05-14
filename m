Return-Path: <linux-ext4+bounces-7875-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A374DAB6268
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 07:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992813BEBAC
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 05:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376BA1F3FC6;
	Wed, 14 May 2025 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeEMRc9l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9BA1DE4C5
	for <linux-ext4@vger.kernel.org>; Wed, 14 May 2025 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747201015; cv=none; b=rM7esdpTCIHmrxdBkBi2O6OEFhM67jH9dMrdDVGZPeL7H2eM4TrTuS8Nv3hjuuqt0VPDA9xiyTwHPv5ueFbiQuoY6ry/yHFyBUlLU6uXD1S9pE2RcUKM7xaLjDNuKiE/fLOVM8OGUELq16yS1Q3se/F2qfhfekJo3so8FrSXmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747201015; c=relaxed/simple;
	bh=5cfTI/aWoZlCOnNpty3N6u09TpujQH8CPhzu9Z7vEJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPXcRD4zEdpHDCki31hpmy9mrgbbiLfAR8jzuTIbwwF8uSsFFcc788rH4M01YOxkPsyY9A5LzKhB0E70h8IdyfMJjBBhx5FdQqxQ/HftNc+wPaUscx+rCdSIqYyKMzk3f0QlVAKY1MOwqKJ/35gRSOwSc3Pl0vJao4xgt8oVHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeEMRc9l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747201013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7DVWcCawpaeNJq2qKOr5EAfsfYlAClMdZ4LZ2aaJxI=;
	b=DeEMRc9lOWQT5QeT7dVD6hBqG/zUIqNYXmJAEl7UU7/iP1k8u20ZwOKKxPGjVqysKMEA7H
	brgXEi0Wf0hPLNtRG9UHYHJV3tgoh7X/sSLGk1pXFCPqhwf+661zAw1KdI7fQh7IXb/2Bb
	swsFmZvlQvXlwz7AdljE8bYxyffsSmI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-M3d3cIPyP_qypCmJ9SyoTA-1; Wed, 14 May 2025 01:36:52 -0400
X-MC-Unique: M3d3cIPyP_qypCmJ9SyoTA-1
X-Mimecast-MFC-AGG-ID: M3d3cIPyP_qypCmJ9SyoTA_1747201011
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so6489263a12.3
        for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 22:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747201011; x=1747805811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7DVWcCawpaeNJq2qKOr5EAfsfYlAClMdZ4LZ2aaJxI=;
        b=JJ0g1YtmiuCv53RM5QIM6KgC1cNh3momuhPC7QoQYs9t6fFFoRK9bmaqcZofjTQWEo
         i4Hdg5foCxOzkoQROW8dXT3KEeSeY5+SWDBsKQVr1T+gmPUFHiQpeeTpuhA6q6yZzaOP
         KdduF8m7SVkGclJt4MibM7kMLxkYmfCu3rn+kQf5lq5y+icEriNRBozWpI5F7uwZR7AW
         KXNdMGJpMYAK+JzgZBo3Un5qtyHAKQvEYOsKuie8ApXn2C7WwRUFkrQTXWV+xip9/eSC
         cWFUK8tOVPUd9A3ClQrvPsebGwed9W6Xzcw6+dL/XyaqvmOvYRKg4l35xG6vBTdnuwNm
         YCkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnZZjTaYCLjPWpLfHlXVarDmZ6ejas3pBmIqmNau+T5ZO6W71g+hN3AP54Jv8P6d8ntGAxlitDAgnA@vger.kernel.org
X-Gm-Message-State: AOJu0YwfOKcYPjhBlK9et6xPQqL0VHGhwfNN8o1dRdPYgLngE/Ys38n6
	Cj/FGt5iIT6PbtmwXQyeScPQy/f53Ae8kixuNW0bWiVdBeLY18Tnz2Cp0Ju8X3inlqRgnlRWD4o
	wsyOF/4NlI3AFA8HN+P9Ebw6jxgPpFuQrcSFRcPHu8Cc3qKkOJrzQF3doYPhq2jkvMmg=
X-Gm-Gg: ASbGnctf1zkPOJxxVcr07hzMVLIQZK379niX5MHBuzL+X96cf9YNMqtwNyzvz2ETqia
	oiu7b+kQBI1MS8VMAQqq+INSaE/K0CHjPlO54oKLU64WbTmb5VOL02dKUFhYQbnP4lgA1TB6Ll8
	RWRb20PPIKSFKEtfHmKhHDv3QXXqaZrQcGu89EE8mg5hAvs+iTPDDuREEkrehYtwkWpZZj8hIhf
	3E5In/TatyQpbl97Ii0+2cZocxDwMfa1bRUq2JX/3nfs6EZ+CSxt4R0S6QJrYeAWjmo9YjQ+jsU
	Qbkv0cBH4wRYXYlq7WS9uGexMOSOMqTr1f3ZELhPgI3+T6DvliaP
X-Received: by 2002:a05:6a21:33a1:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-215ff08f0d0mr2736417637.3.1747201010714;
        Tue, 13 May 2025 22:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5eWBBrJf4d2S34HMSb0MF2dI6lzhWWQaGfh5YOlas66yp91639bve2mCDTBX6wAna3TDIig==
X-Received: by 2002:a05:6a21:33a1:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-215ff08f0d0mr2736391637.3.1747201010402;
        Tue, 13 May 2025 22:36:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b236de8839asm8012301a12.40.2025.05.13.22.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:36:50 -0700 (PDT)
Date: Wed, 14 May 2025 13:36:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v1 1/3] new: Add a new parameter (name/emailid) in the
 "new" script
Message-ID: <20250514053644.q2yzlhceclxvvffn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
 <837f220a24b8cbaaaeb2bc91287f2d7db930001a.1747123422.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <837f220a24b8cbaaaeb2bc91287f2d7db930001a.1747123422.git.nirjhar.roy.lists@gmail.com>

On Tue, May 13, 2025 at 08:10:10AM +0000, Nirjhar Roy (IBM) wrote:
> This patch another optional interactive prompt to enter the
> author name and email id for each new test file that is
> created using the "new" file.
> 
> The sample output looks like something like the following:
> 
> ./new selftest
> Next test id is 007
> Append a name to the ID? Test name will be 007-$name. y,[n]:
> Creating test file '007'
> Add to group(s) [auto] (separate by space, ? for list): selftest quick
> Enter <author_name> <email-id>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
> Creating skeletal script for you to edit ...
>  done.
> 
> ...
> ...
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  new | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/new b/new
> index 6b50ffed..139715bf 100755
> --- a/new
> +++ b/new
> @@ -136,6 +136,9 @@ else
>  	check_groups "${new_groups[@]}" || exit 1
>  fi
>  
> +read -p "Enter <author_name> <email-id>: " -r

I think most of "YOUR NAME HERE" are the name of company, e.g.
"Oracle, Inc", "Red Hat, Inc". Some authors just write their names, e.g.
"Filipe Manana", "Chao Yu"...

So I think the "<email-id>" hint isn't necessary. If someone need that, he
can write it with his name together.

Thanks,
Zorro

> +author_name="${REPLY:=YOUR NAME HERE}"
> +
>  echo -n "Creating skeletal script for you to edit ..."
>  
>  year=`date +%Y`
> @@ -143,7 +146,7 @@ year=`date +%Y`
>  cat <<End-of-File >$tdir/$id
>  #! /bin/bash
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
> +# Copyright (c) $year $author_name.  All Rights Reserved.
>  #
>  # FS QA Test $id
>  #
> -- 
> 2.34.1
> 
> 


