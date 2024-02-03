Return-Path: <linux-ext4+bounces-1075-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A809848815
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Feb 2024 18:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7EAB2386A
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Feb 2024 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C05FB8B;
	Sat,  3 Feb 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="n81vRCmS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679060DF2
	for <linux-ext4@vger.kernel.org>; Sat,  3 Feb 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983062; cv=none; b=ru9R15fo26feo2T0ZkBW6m5e7pqgHu4llRSerjmR92uQh2I8DzvjFXPAlevHWVA+Hbaj16NqgjZXXi9DJ69BVbdpsFYKK5uaqsSXFslJrk9oBGZm+kfG79MRd/20s/nCJh6c16BWRRRcL4JoCushB0dlSqYhkjEfHXuuFNHkWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983062; c=relaxed/simple;
	bh=L5XYF2KuEo1BrAG7ckKe76GQrqm8pMIi0dIvttW0n/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv7T786IVSWjT/K+MFjMlCRUxjcIXhNTsNifZUuA2suGRJmIY4NM2qlcckrxNpuCzdzRXnLIQihqM0wv4mD4sT6ZoXLasm1UzKHYkDOKBPd7lUtHIgD09jHi/cZ44OCqyAqAEjR+f9nhobzI4/uW2UId2wi9dZW0x4AzQCIc1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=n81vRCmS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 413Hv0J2016980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 12:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706983023; bh=cgektm8Q7wvIKkcrsOa9PWTVTa13uIiTg1vywPCUM4Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=n81vRCmSk5GvNTiXt3ljeqomzIgwcMUo5S6oAocqScuncfnGHRQ6R3RHyqAdMlEpn
	 HktVRHFGsKiNMvi5miX4LLjzTm6Ayn4SMzu0eMbJd9ZM2hzTGo+RdL0RH651HO047O
	 5o+Up20WUjt4fnEssoNFAh5pwcuRE6WsabSdb0ql+WvA7TG2PP8vleQhJP/bLCeNbN
	 o1nObKq9Q+sqyYkZ86cudLcGYvwdjcXBJa4lY0tr2h6fLGh92MDk0wtSzopH7/GO91
	 iH3lV/q7iJOYmzerxB2i43FRIEHnbo0eahb0sqkktp5lmQeNVzDSa1CnQQ5w1yfn2t
	 Im+y23yeZB2Rw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5574C15C02FC; Sat,  3 Feb 2024 12:57:00 -0500 (EST)
Date: Sat, 3 Feb 2024 12:57:00 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        hch@infradead.org, djwong@kernel.org, willy@infradead.org,
        zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 05/26] ext4: make ext4_map_blocks() distinguish
 delalloc only extent
Message-ID: <20240203175700.GH36616@mit.edu>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-6-yi.zhang@huaweicloud.com>

On Sat, Jan 27, 2024 at 09:58:04AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Add a new map flag EXT4_MAP_DELAYED to indicate the mapping range is a
> delayed allocated only (not unwritten) one, and making
> ext4_map_blocks() can distinguish it, no longer mixing it with holes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.


