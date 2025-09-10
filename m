Return-Path: <linux-ext4+bounces-9894-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB14B50DD3
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 08:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D204E068D
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 06:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0F2305E19;
	Wed, 10 Sep 2025 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjHxuDyr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83D2D191E
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 06:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484447; cv=none; b=EpDhlu2uiWwE+Y1TEfYis0RcsTY9CrIeYWoSicB51kUVtNYWRcsrbwCqeWgDmTjA//MLxhaGDkk6B3ZBkHfGXtOxLxsuN77NybAzsgVduJJtyQfldOhVN8WpPkZgJM27elEKKdoKkabhUM/fH6U5Sf9ewXEN3acT1LVVphMRxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484447; c=relaxed/simple;
	bh=gbYCNoVCr2sz/dvmF3FJfLnJEFurD2LkE3QO/MJ+M9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgyYwD4rSIHXbzYf9Z0zyX9f5umFng+9XbAUaFMzPht9it+NV6C2djM5b8BXjRLUChMyOifwQt7dkP7L5JeNIhpDS5IKL1vsqehNkFSohSYJl+D2q2AE+tXq//rbvup6C6dZkjdlZMkkw7RR5SDA/XI+O+8MX1H+pg5MCexag6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjHxuDyr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757484444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mWiGzTdHTTRflbkk77kHOQXZWch1zMY1MtxXB+Kyuw=;
	b=OjHxuDyrG5eZrTFYx+Cpk2FXyK7s2kn8rXF/uS+X6EHhgNzGQCS79kpFZRKZEtmLufXQYK
	UyvSSLNK4doYs9L0+8M8M2Ndd2EARNKZrlUCvOaAJzEXCYj0Og4q8TvcfhZP67kZ9V0KCs
	/CMemZ/6KhIiT7Ih/AU0daagSMikyD4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-ifNJQWrKNLSJxD8BvtL6gQ-1; Wed, 10 Sep 2025 02:07:23 -0400
X-MC-Unique: ifNJQWrKNLSJxD8BvtL6gQ-1
X-Mimecast-MFC-AGG-ID: ifNJQWrKNLSJxD8BvtL6gQ_1757484442
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458345f5dso90312005ad.3
        for <linux-ext4@vger.kernel.org>; Tue, 09 Sep 2025 23:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757484442; x=1758089242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mWiGzTdHTTRflbkk77kHOQXZWch1zMY1MtxXB+Kyuw=;
        b=dUICNy45ZP+d2lMXm1pgH0fMHT7ubAYzkgSA9ybBl06fFyyJkzH5Z/0950qs/ukfDR
         JbGanCUtmDHlxTSWrTyiPDZypKuLQ/QfkYyVAozT4IDB8rWQjh/eLog5ImQiUhguRUQY
         w7vkO7OoinIu+THrv1bgZRVGoT10qA2DUK6Yiw6KjqZgfV+YEZx0tM0AQrrkfkC1sPk0
         HASShUy3iyZel80HpNpes79TluCFJyiMK08lB+RG0huPshhA9iYahS77427b97EjPHJg
         lCL+bV5BUFh3AukJ8Lwggpb6dts4WJvQlNmsfNn94sqdRWW1p6SKllAqcoRd6jPwHKJZ
         LOYA==
X-Forwarded-Encrypted: i=1; AJvYcCVgD8gbIUZfibPADQ6oTjHvV6082wthuwTKjqy5DsL8UUQ/sGtmikZ8uTm7HFM/qcyTXqmqVQEno1xy@vger.kernel.org
X-Gm-Message-State: AOJu0YxsB2I3E7HABVnioucPrmD2dZatmMrkPOgkV39iLbVjX4CHqY0t
	+koSqkmWnaC1xv8YJC46q9C6sst0NtKwrvEwI4do77EBWUy6oMIL09fpbQDSNBIevTh7Z4fRwXf
	YDzX83ZOO2QR7qkazh5bTvYalyTZud7g7CyxAmpjOTh/KVJerkKibFFIKD31gpmfolbrcZ6Czsw
	==
