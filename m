Return-Path: <linux-ext4+bounces-3205-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96692E91A
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 15:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF21289275
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2024 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79561607BA;
	Thu, 11 Jul 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbHHyF/7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2B15FCED
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703809; cv=none; b=KSHqt22xSCOSxfT08GGXmxooWsWSJcZp+mOGVhY6hx0dtMAgPtBGHDItLwBm/dd1e7giR4vDiN0Ftik9gF+nrAkFz/13jlyQo3i90d1MDolDn/qDIY7WIvdAv47feWw7lDAwQDJ1BicooUsVsYeRB2qxPFS4t/PkH/Rde9/qnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703809; c=relaxed/simple;
	bh=Lhhf9Cwiy2b16rpSQ5wrUHf4nIRSvGGMWJMnncpSSrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH28016Hzmu0ei03I+ot+qy+/xWkPj5NZ3KgeeQjKBK2d3z75hmPYIshgkoRG2OXdUsLdtlyOFHoPU/QqY94whnRMOruWPeOxAqpVzehbBENackRvJuzfNBoF0ZocJdQk7Zc7ggiENrrcuGKMTP7/PxN5wbaqmFVovl9zPMxA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbHHyF/7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720703806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kICuC6UephpQnZRREowkwCRWc4L9gWonI74CmTG3w9I=;
	b=YbHHyF/7OU4FJjBf1So0+p6VpiDirjDIdWEvvPe7y8VurWwaSbDLDT57ZOBY22F9IozVTs
	CXk21/IhvJYXF+HwA+CQNJZGMX980+zf07PVOY3Ss7l8PUSwdvYE7dxDvGpsT3uPKfQlAz
	9pKHfjFbtPTckZ4HxL2/IlMiR239TKE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-ltB8EnfDPg2glVkEBdQjoA-1; Thu, 11 Jul 2024 09:16:45 -0400
X-MC-Unique: ltB8EnfDPg2glVkEBdQjoA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1fb116ff8bfso8459215ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 11 Jul 2024 06:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703804; x=1721308604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kICuC6UephpQnZRREowkwCRWc4L9gWonI74CmTG3w9I=;
        b=e9RBuNiHNBH6AAz8lKCI3wMnRC/jUwMnvDsNzCz24eLWCdfnQ0vYmqBdXcdIJ64OyF
         JOjRxfd5hyrsqjREFaIATyBYkvnlBGEuH/Q2SADJAzXFTtgxhQk8ydNMGH76dPg7J+9B
         ZWLuYfPfhjTkBBBo/ZxcFXFsJNhFj0C3pYaVanbhpUHXxKoXqbeRpVWuwMki26t9mxmr
         bixR66mC+h744jEIdJtqiy+bwliHI2ThW01hBZ4o37yQ4AG9eJLXQnQ56tftNd3JNNDz
         IQHTLV+y0NvQnc6Nxis/q/P1YbB77IRk5BBHpVEWJgCTToZ54gf6S4dDhWpINlyZbX1L
         igdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZqth8EocPBUGryE+MAA3gqnMUm65zbW9Ky363dtEeOefaTl0XUwgVqrJ2Ms5iC/QBaT/x5m7km+AqQmgfQQqBzKBtqB0sKTrI7w==
X-Gm-Message-State: AOJu0Ywi6Qqlf+grP/hujfW8fG6X3E75NydIxUpaZLgmlfWlouzD5Sh/
	K9sFfS2z/TEEKoolF5WVuNuzU2X+um8N+so09mz9UqIaj0jXiHuKSpTghkwh9ULY3duK0J0m3Xx
	dqFNFILzg8ttB8AILrB53djhoLL2q/G156jwrq9yNCZYsrdpgt4mFo1p5h4c=
X-Received: by 2002:a17:902:f691:b0:1fb:1fd6:5e57 with SMTP id d9443c01a7336-1fbb6ce5033mr71489045ad.6.1720703804123;
        Thu, 11 Jul 2024 06:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpMdyl18akj0+VA/oWLOWvxIOV4BCdIiIrIdhAbZbD0WDL02CPyOVIzjebhy6Xb4Noj7ANmg==
X-Received: by 2002:a17:902:f691:b0:1fb:1fd6:5e57 with SMTP id d9443c01a7336-1fbb6ce5033mr71488855ad.6.1720703803685;
        Thu, 11 Jul 2024 06:16:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac08dfsm50086345ad.213.2024.07.11.06.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:16:43 -0700 (PDT)
Date: Thu, 11 Jul 2024 21:16:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: mostly remove _supported_fs
Message-ID: <20240711131639.fmy4sjptoizsfuck@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240623121103.974270-1-hch@lst.de>
 <20240710061603.GA25790@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710061603.GA25790@lst.de>

On Wed, Jul 10, 2024 at 08:16:03AM +0200, Christoph Hellwig wrote:
> Hi Zorro,
> 
> is there anything that blocks this series?

Hi Christoph,

Nothing blocks this series. I'm testing it locally, if nothing wrong, I'll
push it in next release :) And I saw you talked with Ted and Darrick in
this series about g/740, so double check if there's something you want to
change.

Thanks,
Zorro

> 


