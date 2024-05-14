Return-Path: <linux-ext4+bounces-2495-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA6B8C4C4E
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 08:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527931F217A5
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 06:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF91CF8A;
	Tue, 14 May 2024 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DUGSein1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044A1CD38
	for <linux-ext4@vger.kernel.org>; Tue, 14 May 2024 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668181; cv=none; b=Mo3ddq3tH2yJkvaWe34ucuje+8RkwmDYJst95n8kq/uRR/Vnp1t6cIkleNmpdGf1zgzLPYRHZ/pLX5Cxu4wiEHZyCvOhUgPgCLHlu25nDnow3JhsmqW7zUNWQZxsfmiYm3KK9kgic83awnOIV14yNCwusuL7OAUPoM3hUvZE6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668181; c=relaxed/simple;
	bh=pPTPF06+Vab2kdwIuBG+QE+aqQ/bqUXlj3j0vV2O+ug=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uSN6Ykzvh1ctRSou8RxPW30kKSjGFRiab008GhGqIkgRz43ZJ6vjYP92S+QulSM3K1vDU8PCO6hkRQF8vQZW9yVzBOnnFgrytMEGtR5za13yBjOtiUWSNI4mzbT7crVSXh4Jhwx6BQbr6wsuU634+TCbYBwuLWG2HKrwMk7iN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DUGSein1; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([50.204.89.32])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44E6TXVX016010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 02:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715668175; bh=rp7v+qEt3X5JkQjt/u2/elDF4dnEZnOtgmiQ4+VIfWo=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DUGSein1Rz/NDtZAwea0tL2WvAJzU9S6b7km8hObpyu5W+ge4AlHI3tI5vadzvFtU
	 gW2Sn8O0BSj0oizllT4a4JLyBn+HMaUCccHd5SC4WGg3wTEMUXclj4RqBlI8Ecsan0
	 RtYqKEJeBbg0O8/93qsO4nDk4SNh0Xl2/9nRKwdu+Tx1LrY2DbT6zlWCVyQqJVAZjp
	 57GWReWBQPOPWTJf2mIN244XkVAl2Dvm+BjNX33XpscnH2z5lL7i0qHboX/kFqmVn7
	 dZkKInB+RSQnTxAb/gMZfK4ZQbP0XwC3w4xeOp62EWLU3mWIxJKmWHW3IkJ7Pvw2+y
	 pkFS3Hl+4SwDQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D9D0A34046A; Tue, 14 May 2024 00:29:32 -0600 (MDT)
Date: Tue, 14 May 2024 00:29:32 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: EXT4 BOF at LSF/MM
Message-ID: <20240514062932.GA56003@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a call for potential agenda topics at the Ext4 BOF at LSF/MM,
which will be held after the XFS BOF on Wednesday in Grand Ballroom B.

I'll kick things off with one suggestion:

* Time to deprecate data=journal mode?


What are other discussion topics that people would like to suggest?

Thanks,

							- Ted
							

