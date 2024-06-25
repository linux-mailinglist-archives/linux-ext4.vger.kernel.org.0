Return-Path: <linux-ext4+bounces-2945-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795F8915E8E
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 08:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B9A1F22889
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jun 2024 06:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D823E145B2E;
	Tue, 25 Jun 2024 06:00:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7361B806;
	Tue, 25 Jun 2024 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295247; cv=none; b=XWNXA3uTudD6xmqprOTK0bVe+XLEkAFfoQCoH0JBpHcD/UxtrxILMzE7BcpEx4DwjWlMOyK2zrmE0Iut0/RH3eS6UUyL3P8gpbSbqXxUEhppWKeXwtkerMwv+TLcxRvhXBhi1XZQBXzreQMIUJA4NlPyvjIQgdKdUusKFNlnCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295247; c=relaxed/simple;
	bh=02L6CHPUK6t3ehMx1n1Z1Ul4pY+fIL8TbmR0S1ON1IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIPs6euKcBk0lJc7xnXmZ0IvyOHmCjzhuAiMxmhVZRqW0GH0ha5REcVcNK/HDkAyG+CTG34bT1vR4TtY9xaAg9mLuaTZ8us04OEscmBOvqJDuGVXoHrMns2F8ziS0ITngZTHFT0zgYcLuIrWqAkyZdkkrnQYswjIi8eXfkigR6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A7C768D12; Tue, 25 Jun 2024 08:00:40 +0200 (CEST)
Date: Tue, 25 Jun 2024 08:00:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/8] generic/740: enable by default
Message-ID: <20240625060038.GA1497@lst.de>
References: <20240623121103.974270-1-hch@lst.de> <20240623121103.974270-6-hch@lst.de> <20240624161605.GF103020@frogsfrogsfrogs> <20240625035008.GC7185@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625035008.GC7185@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 24, 2024 at 11:50:08PM -0400, Theodore Ts'o wrote:
> It might not be worth it.  One of the reasons for it is that mkfs.ext4
> can be set up to try to pull in libmagic using dlopen, to minimize the
> package dependencies for things like the distribution's installer or
> minimal root setu[s for Docker, et. al.

So mkfs.extN doesn't actually use libblkid for foreign fs detection
like most (all?) other tools?


