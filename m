Return-Path: <linux-ext4+bounces-8634-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38344AE82E4
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 14:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D707AF2B6
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5F425B31F;
	Wed, 25 Jun 2025 12:39:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CD20ED
	for <linux-ext4@vger.kernel.org>; Wed, 25 Jun 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855193; cv=none; b=Tv7EzHpIDHf5DDtoy94+VQ7IQ3K3OQu3MfqZw8vJnhA8U9ZeAZ806+kgcTXorHOc8vsDfdLpeUBpkyZ2xvn/cUKpsHNxjTcQmqeI+2wrlik6MfGYtJR8uDJorw/l5nnA/sE4YXMyGhPNWuan8CEPc4RU6A/pqkBkkClXbdi5igo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855193; c=relaxed/simple;
	bh=/DJNCbbE9xrrflkcsjqfb15zNGUaui6fVcmOOXNjCfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFxGbwSR+/D45MHAlA118L6G36ExzqnRKAsziWM4QGenTnp73/cTTm/Ee45FT5iekZRe+GIBSZx0PBpq7in8KgRKaYlM69sGiEpGgomXDxHfIpmKGgCdYkTrpg8Xu6UIKzpM7jUUcWMlV+BlmXN96hYUrLXbwhnkF/bMItOfsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55PCd4hq003624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:39:04 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F0C232E00D5; Wed, 25 Jun 2025 08:39:03 -0400 (EDT)
Date: Wed, 25 Jun 2025 08:39:03 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun1@huawei.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
        Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>, linux-ext4@vger.kernel.org,
        Zhang Yi <yi.zhang@huaweicloud.com>
Subject: Re: LBS support for EXT4
Message-ID: <20250625123903.GB28249@mit.edu>
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
 <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
 <279f3612-ca02-46e0-a4ae-05052f2b1e50@pankajraghav.com>
 <20250623141753.GA33354@mit.edu>
 <c3ywjnnpfefledcl27qoqvwi4ew7fkrpmneddbxtquazraocrv@5e6l3t5oqap4>
 <dfad7391-e3fe-498d-8d33-55c00d8a3f46@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfad7391-e3fe-498d-8d33-55c00d8a3f46@huawei.com>

On Wed, Jun 25, 2025 at 07:51:56PM +0800, Baokun Li wrote:
> Now that mainline ext4 supports buffer head large folios, we'll first
> focus on LBS support based on buffer heads. The main work involves adapting
> ext4's internal logic (e.g., block allocation, read/write operations,
> defragmentation) and clean up the process related to buffer head.

That makes sense; ext4 uses buffer heads for metadata blocks, and so
even if we were using the buffered iomap code, that only is relevant
to the data path, so the changes so that jbd2 and ext4 can suport
large blocks while updating inode table blocks, allocation bitmaps,
etc. would be needed anyway.

Cheers,

						- Ted

