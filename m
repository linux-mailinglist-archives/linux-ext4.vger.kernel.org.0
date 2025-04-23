Return-Path: <linux-ext4+bounces-7446-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E86A997BA
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 20:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DB61B83771
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90328EA4C;
	Wed, 23 Apr 2025 18:21:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390EA28DF1F
	for <linux-ext4@vger.kernel.org>; Wed, 23 Apr 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432461; cv=none; b=YjkgQsAEEDypK3x5Epv16nmlv52LwDQ7evGxI7QI1Cw4xUPgoEYHrvteV8PyQofciZCdXekKw+WdrIwm5Jfb/bCUxv66t4OrLZtTqoLrsobagVhC6YIiaYvKN7NiMkorN/ZMM3UzWHXBTZ0q24JOeDGU/CXF9DWJ6OA3sWxnGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432461; c=relaxed/simple;
	bh=3cwv0921IscvB/NrWSs0v/7SM8HODWnllMIfji9Jqrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHbUyw21yICVPF6TvMOEi9ykVPZlQZsbArPvwB5e168oQfaxxknW1Dzppe66fqAfYF5nJxHrD5khtyz0JDhQRckxYOEsR4Xj7tD09YDstJ+qXrOMdBP1N5f5K7gq691p0r5yXq47FvpRHwKUaIA8AGfwRCekv8CMDeU0Z9VsALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53NIKdBm005121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 14:20:40 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 5587A2E00EC; Wed, 23 Apr 2025 14:20:39 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, Tom Vierjahn <tom.vierjahn@acm.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, dirk.gouders@w-hs.de,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ext4: Add fields to ext4_super_block documentation
Date: Wed, 23 Apr 2025 14:20:34 -0400
Message-ID: <174543076505.1215499.16527346379212459412.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250324221004.5268-1-tom.vierjahn@acm.org>
References: <20250324221004.5268-1-tom.vierjahn@acm.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Mar 2025 23:09:30 +0100, Tom Vierjahn wrote:
> Documentation and implementation of the ext4 super block have
> slightly diverged: Padding has been removed in order to make room for
> new fields that are still missing in the documentation.
> 
> Add the new fields s_encryption_level, s_first_error_errorcode,
> s_last_error_errorcode to the documentation of the ext4 super block.
> 
> [...]

Applied, thanks!

[1/1] Documentation: ext4: Add fields to ext4_super_block documentation
      commit: ce7e8a65aa1b7e8a6833403b314fa8f2cf133119

(Apologies for sending this late; I've been dealing with a family
medical emergency.  In any case, the patch landed in v6.16-rc2.)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

