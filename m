Return-Path: <linux-ext4+bounces-8050-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC4ABDD7D
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 16:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9090B3B3F54
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0A24EA80;
	Tue, 20 May 2025 14:40:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651224E019
	for <linux-ext4@vger.kernel.org>; Tue, 20 May 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752036; cv=none; b=QIGpvfBjrFk+oIafnmbuPYQrm5YSB3oqo0DLUul5/RWClB7GLe5fMEjJKnSMLeaLiPZVEGMJ5PKcN0NKqMEFqlLoz3KLAAlADXylKkUM4MJ6ALZS6YKypFYlBtbMXzQIVDYlcBg0Ujr0IpP9oncOeJMqNwAaiXgnOJfnm3jT5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752036; c=relaxed/simple;
	bh=bSnb/Bp1/RAnOC8UGkHSp7h1Y3RrgXvmsHwZlix3bXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ly14rtWXj3mpXyoBmo0wQdklAoBvWNfS6NDYBCZn7+b9uMTeEN0oa4K94fRLPWg/GNQC10zi7QyhXPto+/3CDwztaAQWqxE/eO2G14yOtewlqsqA3yRU3QzH5kaP72xYY7pBoqeIX3ArH32vKKzmURxwss0m+5KKiSPAr8fnnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEePff013144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:26 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C15372E00E4; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: use writeback_iter in ext4_journalled_submit_inode_data_buffers
Date: Tue, 20 May 2025 10:40:15 -0400
Message-ID: <174775151765.432196.4093412093529968215.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505091604.3449879-1-hch@lst.de>
References: <20250505091604.3449879-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 05 May 2025 11:16:04 +0200, Christoph Hellwig wrote:
> Use writeback_iter directly instead of write_cache_pages for a nicer
> code structure and less indirect calls.
> 
> 

Applied, thanks!

[1/1] ext4: use writeback_iter in ext4_journalled_submit_inode_data_buffers
      commit: e80325ef5cc2d9de13845ab32c50d5012357d42b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

