Return-Path: <linux-ext4+bounces-2020-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2538A055F
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 03:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0EB1C22720
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 01:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9BA60B9C;
	Thu, 11 Apr 2024 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=accum.se header.i=@accum.se header.b="XqyN7eDT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.acc.umu.se (mail.acc.umu.se [130.239.18.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E0F9C3
	for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.239.18.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798214; cv=none; b=OWRHWc/uXTFvwiuHP8x3yaezcd9Tqq7ZRVoh6BHpu961aypVYUgYTN0rhPhRZhyib9EH4c77fm+qa1CyzmONce5zv4jVug0FGTvBLDQO07iBxqD/3WPrZhZ9VP+5qqku9jhT3A9wugCMyHBkxmT4cy9Z3/YFRYhE+KgX+3fPxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798214; c=relaxed/simple;
	bh=YexmIQ9s2Y2RCZzv3monswruhAJ5vxWBDZhP0gWGBqQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=abhQFSOIzu3XRetnvwqEwc6T6Gage9oDf2Z8qiCIi8/N90mB6I813m6GcV9KZ5a8oLgEugJ9cktYz//plR12ulM0ankVA1giSX7l4uUsclYq9mnIT+nVx9zvWlGO95VYqK0DrsgTluRo0keU7D/w8wJOFyYl/EZqXnX1QANaiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=accum.se; spf=pass smtp.mailfrom=accum.se; dkim=pass (1024-bit key) header.d=accum.se header.i=@accum.se header.b=XqyN7eDT; arc=none smtp.client-ip=130.239.18.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=accum.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=accum.se
Received: from localhost (localhost.localdomain [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 0C86744BA2
	for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 03:16:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=accum.se; s=default;
	t=1712798208; bh=YexmIQ9s2Y2RCZzv3monswruhAJ5vxWBDZhP0gWGBqQ=;
	h=Date:From:To:Subject:From;
	b=XqyN7eDTpHrofkOlYgNvMouMUu+uDkb9sEjSPLtXnFfkDbGXPMpXj7zCtUsFHDnBD
	 7AxaHSG9kIyc8rKRHRWPwC3TDr959t6qmwm3OZG6Q4rSAyE2KfnHAbrKKtdwq9L35Y
	 1EJdUXWXOVM9sg15Qx1Dx29IQ2HdFD5680/d/DME=
Received: from suiko.ac2.se (suiko.ac2.se [IPv6:2001:6b0:e:2018::162])
	by mail.acc.umu.se (Postfix) with ESMTP id 64B6744B98
	for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 03:16:47 +0200 (CEST)
Received: by suiko.ac2.se (Postfix, from userid 10005)
	id 5C1F142B51; Thu, 11 Apr 2024 03:16:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by suiko.ac2.se (Postfix) with ESMTP id 599E442B50
	for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 03:16:47 +0200 (CEST)
Date: Thu, 11 Apr 2024 03:16:47 +0200 (CEST)
From: Bo Branten <bosse@accum.se>
X-X-Sender: bosse@suiko.ac2.se
To: linux-ext4@vger.kernel.org
Subject: When is "casefold" enabled as default?
Message-ID: <d53dd39-70f7-5422-5ddd-fdd96686e7fd@accum.se>
User-Agent: Alpine 2.25 (DEB 592 2021-09-18)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


We have a compatibility problem with the ext4 feature "casefold" and now 
some users have reported that they have this feature enabled without 
asking so when formating the filesystem so I would like to as you if you 
know why this might happen? Does some distributions set it as default or 
is it some container system that has started using it?

Bo Branten


