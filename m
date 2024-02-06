Return-Path: <linux-ext4+bounces-1137-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA5684B94C
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Feb 2024 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6CB1C2463E
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Feb 2024 15:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3D213DBB5;
	Tue,  6 Feb 2024 15:14:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85687133410
	for <linux-ext4@vger.kernel.org>; Tue,  6 Feb 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232467; cv=none; b=mwdKQ2kVwVirAiaNe8djVUfsgkeU/e+zZHyXAoMWlKStaM6AGvNxEiM7a17s08+3QOU3+HfNsq9NazqXyP7bbxftXbPWk2nArcIVVpLhuwwD7uYRyiZ1jSkjrW1bfaItI1ydUIHU+O1sneeZQkOoPsYwQKirDFKG0DoOS+yhyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232467; c=relaxed/simple;
	bh=Y3X82nAfaTwBqfXQY/WFHAGmNltENlJyVvF/VUQUpTs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BXhsacreBnhduMeHsyIjOHFcCbU/MAC3Gf9D1D0Oa3g9dUOaPyD0EyhQNLyA8678pdOW5DCeDAEf6ImmEVSNlSrfpbwsViwtWfCcwG3hZK3bdF9RsNuwm/k9PMSTTabxPDli62dxgCOKBDIMMVXZ/ZfWzMCNl6LxgwYLGE9FkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=none smtp.mailfrom=vps.thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vps.thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 9C3F3225EF; Tue,  6 Feb 2024 10:14:23 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: linux-ext4@vger.kernel.org
Subject: Re: sync causing a flush with no data
In-Reply-To: <87il364n1s.fsf@vps.thesusis.net>
References: <87il364n1s.fsf@vps.thesusis.net>
Date: Tue, 06 Feb 2024 10:14:23 -0500
Message-ID: <87le7xbp68.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Susi <phill@thesusis.net> writes:

> It looks like ext4_sync_fs() calls jbd2_trans_will_send_data_barrier(),
> which returns 0, causing a call to blkdev_issue_flush().  Shouldn't this
> return a 1 if the transaction is empty?

Tracing a little more, it appears that
jbd2_trans_will_send_data_barrier() is returning 0 because the
transaction is already committed.  How can this be?  If a transaction
has been committed, shouldn't a new one be opened?  If not, and the
transaction indeed has already been committed, then why is that a reason
for the fs to issue another barrier?  If it has already been committed,
then the barrier should already have been issued shouldn't it?


