Return-Path: <linux-ext4+bounces-6851-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF0A6678F
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31983176A82
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0FD1A8F98;
	Tue, 18 Mar 2025 03:42:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264638FA6
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269325; cv=none; b=dbFho8sADdBhXtvLy3a+i9VTzibcBh3m2X/TlksBCuH1jnQ4UwENGvLBmXAIKo2jLEOPzHKjoNugnOR58WLxpTg5QpR/qkRyJPE1RpwvL+mpHYQVQvu5AMRYlRj98sT7lhShKwY5OqKg0qD4LRQRZ4/SkaRotcxVeY5IK8L8cug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269325; c=relaxed/simple;
	bh=U+LtcT0zsfAgse4AYQMBr+iY4Hfn5dwICO6vNn8fUuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoDgIkuCcODDKU17VwjOLxPa4Ksr+Mkb66A5KJkdILvcTq+GnT03bIL+u9mvvFWfNt63HCb3x3DQsXiqFpbPE2dP6eOxEe68sypz2FT1uDV9hzblQGPxclJ5dMm/spTqE9qnm2mV8YhdCEs1u2q6re1QaazbQu8AaQfVp75hSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fm6o012150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E6FEE2E0116; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Diangang Li <lidiangang@bytedance.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: clear DISCARD flag if device does not support discard
Date: Mon, 17 Mar 2025 23:41:24 -0400
Message-ID: <174226639140.1025346.17209079713890746591.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311021310.669524-1-lidiangang@bytedance.com>
References: <20250311021310.669524-1-lidiangang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Mar 2025 10:13:10 +0800, Diangang Li wrote:
> commit 79add3a3f795e ("ext4: notify when discard is not supported")
> noted that keeping the DISCARD flag is for possibility that the underlying
> device might change in future even without file system remount. However,
> this scenario has rarely occurred in practice on the device side. Even if
> it does occur, it can be resolved with remount. Clearing the DISCARD flag
> not only prevents confusion caused by mount options but also avoids
> sending unnecessary discard commands.
> 
> [...]

Applied, thanks!

[1/1] ext4: clear DISCARD flag if device does not support discard
      commit: 1c81b7fbcea9ba75f059dcd1ed4c94543593378f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

