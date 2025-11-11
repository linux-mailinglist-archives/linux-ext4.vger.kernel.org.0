Return-Path: <linux-ext4+bounces-11754-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A1AC4CA78
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5471883AA8
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C427B2DAFD2;
	Tue, 11 Nov 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="URCa80VN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512A4A01;
	Tue, 11 Nov 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853307; cv=none; b=BVzg0yqHs3UXtZX8ftoJ1FRvjZpA8CWApueQhjx5//rXPS50jiT1XQybrVkmkX8EpbzrDFCzsc/W0InXb91yDVXHEUNKXdEYBgbF/hYZ3/Dao7JRGAwq5n4iJ9dplCATwD3qtQVPLPbb98QlFpDOZIazJ7mERBAJ2pPoBO3ed+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853307; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byG7DHmWKiSYykOBFGe+KJAfOssIg265ZX4gte7V0MJj2/S/Dku0Pj60Zd5q+XMIqH5SQphjEstppDczF4Chbxhv12Dy9T2OVwjXt+Ex7PbB/UegL+vB1ltKKpoFpTdkGiaDD/3QvPzMJQ8zDN3gXl6tYmRgdZsZRb1wIzyF2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=URCa80VN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=URCa80VNWygTp55amY484BMsP4
	Xu0mwBFEc4fjAnN14YMkDGwmocFNJRmT/vji/frdXZs55Vn/KwoBxUTHkzkWbTlsksT6FQmHc5rEo
	n+96TGzpSklKOBsPI0DmjDwcm8daLFtfYESNpEK8gQTuuv2Oe1PQjWKmpL5E290Sdj/fBQ/fT8q/g
	kmXPRhfk05xqlSrNtu7t+CqcfGEEB3C08xniHXQutyJ3kvU4WXcryeBrFJ6z/KHC+14YorkwsfVaA
	NfRly3PYbAurPQ8xPAro9VWa2sjhf4qM/gVLMrBy6GT/rQbWcogm4vWw3mMi4j5xgzfwiD2QZjHKV
	nYTftCFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkfp-00000006qPu-35nB;
	Tue, 11 Nov 2025 09:28:25 +0000
Date: Tue, 11 Nov 2025 01:28:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/7] generic/778: fix background loop control with
 sentinel files
Message-ID: <aRMBuVRoSmHikNWO@infradead.org>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909060.605950.10294250986845341696.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909060.605950.10294250986845341696.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


