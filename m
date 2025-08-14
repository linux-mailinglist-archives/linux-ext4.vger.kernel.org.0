Return-Path: <linux-ext4+bounces-9368-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADBCB26A30
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 16:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B368A245A4
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Aug 2025 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2331FE45A;
	Thu, 14 Aug 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KC98Mb6A"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7DD1DE3B5
	for <linux-ext4@vger.kernel.org>; Thu, 14 Aug 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182943; cv=none; b=Z+IXQkT9Js8BfJKP7gYTS1vvO2sH2c18s44QU4XzsCrcw8BCHpWkAWYITW7UzxBiNbSwHryXRQC3R+2GbTAtIWqSWIb2BVIb4Q4LIC4t/TVfl36n4RGXAmwWyoAZCw6VkpMcqmayilyjvypFQK+xqmhq4Zs+u97hXNJrDovq6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182943; c=relaxed/simple;
	bh=Zyn2lbfe+RhoT1pry4GTpM3joFrDzAfPV4ZWBeV4cC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtOYRZn7so7w/W527xUjEsToGsdFOcCBxVzQP9oPbE4aQoXL+xncmXTE2Ck3JkznLI/a5k1Z0wJHSU38TauEfF1zHjKN7KvL1Zw5D/1eKIcoH8W4GCsAJhUxXdVOGQNzjxlczIRW42gWRauVE0YrgrhwUIogQvCfG4CglVv6lKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KC98Mb6A; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-254.bstnma.fios.verizon.net [173.48.113.254])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57EEmmn4028536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755182931; bh=USFrYrh03EWabSVglgCn3HMtkCYIVtEMIDrCpp0/j6Q=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=KC98Mb6AMAs4PrjyhYlOGwvL8u8qekt0H2xX5R8x8QS9WDMJpHR1iqD65pXEHKFcS
	 qYjekx8pOg+IYG2poLhVQ3/HSPEtS5zIis87HflzIoo9CNHPEBsKDjWOV32iXQ7AR2
	 XjbWQVAqRkWmjd06WvYB5pVN0NOOb3UbOBxryeP88XBjtie0vvKXXlLislWQKCRZn3
	 dq6HPz6Ttqm1fIjrryLZeE321DWTfpz5mC5T18BYJPPD01GBx2Q/LKxfdhsHTHY/sj
	 SkeqrxfqEpiZzPkM37gz+zRzquEIbXJgDxgn9o3OPLBWbu3pT95ZPwXG/YHIWPyYvf
	 Y3QnYCK4l6OmQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C57EA2E00D0; Thu, 14 Aug 2025 10:48:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Antonio Quartulli <antonio@mandelbit.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: remove useless if check
Date: Thu, 14 Aug 2025 10:48:40 -0400
Message-ID: <175518289071.1126827.11027768905716464670.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250721200902.1071-1-antonio@mandelbit.com>
References: <20250721200902.1071-1-antonio@mandelbit.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 21 Jul 2025 22:09:02 +0200, Antonio Quartulli wrote:
> This if branch is only jumping to 'out' which
> is defined just after the branch itself.
> Hence this is if-check is a no-op and can be removed.
> 
> 

Applied, thanks!

[1/1] ext4: remove useless if check
      commit: f3fbaa74d999c16b5caeca779e6d7e6e6e7feed8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

