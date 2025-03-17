Return-Path: <linux-ext4+bounces-6820-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0360FA6411F
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Mar 2025 07:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29537189121A
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Mar 2025 06:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66559219A67;
	Mon, 17 Mar 2025 06:18:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46084430;
	Mon, 17 Mar 2025 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742192306; cv=none; b=UiXf0kRd/pP0zkEPzl7uHcZ4+133cOBIcojAMrqQQlcDJUX0IT0o2UdRcqnF2nA+2vEedMSOkGpIadtHtLttC9wRL/qlzTommNKgi5P2S/1+ixyKGWhYkPzquwcwn+ubkr1nF5RQBDQPh8RwmF7cR7/Xe3KFsR7DMdRL4BcDMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742192306; c=relaxed/simple;
	bh=o1UEa83JyFzeLRVpQaWIm0eAVlGMB6N2fjs91gMS1I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyvswvQ2QRdGfVDUoXG1WlicXg9aehTfNLT2SzX2HRYsVI7W0xHCcIOEl3mHrvy2eDaand7dUfYNKHF3T9193AyvSUvnB6SYUxwIBSARU291AzEtTJgG1C10hAwq9HvX2ysm5EwdKKd3FchQTfg0B8lHSMoP/1DZAA+TUZPXth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20A7168D0A; Mon, 17 Mar 2025 07:18:18 +0100 (CET)
Date: Mon, 17 Mar 2025 07:18:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 06/13] xfs: switch atomic write size check in
 xfs_file_write_iter()
Message-ID: <20250317061817.GF27019@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-7-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

switch seems like odd wording here (but then again I'm not a native
speaker).  What about something like "refine" instead?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

