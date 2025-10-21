Return-Path: <linux-ext4+bounces-10989-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0EBF4A56
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 07:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C51F3A7DB6
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 05:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE5242D9B;
	Tue, 21 Oct 2025 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UGDxDwA7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8F1F5EA;
	Tue, 21 Oct 2025 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024632; cv=none; b=sDm1wMU42DIJdQS+JBKvyIUByFQTayeSgrM+32zC6zEFSkpOWMwKXZ1+E17C2Qka908JaEXhlBd2Ksm/pNA785S/hnbJTb7mx4+MKMn6CMDXKGq2/3xg7nq8I2nU+ZD8K4oST/YhlefAoL2ROEmMce5MLd0n2e4j0VOKuSbXGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024632; c=relaxed/simple;
	bh=58JB3OXmT/Dcm5ZQWLxXVb8cZcxUXvoqweDpiWVS5/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KarL2I1myEY2zzes7H+RX70oi8/fhnmqwVVieT6u3eQOWvLFs/ETwp4v4GLWFMknBEOaF3gxjN0+6GdL45az1j7B7gQHU0FFFdjCgQVedMZxoCvgRnZWGaYpAG0SR2kMIGoFdq8QN4gfQtb5g3SxtCDLJHahMTBnq90pnQA3ImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UGDxDwA7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JF1Nnm3PTrBK6caP+xG43SNQx+MMy4M1FkV2fWGTi6o=; b=UGDxDwA73N0sFBybofJKOplqzB
	dBv75T57bjWZ2Ib4spZfGdjzeocaAJNmWBLVtY7Nk/h5pPRcTnD1kqpmOuWphJpnhPWkduB3K0F9a
	tHw6VPD4sUQiGZnZ/k3NOw5oVUMZ0bIke+srDuMW6J65KIOPgWUE3hf5qK2NZWcWW0xI22J2Nak1G
	jXHyY/HBiVqXy9R2Q5JgEwHv/1l4yiuf0b6xvQuf9hDhjt9lHG1kYWH14sfGiJ/TgtsVMetOPj+/d
	OHweOiibFGApMohG8XQkqid34ziheoirszhlslZ6lTYa6CmhDoO3mpqGJefwjobZW8dgPg4b+aPM2
	UCfJ8Etg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB4x3-0000000FrU6-1Bvj;
	Tue, 21 Oct 2025 05:30:29 +0000
Date: Mon, 20 Oct 2025 22:30:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	zlang@redhat.com, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 6/8] common/filter: fix _filter_file_attributes to handle
 xfs file flags
Message-ID: <aPcadbSFFBj4Do4c@infradead.org>
References: <176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
 <176054618007.2391029.16547003793604851342.stgit@frogsfrogsfrogs>
 <aPHE0N8JX4H8eEo6@infradead.org>
 <20251017162218.GD6178@frogsfrogsfrogs>
 <aPXeQW0ISn6_aCoP@infradead.org>
 <20251020163713.GM6178@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020163713.GM6178@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 09:37:13AM -0700, Darrick J. Wong wrote:
> [add tytso and linux-ext4]
> 
> I think we should standardize on the VFS (aka file_getattr) flag values,
> which means the xfs version more or less wins.

Ok, I'm more than confused than before.  Shouldn't we simply use
separate filters for FS_IOC_GETFLAGS vs FS_IOC_FSGETXATTR?


