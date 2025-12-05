Return-Path: <linux-ext4+bounces-12209-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D58CA75AD
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 12:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1A13079A04
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 11:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC3D31A545;
	Fri,  5 Dec 2025 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gvylSL66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DSRCaNxa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061F2F83C2;
	Fri,  5 Dec 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764933754; cv=none; b=QDNQbODDhKs25AoZyFtqoYbPhbwsE3ncfeIR1CQMrmNhR/PxSOscKGmMSKx6QMvkLf/s1x1RvcGDH/JS+oh+hOJk0ajw0KldWZ0nft5C5k59mkP6NX3R10M+H6cqGGiBxmmVKwm/Wjc2Nma9E0UW7JEpagYRt2PUN3wZt6fj4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764933754; c=relaxed/simple;
	bh=EXpnFycUd01xtwVkQQKLYPp/XCCUu8IXPx6xasaMzVc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nmLfQQ4fo66PiKjnQF56tr9Lzq6Ty0Dy3Z5h0GTLILtxAAVGjqVU+XFtnlkp5d8Yv9nzXdE7fNVNE4aL8OyK/1oFyoFl5bqNRo1Mc11ilSb3GN1rvyHT3Of4pG1nawoUoV4rsylUCZUwR5k3WjpFOdZ8qAX/pwxS2vQ2At03UdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gvylSL66; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DSRCaNxa; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC14E14000C5;
	Fri,  5 Dec 2025 06:22:28 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Fri, 05 Dec 2025 06:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764933748;
	 x=1765020148; bh=ytIpZFjO4mbAU1yjjbdp7ZFalj0d4nWstswhFAtPa1s=; b=
	gvylSL66HM68QYA6Vfh/5iz6WwebenrRoShNaWeRhE03+DKux80bXv9OiBTq+0OS
	B/3yf0DVZTS81ggXsz64/brd7Pd+VtqIDkOjmSTpXSqPwj1xZLkDTYYCJEYzlkwY
	wNMystn+v9YEx/EpMOdUxW1VFm2CCIvxorJGIOmqir1rjc2SZpkYzS695BPT+tjF
	ReBQxSJ96DSWKy5brMAhQ1I0fBwNBcS1s8aNaAx8fkLgtYRmdukGGoUSj8dDyLI7
	Mr1XLO47DejqZmNVRbDI70xySR5UbCXfvp1cUzrtQe3OfAC86AO1Kh3RQER6BcsI
	HbfFyKRfn5Yf5wTiCaZ9PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764933748; x=
	1765020148; bh=ytIpZFjO4mbAU1yjjbdp7ZFalj0d4nWstswhFAtPa1s=; b=D
	SRCaNxajD7UPFMbXQUQDoEUhenPnm7HTndpdS1p/hfShzbHP4ktGMQ7Yn40ObqV0
	eCR21U8l3u8mzc7kcc3RyGxkm0r6drh9qQwkEa/uCYLMgoGSXJjd//rR/AXpHMwK
	teLRjZBnQa6tvNjy6cl4dwJdFSL/7ECVy3RoLXoppPPeIbV1mr8WoBxEHE0wM0Zk
	OXH5RV3Q+PUH9fVesmlu+XYoesWwuEEYi4gljuuYfr+7QhoKYFBBEgjrL1PDh/kG
	AhnakEPxnrBsqWSU+D/m8hsQf+/4Craj8G4qhnrjO8tzWT1o7Our5mPy78i4r3xm
	o4pAWO5E/whs13sdyJ6Hg==
X-ME-Sender: <xms:dMAyaSgUt2iCitWZy1gN06tDYOn8oPO2hGcydUDCteLC5D21MgfqWw>
    <xme:dMAyad1YfjKcUBmkao34pUcj99HewGC3db2GM1FAESTMvZka9uVD4gPQ6IsX9xJL5
    eJVRSNJCafG387pxFc0ckHfeg6YRK37bT_OsXktt7fec_Q-0s-rfqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguse
    grrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprgguihhlghgvrhesughilhhgvghrrdgtrgdprhgtphhtthhopegrrhhnug
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:dMAyaYJkIho3ziAixiLrfpFrw1aYLIarr4W4TWUgiwepcOka3GkKXQ>
    <xmx:dMAyaSP3Fr2JOhyynS3-DPiZwP9exRHw4pAmjwvod0Yn9tgsW3z7Og>
    <xmx:dMAyaYkH78b4GB7l2g6-6KjTiOjddZuHx6f-VtQRDFhKKWym5HOK-Q>
    <xmx:dMAyaW5GQMPveDdhDkhow8EPBJsc03Uy6cJboTFkKfmM9zpICGZ4Bg>
    <xmx:dMAyadqvbYM8kmM5AZxdJ0_U91YdJqbGW_J3XDDhdkMyqdVxhiKXHohx>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1AA8FC40054; Fri,  5 Dec 2025 06:22:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZXKNX32rXGF
Date: Fri, 05 Dec 2025 12:22:07 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Dilger" <adilger@dilger.ca>, "Jan Kara" <jack@suse.cz>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <a1807d6f-1b47-4a30-86d8-eea56d990ed9@app.fastmail.com>
In-Reply-To: <B2AC14DC-0B9D-433A-A1B0-78D0778D0A39@dilger.ca>
References: <20251204101914.1037148-1-arnd@kernel.org>
 <3ueamfhbmtwmclmtm77msvsuylgxabt3zqkrtvxqtajqhupfdd@vy7bw3e3wiwn>
 <B2AC14DC-0B9D-433A-A1B0-78D0778D0A39@dilger.ca>
Subject: Re: [PATCH] ext4: fix ext4_tune_sb_params padding
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025, at 11:17, Andreas Dilger wrote:
>> On Dec 4, 2025, at 3:31=E2=80=AFAM, Jan Kara <jack@suse.cz> wrote:
>> On Thu 04-12-25 11:19:10, Arnd Bergmann wrote:
>
> While this change isn't _wrong_ per-se, it does seem very strange to h=
ave
> a 68-byte padding at the end of the struct.  You have to check the num=
ber
> of __u32 fields closely to see this,=20

I had the same thought but decided against that because it would be
an ABI break on all architectures. The version I posted only changes
the structure size on x86-32, csky, m68k and microblaze, as far
as I can tell.

> and I wonder if this will perpetuate
> errors in the future (e.g. adding a __u64 field after mount_opts[64]).

Indeed, I can see how that could become worse.

> IMHO, it would be more clear to either add an explicit "__u32 pad_3;"
> field after mount_opts[64], or alternately declare mount_opts[68] so it
> will consume those bytes and leave the remaining fields properly align=
ed.
> It isn't critical if the user tools use the last 4 bytes of mount_opts=
[]
> or not, so they could be changed independently at some later time.
>
> Either will ensure that new fields added in place of pad[64] will be
> properly aligned in the future.

Changing mount_opts[] to 68 bytes sounds fine to me, I'll send an
updated patch for that. I've kept the Ack from Jan, please shout
if I should drop that instead.

   Arnd

