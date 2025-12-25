Return-Path: <linux-ext4+bounces-12519-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CAFCDE1FF
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Dec 2025 23:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49AE8300B902
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Dec 2025 22:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E62848AD;
	Thu, 25 Dec 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=accum.se header.i=@accum.se header.b="lVSQrShb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.acc.umu.se (mail.acc.umu.se [130.239.18.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BD279DC3
	for <linux-ext4@vger.kernel.org>; Thu, 25 Dec 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.239.18.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766700844; cv=none; b=oSVFQ79IW3XRuAEfBzeGQn0lBiuJQRT4S/+fge7UCnfdey5tu44RzCWptmYf6clA0Rdiq+QdNcppW02jIh81J/wIlmdifuaVC0z/FeaCt8bGP1jHvLVhkrL++omx5CmEZXkxquPFTdetkKn4APX/y6Gk+TdebUjH3VMViKPVBgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766700844; c=relaxed/simple;
	bh=L3n+ZwKglIMGYxhwm3yVNySYXTChz0OtwWMn8kQTURc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=dZ/Q/6OPDE35HyCjjpBCh4aUP6dDnxR5JZJQ78IJGUIMbq4zJUVqAXLp3N729DUzzDyj/ymF/huxqdJ0EraSMcwVTIKZ3yTxb7fO/DfoV7pISdIBp/ItDQ83k6OKqF+ZrFetnlrMBDTjlCEbiGnz7Cd3Htb43i12XcYjtYfpxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=accum.se; spf=pass smtp.mailfrom=accum.se; dkim=pass (1024-bit key) header.d=accum.se header.i=@accum.se header.b=lVSQrShb; arc=none smtp.client-ip=130.239.18.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=accum.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=accum.se
Received: from localhost (localhost.localdomain [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 2D1E044B91
	for <linux-ext4@vger.kernel.org>; Thu, 25 Dec 2025 23:06:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=accum.se; s=default;
	t=1766700379; bh=L3n+ZwKglIMGYxhwm3yVNySYXTChz0OtwWMn8kQTURc=;
	h=Date:From:To:Subject:From;
	b=lVSQrShb06/pfj/JWta7eBuoDYO7iaTqsjkNsTr0G7Ym1MicF4PAvzwZDcZF8UGEi
	 o5qBaBIHMXEFdX7A+y3Xo8o6zmgNEPF98kyt3vifFQ786xWC7ej5ISAIQ6k0Ti5zae
	 kVDl49W7eCEoGQzNX3y+8Dee+P8LjGhFlBBHpHEU=
Received: from suiko.ac2.se (suiko.ac2.se [130.239.18.162])
	by mail.acc.umu.se (Postfix) with ESMTP id ED95444B90
	for <linux-ext4@vger.kernel.org>; Thu, 25 Dec 2025 23:06:17 +0100 (CET)
Received: by suiko.ac2.se (Postfix, from userid 10005)
	id DF74D42B4B; Thu, 25 Dec 2025 23:06:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by suiko.ac2.se (Postfix) with ESMTP id DA10642B49
	for <linux-ext4@vger.kernel.org>; Thu, 25 Dec 2025 23:06:17 +0100 (CET)
Date: Thu, 25 Dec 2025 23:06:17 +0100 (CET)
From: Bo Branten <bosse@accum.se>
X-X-Sender: bosse@suiko.ac2.se
To: linux-ext4@vger.kernel.org
Subject: question about the casefold feature
Message-ID: <f6df7d23-d465-5ae8-686c-11e772dc587f@accum.se>
User-Agent: Alpine 2.25 (DEB 592 2021-09-18)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


Hello,
I am studying the casefold feature in ext4 and is trying to understand why 
it was classified as an incompat feature instead of an read-only incompat 
feature? What bad would happen if one only trys to read an fs that was 
created with casefolding with an old kernel as long as one don't do any 
new writing to it?

Bo Brantén


