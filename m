Return-Path: <linux-ext4+bounces-5530-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B184C9EA92C
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 07:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B929B162DE1
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 06:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9D22CBD9;
	Tue, 10 Dec 2024 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A5C+WndL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D403594F;
	Tue, 10 Dec 2024 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813946; cv=none; b=GO6jaFhRnbp7AheN8hZn9mhM8MhOib+GmcK9H55Y9XLONwUFjwCB5047YDpMR0JIxJA9jt1tA+9x1aSlwIEuKqr3LbJnbZrB8dAKinwWkSMp1pVn9cjOBVQ6hZwzymWdz3UbuwEQ9w9umoLrTXia0X50wgDUKqSxQLYu0EvUArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813946; c=relaxed/simple;
	bh=i9z2lh+moRXBzIVmTTGeiEmlUXU/YfBTYTBIb/tId9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7Dxsl2E4gZccYOx7MM7s3wFiwtElliyMxfs3aMb6yxMtmDaXsNMeR4L6ZYYyHizI4rrprmz7hrSgy0dyLuNtlzU6QrtAZXEgwXAhbevVaiV5dMnvgZEjFeTaj41QojDF0LwXlSRe22dBy5+qQW+gxZkZkI4C0OmF5mDPpcyBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A5C+WndL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=grzCkfShT30aunxd0D2eh0Tfcjifv6SZ+epoyRYk1no=; b=A5C+WndLMSpCvW5ywLu9n3mFJU
	ZBgX92Qq0oU5b+7J0itxBqysGQhkcT5LoDFoYw4W1qP2/bMyoOeH06lIPSoaAkqUddPT8MsOFUc6G
	ff9Qd1fB9GVhHVKt+D44x4g4BMx3tHd4s4TsW0OFmnKZDVOWl4m2CEsX1j7SM4RNK8i6nFgDSQSfg
	ooVLoMffuvVK/onlpT0ehBhk+xv7HY5rqdJ6z9uuVRMOJ4CKUbsgcYWffjLwevVwSMhnAOp5/LRKH
	r14xOi2wncdaCO1PZ+T+hq8TRcVfk94/d2KyPO3H6hja5UQhtxlCcif1PUcMBXuvI9YKvaJPj7Lze
	F+LVw3Lg==;
Received: from 2a02-8389-2341-5b80-e2a6-542f-4e27-82ec.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e2a6:542f:4e27:82ec] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuD1-0000000AUca-1OH5;
	Tue, 10 Dec 2024 06:59:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: remove _supported_fs
Date: Tue, 10 Dec 2024 07:58:24 +0100
Message-ID: <20241210065900.1235379-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series removes the remaining _supported_fs calls and replaces them
with a new _exclude_fs call.

The first patch removes a _supported_fs for a relatively new test from
Brian that fails on other file systems.  We should still run it so that
people have a chance to fix the corruption, so I think this make sense.

Then the ext4 directory is split so that the shared extN tests have their
own directory, and then it finally does the switch over now that now many
_supported_fs calls are left.

