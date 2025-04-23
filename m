Return-Path: <linux-ext4+bounces-7444-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDBAA997B5
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 20:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E881C3AC165
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9328D83B;
	Wed, 23 Apr 2025 18:20:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5EB265CC0
	for <linux-ext4@vger.kernel.org>; Wed, 23 Apr 2025 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432448; cv=none; b=c/DudtNjUqOc06arkkS2w8GeITNwU2F1zCfmeAu5k1afM6zHtdd0nG6wq8xA4O6JMZTO6ec4PjFnO9QA7+/vBa8X36k5TRUvyj5uwZbbomnyvz3xo6vT8gJd71F5iGyau4GrVKHuWo1FEEOsLCn09aMXFsl+t6oyEfbQdyhn330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432448; c=relaxed/simple;
	bh=BXomuzHUN126JCY1qWIkZJBlPF7DBcz84bj7SMVpS5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hd1cFCY5dGhA7X9VZNFX5Lej29a8gR8EexSp5QGYm6hhsz4/r2fqHsq+xIgOhV6Ma+3GBVBd/j0Iv4YGvCau+BHWu5P1fLYQXS079lCRIRlH+j5YJ+F2BcPPZTFLAzzLizert/2KKe5JxpguhhEstrmuITHfXH1BTo1frhtM4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53NIKdV8005122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 14:20:40 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 503922E00EA; Wed, 23 Apr 2025 14:20:39 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ext4: Avoid -Wflex-array-member-not-at-end warning
Date: Wed, 23 Apr 2025 14:20:32 -0400
Message-ID: <174543076506.1215499.12197124623558022635.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <Z-SF97N3AxcIMlSi@kspp>
References: <Z-SF97N3AxcIMlSi@kspp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 26 Mar 2025 16:55:51 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> [...]

Applied, thanks!

[1/1] ext4: Avoid -Wflex-array-member-not-at-end warning
      commit: 7e50bbb134aba1df0854f171b596b3a42d35605a

(Apologies for sending this late; I've been dealing with a family
medical emergency.  In any case, the patch landed in v6.16-rc2.)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

