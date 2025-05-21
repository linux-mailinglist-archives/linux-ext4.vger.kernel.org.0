Return-Path: <linux-ext4+bounces-8069-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD63ABF8D1
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA08A23986
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A44122256A;
	Wed, 21 May 2025 14:51:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E341EB5D8
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839088; cv=none; b=pFUhSi7nzwZIKnev8ExXJJoyILUJ/fkU3pmzQOudNR3JwphLlTZj9HlorTm40AuwjF0cBzRHI4ySPKXQ3LdSWrnQlu6m/RhcGn+J7nulHXy7Xf8yVpZt/409e9C52EZd5D1FIARPB2xI/p7SOZRLhYe14ry23yk9YN9Ck/jRCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839088; c=relaxed/simple;
	bh=1bHSFO5Q8z+2rLFmQ3TYwfUIrvwbBhYfy9F1/PoQat4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sl/nja27FFHOqId891ajVagUhUkaAhqU6UPHgc/0ZS7lpPfpASatvE21fBNVkasIRQnLrF6V4tNhJkjlBnNYeAxpPtk7Q/BJ9FO+Iw0C25nEWXu+4AlQvZiMjfwdQRGX+cQzgZ+IXog9EqH17kSXyV57nrN03u81DAaVF7CyPwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LEpE5J001402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:51:15 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BB63F2E00E6; Wed, 21 May 2025 10:51:13 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jakub Wilk <jwilk@jwilk.net>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH e2fsprogs] e2image.8: add missing comma
Date: Wed, 21 May 2025 10:51:07 -0400
Message-ID: <174783906007.866336.2299978412189651128.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250107070724.6375-1-jwilk@jwilk.net>
References: <20250107070724.6375-1-jwilk@jwilk.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 07 Jan 2025 08:07:24 +0100, Jakub Wilk wrote:
> 


Applied, thanks!

[1/1] e2image.8: add missing comma
      commit: 5a6ec683252be78ccda7dec7dac530f2ebc46ce6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

