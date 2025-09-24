Return-Path: <linux-ext4+bounces-10382-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC8DB9AF68
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 19:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CB04C77EF
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCB314A8E;
	Wed, 24 Sep 2025 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dRAWxomV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0770315D4B
	for <linux-ext4@vger.kernel.org>; Wed, 24 Sep 2025 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733324; cv=none; b=WKvVfDZ0DOhKkBLqG/UpGZoggdBv16jCHWG47W1Vc/g+3uBRhaY/PW7er8dXJ8m6YvM1QETI+5mL7p8GslpIUxAs/8SZ4+tlE4nYVp6bl2BennHClrWDjOXXu6lG/LU3xgi+ltuUdZpvHtyqar+GSbjo4Vb/JRAWp/HPwCuCRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733324; c=relaxed/simple;
	bh=wgwKw2Ak5rTcbgRtEjgVcb0FcZB8irt8khYCU0FdT70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaEiIar/g2kLYcqmNbQ83vVGxfQkHpKnq7IgRvD6ywgmUXkuo81z7AA703khv/pEzAxRbCwKZlrkzRBsS5Qzsl9B5SKBtAUqk0Ug3f57LVAeHlomanYtnwS71dDiqBX6g5b68ntRSbytNCnBL9XZaQBjpn8/V1KEOLpyjlOuSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dRAWxomV; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-125.bstnma.fios.verizon.net [173.48.102.125])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58OH1QN1027715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 13:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758733289; bh=sL9RdBshIWYkj/7i0/+kEoAfyJk9zXQKRJZJxOWTOFk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dRAWxomVriCdBjejleeuZnW8sP7gTHLlUJc4OMoU+eF8OC1I6RrjVISwASR8L+M6z
	 7Wm5Vern77ywL78gsV9nxwq3XwPldwT2EitHpGr6WOTKTHh2GTnDW+gWuvjJ/ZSwoR
	 e6OoD7OGhA08bNxE1gyVD3Y8yxX493Ii0O91KZc7LjtLJhOvtdtUsGbLRgn7dnkesH
	 EjGLfcyMRWF5YSMkkNxxDC+1oxasRYwADsRyjTRWuRegkDaOnqDqsbCC8KxUU+zNXR
	 4JtmI05P7j/jB00OPF3nO3KmSTUW0l5PvaMeJbUS4Bka4JgS8EnWodfRE1TNzRnNy2
	 45/ZIqDedmnpg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 574182E00D9; Wed, 24 Sep 2025 13:01:26 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Benno Schulenberg <bensberg@telfort.nl>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fix several typos in the latest Release Notes
Date: Wed, 24 Sep 2025 13:01:22 -0400
Message-ID: <175873324604.600208.5780209125699810148.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250601142217.17820-1-bensberg@telfort.nl>
References: <20250601142217.17820-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 01 Jun 2025 16:22:17 +0200, Benno Schulenberg wrote:
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> 
> Something is missing in the following sentence in the "UI and Features"
> section, but I don't know what:
> 
> Add mke2fs.conf knobs to control whether the RAID stripe or stride sizes
>   from the storage device information depending on whether the storage
>   device is a rotational or non-rotational device.
> 
> [...]

Applied, thanks!

[1/1] fix several typos in the latest Release Notes
      commit: cce570fa47fe831471806d96f29bda193f655eeb

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

