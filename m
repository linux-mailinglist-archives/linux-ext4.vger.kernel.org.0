Return-Path: <linux-ext4+bounces-6154-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E74F3A1766D
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 05:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1CF188A975
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 04:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8151527AC;
	Tue, 21 Jan 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SwlnSiXB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED622F5B
	for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737432093; cv=none; b=Fu/JZykXtSCJmk1bUnZaCohRenKBpZ9D5H5gw2ihitFhwijXnOy0u+8YbOQSNeNhdGMOVTJ+6l3SazFLjz6InuYfzj8PcfyN6u//kOlGV1cQbrlHKPOkVPxfa0xiolpLMDLnYhJMiGb31yF1SFrUXzWjfPGX8ZOETfDiMDiK/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737432093; c=relaxed/simple;
	bh=6kY2CfxpxpFZVxQOrTyM+yX7jWlUk6ksvtEHi9lF4nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDO/uOVuGg/j5L6cBRMQlqrSgX963/yT5qMcydVwxJi4oLocmjMMgSUWLzuYQf36NnjCI4BM66x/D10dWprKtR0l5riLVl4xSp08+qwNFgmsNumqao4JqDlyae3RZFAdc6OcL6HW0XUiWZKXncJN+Xibmw1ut8l1h3YFE5EkEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SwlnSiXB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-114-200.bstnma.fios.verizon.net [173.48.114.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50L41PAr024662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 23:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737432087; bh=/tYOhMctsi0J9YpjBd+EYiyBmQD0HYot8R7VxKMT/xw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SwlnSiXBnXEIOaAgr1DnaKzgh5lunCqntJ9Uf9I9xLzw/6zyYTcmxPwGAO6oxSqAO
	 w9IjIuOgzX4X51j7Y84ado+WXwlyBFkg0LfE3hPJ8JtCo/8m9Fxwjsnwy45sKnbUPA
	 P8qsjLyzj1YNIWTyrqBvprOe8Gl1d+RMbpF6vY/LfyeqaLkLcE4MJoSs4UB8K6YQ4H
	 KE++IgaXTwqg1EKOO0MzLKEtOgYSBthpF0yY2/SaXZJRvS93tHETWFrEr5hFZzZ0zG
	 QIF0/7dGVbA+6AMAAwaA0tThB1Ji5ADPMwHkztw5h8bQqp2E4Y+Yk3U3xJPV4MhNd6
	 BNLt32TaNDRBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AC70615C0179; Mon, 20 Jan 2025 23:01:25 -0500 (EST)
Date: Mon, 20 Jan 2025 23:01:25 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gerhard Wiesinger <lists@wiesinger.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Transparent compression with ext4 - especially with zstd
Message-ID: <20250121040125.GC3761769@mit.edu>
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>

On Sun, Jan 19, 2025 at 03:37:27PM +0100, Gerhard Wiesinger wrote:
> 
> Are there any plans to include transparent compression with ext4 (especially
> with zstd)?

I'm not aware of anyone in the ext4 deveopment commuity working on
something like this.  Fully transparent compression is challenging,
since supporting random writes into a compressed file is tricky.
There are solutions (for example, the Stac patent which resulted in
Microsoft to pay $120 million dollars), but even ignoring the
intellectual property issues, they tend to compromise the efficiency
of the compression.

More to the point, given how cheap byte storage tends to be (dollars
per IOPS tend to be far more of a constraint than dollars per GB),
it's unclear what the business case would be for any company to fund
development work in this area, when the cost of a slightly large HDD
or SSD is going to be far cheaper than the necessary software
engineering investrment needed, even for a hyperscaler cloud company
(and even there, it's unclear that transparent compression is really
needed).

What is the business and/or technical problem which you are trying to
solve?

Cheers,

					- Ted

