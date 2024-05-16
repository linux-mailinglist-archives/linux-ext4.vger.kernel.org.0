Return-Path: <linux-ext4+bounces-2537-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F1C8C780F
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020741C21AB2
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090CB1482F0;
	Thu, 16 May 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bDAflBKR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE08145A1D
	for <linux-ext4@vger.kernel.org>; Thu, 16 May 2024 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715867910; cv=none; b=lUt+sCvfXnLUcgFI78AITiJf31RUnnIRAcQEyG1ibaPLtPuTtE2/9UQJhIHAXSdfd3g3K1/AUG4AWDnbk3O9HcD+S1S2Sw1nQD2bHM+TTXVe3w2dJSzvY35iegPLTzHpax8kXtUqd+onayGA+HYgrd9kCsmRRviaGxWpzKbq/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715867910; c=relaxed/simple;
	bh=iWsDHgqNQ8pgweObYMjLBbN2LKY9Gg1S0d0qZ2RPGF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIB6RfC/f0khATTGDFbCI9bEC0Au6zq9blWARyxxdxYvOEsbr+iu2cBhr70txyVrB3iCy+nCdSUx6kqw94zT0cCrtX4h4asJgdM9YgCesylAjcT47DTBW1wbpHllTRgROgAZ0FL+7BXtMQmgpA8iFPyx25n69YuqOZxUqOzf7G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bDAflBKR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([50.204.89.32])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44GDwLJd030699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 09:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715867903; bh=xJIoxjlC8jU+siHznDQ1IUuhqn4B1CX0fXIalXOZzeA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bDAflBKR43ruQP4gVpuCQKJ71lKCvrUcjJuwDIGCknOThKSdRgqcnqjgK1xtbG6Ju
	 egnhhWjSMmAWEfzBLgyh5cPfz3LqmvMNunCBVjA7o29uwntU1JPKwYP8JEPNi4f9bx
	 tqqdd7VP8hXK9LnGhVJbv5CguWr16izbc0QRzzjz5l90ZMS41nONTPdjzaB0ad6kgM
	 7BgTjr07c8kG49LKmtG2RQLlSxCOnYwdZ47nQ0a6bzzV1HY/2ABXxd6OjdOwc69POi
	 QIvc4SQyndJcbCXLvgLb9Kwmep6baOi5G4ml6BUhDO7bvnKehqKVpfCPmJSvkeh0Do
	 0kjTsD79zupgA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 29E1E3407A1; Thu, 16 May 2024 07:58:21 -0600 (MDT)
Date: Thu, 16 May 2024 07:58:21 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: Shuangpeng Bai <shuangpengbai@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: KASAN: use-after-free in ext4_find_extent in v6.9
Message-ID: <20240516135821.GA272071@mit.edu>
References: <5B9F0C1F-C804-4A9C-8597-4E1A7D16B983@gmail.com>
 <20240515224932.GA202157@mit.edu>
 <2184C9DB-DDC2-484B-A1B2-A1E312B62D54@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2184C9DB-DDC2-484B-A1B2-A1E312B62D54@gmail.com>

On Wed, May 15, 2024 at 08:33:33PM -0400, Shuangpeng Bai wrote:
> 
> You are right. I disabled CONFIG_BLK_DEV_WRITE_MOUNTED and found
> this bug can not be triggered anymore.
> 
> I am wondering if there is any suggested way for me to check whether
> a bug is reproduced under a reasonable environment (such as
> compiling config) or not? If so, that would be very helpful.

As I mentioned, the upstream syzkaller always forces the
CONFIG_BLK_DEV_WRITE_MOUNTED to be disabled.  That's the best way to
check whether the bug is reproducible under a reasonable environment,
and to do it in an automated way.

Cheers,

					- Ted

