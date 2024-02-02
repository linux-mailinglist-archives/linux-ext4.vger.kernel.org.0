Return-Path: <linux-ext4+bounces-1069-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB68847A9D
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 21:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207261F25548
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7093A1BA;
	Fri,  2 Feb 2024 20:40:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FFB182AE
	for <linux-ext4@vger.kernel.org>; Fri,  2 Feb 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906449; cv=none; b=ZQz7UUb+7IcC2k51jz2Ofe3sSLF8ZOA5199a8hvAv6stXfNLHrF+IO9joU9vcmTaK2MUDN08ppM0endjjy0LG5+NPqfWjU2Q9TR2TqD+DemXxxiL/3zAng2ZJy6528EKcrfXu/JE0asRVogAfIfZsX2+Qu0o6JSKP82Vh+OneQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906449; c=relaxed/simple;
	bh=s8UDJn1GSpiHSwMB13nb5Vh0w0k7AGkr0ylvG3U6org=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nuem9nSQBzrJItbXdRhSdQntgJrspzJrvfqIoO/v03/u78XLVVle/TYrq474xCEOXxqHz90lhyFnJrvhjfNn7f0SnRx2jtrwbacQ7zvQnH7WHkdJTg49yAEzkAbQZyhbLD5jxWiYJxEifsuGUT10r+OlxZmy2HqW8v2rGvM/9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=none smtp.mailfrom=vps.thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vps.thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id AB03C21F15; Fri,  2 Feb 2024 15:40:47 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: linux-ext4@vger.kernel.org
Subject: sync causing a flush with no data
Date: Fri, 02 Feb 2024 15:40:47 -0500
Message-ID: <87il364n1s.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I have noticed that when entering suspend-to-ram, the kernel syncs the
filesystem, and ext4 issues a flush even though nothing has been
written, causing a disk that has been suspended with runtime pm to wake
up for no reason.

It looks like ext4_sync_fs() calls jbd2_trans_will_send_data_barrier(),
which returns 0, causing a call to blkdev_issue_flush().  Shouldn't this
return a 1 if the transaction is empty?

