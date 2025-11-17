Return-Path: <linux-ext4+bounces-11879-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ED6C65EAB
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8065A36477C
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F094A337690;
	Mon, 17 Nov 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HAeb8awK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAEE3358BD
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406852; cv=none; b=f9HD9Y39pu+805KMM6DwgVcd4vIUKJF8N1l+S14h04sA6om2E+C8jkBfzUZ0CYQIEIU7YBEp57enB52ib7aGSBEh7b835jDgjagiBiaVYadhwVu2wTr+B+nltDqrhYjrsJDW5gSoHm0EZfjWxVrOclHHAg6HucWtMzOYX0oYwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406852; c=relaxed/simple;
	bh=0/Fd5tPG+aYfe7mKT9+Eb8UPd1PVjTJeb1ASHu0sm+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDDdENd0t4/Ogpw7KqOcP34/KSc5zhdO0hSU3acu18byu83kISjvmyjD5ABo+y1tAuM1G7ZGmNQpYj7LRCzxGXfkmKl6G9X86L5OzXBiR9frY8tojoi48O/ODteOwvzUVOO7bYBKX35dmVvkP5dl9EK2QS0ARInVW3TcS+xarzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HAeb8awK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDrtI020641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406835; bh=ptnVaNFv6jHS5Dvs43t4mwfN7Uv5BQkrhmXFIgJeO8c=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=HAeb8awKvL+nm+ZWTawBYyYGeREWQ9BeThS8vQsSQoohtpZHqr7ez9AIsiEu67/j1
	 XGdUxkoENV5T7JKYWVbosaTfn1Qqd1Vig0Fww9fncB4ZCxSKn18UTjWiB9d0n8staC
	 7NF8BpaRdbJbDbejh2CPdaWu2ymhjifSmrDyMJF9RjTfj5aw6XiDMC5EF6xiKpHYoT
	 4kODSwJjTA8cfb/YItz/2gIg4q5KKPmBnZ+fxZtaQZQg0WAUdTTX+y2jgYjoyOdFSo
	 CNDxU1JJKb7nqTyZ2HP8+cKVrzVEgQBOaHnNdHlFimvSgyDGkdtpB2fTYDfwvtjjzZ
	 49HYEc3KbtMAg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4B7E72E00E0; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Wengang Wang <wen.gang.wang@oracle.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        yi.zhang@huaweicloud.com
Subject: Re: [PATCH V2] jbd2: store more accurate errno in superblock when possible
Date: Mon, 17 Nov 2025 14:13:37 -0500
Message-ID: <176340680644.138575.14066880434513446946.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031210501.7337-1-wen.gang.wang@oracle.com>
References: <20251031210501.7337-1-wen.gang.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 31 Oct 2025 14:05:01 -0700, Wengang Wang wrote:
> When jbd2_journal_abort() is called, the provided error code is stored
> in the journal superblock. Some existing calls hard-code -EIO even when
> the actual failure is not I/O related.
> 
> This patch updates those calls to pass more accurate error codes,
> allowing the superblock to record the true cause of failure. This helps
> improve diagnostics and debugging clarity when analyzing journal aborts.
> 
> [...]

Applied, thanks!

[1/1] jbd2: store more accurate errno in superblock when possible
      commit: 7416e371b5bf8f0495829d53259bf3a0f17e493c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

