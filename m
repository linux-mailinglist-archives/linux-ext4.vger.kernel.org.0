Return-Path: <linux-ext4+bounces-12103-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73FC98391
	for <lists+linux-ext4@lfdr.de>; Mon, 01 Dec 2025 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D7A3A2E7F
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Dec 2025 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99943346A0;
	Mon,  1 Dec 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="by0VAI73"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3533344B
	for <linux-ext4@vger.kernel.org>; Mon,  1 Dec 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606247; cv=none; b=VhMUR5MX35lYd+IgYB1jd47ydtERxkAw1I+MFaVseFCrREQzZG4QKXhVZqBsVM4eMtFrPrnc6HCpYFExASW7DbxVdFihJsXvG+h04hjUeoxE1jYWyH9yVn9zMNNlzOoC/3VuewFxICUEX+A5HGIzDc3Qd5rUa7rUC6KKa4opwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606247; c=relaxed/simple;
	bh=2XF32lt5uaq6lb27hpfrHwfKFjS2ZmiAs7kR/1j41Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoO/7FZE2ZQK1uBRhunov0RHh1dxhqlFGSYKSmMBYHtrwoEbyweYfwmJZSWK+2uWvN/pOCS9S6c/MjGmvC+xhUC5E9ljQADliKCbfrqoSqS4gjRLGI4w+ISrUsfbwnUqUkcOSFIPrHDNpD8ajJVYtOA4mJ6J0/Y6o3Dt3mhbmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=by0VAI73; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GNtqB008191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764606238; bh=za6aVn7iR4ZtMsOVRsDtc6/ir73UJUFZBb8+jOatM1E=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=by0VAI731ILq9Vv0KJj7IU8KoTW3cYSsmqxMz9FuNSq34AEcA8T5+iGI21VhUiFHF
	 YRxcdGzmzp2ZTq3Q3kRcUdsHNlGk+EZ7RIfJTRnL26bsIXJts+2ezRpoHAYRnB2nXL
	 A8RjoGaNzzqVU3Ck9SLtELW5Vt4UFeThi5y98Y3xYvXPOUsGqxL/a9BPI301t/MC5v
	 EcGHRm3TdzHyp9JrDC499hHKJyueE37AaRHCcTz7wh0mv+9AIyYkSHWQMSHehvNmpP
	 BiqcOpNfgig/EyU/4eIhMbbAT5W29kCKpTzwfuZR9vSyduyiFWHU2zuTBC6sQepEDD
	 +39EV+xGfbDbw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 072C02E00DE; Mon, 01 Dec 2025 11:23:54 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Haodong Tian <tianhd25@mails.tsinghua.edu.cn>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ext4: fix typo in comment
Date: Mon,  1 Dec 2025 11:23:48 -0500
Message-ID: <176455640535.1349182.17990597852765044455.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112155916.3007639-1-tianhd25@mails.tsinghua.edu.cn>
References: <20251112155916.3007639-1-tianhd25@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 12 Nov 2025 23:59:16 +0800, Haodong Tian wrote:
> Correct 'metdata' -> 'metadata' in comment.
> 
> 

Applied, thanks!

[1/1] fs/ext4: fix typo in comment
      commit: 4ada1e4f8937f1ae6b620e7b1c76e02b9b3a15be

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

