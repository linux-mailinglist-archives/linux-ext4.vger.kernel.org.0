Return-Path: <linux-ext4+bounces-6304-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA8A278A8
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Feb 2025 18:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73B3D7A3DCF
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Feb 2025 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FB216E2C;
	Tue,  4 Feb 2025 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTv3GHy2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088F21765B
	for <linux-ext4@vger.kernel.org>; Tue,  4 Feb 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690582; cv=none; b=UvX5C9DYRo+RXuyFz30ZQx8W7YLoktQNpy2u0mwLfZudy9HUHZSw6zlb/OeS3P0B5O2sw8fiRhoKXiswrbnH1r53Im1OlyMx2/BM33yadE/1j5QNEqgoHFMi19cn31IaU/DMsvgInxxajHoc5qct9roBL88VDZ/ZfDD2ujVAHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690582; c=relaxed/simple;
	bh=kaqzE4CHHaM1Aqnj4GS/9KVQe097Vhi5E5Bi6Pt0Iqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zyc+eypgUUcNE5nKtutx/nCyAGFl+PK4qEzPRL5lOmHqEdyFJTsFJGxE3CbbO6txPC+ku3VGCwZECVsB5UiBgcoRUvhCRxLJpT7gkajC683szzlqhI5flShKj2vJi/B7H4B8A2A7stYv9+rznopKDNas51kZK4eZ9BkeXifVFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTv3GHy2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738690579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIlxlT5GvDdtnlDPE6aVG5NuaU14d5+F32sJyA4nKIk=;
	b=jTv3GHy2B4/PSfvhIVxZxx1Sp6rZ4Dkc98Tku2q4FbQGPUN94k5gz5rIcbxW5P/eiCOZFZ
	AhIEDr3AT4obHoVGyGCplQnzOpj3bKq3Ijim/F2ej8ugGnXmwwqPQV8uIL0N+s6/ATHCzn
	rKp8j24PD2jHY7Fv6sp44v61XZEe4V4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-58K1skSDM_6Ul4Sd2b-HZQ-1; Tue, 04 Feb 2025 12:36:17 -0500
X-MC-Unique: 58K1skSDM_6Ul4Sd2b-HZQ-1
X-Mimecast-MFC-AGG-ID: 58K1skSDM_6Ul4Sd2b-HZQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f9c774c1c1so2209319a91.0
        for <linux-ext4@vger.kernel.org>; Tue, 04 Feb 2025 09:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690575; x=1739295375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIlxlT5GvDdtnlDPE6aVG5NuaU14d5+F32sJyA4nKIk=;
        b=aTEa+ROJdJKlzgi5v9bUBEs4e78B9ZdgbWeERyOQBPImOPdJfZfHE/2fR7KNo8isrH
         X3hMs8gPZgL9qbOiHujSfGjIGr9xfI3kAlFmh3ntBu5Rcy81JyoCXH0x3I4tSeQ7LWNU
         TlgUAqFGlj56y1Pv83+3yM7dGBHRSoqocsLiYClJrJJJujF37cWnxC8wzp2GSOgsGUt2
         3HyQDwrU38LnxhGKNECC/T71RR43KJVGrxpQvWNZ3ozyTr/nuJR8BHAANuJ4qV5KMSS6
         wqKBRUyo6u9DfQHbRkIbNbSm3Ap5EbMYvYCJ3y6Un9s5mRrop9BnyXJFvfN4t+yWD/mX
         KSEw==
X-Forwarded-Encrypted: i=1; AJvYcCVhV7RmolhNwCIzKPQtYZ1BmsubMySYhnAco4s+Z9sryRnLuWgM4NDwAMZ4xvUB7S+UZEmaJPaO7gbO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Q6t1oRd2N0rm9nw7nTWDcE2qrEIO94b742UkiXvPcvStL8De
	/LWhe6olyArurLcCQyNLjc4+H7BIMv2IZjJkl1s3SnpU+tfv5l2dvX12XNiZq2Zo1AM0+cwboIV
	sKuJ3hEsGvQQ5mGMSbDl+COS8GcIvuA0jGA6MGeISEp+4y+5mQAd45rfAj90=
X-Gm-Gg: ASbGnctQk+6G9P3I1cQ8h6XdKX/OkSt2UjTW9rpVFOPzm7gxhrPyfAKHNdKfAdNMNXJ
	wDNfRWNgp0a6k8li9Fih0r3tj6VB/+Y0H+u4xu7y1TrIGYDIczPeV2RA65+AmgQgbJ8hQw84oIj
	bJf4eUIEYffU1ZxUmOjoN/kqSwakHgPQJL6DNsZ6pzYWW9qZ7ezcXbPz/zwexkVOaRvnHMZTyxZ
	pA4kOCF9OE3lWHFca8AugTXxRVI/DwbIoOQQ6JuCcY7j+o4CfyVZ0waMKoaXkvbX83BwrYHEH17
	pez2rMyOOL99GMMm8DRsj0C6H4kRpff7HvMz1aDURuKZIA==
X-Received: by 2002:a05:6a00:a88e:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-72fd0c98729mr40768263b3a.22.1738690574909;
        Tue, 04 Feb 2025 09:36:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYWcKcTHCT1xOLJ0jIr/KoDYsB8wS9lxwOYvyGzi25rW09Tm7wdNPYgBA9pweQb7N6R/AVVA==
X-Received: by 2002:a05:6a00:a88e:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-72fd0c98729mr40768231b3a.22.1738690574596;
        Tue, 04 Feb 2025 09:36:14 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6424f8csm10864631b3a.44.2025.02.04.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:36:14 -0800 (PST)
Date: Wed, 5 Feb 2025 01:36:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] replace _supported_fs with _exclude_fs
Message-ID: <20250204173610.6atogxyeab7xhlli@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250128071315.676272-1-hch@lst.de>
 <20250128071315.676272-4-hch@lst.de>
 <20250202133101.bpst6rzhjn7g4zvw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250203064029.GA16864@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203064029.GA16864@lst.de>

On Mon, Feb 03, 2025 at 07:40:29AM +0100, Christoph Hellwig wrote:
> On Sun, Feb 02, 2025 at 09:31:01PM +0800, Zorro Lang wrote:
> > generic/730 is missed:
> > 
> >   /var/lib/xfstests/tests/generic/370: line 31: _supported_fs: command not found
> > 
> > Anyway, I'll help to change g/370 when I merge this patch.
> 
> generic/730 didn't exist when I submitted this series, you applied
> it in the same batch of patches.

Yeah, sorry it's from another patch which was in the same fstests release
with  yours :) I've fix this "conflict" and pushed, please refer to the
latest for-next branch.

Thanks,
Zorro

> 
> But it really should not skip xfs to start with.  Either the test
> is correct and XFS should fail it (and get fixed) or the test is
> incorrect and it should not be added.  I suspect it is the former
> and I'll look into fixing it.
> 
> As added in the comments in this series we should never add a
> _exclude_fs without a very good reason and comment explaining it.
> 


