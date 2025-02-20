Return-Path: <linux-ext4+bounces-6519-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75484A3DD56
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5870E174B5E
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FB81CEAC3;
	Thu, 20 Feb 2025 14:52:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A69175D50
	for <linux-ext4@vger.kernel.org>; Thu, 20 Feb 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063153; cv=none; b=alx8WXmJkUU50s9TB/Ix3u/LeJniS9oeuFeFXojltXA33dihh/Jc0nt+h9THi675ilWjjDFtTKGi+PzSfveQjngPWVNzUonKCTQOt699xUqYeB3SXzcOpF3Uze5jC2076814HzMpawoCqZSpwA24xHLDWBsyxeT5b7ZAjwavrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063153; c=relaxed/simple;
	bh=QHaybYCRBCpIWGa39OUBuvooWaXcZQveAKqIeESIy6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipbUkLe8VxH3gyzrJFmtgViCwUbENVmha3Qedoed0rX4VfkjE5K6kmhtl1CyRba/EWs90P9ihBYbYFqIci1C9I505SMLVeyo5pK6+K27WG3zFzE4Y8JUsnOcxkliSsGCcIogkXiZAzrzaqGRqrpueLjy/FN0GrUSN4Z1kC76AT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-12.bstnma.fios.verizon.net [173.48.114.12])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51KEqFKB003980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:52:15 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4795C2E011A; Thu, 20 Feb 2025 09:52:15 -0500 (EST)
Date: Thu, 20 Feb 2025 09:52:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Adithya.Balakumar@toshiba-tsip.com, linux-ext4@vger.kernel.org,
        Shivanand.Kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: Is it possible to make ext4 images reproducible even after
 filesystem operations ?
Message-ID: <20250220145215.GB2150479@mit.edu>
References: <TYCPR01MB966943691EBB5DA3F5F85621C4E62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <21C92625-5A8E-430C-8359-A07CE698DE42@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21C92625-5A8E-430C-8359-A07CE698DE42@dilger.ca>

Andreas,

FYI, for context, this discussion has also came up on a github issue,
by Adithya.  I told Adithya many of the same things that you did, and
more besides:

     https://github.com/tytso/e2fsprogs/issues/214

						- Ted

