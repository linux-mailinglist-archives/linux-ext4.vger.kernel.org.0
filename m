Return-Path: <linux-ext4+bounces-12145-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E92CA156A
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 20:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15B832A3D55
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314332ED22;
	Wed,  3 Dec 2025 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="oWPLoaJK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6B2F90CA
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787305; cv=none; b=mgWpLQuh/B53zFLYkG/qugCnzWEjl2cC5r3ACIVD5ps+wkLimY7voP3jFdb8QQtEDRWHlLL0S8JE3HNVNIGb680Io7J20SXO6ZPO8MJ0nsbqWscfOipUbdaMzoBJ9U/rVaTp8bNlh36ZcnGXbdv1pk4YIe6FR76wQc8SfNdIS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787305; c=relaxed/simple;
	bh=hqfPjT7qFLqjPx8uTnpHVZmH1aAF8LyeB35G2WmTWfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLC6+duM5tnu5a6qKaADPK/7Gk286zUoAQ+xO214Mn+Q2zXR2RYzJ9fNoemjYyfw7I1dNy/8Kubvh44C3PGYJA3S8L1SEGn46iqTMLDEDXlFTjrKdB0qvycGuo2J2Le25zW0rw62SQJOHD5OFgsakxMWUB0WjaQHEczf56+vsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=oWPLoaJK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-187.bstnma.fios.verizon.net [173.48.102.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B3IfNAa006502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Dec 2025 13:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764787286; bh=MyV+mB2jQVRXWGqh39soDUJCtvs1t1WU+YSjLvX0Ye8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=oWPLoaJKAr4zQsr8bZqSUf8NLt46Jl+milcSpyhEsrwZw8Sf9Sn23vZ+1aadAYM1A
	 QpcHLif4tPb5k8NO0SDaxZEG9AbdSXRM2Nme6AbQIMQ5wHa4iQ3LU8hMEYmDwtkuhW
	 UasxmR8x+KYdCFdiWMu6BpL/9LlJGUTNUaJEeJQbLDq3i2zFWSZ3/8qeGyKv6CyoGA
	 24HA9WlNanegbz0EwFTAcMWEBK7v4Fi+l8zey3W3gJjxYDti1Vfvys0Bti4OGSrgBY
	 af5T6VAjJBL02x2WFYu3025ME/qL0fErB7/FDiopkDe5+auyNuV8F7pN9cKzwIZ6Tl
	 LXSu1bMWB+Q2g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 8AA0D4E1E599; Wed,  3 Dec 2025 13:40:22 -0500 (EST)
Date: Wed, 3 Dec 2025 13:40:22 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in
 ext4_page_mkwrite()
Message-ID: <20251203184022.GJ93777@macsyma.lan>
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
 <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203154657.GC93777@macsyma.lan>

On Wed, Dec 03, 2025 at 10:46:57AM -0500, Theodore Tso wrote:
> 
> 	if (!folio_test_uptodate(folio)) {
> 		ret = VM_FAULT_SIGBUS;
> 		goto out;
> 	}

And actually, thinking about this some more, is this check something
that we should be doing in ext4?  Or in the mm layer?

Matthew, what do you think?

     	       	  	   	     	- Ted

