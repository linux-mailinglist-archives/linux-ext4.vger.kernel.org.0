Return-Path: <linux-ext4+bounces-4518-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B437991C6B
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Oct 2024 05:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC601F21E4E
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Oct 2024 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA28166F0C;
	Sun,  6 Oct 2024 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="jT9l+tfW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890BE320B
	for <linux-ext4@vger.kernel.org>; Sun,  6 Oct 2024 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728185928; cv=none; b=WFov8c8gstxhdK2Y9JeGu1ca9WUM9zbLWvZDt8yinT2Gqi4Np/+JBkkbHrA30c+B1Fk2JgDzr6ztCmx7eqdm9wrda/rMOrlYawQU1/+yAu0na2GWoq1XZmTefqgltF6Zi7UGWIg2zARAS1gO/V/OI69fFf8a1NnU52EsaPx54E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728185928; c=relaxed/simple;
	bh=RCXBCq+nZWtkjXKtHC6Z2v1HSF/B5HMBPjyiighVBOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzPcsvBdcANJUlsRIBCk8BcMey2RwyMeUeMTYhT+3kGE0S8tJ1bdvQAhTAJjqWBMyhVqiaR/l/IJ7M1kfLuzcPWk0s7uEVwoNhAAoAhR0krsghIWcSGHG1ylz1aploCJKV5DSQjub/wkBCuk8HQqyw0nNNk9YNXjsk37xx/+ZMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=jT9l+tfW; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-178.bstnma.fios.verizon.net [173.48.111.178])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4963c5lT019613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 23:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728185893; bh=oCEEqj+UtNwLXvigx5EXmnpRe6dWCvtIGCt8HrRAOZQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=jT9l+tfW8Xt8ZDRXCHbo1A9oBWKxJFfvFcmX3f+kRWSXhjHeZTlIcMAnGylsCAIUU
	 BzoDQQFShM913bZrUBEuWEqoYyyV1lsFcVHh/k/5QalXHxFH6W5i13ZK6erEIvNiZb
	 4XLDg4vUQ/dtMpZHcFDzzeIvbOyDcgxhm9EA4LCm0LTF1DCuj+LXjC0EExOame65+w
	 /LrqlfRWC3nfl6OzIlOpSNnC8AGEVPXApwaOF8pBJDSSJ+LF7raCmQtsR/FtOA67XL
	 YCegeAvaRD6Gu7JZEMsQ5gnvgTEqSgKdPvzEo7d6zXFagUUaAfODN9aTUYzNupwCRC
	 +yRCtH6d/pguA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6068A15C6668; Sat, 05 Oct 2024 23:38:05 -0400 (EDT)
Date: Sat, 5 Oct 2024 23:38:05 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Jan Stancek <jstancek@redhat.com>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <20241006033805.GB158527@mit.edu>
References: <20240805201241.27286-1-jack@suse.cz>
 <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3>
 <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
 <877canu0gr.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877canu0gr.fsf@mailhost.krisman.be>

On Fri, Oct 04, 2024 at 03:33:56PM -0400, Gabriel Krisman Bertazi wrote:
> > Regardless of what is right or wrong to do in ext4, I don't think that the test
> > really cares about remount read-only.
> > I don't see anything in the test that requires it. Gabriel?
> > If I remove MS_RDONLY from the test it works just fine.
> 
> If I recall correctly, no, there is no need for the MS_RDONLY.  We only
> care about getting the event to test FS_ERROR.

Looking at ltp/testcases/kernel/syscalls/fanotify/fanotify22.c this
appears to be true.

I'll note though that this comment in fanotify22.c is a bit
misleading:

	/* Unmount and mount the filesystem to get it out of the error state */
	SAFE_UMOUNT(MOUNT_PATH);
	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);

Once ext4_error() gets called, the file system will be marked as
containing errors.  This can be seen when you mount the file system,
and when you run fsck -p:

root@kvm-xfstests:~# mount /dev/vdc /vdc
[ 1893.569015] EXT4-fs (vdc): mounted filesystem 9bf1a2df-fc1c-4b46-a8e8-c9e3e9bc7a26 r/w with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# echo "testing 123" > /sys/fs/ext4/vdc/trigger_fs_error 
[ 1907.268249] EXT4-fs error (device vdc): trigger_test_error:129: comm bash: testing 123
root@kvm-xfstests:~# umount /vdc
[ 1919.722934] EXT4-fs (vdc): unmounting filesystem 9bf1a2df-fc1c-4b46-a8e8-c9e3e9bc7a26.
root@kvm-xfstests:~# mount /dev/vdc /vdc
[ 1923.270852] EXT4-fs (vdc): warning: mounting fs with errors, running e2fsck is recommended
[ 1923.297998] EXT4-fs (vdc): mounted filesystem 9bf1a2df-fc1c-4b46-a8e8-c9e3e9bc7a26 r/w with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# umount /vdc
[ 1925.889086] EXT4-fs (vdc): unmounting filesystem 9bf1a2df-fc1c-4b46-a8e8-c9e3e9bc7a26.
root@kvm-xfstests:~# fsck -p /dev/vdc
fsck from util-linux 2.38.1
/dev/vdc contains a file system with errors, check forced.
/dev/vdc: 12/327680 files (0.0% non-contiguous), 42398/1310720 blocks

Unmounting and remounting the file system is not going to clear file
system's error state.  You have to clear the EXT2_ERROR_FS state, and
if you want to prevent fsck.ext4 -p from running, you'll need to set
the EXT2_VALID_FS bit, via 'debugfs -w -R "ssv state 1" /dev/vdc' or
you could just run 'fsck.ext4 -p /dev/vdc'.

Also note that way I generally recommend that people simulate
triggering a file system error is via a command like this:

   echo "test error description" > /sys/fs/ext4/vdc/trigger_fs_error

To be honest, I had completely forgotten that the abort mount option
exists at all, and if I didn't know that ltp was using it, I'd be
inclined to deprecate and remove it....

						- Ted


