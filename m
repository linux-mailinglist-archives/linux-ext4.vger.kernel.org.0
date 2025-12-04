Return-Path: <linux-ext4+bounces-12155-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC65CA3E88
	for <lists+linux-ext4@lfdr.de>; Thu, 04 Dec 2025 14:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 211353095E42
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Dec 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E0A33508C;
	Thu,  4 Dec 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CYhHZNBj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxFswYUs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9F333420;
	Thu,  4 Dec 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855751; cv=none; b=ELMTQC0aiW+v8xH2DzF2cBpt2QN5wd/WpCP13i4vOYw67ZWqWkFVbgQatDbtOCPu138z/PCG/7SsEgumFyIvjOvm01GYQiITymzo8EPGMzwCnZcGqh3P+/SsCYyhDMcBVXsanDhmgum2H5nBqnzNu8p+z49v3i0b152qymVFLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855751; c=relaxed/simple;
	bh=QxcnK8IosllFIf/19q0p+7wwom5vEbE6M5uR89vyNIU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YdnNaiaJsby0jNIIptpA36aIO5KRGuMbkqfPZ7G2YctC9rPrENijgNDcYV4/TfJLB6Up8QtZBPyW3k/Ye+3Hd7eh4i06oH4SmLB575HmZN1CANr7tWscwd+dzk3szSmaQOpJF+wDvSKGQtb4ccTHagkFVGLSoDkEjUsshaE041A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CYhHZNBj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jxFswYUs; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D61037A015D;
	Thu,  4 Dec 2025 08:42:27 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Thu, 04 Dec 2025 08:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764855747;
	 x=1764942147; bh=WWDxjptQbcfXXkMz0Nh1sEB1n0QB96nHUF/JtdtdjTk=; b=
	CYhHZNBj/LqWTR1YJd+rnCShceO1SXGYhAmljho5UJ8sIxVNnu+/uMRoKNTubjAh
	iKYZB5jxssjiVcGI2CN19DdbSa/VslCuf8e+ty4IOaKIlQuficC4ZzaoDHvif2ZF
	G1rxPtrL6s5Imr4a3kRqfcIb51aKun5jyCBQSiV8pgPxFHY9q/3AUnjSeIvfYTWT
	dKmwVuQVYcEZZHeZqkwaoS0/CruFX913pnOwui86PAefbJxdD5gIcjdby8LH+c53
	Ha1OMYPWQNwxjO2hQNwXmpwkHeKMfoUJ22rXHom2leuPoPTpOqANVjE5mgC7YLVz
	TonSMJiMfKZcVZmOi5ERog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764855747; x=
	1764942147; bh=WWDxjptQbcfXXkMz0Nh1sEB1n0QB96nHUF/JtdtdjTk=; b=j
	xFswYUsgHztbA8EonpHEqgZcFC1fOYJHTs+Rm7ik1YpVdr8fwtbTsu2ipXUQAGJh
	P9S2HxcpUdilMXOviZzI7RZiryo0Yi9His1kprmnX7d45tojYgTRiFnm3mGgOsfn
	RiECyjnVPJ/kUnzNtM4fKQeBBg1z1zhzBPT4+wFTRBW8VkdwFK4aQGPRnNQPJpjV
	z4ETJtQO+zCig87XkDmtwL4nbvVIK//RxBKdd0pLMy+2o0BqJsLg6m9ZTTneopw2
	qOZd5pVXx74VF8adAWstLaUWpSrJ1Y09GqFPb1wtazE4t0YaHrgapXDkqGo3s90g
	LSGP2efXhRE7f16wDRoew==
X-ME-Sender: <xms:w48xabJkP5T22Nl885AFQODMNuFdO8y2Xtq0LH0kYmrMVV5DMmI2JQ>
    <xme:w48xaZ-fHB9D5_Z8TOv_gIf3DaausGNLS2NfnepfzYWsok8dAc_zwNM6N58f4WT3t
    WOEj152IjBVuhTHTG5-LAYF2bg0UEXu0LDPr6bf-6C2Pk21tRnvgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    ephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprgguihhlghgvrhdrkhgvrhhnvghlseguihhlghgvrhdrtggrpdhrtghpth
    htohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhngheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphht
    thhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdgvgihtgeesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:w48xaXKOOodw5zjKaFwZTHiUaCGlv957eH8L8qBLMRLYO47U1TFgRQ>
    <xmx:w48xaR5jxN-VvGlhLkxhtCQjBAeYEEOWJvBws6x5WPZAgSpiq7bntA>
    <xmx:w48xaRcIB06QOqbg_b_nvgYBHB0dNnArXdPiYACYRZJ8wvVX9B8G3Q>
    <xmx:w48xacHwlHiQYkM3pu1cYOlpnh-QR2r7iKQQ4ICXJZlk1V-ACuzwew>
    <xmx:w48xaaNqVrhPyTHpVJBfOFjfYcXO9-Npxd0TwEI51fHZ-Wc7Cr6QptVG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 59095C4006B; Thu,  4 Dec 2025 08:42:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZXKNX32rXGF
Date: Thu, 04 Dec 2025 14:42:06 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Laight" <david.laight.linux@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.cz>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <6893f1e7-3e0b-4cf1-9c35-5d28b2507129@app.fastmail.com>
In-Reply-To: <20251204123507.2e6091a9@pumpkin>
References: <20251204101914.1037148-1-arnd@kernel.org>
 <20251204123507.2e6091a9@pumpkin>
Subject: Re: [PATCH] ext4: fix ext4_tune_sb_params padding
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Dec 4, 2025, at 13:35, David Laight wrote:
> On Thu,  4 Dec 2025 11:19:10 +0100
> Arnd Bergmann <arnd@kernel.org> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The padding at the end of struct ext4_tune_sb_params is architecture
>> specific and in particular is different between x86-32 and x86-64,
>> since the __u64 member only enforces struct alignment on the latter.
>
> Is it worth adding a compile-time check for the size somewhere?
> Since the intention seems to be that any extensions will use the padding.

There is already ABI checking with abigail that ensures that struct
members and sizes don't change in the future, which I think covers
that. I would also like to push my series to enable -Werror=padded
in the header checks, but I'm not sure yet what others think of the
idea.

     Arnd

