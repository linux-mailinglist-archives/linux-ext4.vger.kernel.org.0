Return-Path: <linux-ext4+bounces-2915-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1AF912B74
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 18:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0111F26E2D
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE0160783;
	Fri, 21 Jun 2024 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxv6jnXe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC49156227;
	Fri, 21 Jun 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987768; cv=none; b=niz1gfQEMNn0xp508Q4gqf3MwctqzRrD4FmnhkHv0AwQatE66U6w/UmK0WIaJ/hIuU48Q37kapzIQJpitR7xWdcFTWVzjirs8iwANm+TmbrgZFxLxmrZM20GUhozZCE89wtBo910C1eJgR6awMuzExLKo2EiH5nVS9RT8PPgNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987768; c=relaxed/simple;
	bh=rMw0lXR+0qFw57y0kRCi9QHfXwdq/RCbQ9Ljz3ZOGNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EC28LB7akkjz8iD8eN6+RfX4szgTLXOdRXPuh7OsEggXmKdmJkz0kMDKqATGGI2urWJriybZmGDsFAHlAgLEsoCokwcPPuosrAwlom55nMavs6kPmfUPpn1QAMrjILBa2Fn4mEKlSmVDDkuU692mHB6xvk3HLq2+kjuCbmeZYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxv6jnXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61483C2BBFC;
	Fri, 21 Jun 2024 16:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718987768;
	bh=rMw0lXR+0qFw57y0kRCi9QHfXwdq/RCbQ9Ljz3ZOGNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dxv6jnXeaDEirXvPRL2aeqM/sjUx6iD7YGHNZ/gP/m3xgaI2sOduzNoSC7gm+l1bm
	 4FabIvmBz0P+/at4e0p8/EpJ/Z1mAQfc5M3n9dmrnFeeHeXp1u5/bMngO4YbbgZ97n
	 MiYyDBSykYEVN1PJTzXQvQDfDcOCCyASMQXd69GwM0sBNsVwVyE2ci1xzMOwtNwEK7
	 NCdhLj3r25KjPjix9Y8pTxM2dp3mY+2YZ8ppetxKOaqr73nSnljElBp6zQt/3uXSeJ
	 aoT9A2aXJiXtlJWt+Yi6wHdCMWOr/Gq+rP9q1Dp1tD3kK/N7/flH/FJU/IEwXL2UE0
	 z8LlTaN16CgDw==
Date: Sat, 22 Jun 2024 00:36:03 +0800
From: Zorro Lang <zlang@kernel.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	linux-fstests@mit.edu,
	=?utf-8?B?5p2o5LqM5Z2k?= <yangerkun@huawei.com>,
	fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/059: disable block_validity checks when mounting a
 corrupted file system
Message-ID: <20240621163603.mid7acwta2tnbhqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230823145621.3680601-1-tytso@mit.edu>
 <45251246-e24b-4ace-9b45-2efad65e8eb5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45251246-e24b-4ace-9b45-2efad65e8eb5@huawei.com>

On Thu, Jun 13, 2024 at 10:09:44AM +0800, Baokun Li wrote:
> Hi Zorro,
> 
> Could you pick up this patch?
> This test case has been failing in the mainline for a while now.

Sorry I just noticed this patch, looks like it was not sent to fstests@.
Sure, I'll merge it, thanks for CC me :)

Thanks,
Zorro

> 
> Thanks,
> Baokun
> 
> On 2023/8/23 22:56, Theodore Ts'o wrote:
> > Kernels with the commit "ext4: add correct group descriptors and
> > reserved GDT blocks to system zone" will refuse to mount the corrupted
> > file system constructed by this test.  So in order to perform the
> > test, we need to disable the block_validity checks.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> Looks good to me, thanks for the patch!
> 
> Reviewed-and-tested-by: Baokun Li <libaokun1@huawei.com>
> 
> > ---
> >   tests/ext4/059 | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/tests/ext4/059 b/tests/ext4/059
> > index 4230bde92..e4af77f1e 100755
> > --- a/tests/ext4/059
> > +++ b/tests/ext4/059
> > @@ -31,6 +31,11 @@ $DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
> >   $DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
> >   	grep "Reserved GDT blocks"
> > +# Kernels with the commit "ext4: add correct group descriptors and
> > +# reserved GDT blocks to system zone" will refuse to mount the file
> > +# system due to block_validity checks; so disable block_validity.
> > +MOUNT_OPTIONS="$MOUNT_OPTIONS -o noblock_validity"
> > +
> >   _scratch_mount
> >   # Expect no crash from this resize operation
> 
> 
> -- 
> With Best Regards,
> Baokun Li
> 

