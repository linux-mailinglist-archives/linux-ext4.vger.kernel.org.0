Return-Path: <linux-ext4+bounces-11531-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A9BC3C2C8
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 16:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518BE422619
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCDC2853E9;
	Thu,  6 Nov 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eqmNzCNS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9125392D
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443971; cv=none; b=J0LAiAi/fcicOThim9AEZjLbwo2rSRgYcoRpYc8rgDw/4MvNA7hLNC6N4iIJ94izdb6UTvrSD83dYWZT9veEr4kWZO+TpC5EQ4h1lbdS5EygPmHe7iVjxasN8sqHnWOXm67YlokcAs3/GhpBP5bnhTQPmSN3Kbg9Jc/7hpAvYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443971; c=relaxed/simple;
	bh=vGa//F9wRlp+EWv0LwPCA0GRKZK8M9i5+Wwlgba/xAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wc/VSdYfFPxfhwP9I2VQDAISeyK8ptto3WEloDToOLjKZ8cO/CUvtVXrEorF6oeLXQkv8yELy6x/QTJeBXOoHqsEVOQDFvSYSBRXhpmio9TdX54Js+Vo8UoeCskDKKBjQNXp1BM0rNtLIhdwYvivSqEjSk6qf03bIWvmZPmiKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=eqmNzCNS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-124-240.bstnma.fios.verizon.net [173.48.124.240])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A6Fjqrj005529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Nov 2025 10:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762443954; bh=jeGFASVH02jXtiX8ui6OqTmIIWRoiFXq9r20lis8QTA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=eqmNzCNS7c9tQxFFLEl6TqGa+CKX67tSofDcPMtug9HRN32qe86ubgoxzK88K93Z7
	 brYI2vjKz0W+66FVgEplRPkQgvGn/IIzKJ3lDEBBRk5LtIEvBazQI2SoS4DNfCbo23
	 wanojWBVgRVvlVuZbd9mZMP2oB+nQNxupSIVxYtNkB2HIG4ibvSuhJzWJI3jV9jRRb
	 Wpx6Bmb898fuxAEE+i0aKNnPakMeVWNaodQMPxcZJfk41w2zOdU39r9W+Lo/nVGTk0
	 hVYgaZezmM1unQ6jn0VQtpiRi9u1tuO+h0KBEu46ArXU0xTogFE2cdyqxo39RThaYK
	 hk1lL9PXmG+LA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 6E3AE2E00D9; Thu, 06 Nov 2025 10:45:52 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Julian Sun <sunjunchao@bytedance.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        drosen@google.com
Subject: Re: [PATCH] ext4: Make error code in __ext4fs_dirhash() consistent.
Date: Thu,  6 Nov 2025 10:45:46 -0500
Message-ID: <176244393633.3131189.3932739840974111464.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010095257.3008275-1-sunjunchao@bytedance.com>
References: <20251010095257.3008275-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 10 Oct 2025 17:52:57 +0800, Julian Sun wrote:
> Currently __ext4fs_dirhash() returns -1 (-EPERM) if fscrypt doesn't
> have encryption key, which may confuse users. Make the error code here
> consistent with existing error code.
> 
> 

Applied, thanks!

[1/1] ext4: Make error code in __ext4fs_dirhash() consistent.
      commit: ce3236a3c7d8e048e0bcc7f445f12f911dd9dc7d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

