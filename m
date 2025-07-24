Return-Path: <linux-ext4+bounces-9173-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA4EB0FFC3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 06:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671B34E5A67
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 04:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2CE1F419B;
	Thu, 24 Jul 2025 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Q9eu57+x"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3010E0
	for <linux-ext4@vger.kernel.org>; Thu, 24 Jul 2025 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753332987; cv=none; b=MBIA2xrpbazHhCW90rR9TtGeazPnnrcU91G0GQ8oq2oTfzS4l1wR8QLqz9Q1Dle3HrLuqmmeRR51EQEdONsTIHYbA20hfdd6vHMYqFCwNybY4+uye8k1bgFf7MOqCaIhT14RjI3uo5dY6RFs4KlVCnHa2fs/7MMTo5b8l81h2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753332987; c=relaxed/simple;
	bh=fP6kX1LMGmOTclonzU54n3N9v2G92MN3VZq19VXBsgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em272HOgpC/wqSekS8BOqEPMH23cS57Noi26nSPVytyfoJ7/rKzuoAvLhaguiRbnyaIPrz/zulHy/OhLkIPrwviroYsou8//R1MecguSXNMRGRbYbx16iTLcZE1VQSiemQd8po2bn0RATPtlZiX8B8d2RLgZ6PbgwldC01MZSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Q9eu57+x; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-231.bstnma.fios.verizon.net [173.48.112.231])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56O4suTs029451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 00:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753332901; bh=1TXGdBZR9RlN4AvgbzOvBSB5nCw6F2aas8EVLPSRxe4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Q9eu57+xuy3qN3Iwbp/+OHTKDS/A1hIvgruYiiuKEWAEqUK+X9CZSu3cz0EQThwtL
	 5a1tv5ioqGrp8Rsu5OGMrTIs9WQz3iYVPlnYR6+Ia8vPVJtdMTA/v4+HP8Xo6fA5qf
	 4OU1O4rRrNrekBNJrEwzaN7F+zaLnhe7FvJdSgzSfgK2HRT5an51HQOzRzxJQ7wrbi
	 X/FAKjkSX8ZMPqzTtDod5e+T13qZLhhOodzrcTdfCsR96TqRhCGyZsiBwr5glXsKvc
	 utIRh6bYPDmWRWNm65+v6W7U4xdSwUsf+QreeCxTecVq7lPWEWOKNhA8mnvnwQMZWO
	 cF2EMzz2CFIeA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 6A76E2E00D5; Thu, 24 Jul 2025 00:54:56 -0400 (EDT)
Date: Thu, 24 Jul 2025 00:54:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, julia.lawall@inria.fr, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH v3 15/17] ext4: convert free groups order lists to xarrays
Message-ID: <20250724045456.GA80823@mit.edu>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-16-libaokun1@huawei.com>
 <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net>

On Wed, Jul 23, 2025 at 08:55:14PM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Mon, Jul 14, 2025 at 09:03:25PM +0800, Baokun Li wrote:
> > While traversing the list, holding a spin_lock prevents load_buddy, making
> > direct use of ext4_try_lock_group impossible. This can lead to a bouncing
> > scenario where spin_is_locked(grp_A) succeeds, but ext4_try_lock_group()
> > fails, forcing the list traversal to repeatedly restart from grp_A.
> > 
> 
> This patch causes crashes for pretty much every architecture when
> running unit tests as part of booting.

I'm assuming that you're using a randconfig that happened to enable
CONFIG_EXT4_KUNIT_TESTS=y.

A simpler reprducer is to have a .kunitconfig containing:

CONFIG_KUNIT=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_EXT4_KUNIT_TESTS=y

... and then run :./tools/testing/kunit/kunit.py run".

The first failure is actually with [11/17] ext4: fix largest free
orders lists corruption on mb_optimize_scan switch, which triggers a
failure of test_mb_mark_used.

Baokun, can you take a look please?   Many thanks!

	    	       	    	      - Ted

