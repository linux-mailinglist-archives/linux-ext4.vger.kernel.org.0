Return-Path: <linux-ext4+bounces-1354-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3B85EB39
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 22:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC1628233F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0357B128373;
	Wed, 21 Feb 2024 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eP/0nrEB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B57127B66
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551997; cv=none; b=fKkuRPzm0KTYY1W0zC+OJS6OEkg/Cx8/a8zSgYB9WpHgs8h+k1EmJeXpxRQ0aUnBxB4lgG4BM+KyA4Q7/PPI79nw3tH14XTKLoaJyBZBIIs3Khk9nSztkXQMYFPEUPsDFcteXdbFDHCSYzaqSh6veNNz6ZeUpRY47ZCvQzsJ9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551997; c=relaxed/simple;
	bh=GHL7pKies6DxjBtJXbeq94J76LxJe7B4UO2yc0XNjLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAsUpmNz1WSJRmhY9q7126piqiot397YFkBNvFs7LaLGxahfGn6xtMWcaQcyyWo9HEGBhGBC3aya/76Zy1jBWxc+mOEYWwltBmSmP9sXlEBkxGCS+wyOiwgj34PjHCMDw0b4fVSVfmeQ+E5D16maecl9odqx15tiPkB2lJya0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=eP/0nrEB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41LLkQOT011479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 16:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708551988; bh=LYdKru+0kSq2j54g/XhCijm2qWmvTfLfKFGcIx7cmeU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=eP/0nrEBP3brTgRP8Lj6g0lu6i2QAbrFC8WPL6GqKNbGmkn/ivSrPkKhRzziipPXe
	 RajQ3VKPg+vbOc/KhU5qrq0jrjkEP4jMU0912IaeskgIdpImYA3m4FNtb5bYQmcSMt
	 s+aBBvv3aseJacZmM0ZgvgQ+79DPA5gJXpL3OcZ9i+B92JSYSOV7ybAfKBxboblFT2
	 2F8YwK03C7UFPsfkzaMGTVe6lR8ZCgUeVu0imfVpr8Ch+7nksITNMyphd8RWTXUkmv
	 j7tVYmoBvvCtefYd/OBtvGm75QIs0JRA3fd0/0onu2t78NfiQwgG8CbixaM+rkn7UP
	 aj4SyRBBoNAkA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 68CBC15C0336; Wed, 21 Feb 2024 16:46:26 -0500 (EST)
Date: Wed, 21 Feb 2024 16:46:26 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: JunChao Sun <sunjunchao2870@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: A problem about BLK_OPEN_RESTRICT_WRITES
Message-ID: <20240221214626.GB633176@mit.edu>
References: <CAHB1NahoCEsw-vtu=6AUgG8oL0tTVV3gbP121zTgvdBzrMUo8w@mail.gmail.com>
 <20240221161954.zwx34k5rvoevpe7o@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221161954.zwx34k5rvoevpe7o@quack3>

On Wed, Feb 21, 2024 at 05:19:54PM +0100, Jan Kara wrote:
> 
> No. Cases like above are the reason why there's still a config option
> CONFIG_BLK_DEV_WRITE_MOUNTED and it defaults to 'y'. We need to be fixing
> userspace - util-linux in this case - to avoid having writeable file handle
> open to block devices that are being mounted.

Note also that at least as far as ext4 is concerned, I don't recommend
that people use CONFIG_BLK_DEV_WRITE_MOUNTED on production systems.
This will break programs like tune2fs operating on mounted file
systems.  There is a plan to add super to allow various superblock
tuning operations to bet set via ioctls, much like the new ioctl's
which allow the label and uuid to be set via an ioctl.  This will
require users upgrade to newer kerrnels and newer versions of
e2fsprogs, so it will a while before we're at that point.

For now, the main use of CONFIG_BLK_DEV_WRITE_MOUNTED is to prevent
tools like syzbot from issuing false positives; I don't recommend that
it be used in other situations.

Cheers,

					- Ted

