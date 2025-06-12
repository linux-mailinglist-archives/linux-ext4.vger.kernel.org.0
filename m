Return-Path: <linux-ext4+bounces-8393-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E4EAD7036
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 14:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47A11BC7088
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF2183CA6;
	Thu, 12 Jun 2025 12:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NBr6znK/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A019DF66;
	Thu, 12 Jun 2025 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730943; cv=none; b=GyG1BUYJh6m4mVRNd4RYblV8OtiodxKQt0p2S1awuPB/lUkw51mmjtEFNdJ8RXs8FyBtOC0AgAytySTYUqboj7dtQOfHSB1ZmEmTHgPT++Srtqktdh8yEZ/tEzCLLKBs/gFlk2hpmgbki1hvTr+BGeYYUsTp9do/AL2qlX7yvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730943; c=relaxed/simple;
	bh=NZqJWh5KCIoywtSRjiA0fgJJgHshegwy6qxNZ2qo2IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7aq0AOugfhoyoPqpcyIk32eb73EetCnrOTLA2SRwxh72PUBjwN7ESPDLa+MM4soJh6BVxjCN60xY7Rzb1jy3q1zOxXLLycM2BC1cJUbz/BZQFMLxgGJZ6cao7OGBWuBYZkL4WdUk7h7/XJQsFJLB6PewK74Gc4MeCvjqxrS/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NBr6znK/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EC9BE41AA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1749730941; bh=7IBMRtiIcXkNA4P1sWxpy5b7ypIcO3OlWKJOuHFJ128=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NBr6znK/olM+h+b9tg879FSns7+V2eX0dFb1+HOA4D5vTr30PPXl1GlsHBf3GQzrg
	 TJjHeVTOiOglR4IP1HZzXi5uYub4iC55bjNxN5cWdiWFX3esvhg99RzmufdBNdQkzK
	 Yg58b6xZgNo7TmYFB2oDe5xLPJDVdjY0leHGqB32hAgPHtptUjMUSMc67vERJofjo5
	 DkYPnciO4ikjqYGhd2hORezLHioL2TByzxcyJ60GWnM0AUtk85vSo4inyJQOnJgBk3
	 8xloEL7pBHFc+wCzlQ99g+cvrErjprDzmk/l3CfJB83Inpi+/cgDZaOZRWXruJfJru
	 WW4wV8fK7I4QA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EC9BE41AA1;
	Thu, 12 Jun 2025 12:22:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Darrick J. Wong" <djwong@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux ext4
 <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>
Subject: Re: [PATCH] Documentation: ext4: atomic_writes: Remove
 cross-reference labels
In-Reply-To: <20250612010942.GJ6179@frogsfrogsfrogs>
References: <20250610091200.54075-2-bagasdotme@gmail.com>
 <20250611164800.GC6134@frogsfrogsfrogs> <87ikl21a5u.fsf@trenco.lwn.net>
 <aEoaJEhw5qHkd2_w@archie.me> <20250612010942.GJ6179@frogsfrogsfrogs>
Date: Thu, 12 Jun 2025 06:22:20 -0600
Message-ID: <87ldpxm9oj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Darrick J. Wong" <djwong@kernel.org> writes:

>> > Sphinx wants to snarf up every .rst file it sees, regardless of whether
>> > it is explicitly made part of the document tree.  So it will pick up
>> > atomic_writes.rst separately from the include.
>
> Does that mean that overview.rst doesn't need to include the other files
> at all?

Not quite.  Sphinx does what is arguably the least useful thing possible
- it picks up and parses the file, but does not place it in the TOC
tree.  It will normally warn in such cases, at least.  So if this file
is not brought in with an "include" directive, it needs to appear in a
table of contents somewhere.

jon

