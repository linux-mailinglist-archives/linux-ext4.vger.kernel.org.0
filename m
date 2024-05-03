Return-Path: <linux-ext4+bounces-2274-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36D8BA5DE
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 06:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34049283FF3
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 04:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F81B208AD;
	Fri,  3 May 2024 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gJ3BFFwT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585757C97
	for <linux-ext4@vger.kernel.org>; Fri,  3 May 2024 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708922; cv=none; b=Gka68xF+G4qYP7O6U/TFvpv0/AjkcBHtsTb/wYe7ym4+j1kQBvpVVdR/EEGHtRSnKx94bAjm2wk5Bu/s2kFWh+LqxT25Ysq8kCr5n8TuCZhTMSe159Cqzr70mRTNVjg61GO3Q2kiahsZSukTo15rVmIuYCyRX8a9+l/q2WnXrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708922; c=relaxed/simple;
	bh=EIKqL4Fe6zTfIiGFvhplX1rkhlisWCXGK/ugG3gF7sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poIQy8lXzMDbCgu13gDU3PXsVw/lHjnJlGzQ2epkuwfNxx8iOIWT1keG3+nrldC0BejDk6kGtEdiHOrv5F2qtW8qHKwUi0D/yZiP0AnsZORZvp/JLHxT8W1NVOSns2KYrTTXt8qu+8f9ekLZJbocqzP0rQqj62vnGoGt7jBRSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gJ3BFFwT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44341p7r020175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 00:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714708914; bh=/Wbln/AFVQgPbrMO1nTELVEZKZ80m+nkQTpGDkZe9XI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=gJ3BFFwTyEwqRz9xM1YQTQROf7/IE+GR83zLkFt22axFIJDUBsSEKMFxvzBdSBrRo
	 8TpeuKaLYO+l8Y5meD8KjNMIjwLYT3CQ3lY5QSNljddgsZVZUzQa+LURkooGyEGs0d
	 uLBY9LB1hGp/SNoDc+YmwvWSzu5nCqyaD8DzUe+G/C4PIOstwLUHYB5HlY77z87+M+
	 42KszM9/mw2S7LRhqWh3DO/wY50nkDvWdu8LeB4/VMZl/4V5TQ4wikqRChzuFaK6B7
	 oGCNsFbyTMro38xzFbwqta7+RiOhd8lcY4h/84JjcIZYV3QM3qq2CpEL45577TN+qr
	 Jyuvpz5hHU6Mg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 828E015C02BB; Fri,  3 May 2024 00:01:51 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        Justin Stitt <justinstitt@google.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ext4: replace deprecated strncpy with alternatives
Date: Fri,  3 May 2024 00:01:47 -0400
Message-ID: <171470889035.3010818.5490902997038029222.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321-strncpy-fs-ext4-file-c-v1-1-36a6a09fef0c@google.com>
References: <20240321-strncpy-fs-ext4-file-c-v1-1-36a6a09fef0c@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Mar 2024 01:03:10 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> in file.c:
> s_last_mounted is marked as __nonstring meaning it does not need to be
> NUL-terminated. Let's instead use strtomem_pad() to copy bytes from the
> string source to the byte array destination -- while also ensuring to
> pad with zeroes.
> 
> [...]

Applied, thanks!

[1/1] ext4: replace deprecated strncpy with alternatives
      commit: 744a56389f7398f286231e062c2e63f0de01bcc6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

