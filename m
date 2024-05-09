Return-Path: <linux-ext4+bounces-2402-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288AA8C0A78
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 06:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D83283AF6
	for <lists+linux-ext4@lfdr.de>; Thu,  9 May 2024 04:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30091482EB;
	Thu,  9 May 2024 04:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="O3w3zlX0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDB413B2A4
	for <linux-ext4@vger.kernel.org>; Thu,  9 May 2024 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715228785; cv=none; b=IwDXDtyoE3kLqiL/w8H+TCoJdVB7NzhhbnGhGJ+SEAF2vIXmzKPqY6qoOLSdEmZYJqLfwNNQLrPm2Bs7Am0Hd6OzIAIsyKmcmjt7yl1jvaqex2Trfql9NQr+H5k8xbbN7jHDrT0cTBNpOX+jOjTBHVmBpar0MmezmGeszljZgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715228785; c=relaxed/simple;
	bh=OPgnz3BbwCSjBrTHEf0ogJDT/57Rgui6B0Ex1Qirsq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFY6mfrlJi6yo3J3VFrCOMWgP4Ud3scZSwQaXk0/OAisZD4Q7jH8Vr6ie54v8XuPhWdRNjLiEW1DfekVIKe16n7tKVwUZ03zFjUECYtg9QlpbgVrbhJDoUTa4hnFP0gkkLnJTrLb93GkBpzr5ts9eGIS1MNXmfmo/Po4YdHaTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=O3w3zlX0; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4494Q8IT028120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 00:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715228771; bh=gbBCfNyqasl5btmlSBV5HCwoEoqrsV1lWmaN0F7qRGA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=O3w3zlX07uhsmm4Y3Kr27SfIrPiM+Oofz+aVWQLfGkc0xfpQgkYJ0uByrcHSsGjNd
	 bVhsvvLAb7WV+/xAp9RkohfRyv4qsiFcnINdL/6S7LUj089v+cFDUP8qhzBQcf/i0L
	 8oGppBiPux9WPF2T7Dq4rEiGH6YS1g5oDq4l+dTPOzDyPlicPbELfdrtesIwSKiUBp
	 /Gx3D3w0v7OtEu0qrsg8jKoUx2yRnv8r+L8q033zxqqu/ifI+T/yynp0NT5ToN9Fem
	 8PAUFAygmCbO+rkkyAoNPSEoy8SWu701asJ8ru/YMV2P7RSg+sS75Khb3uhAZhz7PD
	 iW272fLSmV6GQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6381915C026D; Thu, 09 May 2024 00:26:08 -0400 (EDT)
Date: Thu, 9 May 2024 00:26:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Convert ext4's mballoc to use folios
Message-ID: <20240509042608.GC3620298@mit.edu>
References: <20240416172900.244637-1-willy@infradead.org>
 <171512302195.3602678.13595191031798220265.b4-ty@mit.edu>
 <ZjuYM5ElTeBrXW4D@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjuYM5ElTeBrXW4D@casper.infradead.org>

On Wed, May 08, 2024 at 04:20:19PM +0100, Matthew Wilcox wrote:
> 
> Thanks!  Can you also add 20240420025029.2166544-11-willy@infradead.org

Thanks, done.

						- Ted
						


