Return-Path: <linux-ext4+bounces-8325-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC722ACF242
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jun 2025 16:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9411017A707
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jun 2025 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD216FF37;
	Thu,  5 Jun 2025 14:43:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8F2E659
	for <linux-ext4@vger.kernel.org>; Thu,  5 Jun 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134632; cv=none; b=SUPD4pPYNnsEEXb4HMoj1tXxW+vfk2wYKfrEzVJHKDnqNeGv7w0cVmBbugMtJKxfJ5z39vfuzMmxQdymc3duug2o846AE5NGbJ8dEs82Mcp+36jAHDhr2bmfzze5zDACwaR93IY4Yb0BLIXB/K0CLYNMG1lpeRXOUsGdYZw25S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134632; c=relaxed/simple;
	bh=sNF6t9DWi6Uk2mS8jbsDC/R9eZVi70laygo5LiO5AWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZ2+1Q5IHVKewb6mkk1142WE9K7RE5oGx3BIjUHwyKnT+VLU3GNWNrYb78s1i8nDZ8yPhcgBqArw9uNaKJ9zl5Dz5rckpYyKfhhfmmyuDMGkgwBa9mfg8s3h084MQD5Eb2XakSMh5giORiSdP2UfXaifxkGo2XyateiK88ZKPgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([191.96.227.79])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 555EhVmI003358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 10:43:34 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id ABC47340728; Thu, 05 Jun 2025 10:43:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Benno Schulenberg <bensberg@telfort.nl>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] mke2fs: fix a misindentation in the man page
Date: Thu,  5 Jun 2025 14:43:13 +0000
Message-ID: <174913434448.793354.16451336621203693743.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250601123624.16583-1-bensberg@telfort.nl>
References: <20250601123624.16583-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Nice catch!  Applied, thanks!

[1/2] mke2fs: fix a misindentation in the man page
      commit: 4d6cfa2557de7d0878fed3203ac36d3e91df183f
[2/2] e2freefrag: correct a mistyped symbol name
      commit: 030b523d84a96c941cf9914444e39254aff10e59

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

