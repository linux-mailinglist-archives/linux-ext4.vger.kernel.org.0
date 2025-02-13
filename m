Return-Path: <linux-ext4+bounces-6455-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C311A34F3A
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 21:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAF518911E6
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 20:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E8A24BBED;
	Thu, 13 Feb 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryLhfaM3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0124A068
	for <linux-ext4@vger.kernel.org>; Thu, 13 Feb 2025 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477827; cv=none; b=X13fF2BUl5lreij1cj4UnHtxs/o1Kc4rIJT3NKxjMS34pJ2nb9CQcDlhXQn4rUC/NL1tSzPumRedbDHcU3X520Ynj17YHLnRNokBZq3+QGe+QEsEeUlNIxvP+V+Vu6k4BDdxcWTp8NrHN+cnILVSX6tUaYXL8tPbMJp2+8fZesQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477827; c=relaxed/simple;
	bh=rvlNZ80ofqpKU5c4ZKSCr7/5YcWya9I0EQgvyeAqOuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAHT4bsXPR43lkyOtZndHkbYeGW5Z2DlB3NLGXaCHWA0cLp3CSCLuEPkeYCGk/tRJz9kLQrLRJfW2jxc7gfbcLe8vkrfaSk2tfl1G9yFoSMPwaVC4OaP0gUR8WspNwV4bJBtDE6Eqh9gERkCeB2HS/ygqxIJbDGxcIbqEX0eXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryLhfaM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AF8C4CED1;
	Thu, 13 Feb 2025 20:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739477827;
	bh=rvlNZ80ofqpKU5c4ZKSCr7/5YcWya9I0EQgvyeAqOuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryLhfaM3yyh1ElVLFWTr82u30btMi2UN44XlkWTL8gw0YmyNOl4juTU5JFsmVy9+S
	 //U/rXYXRgzVWM4zhAbZJGm3gZhDo7TZixPCNfHDg6xEhPtqnBIuoktdNyGycFu+dd
	 I6733z6TAfd+ClJ8PGZbNco/OUgxeeh3V0unHrg8HvRa5uN/nyV1luW2P36JkebmXD
	 uF0KEozoqenKkphDt5xWeBS67giI0eo/yomUAeSa16UXgPSXhG1yQnd3m/eg69ueiz
	 9C4dKvEjTLX4JQ17no7lGCTsu3c29p5qqYAAUbvdUp/9c6P0IovLW5p4Rk55S0NxQH
	 IbY1rR4Ge7+Mg==
Date: Thu, 13 Feb 2025 20:17:05 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, krisman@suse.de,
	drosen@google.com
Subject: Re: [PATCH -v2] ext4: introduce linear search for dentries
Message-ID: <20250213201705.GA1576694@google.com>
References: <20250212164448.111211-1-tytso@mit.edu>
 <20250213201021.464223-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213201021.464223-1-tytso@mit.edu>

On Thu, Feb 13, 2025 at 03:10:21PM -0500, Theodore Ts'o wrote:
> There are good reasons why this change should be made; it's actually
> quite stupid that Unicode seems to think that the characters ❤ and ❤️
> should be casefolded.

It actually doesn't.  See
https://www.unicode.org/Public/16.0.0/ucd/CaseFolding.txt and note that heart is
not listed there.

For some reason ext4 actually does Unicode normalization, which is different.

- Eric

