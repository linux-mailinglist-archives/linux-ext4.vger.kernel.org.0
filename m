Return-Path: <linux-ext4+bounces-6940-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665FA6B3ED
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Mar 2025 06:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E2A465CD8
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Mar 2025 05:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994B1D516F;
	Fri, 21 Mar 2025 05:09:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C8282F1
	for <linux-ext4@vger.kernel.org>; Fri, 21 Mar 2025 05:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533772; cv=none; b=A7xo36+H/4wLRF/b5fzIfbLrk91vMU6O0YGDaelMtDGj4uS1/j1AEaA5E7gZWOk1fno+iQxkDKeDMqB9v1pHdHcfDqPgyMS1JioVSFxcUL+isQXsqxAvXNOK+Jwd9IC55sN1hVmxrT6f/hoJxDQ9lOqPY1QJa5X5tMEKZVGqUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533772; c=relaxed/simple;
	bh=thSOFIOaa7CQ3M84B093YYjHWrRsz7Aqtb8JBKOH6rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK9TX9YqJEQxQh0LS0mswajuwlJLRXCRxX5l+nUgA+b0Ej4rA69CK9JOI/kDkjCo6t01UCRlVIpjUyyxsuyQoarWDx54D0ItXXexOAMOHQwajBViDL5x3FCo43eSQlrqxCMtv2zPJWs01VEeU0xS1Zq+LdZ6O4+ipryUX95cGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52L58sAT020188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 01:08:54 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0C89A2E010B; Fri, 21 Mar 2025 01:08:54 -0400 (EDT)
Date: Fri, 21 Mar 2025 01:08:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Charles Han <hanchunchao@inspur.com>
Cc: adilger.kernel@dilger.ca, shikemeng@huaweicloud.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix potential null dereference in ext4 test
Message-ID: <20250321050854.GC1161423@mit.edu>
References: <20250307115432.2112-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307115432.2112-1-hanchunchao@inspur.com>

On Fri, Mar 07, 2025 at 07:54:31PM +0800, Charles Han wrote:
> kunit_kzalloc() may return a NULL pointer, dereferencing it without
> NULL check may lead to NULL dereference.
> Add a NULL check for test_state

Thanks, others have submitted the same fix.  It's now fixed in my tree
and linux-next.

	       	    	      	       - Ted