X-Gm-Gg: ASbGncsR9z9gYgUbgkBkdDfKmt+TmvykmGM1mGEg5idLA5rl/iGXrkJcDNEycP95N7X
	VVNlif/4FUW4J0n5h8lfULvEEL9pizNUZCGjxM/zBZLK4ftPLAgTXsumJR5hjkLKwAbqzVdU1rl
	wJQFC3kWSkmti8CzhSR6oeLSdJQ55LXHhff23ccXKj32OKe7/UoT/Xw+WO26ZKjO4kz0Qhq0Rq4
	AIvvjcNJT9sWCen1FMHDc1SgW6VaoBoaQdepRKGMX6sSFOOSC7a1+5Ng1tWUnOtv9DWKRDWp7nM
	6pZvZ/ERXwdNNFXUR8DGxea85gOLQTo7iBjCgptc961dt6EFSUEsa3wZW0MO0ISrQelxKzSevYK
	NPXv9
X-Received: by 2002:a17:902:d4cc:b0:24e:af92:70c2 with SMTP id d9443c01a7336-2516f240f23mr198910905ad.24.1757484441648;
        Tue, 09 Sep 2025 23:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1bGkKYcod7Z34ZVF7GZWSfh7v+1OYk2L6fq8uiER3IOseuf+HFEJpoxMGlGVvkQFgYlzxIA==
X-Received: by 2002:a17:902:d4cc:b0:24e:af92:70c2 with SMTP id d9443c01a7336-2516f240f23mr198910585ad.24.1757484441124;
        Tue, 09 Sep 2025 23:07:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2742590csm16198215ad.8.2025.09.09.23.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 23:07:20 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:07:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: John Garry <john.g.garry@oracle.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <20250910060715.gc2thcbklvhzaxz2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <1b12c0d9-b564-4e57-b1a5-359e2e538e9c@oracle.com>
 <20250907052943.4r3eod6bdb2up63p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aL_US3g7BFpRccQE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <08438a13-6be7-4be3-a102-35a1f6fec9a5@oracle.com>
 <aL_tLHcWyFPShrUc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aL_tLHcWyFPShrUc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Sep 09, 2025 at 02:32:36PM +0530, Ojaswin Mujoo wrote:
> On Tue, Sep 09, 2025 at 08:26:52AM +0100, John Garry wrote:
> > On 09/09/2025 08:16, Ojaswin Mujoo wrote:
> > > > > This requires the user to know the version which corresponds to the feature.
> > > > > Is that how things are done for other such utilities and their versions vs
> > > > > features?
> > > > > 
> > > > > I was going to suggest exporting something like
> > > > > _require_fio_atomic_writes(), and _require_fio_atomic_writes() calls
> > > > > _require_fio_version() to check the version.
> > > > (Sorry, I made a half reply in my last email)
> > > > 
> > > > This looks better than only using _require_fio_version. But the nature is still
> > > > checking fio version. If we don't have a better idea to check if fio really
> > > > support atomic writes, the _require_fio_version is still needed.
> > > > Or we rename it to "__require_fio_version" (one more "_"), to mark it's
> > > > not recommended using directly. But that looks a bit like a trick 😂
> > > > 
> > > > Thanks,
> > > > Zorro
> > > Hey Zorro, I agree with your points that version might not be the best
> > > indicator esp for downstream software, but at this point I'm unsure
> > > what's the workaround.

Hi Ojaswin, I don't have better workaround than require_fio_version for now. I mean:
1) name _require_fio_version as __require_fio_version, to mark it's an internal function
   of another common function.
2) only call __require_fio_version in _require_fio_atomic_writes for now, don't use it
   in any test cases directly.

> > > 
> > > One thing that comes to mind is to let fio do the atomic write and use
> > > the tracepoints to confirm if RWF_ATOMIC was passed, but that adds a lot
> > > of dependency on tracing framework being present (im unsure if something
> > > like this is used somewhere in xfstests before). Further it's messy to
> > > figure out that out of all the IO fio command will do, which one to
> > > check for RWF_ATOMIC.
> > > 
> > > It can be done I suppose but is this sort of complexity something we
> > > want to add is the question. Or do we just go ahead with the version
> > > check.
> > 
> > I think that just checking the version is fine for this specific feature.
> > But I still also think that versioning should be hidden from the end user,
> > i.e. we should provide a helper like _require_fio_atomic_writes
> 
> Sure, I'm okay. @Zorro, does that sound okay to you?

Sure, that's what I tried to say as above, sorry if I made you misunderstand :)

Thanks,
Zorro

> > 
> > thanks,
> > John
> 


