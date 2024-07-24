Return-Path: <linux-ext4+bounces-3404-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27A593AB23
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 04:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C969B22AB3
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F6947A74;
	Wed, 24 Jul 2024 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouhlBo12"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07002D047;
	Wed, 24 Jul 2024 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787408; cv=none; b=JtYToOPXs2MXXuJOQzbOu3bRFV31pCI7GJOigmVYhAPtxWhCOY/XI4DIQv2JQeFDfjGm6yRc3qKzRKsWX34l5n3fu2f82uoQZTdo00m7A81qGUCepsvwidIPTy+3N+2qn5WZ920E+myg9zbRr6chuGYSQYz+68OqUES26VjYhiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787408; c=relaxed/simple;
	bh=2Qki7VFr+Qj7tXxTqGvLoGf+PC67LDKcpFGcJzAFu6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aTbyHWLJV499cXUD1y4IrKmT8e1+0BAkKj/VpNOnnC79tw89GAyO/mpUy6/EVVCshz1aYgSaVna9ylRDWrTMOO1CqcT9V47NBoMAmYAg0f4EBxkIajn3+E/RNHNGFMEvEOYLbP1A6HtSenrEkbb4ti6Q+mWcaf1cz4LBhNuX3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouhlBo12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9EE8C4DDE0;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721787407;
	bh=2Qki7VFr+Qj7tXxTqGvLoGf+PC67LDKcpFGcJzAFu6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ouhlBo12N68ilfm38ZrqoSUhIokoptwXvzvwluu497leeNds+QrltwVgSf+s9X+Nz
	 KpQ/Nh3ZSnbL0/qi1IjJOGwvbdyY4X6FQqGSGCi72ks9O57hCpvVUq/iVbg2xREagb
	 EeXXZS9A9ZMLP1HyhoOEL0bTNK7FRhLAX4XB3G27VmjjcenzJ63T5KN/aJcU2waJEm
	 qgrZrigjnVDfYn6dOcL0XUmdRIGkfcvLGRYQY8Qf2X03ZfwcQxY8u0UHX7b+h0jUak
	 6hwIPN+1lQSFHfX8+kBvvB/Fg2n9a1fpZne9+/mYqSaZabLwbKxjDdBiqkx2YO9LD0
	 zNydIgD9W7mYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D706C43140;
	Wed, 24 Jul 2024 02:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [RESEND PATCH v9 0/2] Minor cleanup for case insensitive
 path
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172178740664.17759.11130907548289451069.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 02:16:46 +0000
References: <20240207064302.221060-1-eugen.hristev@collabora.com>
In-Reply-To: <20240207064302.221060-1-eugen.hristev@collabora.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com,
 adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Wed,  7 Feb 2024 08:43:00 +0200 you wrote:
> Hello,
> 
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
> 
> To make it easier to apply I split it into smaller chunks which address
> one single thing.
> This series will just convert to qstr the storage of the filename
> currently using fscrypt_str .
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,RESEND,v9,1/2] ext4: Simplify the handling of cached insensitive names
    https://git.kernel.org/jaegeuk/f2fs/c/f776f02a2c96
  - [f2fs-dev,RESEND,v9,2/2] f2fs: Simplify the handling of cached insensitive names
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



