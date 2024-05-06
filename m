Return-Path: <linux-ext4+bounces-2316-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101EE8BCEF6
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99A61F2420A
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9E78276;
	Mon,  6 May 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fisica.ufpr.br header.i=@fisica.ufpr.br header.b="SaLNdsq2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from hoggar.fisica.ufpr.br (hoggar.fisica.ufpr.br [200.238.171.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913474BF8;
	Mon,  6 May 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.238.171.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002354; cv=none; b=nmyXxTpRgCmWBT28PBfdv142BamutrxvjrmJGCjlXSxRpghpmrSM4QQEMPLZU9Gz4BqA9sSDyuV21npbibGxGKeyZX2KOSvL9Of0PZrgMLrJGEDuGseHTzifpVHjKHATK+P+9PULwSL6564NAXZq5roJ+iUvKNj9DDsQBVf+y8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002354; c=relaxed/simple;
	bh=5aPWLNBCt9nnOWvrjzXnoFe/wAdPKeU8CYYqXZeZPZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZYfuQga1hVO5DrHa2kSVYEKgzPT6JyNL9x+xcPEhpswQL9DiR1doeI8Z6yJHu1L3iP4UEkuCBCEiLYZHV3RdMdtSFHt6bDHlt2FYZ62/AyzVwts6nSfPmtiChOlLxzol1PMH1Ua72GyMP8VmmCQV1DBVWscfdCWUMnAjKSw29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fisica.ufpr.br; spf=pass smtp.mailfrom=fisica.ufpr.br; dkim=pass (2048-bit key) header.d=fisica.ufpr.br header.i=@fisica.ufpr.br header.b=SaLNdsq2; arc=none smtp.client-ip=200.238.171.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fisica.ufpr.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fisica.ufpr.br
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fisica.ufpr.br;
	s=201705; t=1715002338;
	bh=5aPWLNBCt9nnOWvrjzXnoFe/wAdPKeU8CYYqXZeZPZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaLNdsq24DmAzv2rf5bj32oN1ZeRCqh1yXkv9KIcIMqs2niaZcdr0dew0kw9XyN6q
	 OtXL/zdyIwYusDptM8IrNxe1jkWxiUu+V/NA5QJM7jSpKFcqfoS/dbOqjeUuckLFYb
	 RI2RSjcD75VmEUsnageM0lxENHhqlD6QNoI/fgEPeUZwwhZ6KuepnrJDZJv9EF1sIg
	 Bx6hFY/B0Pt8tX+0gJTOSGNpYSI2yGPIjjwmLbj5tRW7JhkcIhk9i8rkCtvatxsZq6
	 2lOMSL2cVsOB6d1So0Zi7NiEWJ2Ire54M7icBYWiTP9TdfZ+WJO8KMmgS/mOxwYL/G
	 MOvA/1PMyIaew==
Received: by hoggar.fisica.ufpr.br (Postfix, from userid 577)
	id BB29D11A7C87; Mon, 06 May 2024 10:32:18 -0300 (-03)
Date: Mon, 6 May 2024 10:32:18 -0300
From: Carlos Carvalho <carlos@fisica.ufpr.br>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-raid <linux-raid@vger.kernel.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Massive slowdown in kernels as of 6.x
Message-ID: <Zjjb4mjcnjxrPUw3@fisica.ufpr.br>
References: <1ebabc15-51a8-59f3-c813-4e65e897a373@diagnostix.dwd.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ebabc15-51a8-59f3-c813-4e65e897a373@diagnostix.dwd.de>

Holger Kiehl (Holger.Kiehl@dwd.de) wrote on Mon, May 06, 2024 at 08:31:37AM -03:
> Mounted as follows:
> 
>    /dev/md0 on /u2 type ext4 (rw,nodev,noatime,commit=600,stripe=640)

Sorry, missed that. You can try

# mount -o remount,stripe=0 /dev/md0

ext4 is known to have a problem with parity raid with the symptoms you
describe and the above remount works around it. raid10 doesn't have parity but
is stripped so the workaround might work.

