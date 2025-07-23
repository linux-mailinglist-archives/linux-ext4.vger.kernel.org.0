Return-Path: <linux-ext4+bounces-9167-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A871B0F664
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3B6AC393F
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874472F7D02;
	Wed, 23 Jul 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2Cf8VKp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE8301148;
	Wed, 23 Jul 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282467; cv=none; b=fGzN23keyPSvjHrT+M8QLybiQ0Lmk+8CEhk0ZAfsNbAtsBxvaXeAXTcPs65I4Ssr3M63rQtnE9+oSbxND/Jormb3eMnOp6y7tikPS/WSzNh/wyWlLlPuqRhrgkMt212DgSqTu3aLViOoRyvEWhHkJ89cJB7SuP7S+fs3D0fB9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282467; c=relaxed/simple;
	bh=y+g/uzpxGoEeQev5j+AyDMsNyEL4KeDVSDo9psgVMLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpYmb3uGl4WGvBirtLf5FbTQ6iasdW4EFAW+7Rvs/iHgnnAR0EaXYuGo/Fcxt51J/M+OVfkJFQBTVUEdNZYjWpnWT9bJsSx2MiwsnKJoi/pzDwu1KflvIxtq+lWjBdhmmgGx6/A8adwRY3Xifmwy9oMEG7mDGgstXLLmPuMRuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2Cf8VKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB512C4CEFC;
	Wed, 23 Jul 2025 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282463;
	bh=y+g/uzpxGoEeQev5j+AyDMsNyEL4KeDVSDo9psgVMLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2Cf8VKpyjqQEsL1GL9nabTeJnsWtYkmeIQfMMvVw8dhEpQX40cJ34YtfOhRr+j4P
	 d9eekkecg546N1fJS2JQ2hL459GSHae8kwIWugR80LGoDQqZOaDqk/gu/mYGgpDxSN
	 vQTSVGmFUPl842Xud3QTXqaWvIA/zcsb28kCItbQADq3W9cUhYL3gGktSZTHftPnFm
	 RgW2Op0tNNloSe/4wH4HAbVFmi2C1zIpgEnfxWp1lI0646YBBrKZya4K/fRqonlBfH
	 1ov3172yW5mhZkSPbv1fjccBUmomK9HtQGSdxVqONl19P5niyQLUgiCOtNYoGbDLnZ
	 Ze8X+CIn88SAA==
Date: Wed, 23 Jul 2025 07:54:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 07/13] generic/1228: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <20250723145423.GN2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <ae247b8d0a9b1309a2e4887f8dd30c1d6e479848.1752329098.git.ojaswin@linux.ibm.com>
 <20250717163510.GJ2672039@frogsfrogsfrogs>
 <aIDpdg_SibBYFAPy@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIDpdg_SibBYFAPy@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Wed, Jul 23, 2025 at 07:23:58PM +0530, Ojaswin Mujoo wrote:
> On Thu, Jul 17, 2025 at 09:35:10AM -0700, Darrick J. Wong wrote:
> 
> <snip>
> 
> > > +verify_atomic_write() {
> > > +	if [[ "$1" == "shutdown" ]]
> > > +	then
> > > +		local do_shutdown=1
> > > +	fi
> > > +
> > > +	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
> > > +
> > > +	if [[ $do_shutdown -eq "1" ]]
> > > +	then
> > > +		echo "Shutting down filesystem" >> $seqres.full
> > > +		_scratch_shutdown >> $seqres.full
> > > +		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-3"
> > > +	fi
> > > +
> > > +	check_data_integrity
> > > +}
> > > +
> > > +mixed_mapping_test() {
> > > +	prep_mixed_mapping
> > > +
> > > +	echo "+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
> > > +	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> > > +		        grep wrote | awk -F'[/ ]' '{print $2}')
> > > +
> > > +	verify_atomic_write $1
> > 
> > The shutdown happens after the synchronous write completes?  If so, then
> > what part of recovery is this testing?
> > 
> > --D
> 
> Right, it is mostly inspired by [1] where sometimes isize update could
> be lost after dio completion. Although this might not exactly be
> affected by atomic writes, we added it here out of caution.
> 
> [1] https://lore.kernel.org/fstests/434beffaf18d39f898518ea9eb1cea4548e77c3a.1695383715.git.ritesh.list@gmail.com/

Ah, so we're racing with background log flush then.  Would it improve
the potential failure detection rate to call shutdown right after the
pwrite, e.g.

$XFS_IO_PROG -dxc "pwrite -DA..." -c 'shutdown' $testfile

It can take a few milliseconds to walk down the bash functions and
fork/exec another child process.

--D

> > > +}
> > > +
> 

