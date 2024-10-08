Return-Path: <linux-ext4+bounces-4532-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612569951CE
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 16:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214431C20365
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62191DF74F;
	Tue,  8 Oct 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XsGeyAqS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064E1DDC06
	for <linux-ext4@vger.kernel.org>; Tue,  8 Oct 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398085; cv=none; b=fKwFzYMbcxDIVDhP9233GCKzoAZPbU0wiTPACPBt5vLYEYqzaHsnI/US9BrO65OXuTXLsWYprurJzzV21bJQ92bgXHULODjUXedd6HimtOnWK8ZSPv1G23/5CTsZyf3+YomFxem67KX9umofcQxb/G9ij6A3vowOjti/GLOj+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398085; c=relaxed/simple;
	bh=NppUhzEK5qnxhRhCosPdGQmS6AAvxlyQI6ataWQWAco=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rcTlEc+CIJeDkXxNnDqmWmmxvwNth/ySS/e9Q1n/ehuq7RwXAI3V8THEkqw+1sJR+8Im71MtQXcHUszEsn3+Xv3yZzl5k0lvcZ8yqFLFWdKh4qhNSUPDzJ0LO2KTg6sIg5otenA8jRV9+lr8FjmCdxUz+YLzxdmSKsBq8UrvT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XsGeyAqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B9AC4CEC7;
	Tue,  8 Oct 2024 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728398084;
	bh=NppUhzEK5qnxhRhCosPdGQmS6AAvxlyQI6ataWQWAco=;
	h=Date:From:To:Subject:From;
	b=XsGeyAqSRrAWIpjpmECJZzMMJI2/yfuT+ITxNopvqKrvCx9me4qHg57T4ubH6dtqq
	 fBLQ3mdB5XXX0y9VB6Fan5Zuw/JrNwJMmzzyKcenjwz4wkbooOblN9+zrsLbzaHpmO
	 aG2KCxpzO1kFFlqopjpoLoTia0FnopbI2PTwP6HI=
Date: Tue, 8 Oct 2024 10:34:43 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-ext4@vger.kernel.org
Subject: Sunsetting ext4.wiki.kernel.org (unmaintained)
Message-ID: <20241008-strange-hospitable-buzzard-b0e64c@lemur>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

The ext4 wiki appears to be mostly unmaintained and contains pretty obsolete
data going back decades. I suggest we do the following:

- Archive the current contents as a static site on archive.kernel.org/oldwiki/
- Add an admonition on every page that:

  - the viewer is looking at obsolete contents
  - all up-to-date information is on https://docs.kernel.org/filesystems/ext4/

I.e. this is exactly we did for the unmaintained git wiki a while back.

    https://archive.kernel.org/oldwiki/git.wiki.kernel.org/

Please follow up if you have any objections, otherwise I will go ahead with
the plan.

-K

