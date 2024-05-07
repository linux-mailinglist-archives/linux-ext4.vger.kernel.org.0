Return-Path: <linux-ext4+bounces-2347-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB88BF13A
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 01:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF601C22F83
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2024 23:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D8879B9C;
	Tue,  7 May 2024 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hiQZmb9O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5E8060D
	for <linux-ext4@vger.kernel.org>; Tue,  7 May 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123056; cv=none; b=Bz04orh955k1iPVbDlOdgeF9DP0mWw79H8Z+wXk+QNV5oDcAOgUTnGt+5FYC+AWeEYh8T/oZ+Cj/POmf3RtKW/vsYv5tyAynY0GIjIeEqqbdUVC/vkeg2LsZ2OwfRpBuHZQOjrwFcrmjadrDvmeqPCqRX049Wr3UvMaHYhQQDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123056; c=relaxed/simple;
	bh=IgULpxQxANS9vvlOG9lGlantPOqWUSw18OIpd0nF34A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKPaSk45ZQuy9pdKjGui+bRu2Ssqq8A9Sd59H1gEgx9pVpK8246RErzh7AD9R51L4eOgoeQJtVbjtyFh3o25yZ7Xryj6xPZBAgV96Ye3uXOw55VIScaLk7DUdiwTEzGBCI1VkSeHd2OCQGC+b9yWW4mX9lyftQKKReRREjZvjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hiQZmb9O; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 447N40Xc026170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 19:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715123042; bh=P2j7YaaKodp8+E02KPh1U1zOLLuv/QDQ+Bqrchm2mTw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=hiQZmb9OH0RJV2FFJ3UTJp05ieqpJUk2liPQUhVtOd21wwDvJIwFceWbGOsxHPrY5
	 VsgJmUi8TVoTTBszlNPVv74ugs5ik2sG+cJVuebmQcuvQQDzYMPXbt4CmF3NERRe66
	 0YcVqi9AdQZXhUc/viRhWxc2iaas3wHWTvzX+ZLzxLaa+NEme9tuuc8NUCm/1hZWZZ
	 4E4LGZbaxOFGD/II2/dsMT8Rczkque7qMkht391v0zKdwu7dJJ7iZw1Gg9PDDPLl2p
	 l60Gx3uLq3k08hqVrXEwzUBY40KEsNaFrMRKTTbNszVFWV12TU2knMiKTGV65laDIP
	 nmFv06BeqC6yw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0946215C026D; Tue, 07 May 2024 19:04:00 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] jbd2: remove redundant assignement to variable err
Date: Tue,  7 May 2024 19:03:49 -0400
Message-ID: <171512302200.3602678.5356035160659391900.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410112803.232993-1-colin.i.king@gmail.com>
References: <20240410112803.232993-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 10 Apr 2024 12:28:03 +0100, Colin Ian King wrote:
> The variable err is being assigned a value that is never read, it
> is being re-assigned inside the following while loop and also
> after the while loop. The assignment is redundant and can be
> removed.
> 
> Cleans up clang scan build warning:
> fs/jbd2/commit.c:574:2: warning: Value stored to 'err' is never
> read [deadcode.DeadStores]
> 
> [...]

Applied, thanks!

[1/1] jbd2: remove redundant assignement to variable err
      commit: 8b57de1c5edde3faf8a4f6a440b7ec16bb3c81d4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

