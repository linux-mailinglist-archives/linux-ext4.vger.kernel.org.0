Return-Path: <linux-ext4+bounces-4749-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C849AF883
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 05:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED7D2824F1
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 03:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4218C346;
	Fri, 25 Oct 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="i84y9ldG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5918BC32
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828447; cv=none; b=ZsQ8aLdjWH78eofJU/dPBmSW4EFUCEuWbvp0BfU5uL89RdNCc6FVkggC/vHcocSe3I+75sc+7lkGT/E6ic1y6Udf5njcmiBiRP/IKjCk6cyjWxaIjbvN5XrNgcgUOOrZ94w45TyKuaAR9ZvZIesDYnt29N09trU1c544txTag54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828447; c=relaxed/simple;
	bh=UUnwVfC8PR9S/jNggcZHP176wQuKbD9ViRo0NjLdT88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFvE5JqtSn8iv9ysp+rc3LfzRDt+wsIHARrXUdPMKFMvGNOguAWybfa5huwo3VyUQabLN0egfEPceXwdeYqSy+JO10pRj1KddAsRP4liXz/q1U2LPocA+7SPOm0lAVjBXjpBQyQK8bF98B5/4LfglYWxltmXYINH9sUqeD1fM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=i84y9ldG; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49P3rx4p027515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 23:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729828441; bh=pPJA4kz+72UFuRm1TLKggHnB5EEo3IxWvbnfr+g2AXQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=i84y9ldGjQipxCQplJoRbbxfGGmfw5Cs1FFYmKFru+IAYDdX4ceT4l/DYaXlIIRRa
	 OvavdbRFnttZ1Q4Ova5/CZIKMxDrV8uoSxNjJF5YyJG7v1jfhvtjy21IhbL9uI+aI5
	 Bt+FRpLe6FCpEE0LGkOkOy3/ro/vnORIaWZAa9vvNtv7N07Aecc1m8Jy59640nV0VD
	 WqEAauteFLZMWAI1A2HGc63/oBVMdXpTwTtX7Lua4YLO8+kRUPA4siox82nVfM5Yh1
	 z2mFnHdKqqmkKg2erkhZe9hGjmE+YeI059vgJU18p4FgnHACWDr+/VB2Z+dgkslcPl
	 o7RK/2QaoJfEw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AC45B15C0603; Thu, 24 Oct 2024 23:53:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Alyssa Ross <hi@alyssa.is>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH e2fsprogs v2] libext2fs: fix unused parameter warnings/errors
Date: Thu, 24 Oct 2024 23:53:50 -0400
Message-ID: <172982841321.4001088.7404600551753936583.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240528131841.576999-1-hi@alyssa.is>
References: <874jaih04p.fsf@alyssa.is> <20240528131841.576999-1-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 28 May 2024 15:18:41 +0200, Alyssa Ross wrote:
> This fixes building dependent packages that use -Werror.
> 
> 

Applied, thanks!

[1/1] libext2fs: fix unused parameter warnings/errors
      commit: 967bcb155295c5e33c0edc6555bd4e25e9307899

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

