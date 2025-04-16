Return-Path: <linux-ext4+bounces-7306-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ECFA8B00C
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Apr 2025 08:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5D43BB5BA
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Apr 2025 06:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F3722DFA5;
	Wed, 16 Apr 2025 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5B6vUaP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235222B8D4;
	Wed, 16 Apr 2025 06:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783771; cv=none; b=QTIR3gon299pNvB7ng+DPZAl9T6o56I9qd4sXSWkyxhGisHacIHno6WaFPvYJrWipB+4mO6z4yhQ6Bpn4H5I6whko6RJNMFz4GO1QvlbjJKZQr9BECF8EIoT6QiUqrG3udSlKkqW1J+az1ZY6GDH5VO28wnerHB/QBLrpOl6nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783771; c=relaxed/simple;
	bh=atjs9xnnTb8NrElVWESWkmJT4LsGCO0VIogOIOZ7FRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWzu4PKzlylSNNaAIJyx3FdYLl4jM8ELf4r9tAadDLSreJZRT24T7L75beELJxevLT64phz+JqJ+tJMbF72ljx1XY9WvC3RlfgefkuV83ArHZTdJEyvZb5SEaGkGhlmIsQLF4EIDXdiTPciSBEWeE1B5g+NWEQhPb4X7R80bSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h5B6vUaP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=IbjssDbDw4fbWENvdS0KvfimTbvuxyw7pTODQ6w8VYc=; b=h5B6vUaP9nBicHML0o1nO0GmeE
	QzMSCqPyrmX9DLxlVDL3LivdmUQgcpIq4O+RD7ebNUEciFmiCZC4jeM9jadDJ7IG9C6y4TJEzcg7/
	MjcSf2SS0f1+7yiPuyo0LBTtGFyP3oJuwU5sQ2mRNQyFmRG2JItfMzs/e7q7eYYKETvRdsvW1dBtm
	AvhH92UUgWNkXR7ByxniOQAU0KPt0ABo0BimXR960R6Ekjng+6jZ69cJfqQ0muMk4kYPffdf/K5II
	vtQAdzBTmhK4MR+3DVZi0u7xkKKiA7b7OwSiT4s+Zutd7pZ20ekSfIUkGx4VS1rlbMYd4pL7YyHkt
	Tue3T6Sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vxh-00000008Mmg-3PR4;
	Wed, 16 Apr 2025 06:09:29 +0000
Date: Tue, 15 Apr 2025 23:09:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
	zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v1] xfs: Fail remount with noattr2 on a v5 xfs with
 CONFIG_XFS_SUPPORT_V4=y
Message-ID: <Z_9JmaXJJVJFJ2Yl@infradead.org>
References: <7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com>
 <Z_yhpwBQz7Xs4WLI@infradead.org>
 <0d1d7e6f-d2b9-4c38-9c8e-a25671b6380c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d1d7e6f-d2b9-4c38-9c8e-a25671b6380c@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 15, 2025 at 12:48:39PM +0530, Nirjhar Roy (IBM) wrote:
> condition(noattr2 on v5) is not caught in xfs_fs_validate_params() because
> the superblock isn't read yet and "struct xfs_mount    *mp" is still not
> aware of whether the underlying filesystem is v5 or v4 (i.e, whether crc=0
> or crc=1). So, even if the underlying filesystem is v5, xfs_has_attr2() will
> return false, because the m_features isn't populated yet.

Yes.

> However, once
> xfs_readsb() is done, m_features is populated (mp->m_features |=
> xfs_sb_version_to_features(sbp); called at the end of xfs_readsb()). After
> that, when xfs_finish_flags() is called, the invalid mount option (i.e,
> noattr2 with crc=1) is caught, and the mount fails correctly. So, m_features
> is partially populated while xfs_fs_validate_params() is getting executed, I
> am not sure if that is done intentionally.

As you pointed out above it can't be fully populated becaue we don't
have all the information.  And that can't be fixed because some of the
options are needed to even get to reading the superblock.

So we do need a second pass of verification for everything that depends
on informationtion from the superblock.  The fact that m_features
mixes user options and on-disk feature bits is unfortunately not very
helpful for a clear structure here.


