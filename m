Return-Path: <linux-ext4+bounces-7755-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D828AAC906
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 17:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668BD5083BB
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4775A28313A;
	Tue,  6 May 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duDKAhIR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978D2820CD
	for <linux-ext4@vger.kernel.org>; Tue,  6 May 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543811; cv=none; b=f5oiLndowN2Ba0OREjVBE6j9Eg4lUQa7dOQQMC6V+3umED65BAgtIr8ykb9i449Rmk67RtyJHPQWml8H4tmSUeWl5ZLoiEb8L9chhYICj6q9AY7k+SBGCKjx8odVMJ7U+6IWE+0q98JzYz7fX+6pjlTPwEaoDOGPVkCqkKgySrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543811; c=relaxed/simple;
	bh=8d9y7ErAjrQOqXuTSOAhEkVIMlXmxaC6B2austCbO/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8oT9NR/EaqEeuNvrxW9wzp4a8CbyINQsakzsIcS5ZJDjBpudq5bAT4CiOMxP1bEQsgSw4lwlCZ27XbnD5XDOxyxBqmgUDB8gW+lgC5FdF2kQSUfanIgbR1ikbMaqsFkTy9B0Ro0nUICmgqxaoQpDqIc6Rd0tCNLthC0NoC1a4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duDKAhIR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746543806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXH29pQMVy4AFRYT+iKQo6DbbvX/wUT7EjvyqhEcdds=;
	b=duDKAhIRpEbrCqbwshT58QmIWfA7MmzKIuxWbeLIamyxXBVGabLYGQWPjS7lZeNKl0Lgfu
	/P1ToDpq82rcvjnmTVbpLzXytRfbWh0aXdPLQHivLAiL0FtxsTy4QvBm2kfwBXLiyTHlfQ
	qeEAJutO4vZduDUsBtz0mGeff3FmzXA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-g-JUtUauNsa2KBT5gpDtSg-1; Tue, 06 May 2025 11:03:24 -0400
X-MC-Unique: g-JUtUauNsa2KBT5gpDtSg-1
X-Mimecast-MFC-AGG-ID: g-JUtUauNsa2KBT5gpDtSg_1746543803
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-224347aef79so77105955ad.2
        for <linux-ext4@vger.kernel.org>; Tue, 06 May 2025 08:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543803; x=1747148603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXH29pQMVy4AFRYT+iKQo6DbbvX/wUT7EjvyqhEcdds=;
        b=mSLhaYCDJPfICztCsfgSEsXzs1SuIvpq6Gb2hEJN0+twqEV5RhdJ9Tm1lbfmVyNrAS
         fqJWO4VI4iqd14/5b0x3wm6Qyqs70PoGOzU3cd2Qt1ccBsOGT9aiJNZbQso/WDdVZh8e
         LUuCynC2noWlK7KtFgo/cmNxg8PTcNoHCIbKnWL9+EpXvJh6A5gm4frL79yb5GPIwXeT
         Bgt7xFMmw4Zs/qY5z4JgksqwxTqS+nvFd6vjoavZtbmW83CQvAfrkgdyZWv5ZUtR5NXL
         QFVYZg8JK46tlz7fFPbS2ZM4R5tAIrsLH3AbIN5Fi4dpFXhlhZZfl5NgIPBFXPQ7fWGn
         1SQg==
X-Forwarded-Encrypted: i=1; AJvYcCVF5Fg1H26l4PlhwdPe5ypUFvPqJDTzwC0iSUtB9ANskEBfk0oFpzzV81n+pXPLBNCvE7bVQohWXY0v@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPZxAMVzM4Ov2WI7rehI8FTUgJ6EkTLYRLww9Yhapq7CaIN7N
	DNM4hsHoO/3dsZdZBh9WMzu8SB7hx/y78+Qcedd30jCKBVDUSykT8kvCSe87tiZZ+ET3gzGhXpQ
	czvTUoolAD6SrT5UcezcUoRp/urmjKRHjrxKpFKI+T61+g0UHRsE074nLcUA=
