Return-Path: <linux-ext4+bounces-7598-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CF5AA5F48
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F1C9C0772
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE711A5B8A;
	Thu,  1 May 2025 13:37:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE62EAE5
	for <linux-ext4@vger.kernel.org>; Thu,  1 May 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746106666; cv=none; b=dpxquqc3CPgAB3w+fCDlqtCRGnxWKWbi/yBoHZ0X1dzoM6sDda3pXSC0ge8ZyeqCXLahhMeqP+E5FDpA9OnjpbEkhGoZtXfi8aJlSRxurhFOt5pLGoppt+mPo5wuQSEAcqLl+We9IybI4g6gmX8+uA7Bd0kHT+rLlkQfDRTAPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746106666; c=relaxed/simple;
	bh=I1JwdI/GDoiYlvy8StSpp/rJO4IhCO++AK17DZ2sPxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo96kdbGZ0nG78ce9iu7vM5bFCb90Uf6m61ZVG1n7plfj/vs7MMQPUi7rvko0VsKo37bVhE7XMj43SRYbF1q1l2zrJmPQpbUAObxnfGfazC5724YoqrSYYcqRPLijuBUeVdurRZT/Wf/2AlQ6oOsrt3jynHgmy24j8xs6tu2Wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-120.bstnma.fios.verizon.net [108.26.156.120])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 541DbaXC017409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 May 2025 09:37:37 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 52BA72E00E9; Thu, 01 May 2025 09:37:36 -0400 (EDT)
Date: Thu, 1 May 2025 09:37:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, jack@suse.cz, harshads@google.com
Subject: Re: [PATCH v8 0/9] Ext4 Fast Commit Performance Patchset
Message-ID: <20250501133736.GB205188@mit.edu>
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
 <20250424145911.GC765145@mit.edu>
 <CAD+ocbzqihJidUkanZLwUfHFNyEs0SO_Tbx4ABr_9W3dRVbArg@mail.gmail.com>
 <20250501041404.GA205188@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501041404.GA205188@mit.edu>

On Thu, May 01, 2025 at 12:14:04AM -0400, Theodore Ts'o wrote:
> 
> I was applying your patches on 6.15-rc3 and this evening I tried
> applying them against 6.15-rc2, which has been failing as well.
> 
> There's nothing else on the ext4 dev branch yet, but there were a
> large number of ext4 patches which landed between 6.14-rc2 and
> 6.15-rc2.

I tried bisecting your patch series using:

  kvm-xfstests -c ext4/fast_commit generic/127 generic/241 generic/418

and the first bad commit was "ext4: rework fast commit commit path".

    	      	  	     	    	   - Ted

git bisect start
# status: waiting for both good and bad commits
# good: [9c32cda43eb78f78c73aee4aa344b777714e259b] Linux 6.15-rc3
git bisect good 9c32cda43eb78f78c73aee4aa344b777714e259b
# status: waiting for bad commit, 1 good commit known
# bad: [a147d000c6914a51becf0d32bbb8c9124e45f6ed] ext4: hold s_fc_lock while during fast commit
git bisect bad a147d000c6914a51becf0d32bbb8c9124e45f6ed
# good: [8ffd015db85fea3e15a77027fda6c02ced4d2444] Linux 6.15-rc2
git bisect good 8ffd015db85fea3e15a77027fda6c02ced4d2444
# bad: [bfd1ce278bb3cfea0ad7017de608691a83c372bf] ext4: rework fast commit commit path
git bisect bad bfd1ce278bb3cfea0ad7017de608691a83c372bf
# good: [36eb0b696b73895b7e40dbf3043275fdc9bcb1fe] ext4: for committing inode, make ext4_fc_track_inode wait
git bisect good 36eb0b696b73895b7e40dbf3043275fdc9bcb1fe
# good: [94cee94db3acfe189463f4343ca7bd9c83570cb7] ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
git bisect good 94cee94db3acfe189463f4343ca7bd9c83570cb7
# first bad commit: [bfd1ce278bb3cfea0ad7017de608691a83c372bf] ext4: rework fast commit commit path


