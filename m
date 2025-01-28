Return-Path: <linux-ext4+bounces-6252-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E50A204F1
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 08:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DC77A1CB7
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 07:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB881C75E2;
	Tue, 28 Jan 2025 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ps2XJS01"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C863192D84;
	Tue, 28 Jan 2025 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048401; cv=none; b=YvorePq5jI0qbhZG8ALkeJiV7TRiuDXONLGey9P/NnSfAsl/1h3oZmeqooTg54fROl0dbiEpOQ5rpEX+XpiWp7VuW33oh7iawfg7ibV/DgUINiO0cWOdu0xm/eF7mYnnWuTQvkHMUQfw37xTz+sFpzOeCiJPYxdZaHfTMtMbyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048401; c=relaxed/simple;
	bh=UOzXf/+YJeSToG9xigCeps8xuPBG2sg1sFZm2kB0nVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djA1RtDxsoxGmI42qtXfYjFyt2X8SJ/n1Et6jFwVUJfktjBbEwbQ7zZ0oDddP8faZOnobXvdHAZfszO5gexdpm+7K5ZzmMstqWKFOIcfUxybFfFVG4fKypdf9mL9fV6Px40qpkG+1TnhdkmKQ8tsySJxnuM4rmiQADGVMCgkNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ps2XJS01; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0fAPBxXriOrlocXY+PgcyMz1JSAr+2M6gpNGaPvcviQ=; b=Ps2XJS01JAW29/Z9sfgdIhfoOu
	XeJc5vP0eTAstEFTD8yZh0xi3ZInLoBpumYYNcv3OOG85d9YxXFXYgwu5gQASqzDjEqooeYxsGdNp
	v1DuqMCMOlr8oWgDlmTTYthG3EBbzrm52BG83G1YGEKuEEDEi0ftrrrdvlRmWPLWS5LXu3JROt99M
	fo/gmPNF1d+1z2Ilo52//e4k1veEwyWX+fC+Gz9AjJSFe4xP/pZuMpw2A5EqONd4e+uLcBqbQzvHA
	aWZ4RqSCv/aZOts2e52H3HhVTpuoboSZt7eTxfQLG0m4YVTIUbaBLBGh7CLhBYFvvquSeZDUwn8AX
	Ay2iG8dQ==;
Received: from 2a02-8389-2341-5b80-d7c6-3fcb-a44b-90d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d7c6:3fcb:a44b:90d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfmh-00000004GOQ-0BwF;
	Tue, 28 Jan 2025 07:13:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: remove _supported_fs v2
Date: Tue, 28 Jan 2025 08:12:57 +0100
Message-ID: <20250128071315.676272-1-hch@lst.de>
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

Unlike the previous version this does not add a new ext-common directory,
but instead uses _exclude_fs for those tests as well, which doesn't
look quite as nice.  Some of the ext4 maintainers said they might want
to switch this to feature checks, which sounds great but also something
better done by people familiar with extN.

Changes since v1:
 - remove the separated ext-common directory previously added

