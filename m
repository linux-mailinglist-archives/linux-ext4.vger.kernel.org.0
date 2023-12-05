Return-Path: <linux-ext4+bounces-308-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01E805CAB
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Dec 2023 18:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0636281EF2
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Dec 2023 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB4C6A344;
	Tue,  5 Dec 2023 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wT63OINb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA57D6A329;
	Tue,  5 Dec 2023 17:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1156C433C8;
	Tue,  5 Dec 2023 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701799042;
	bh=2gbDWzlz/2HnpVET7DLNA3XD6qtbpPe9oj2Q4zkjV3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wT63OINb6S5Ij848WsI6aixbKVJlhTO9f2H0Ppqr7s/mp96Ssg/qFvvnXGxwd98a4
	 9ygGhIW9dfqPPq0vXCHkH5vu/WzpAd01068vX9XsnIepHCxr5Slzy4dVPAKTTON5b0
	 a9RyO7xNqN7P8tlNKAdcxDalLfu3ndq9WWESrfHM=
Date: Wed, 6 Dec 2023 02:57:15 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jan Kara <jack@suse.cz>,
	Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	chrubis@suse.cz, linux-ext4@vger.kernel.org,
	Ted Tso <tytso@mit.edu>
Subject: Re: ext4 data corruption in 6.1 stable tree (was Re: [PATCH 5.15
 000/297] 5.15.140-rc1 review)
Message-ID: <2023120643-evade-legal-ee74@gregkh>
References: <20231124172000.087816911@linuxfoundation.org>
 <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
 <20231127155557.xv5ljrdxcfcigjfa@quack3>
 <CAEUSe7_PUdRgJpY36jZxy84CbNX5TTnynqU8derf0ZBSDtUOqw@mail.gmail.com>
 <20231205122122.dfhhoaswsfscuhc3@quack3>
 <4118ca20-fb7d-4e49-b08c-68fee0522d3d@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4118ca20-fb7d-4e49-b08c-68fee0522d3d@roeck-us.net>

On Tue, Dec 05, 2023 at 09:55:08AM -0800, Guenter Roeck wrote:
> On Tue, Dec 05, 2023 at 01:21:22PM +0100, Jan Kara wrote:
> [ ... ]
> > 
> > So I've got back to this and the failure is a subtle interaction between
> > iomap code and ext4 code. In particular that fact that commit 936e114a245b6
> > ("iomap: update ki_pos a little later in iomap_dio_complete") is not in
> > stable causes that file position is not updated after direct IO write and
> > thus we direct IO writes are ending in wrong locations effectively
> > corrupting data. The subtle detail is that before this commit if ->end_io
> > handler returns non-zero value (which the new ext4 ->end_io handler does),
> > file pos doesn't get updated, after this commit it doesn't get updated only
> > if the return value is < 0.
> > 
> > The commit got merged in 6.5-rc1 so all stable kernels that have
> > 91562895f803 ("ext4: properly sync file size update after O_SYNC direct
> > IO") before 6.5 are corrupting data - I've noticed at least 6.1 is still
> > carrying the problematic commit. Greg, please take out the commit from all
> > stable kernels before 6.5 as soon as possible, we'll figure out proper
> > backport once user data are not being corrupted anymore. Thanks!
> > 
> 
> Thanks a lot for the update.
> 
> Turns out this is causing a regression in chromeos-6.1, and reverting the
> offending patch fixes the problem. I suspect anyone running v6.1.64+ may
> have a problem.

Jan, thanks for the report, and Guenter, thanks for letting me know as
well.  I'll go queue up the fix now and push out new -rc releases.

greg k-h

