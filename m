Return-Path: <linux-ext4+bounces-2144-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59668A9D47
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 16:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8FA1F219F2
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Apr 2024 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F95161933;
	Thu, 18 Apr 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="O+EVjotD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B201DFD8
	for <linux-ext4@vger.kernel.org>; Thu, 18 Apr 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451177; cv=none; b=oPtH+v66SoXXmSDui9Lh7xdgux45VlRiJRggg9rxzjKTC5R16bC+39ESa8R/RbOq8uInUsTo9vrKiFqpSy+xF0XOvO5AWsj3wWqFY86AZ6+eZDBy34qu09C91dEAfxjENgWNKpwb4rfHUvhwGeH60MClkzAhMqn4TyAGFAxZRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451177; c=relaxed/simple;
	bh=Bz3blntIkEKUBpq7NhATiSyROTntEpKJJ1LBQ9/1J5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnC/pKlOEzhy+hs36hk8namE3KAu8MjXSRrI+HFe9pWfRPd3nHWnhKJCRvLtayKZW/TxEiZwvgV2dxO4sNepJkFG7VmRXuyY8KQywNTorjP5+SjKagM3NqrA3U/Z0XKdVWCBnAf4Vkn/uOvHIrrHjdvHTQf9aONvtF50b2ti4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=O+EVjotD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43IEdMY8010586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 10:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713451164; bh=CmRh6tgwvUrY0vuk32UD6Q3L0Q5EV1IoxZDTpemhWm8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=O+EVjotDNNR5FPD2fs6fapRZEzc01ik63EEczsCNOF7fPHtNvwK7gHWqwh2EtBR0G
	 T0ULvq9TLhsK00DMiMK6+pENwiPCfCJOe0Qpfu9RHO7Xz28M03FgCKOctWIGNkLJ5Z
	 9nSzarZRS5gAC/5KN7ao3wUf/rsKaaTY1WXZwNs0tKP/RIysjQ437afFKsK7oiPq20
	 n6xU7Uju3Lcqnnp2p8Hbc5IxK4nFuTsc1SriX42vRxhsT75Ul8SgMXRDtD12X8ToSe
	 jY9Y6bsqizwaniLklbDKM010WdXSW7kdCSpvIMN1Oi83q9P5IiySFF+/+DfzbxxFMe
	 KDfHDRYUEARpA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5E85B15C0CC1; Thu, 18 Apr 2024 10:39:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Sam James <sam@gentoo.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH e2fsprogs] ext2fs: Fix -Walloc-size
Date: Thu, 18 Apr 2024 10:39:18 -0400
Message-ID: <171345110558.3373948.13663666523678695041.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231107233122.2013191-1-sam@gentoo.org>
References: <20231107233122.2013191-1-sam@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 07 Nov 2023 23:31:20 +0000, Sam James wrote:
> GCC 14 introduces a new -Walloc-size included in -Wextra which gives:
> ```
> lib/ext2fs/hashmap.c:37:36: warning: allocation of insufficient size ‘1’ for type ‘struct ext2fs_hashmap’ with size ‘20’ [-Walloc-size]
> ```
> 
> The calloc prototype is:
> ```
> void *calloc(size_t nmemb, size_t size);
> ```
> 
> [...]

Applied, thanks!

[1/1] ext2fs: Fix -Walloc-size
      commit: aa11daba2081da28ec70c557eefd5039a99555a3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