X-Gm-Gg: ASbGncswXgDuNwJHPeOCVhJTmqQYSg1MwvWr8CL5BwaPu1HYZEEyaqVoFLMhS7g/ZTh
	OsKlt/sf9DFff0tbrW6Tm0TOqZLcXuL9Nua3R+dqLjEdJN9NnCN1f7opidgHuqn669VaKoaLQaW
	rbEaY9cc4NKfcCKYj4wUIi/52ZfAdnQnGWAEUsHPSVz723YmKyvb0CceZxUNrQe9Nk/S4hbiKCh
	3FiiT/iau2pO+D6Z9Q2wb//oVgQnbT9ngXz1ylbN4MBmMff839YaYARVUP6QbV2GAbuqol1wkuI
	dzDV4rPkd8qy0WtybbEtpXNjDsILgpxWOOhXEFHgzg0PQLynaOVZ
X-Received: by 2002:a17:902:ef12:b0:220:ff3f:6cba with SMTP id d9443c01a7336-22e3637c4aamr51936065ad.38.1746543803499;
        Tue, 06 May 2025 08:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzJ30l1YniISkWfcZGEXxVAdWUIYEHNTBNN13j9xo6yVGOoS2bHKkxOo79oeFDE+EwgmX1fA==
X-Received: by 2002:a17:902:ef12:b0:220:ff3f:6cba with SMTP id d9443c01a7336-22e3637c4aamr51935745ad.38.1746543803172;
        Tue, 06 May 2025 08:03:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e3b99dce9sm15152655ad.6.2025.05.06.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:03:22 -0700 (PDT)
Date: Tue, 6 May 2025 23:03:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH v3 0/2] common: Move exit related functions to common/exit
Message-ID: <20250506150317.dtaqcp6ocwfb2vwg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
 <aefede43-9ac6-43bb-a22a-47dc0f4c8cd9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefede43-9ac6-43bb-a22a-47dc0f4c8cd9@gmail.com>

On Tue, May 06, 2025 at 02:19:07PM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 4/30/25 18:15, Nirjhar Roy (IBM) wrote:
> > This patch series moves all the exit related functions to a separate file -
> > common/exit. This will remove the dependency to source non-related files to use
> > these exit related functions. Thanks to Dave for suggesting this[1]. The second
> > patch replaces exit with _exit in check file - I missed replacing them in [2].
> > 
> > [v2] -> v3
> >   Addressed Dave's feedbacks.
> >   In patch [1/2]
> >    - Removed _die() and die_now() from common/exit
> >    - Replaced die_now() with _fatal in common/punch
> >    - Removed sourcing of common/exit and common/test_names from common/config
> >      and moved them to the beginning of check.
> >    - Added sourcing of common/test_names in _begin_fstest() since common/config
> >      is no more sourcing common/test_names.
> >    - Added a blank line in _begin_fstest() after sourcing common/{exit,test_names}
> >   In patch [2/2]
> >    - Replaced "_exit 1" with _fatal and "echo <error message>; _exit 1" with
> >     _fatal <error message>.
> >    - Reverted to "exit \$status" in the trap handler registration in check - just
> >      to make it more obvious to the reader that we are capturing $status as the
> >      final exit value.
> 
> Hi Dave and Zorro,
> 
> Any further feedback in this version?

This version is good to me, if there's not more review points from others, I'll merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> --NR
> 
> > 
> > [v1] https://lore.kernel.org/all/cover.1745390030.git.nirjhar.roy.lists@gmail.com/
> > [v2] https://lore.kernel.org/all/cover.1745908976.git.nirjhar.roy.lists@gmail.com/
> > [1] https://lore.kernel.org/all/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
> > [2] https://lore.kernel.org/all/48dacdf636be19ae8bff66cc3852d27e28030613.1744181682.git.nirjhar.roy.lists@gmail.com/
> > 
> > 
> > Nirjhar Roy (IBM) (2):
> >    common: Move exit related functions to a common/exit
> >    check: Replace exit with _fatal and _exit in check
> > 
> >   check           | 54 ++++++++++++++++++-------------------------------
> >   common/config   | 17 ----------------
> >   common/exit     | 39 +++++++++++++++++++++++++++++++++++
> >   common/preamble |  3 +++
> >   common/punch    | 39 ++++++++++++++++-------------------
> >   common/rc       | 28 -------------------------
> >   6 files changed, 79 insertions(+), 101 deletions(-)
> >   create mode 100644 common/exit
> > 
> > --
> > 2.34.1
> > 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 
> 


