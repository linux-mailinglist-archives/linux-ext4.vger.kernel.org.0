Return-Path: <linux-ext4+bounces-12223-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E44CAC411
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 08:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4570300BB90
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 06:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A768B248896;
	Mon,  8 Dec 2025 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TQ6rtLw6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870726290
	for <linux-ext4@vger.kernel.org>; Mon,  8 Dec 2025 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765177197; cv=none; b=OmykERC7U2XyKd7qP3hoC3R8K6MPU2J2nBYv7FpN70bJAazNWcI+IROsQD8Sa00oYbZr1hlfbMJ0R7pO8AiHKkDYH3obFETaj8/7jij9flyOlE43eJJm9dOO4U3yreCPwJ7Q+vvgZn6wYs3zRZLsBLV+PxZlTeyP7S03+GEuh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765177197; c=relaxed/simple;
	bh=MRwuxVRhhcTxWi2AY2WPuwO13lJyvjDB06jGh4lqff8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VFaJ45ABuCgXBBkLDF6jTvkuanGuPY39wxqJmQSIGf5Oei0bsS7rXgGCODj5hWdPFKk/YYyhwaPe+md7SL0bAzwtEX7G0s9ei2NGSMWjzRAzW79ZhTgbDH124m8EnwoUwWtxKK4VcKF34RBUzv06n3vUbxUT+utKCRx6hKtrjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TQ6rtLw6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=/hPTMFlgS3ZqKo+7deZaXdAAUnHBuTfMVAuIB+D/qSI=; b=TQ6rtLw6H3hIyMFRB9JuSvwvj2
	9OKUYI1QVuGUHCsgpQmL2fOzOmiyptzD+KR4kZdbJpUVOJs8kt+NapohchkcNSYKksE9SQ8DCK6Iq
	XOLx5pbAgydm/UbTE9K1fVETuLU1VX3OVYt8XIran3PS+nzYY9thMcMrLx1rgryyeWPJ9Iv41RfFL
	OIQdfK1ImJgKfRcrDYg85xS0WJak0yvg14xaiVfpb+v4sd0oqwTOcFguw4dlH/ra4GhQ9TbOIfxU3
	nhMDca8B3HrQcJDMMiFm7ppWrgi3OglBpPuWyVkWfdZDMyOpNqr9qlz5mggzau7OqrOP0tGus7OcQ
	nHVhdoEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSVDu-0000000Cj3q-1vuG
	for linux-ext4@vger.kernel.org;
	Mon, 08 Dec 2025 06:59:54 +0000
Date: Sun, 7 Dec 2025 22:59:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: linux-ext4@vger.kernel.org
Subject: ext4/004 hangs with -o inlinecrypt,test_dummy_encryption
Message-ID: <aTZ3ahPop7q8O5cE@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

I've just been wanting to test my changes to the inline encruption
fallback code, and it seems like ext/004 (the only ext4 dump test)
hangs when using the following options:

export MKFS_OPTIONS='-O encrypt'
export MOUNT_OPTIONS="-o inlinecrypt,test_dummy_encryption"

I thought I did not see this before, but it reproduces back to at least
Linux 6.17.  This is in an uptodate Debian trixie VM.  The dump/restore
process look like in weird states:

   4727 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir
   4728 ttyS0    T      0:00 /usr/sbin/restore -urvf -
   4729 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir
   4730 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir
   4731 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir
   4732 ttyS0    T      0:00 /usr/sbin/dump -0 -f - /mnt/scratch/dump_restore_dir


