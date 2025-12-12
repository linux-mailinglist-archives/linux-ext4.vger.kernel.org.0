Return-Path: <linux-ext4+bounces-12316-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57520CB83C9
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 09:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DEAC304B229
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 08:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E228F30F942;
	Fri, 12 Dec 2025 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UKY8lZZl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001FA296BAB;
	Fri, 12 Dec 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527739; cv=none; b=HdnFpyaLgJgMqq3ESgfKGznD1Squ97fhXsBE4EuZMaF43fvQMrKqUmEGCNW0dRUe7sEtkNPJeXk2+FSewKJVErYsNQFsev8OdwI12f7KhDefUbwvnotCdRVR91ZTqAKos8FiPbjKAwbcH8dUOITTGxnOdetdxz18n/65HqkEPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527739; c=relaxed/simple;
	bh=rmVCYIpKYQkFvZIeMnfxO8Bsi80SmAT29C5Xhm414QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pK6eWdjEZamNfb9gRKgTJgnKXXpZsY3Ii/MDT6JEtX6Yp0FzQ4p4STsH3PqHSLb0oT1GfzWl3pH0BvTI3qRutCnE5UX7GM6gFqFxs/kjP+nU5tNoEOxYzVDVDNO3dThlvnXHFwnROhctGi4KxNpsiu8WLOVfPTK9nnqE6T0CMMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UKY8lZZl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RBmkWoQMVbjZt7PcoHa3W82sdYUsuU0J62BJ3o6iuqA=; b=UKY8lZZl8mzr0x5AJO9pb6WINn
	i6NInrqc5HatoM4atNF2wamWhnLDxH4wNPaC8pMD27aMAqnVVkePQG6FThYT2r4ZUi78KG7p2bPXb
	tBRH69UKbRrZ/aXX5rzvl3z8KZxrZVfcuX/lr01CvVikvP21dCyBGPeOgiKTRuCrG3Ocn4i880shM
	npjahcUKMp07aYbXZR2Z5+gE4NCyCmzbdRdT0K0o2ZEepJ6dDscHZT6KO+rUEKxQS9A0ax1vCl4mF
	LjcvONVNgEPZTFAlUmNPKI3C1UjuLtk0k7gsbnzHxL4Q/6OMX12e+tHLqkQtkEapJWQ/ZUe18QueT
	51CWcsyQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTyPn-00000000G4v-3gDx;
	Fri, 12 Dec 2025 08:22:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: stop overriding SCRATCH_{,LOG,RT}DEV v2
Date: Fri, 12 Dec 2025 09:21:48 +0100
Message-ID: <20251212082210.23401-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series cleans up various tests to get out of the business of
overriding the scratch devices setup.  This is not only generally a
little ugly, but breaks when mkfs options are incompatible with the
synthesized setups.

My prime example right now are two zoned XFS options:  -r rtreserved,
which only works for zoned RT devices, and breaks as soon as we're
running on non-RT or non-Zoned setups, and -r rtstart which only works
for internal RT zoned RT devices, and breaks as soon as an actual
SCRATCH_RTDEV was used.  There's probably more that we've been
papering over with the try_ options and by scratch_mkfs dropping
options when they conflict.  I plan to remove the need for the latter
in a follow-on series as it leads to hard to debug bugs.

Changes since v1:
 - pass a device to e2fsck in ext4/006
 - add a _require_scratch_size to xfs/521
 - ensure the file system is still mounted when checking it in xfs/528

